#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""این برنامه به شما کمک می‌کند جوراب‌های گمشده خود را با روش‌های بسیار علمی و کمی خنده‌دار پیدا کنید!"""

import random
import time
from sock_data import SCANNING_MESSAGES, DEFAULT_FINDINGS, POSSIBLE_FINDINGS_CONDITIONS, RECOMMENDATIONS

def get_sock_details():
    """اطلاعات جوراب گمشده را از کاربر با سوالات کمی عجیب‌تر و طنزآمیزتر دریافت می کند."""
    print("\nبه بخش بازجویی فوق سری جوراب گمشده خوش آمدید! لطفاً با صداقت کامل و بدون هیچگونه پنهان‌کاری به سوالات پاسخ دهید. سرنوشت کهکشان (یا حداقل کشوی جوراب شما) به این اطلاعات بستگی دارد!")
    color = input("رنگ دقیق و کامل جوراب گمشده چیست؟ (مثلاً: قرمز گوجه‌ای رسیده، آبی آسمانی در یک صبح دل‌انگیز بهاری، سبز لجنی مرموز) ")
    sock_type = input("نوع جوراب چیست؟ (مثلاً: ورزشی فراری و خستگی‌ناپذیر، پشمی فیلسوف و گوشه‌گیر، مچی مهمان‌دوست و اجتماعی، ساق بلند ماجراجو و جهانگرد، یا شاید یک جوراب فضایی با تکنولوژی نامعلوم؟) ")
    last_seen = input("آخرین بار این مظنون جورابی کجا و در چه شرایطی مشاهده شده است؟ (هرچه جزئیات بیشتر و عجیب‌تر، شانس موفقیت ما در این عملیات خطیر بالاتر! مثلا: زیر مبل، در حال فرار به سمت ماشین لباسشویی با یک چمدان کوچک، یا در حال گفتگو با گربه همسایه) ")
    motive = input("به نظر شما، این جوراب چه انگیزه پنهانی و شومی برای ناپدید شدن دارد؟ (مثلاً: پیوستن به سیرک بین‌المللی جوراب‌های گمشده، سفر به ماه برای کشف پنیر سبز، اعتراض به بوی پا و شروع یک زندگی جدید، یا شاید تشکیل یک ارتش جورابی برای تسخیر جهان؟) ")
    
    sock_info = {
        'color': color,
        'type': sock_type,
        'last_seen': last_seen,
        'motive': motive
    }
    return sock_info

def perform_scan(sock_info):
    """اسکن محیط برای یافتن جوراب با استفاده از اطلاعات دریافتی."""
    print(f"\nاسکن برای جورابی با مشخصات زیر شروع می شود:")
    print(f"  رنگ: {sock_info['color']}")
    print(f"  نوع: {sock_info['type']}")
    print(f"  آخرین مکان مشاهده شده: {sock_info['last_seen']}")
    print(f"  نقشه احتمالی: {sock_info['motive']}")
    
    print("\n") # Add a newline for better formatting before scan messages
    for message, duration in SCANNING_MESSAGES:
        print(message)
        time.sleep(duration)

    # Determine findings using logic from sock_data
    final_findings = []
    for condition_lambda, findings_list in POSSIBLE_FINDINGS_CONDITIONS:
        if condition_lambda(sock_info):
            final_findings.extend(findings_list)
    
    if final_findings:
        sock_info['scan_findings'] = random.choice(final_findings)
    else:
        sock_info['scan_findings'] = random.choice(DEFAULT_FINDINGS)

def display_results(sock_info):
    """نمایش نتایج اسکن و سرنوشت جوراب به همراه توصیه‌های بسیار مفید."""
    print("\n\n===================================")
    print("   گزارش رسمی عملیات جوراب‌یابی   ")
    print("===================================")

    print("\nمشخصات جوراب تحت پیگرد:")
    print(f"  - رنگ: {sock_info.get('color', 'نامشخص')}")
    print(f"  - نوع: {sock_info.get('type', 'نامشخص')}")
    print(f"  - آخرین مکان رویت شده: {sock_info.get('last_seen', 'نامشخص')}")
    print(f"  - انگیزه احتمالی برای ناپدید شدن: {sock_info.get('motive', 'نامشخص')}")

    print("\nیافته‌های اسکن فوق پیشرفته کوانتومی:")
    print(f"  >>> {sock_info.get('scan_findings', 'اسکن نتیجه‌ای در بر نداشت. شاید جوراب شما اصلا وجود خارجی ندارد؟')}")
    
    print("\n📜 توصیه تیم فوق تخصصی کارشناسان جوراب‌شناسی بین‌المللی و امور فرازمینی جوراب:")
    print(f"  -> {random.choice(RECOMMENDATIONS)}")
    print("===================================")
    print("پایان گزارش.")

def main():
    """تابع اصلی برنامه برای یافتن جوراب گمشده با چاشنی طنز کیهانی و ماجراجویی‌های بین‌بعدی."""
    # این برنامه به شما کمک می‌کند جوراب‌های گمشده خود را با روش‌های بسیار علمی، کمی خنده‌دار و مقادیری جادوی سیاه پیدا کنید!
    print("\n*** به جوراب یاب فوق پیشرفته کوانتومی نسخه X-Omega 7.1 خوش آمدید! ***")
    print("ما جوراب شما را حتی اگر به بُعد دیگری گریخته باشد یا توسط گ렘لین‌های لباسشویی دزدیده شده باشد، پیدا می کنیم (یا حداقل خیلی تلاش می‌کنیم).")
    sock_info = get_sock_details()
    
    print("\n--- پرونده جوراب مفقوده برای ارسال به لابراتوار تحلیل‌های پیشرفته جورابی آماده شد ---")
    print(f"  شماره پرونده ویژه: {random.randint(1000, 9999)}-SOCK-{random.choice(['ALPHA', 'OMEGA', 'SIGMA', 'GAMMA'])}-{random.randint(1,100)}")
    print(f"  سطح محرمانگی: فوق سری (حتی از خودتان هم مخفی‌تر)")
    print(f"  وضعیت فعلی: در حال ارسال به آزمایشگاه تحلیل جوراب‌های فراری و سرکش واقع در مثلث برمودا")
    print("------------------------------------------------------------------------------------\n")
    
    perform_scan(sock_info) 
    display_results(sock_info)

if __name__ == "__main__":
    main()
