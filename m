Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264410;
	b=NOobOkIQk5Qpo+TCjY0uD2DbASlH35xGbydgHHLqqNYEGoRYR0bhshur13m3fik5/KoY
	 gQXA9L8ogsQj28X1XjsZi/aFv1Su6nUclJtmkMyT/dTM5v8jTJuKTNlGFtlb8hKfg0R4/
	 5JJkZSq7UXtwqipittV/Id+QjXvxcyLHFpG0V9JrYhiWcoIB6Liy0FxjpAwzw9Fzpab0S
	 rO3Qy0T36bboFnMegSHXlOMU5kMUDY4voOev4G/LjfpueJohFRLw1qAEC4IKBusrzRWy0
	 NDHBx7lychZIn4RKCSoGU+US8BPwqwlNU6+xknIXZZldj3ygE91mTPrkg/ipYEEaRPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bas+A2pwMPdYKlr8K9rmQmJzztUh1FCL0UJNjmXGJUs=;
	b=F1m3Y+JJW59HsdBFtwXmmkmKWqckLhoYSvcMYV+oUbL8t7eXcIHxS8Hvvw1MzyMvTsSP
	 Hatw+Yoltlh6LP+dBfEutbQ9eLX6LdzOaS9EtMjzhwZgMRqtbjyn4JfgpUPSe+rqdJLLM
	 rWpR0KfJ/HKNRVP0h5ZtCNp3a67iQNcnYMbaIo2g6USwNAYdTUSnHkMtX186QLBKqH0+9
	 TY5qrLuk8ovpmC7KAfoGKFm0F9vOjBWbpmR7UFtwqnIyhWtNqpSro21aOb7Cw9icoZx0O
	 aMC7oXbxrxeg4uXMMgwWIeeHAKunFIADVwWuHdK6u+Wq+pcld7iKAG5oRMuJkjdTRRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xt7r6i1X;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12FB606A32D
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 09:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E12FB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xt7r6i1X
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a1947498bso1259123eec.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264409; x=1793869209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bas+A2pwMPdYKlr8K9rmQmJzztUh1FCL0UJNjmXGJUs=;
        b=xt7r6i1XB1wkXiieaXlil0rUqSFTNnvo7KXs2PxxFwFRllKLzCjc3lAJO51BFf/aQE
         xwbahwlJGxoNmGtKzWB5ciUYUa8c3l5IJQsM+quncSLh590orvnt0rglBklJg/4hSSr5
         zUPZzBSdVHkEFdUOEXNz8+Iq29pYNSRU0vAv9U/jDNds4FjL0ObkXxPo6wW9U7n8MZge
         OCHy/7VRQ2HxiSov3eT+s6eDTuNFwtOZq9jcBMY8gKElsY6t9e3T1UTNnMtDHZO16180
         l9J76Q96/yivgS/e1DmrD4Nu65RQWYxclEk/7RuWeTqfVqY8JXOD8ciHHvZVApvrwhvR
         6rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264409; x=1793869209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bas+A2pwMPdYKlr8K9rmQmJzztUh1FCL0UJNjmXGJUs=;
        b=MKwRgl5Rb/dO7Yt6mFhPAAmu65AS3lQ36YGEf+4KllB+Zj7d49FoMmrKA05q23N72Z
         Ydgu5c6Wk1tuno0VcmH9NAxKk1drLtcV8S1j564TW2NROfrJf5EBWxM1C4gNsUhht5ZK
         jD6fuYa4PXkAS5+s/Y/acpBW5vCHHwMheXauwojL5DjLi5mAo+8vizhqbxOpUArl5jjo
         CZrF0T92weAIHZeTZz4+SsrKzkVvwbw+lfwb7t1vO8WBTM2W6nF+Ow9LfzLCJl+CDNSZ
         Q2gLTEAsU8L4TUqJgQ2/5uB8VlXwmE6FUDxa5BejDX+hmUitc4D4+qS3p/Ep8g+/o02M
         NeMg==
X-Forwarded-Encrypted: i=1; AKwUvBzbhyegZu9+p9Ooe4FYQTcI0UrUQTOsqlPXnHAb9s2zwcWEF0/i9Gv4mwlcibCHIUkiTxSSZIh0GgI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiG1olY1R89qrA8Cn8xq/2OqAbO76zFvFpKQJEko978LRXE6vz
	bsg1WK6LcwuPK49lv/ciWqE2t6Zju/M5+FGEqJ7deONu2VusP9wtjA4=
X-Gm-Gg: AYBFou3xafkiSsigARPaeU7btNzWJ+A1wKY0D3MsDnDfjzo9+HiZecKA77ZcRRa/wP/
	eMAD8KmcNIZemUjiKMII6etR1wvFB5xc5DoPWIUlxis7FStAYi0PXL8gf2M8JxwucU4zHFURHtH
	+l8lP90xAeG1FVqE6y3ConfMoOiZ+CDeCEEf3UCdD9HmnkCzNwvTi+lxGboJpsS/zNePrjv6OgG
	eGgv+53IaiaOY2sOBssowWvqZki/xp7zuwQRmgGdwjujR8MxYCJiabsonbs3BkNSSQddCjd1pTA
	xvc90us3BFSeIavFjw1i+7SdXWTeFb0DlLRQK28y5SvuXeVfGOSDbi6OGVFk9VJ9ExErrYZTMKT
	+7Bh/mSLvOcU5Nv7AbCCPj8VS45EFEbPfXMX8gwZldfDDwM62KGrYs9+tvGHVqEr1JVJZALzISh
	2A6IYzaSRmxLDrvM3TS0YQ6b6+hzPh7K9fhsCkp+zA78ZiozDWNUdrY5ys9IRTcx6nMUprdZ+DD
	KkgypFUpYuvNQe9kvLRkob+UIHcmE0YJzUyXO/yrlSbkxkb7z6wcuU3NQex0tP1EsT2bEJcKrcJ
	AiB4b+U1ZVoHtXyYCm7XMv3Mp2JnHb4Eby1Y9yiQiIQBEQJRtRnwG9fVzIIPJA==
X-Received: by 2002:a05:7301:d185:b0:369:fe4c:b48f with SMTP id 5a478bee46e88-36a20119d21mr7048294eec.0.1793264408741;
        Thu, 29 Oct 2026 02:00:08 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.01.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:00:08 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 09/14] treewide: disable other rtc's in t2 macs
Date: Thu, 29 Oct 2026 04:52:06 -0400
Message-ID: <20261029085504.3547-10-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CMOS RTC and the ACPI TAD clock don't work correctly on
T2 Macs. When macsmc-rtc is enabled, turn them off on these
machines so macsmc-rtc is the only clock.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/acpi/acpi_tad.c | 4 ++++
 drivers/rtc/rtc-cmos.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 45459a4ca..a137a39e5 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -28,6 +28,7 @@
 #include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
@@ -845,6 +846,9 @@ static int acpi_tad_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (IS_ENABLED(CONFIG_RTC_DRV_MACSMC) && has_apple_t2_chip)
+		caps &= ~ACPI_TAD_RT;
+
 	if (!acpi_has_method(handle, "_PRW")) {
 		dev_info(dev, "Missing _PRW\n");
 		caps &= ~(ACPI_TAD_AC_WAKE | ACPI_TAD_DC_WAKE);
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fa04ece15..bdb436e24 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/platform_device.h>
 #include <linux/log2.h>
 #include <linux/pm.h>
@@ -944,6 +945,9 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 		.priv = &cmos_rtc,
 	};
 
+	if (IS_ENABLED(CONFIG_RTC_DRV_MACSMC) && has_apple_t2_chip)
+		return -ENODEV;
+
 	/* there can be only one ... */
 	if (cmos_rtc.dev)
 		return -EBUSY;
-- 
2.55.0

