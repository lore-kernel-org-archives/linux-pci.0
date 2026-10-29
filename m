Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264441;
	b=4HTjmGmFge6fOY85OrfNX6+p+kfneli9cBCboJwkGPyHmU22wV0AUmXT04wmn7dlRo/1
	 +gNYTFNnJTcs4cfC5Aquku0SOkqWmCyFoxecMuxeLm9N7aRNqsHbwaDKufl0pRLCQkq8v
	 PJl6h0LvPveoBojhai3gcNFLqQvXHpNcQlJjQCYeXgFLU4601PMGv2VWHOW6GZfeA/KEy
	 WRoaUlCmzEXibRpM6I/pbdGOWJ8JINxm7vXI5v43TnLvd7RqsnzEY/4R3V/KHZsinqOvJ
	 7Svi61B5vUv/FaS9jePTXsnWsvXUXANp7uQaDHsJsoPm6PVOYzFXmj2N+pU13+3ipBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hGYaG5S4e7TJEt4TBHtAN4ES2AM8I/c2sIKujiNwJrY=;
	b=dRx3Mg5mU2qYRqoUtzd9aibdOFhodNfupeBkRRwEDzWk7XHeFYUCQU0hODLlxkrFJJCp
	 f1uxBcCGn+jdqeLkG+5g/Hk7GEk9D5o2td/VQ2VChO1kCXQWPSGMBIuHruIME7IgueLnM
	 UK8bwEzlD/ZPdAb4ilYkZDxhLjhrvfvH0vHX9HQebdZeSyyITJuBXLKYO5CYjMthVbjag
	 w1Eo2VnUNPm6IUBzl0TTqTDpqJqYHxnDyZ5gigUaXxotzlwNfXryM/x0jyxfxQWdaG16T
	 4piT3vVAng1TUE77yoQhZ+ccGpKqrD47wU4rDJUQWqbRbuko3cKyWnbNPm2+bl+RDqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xipISR/h";
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C521E606A33B
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 09:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C521E606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xipISR/h
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a17a332ecso2725006eec.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264438; x=1793869238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGYaG5S4e7TJEt4TBHtAN4ES2AM8I/c2sIKujiNwJrY=;
        b=xipISR/hBNNzw7lSvtVi25be6OIkASKWzN2hSQgTVddoxixFt1v3sf7vhgfANS9rMs
         JXLhuLERpR3cd6x92G9DtinkhcrJm9VPi0+i0tH4t8zWfIvlhxKbIyV/WveW5bn2+vHH
         jmlS3aLQ2afo/buVoF7pa+3fpfzkZD+gw/R2HhBEjO3NjhmZZl6DzNh/juxHWKubn5DZ
         s3Gm1VB1JHJ+dfpFF6TNvXJckYa2gutnJIgWeMsssr2biYWjNS3qF0kGd65N0bE5ELi5
         6hMYEi6ze4xBmVCGdWMNJF1TUT8Ioihj5jbHwOZLsHvpK9kPkhhpVdiFcMV6mSTmlLrg
         qhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264438; x=1793869238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hGYaG5S4e7TJEt4TBHtAN4ES2AM8I/c2sIKujiNwJrY=;
        b=rDRdaxNE745y99Yj+U4dQmBD3Y1oJMlGoqwJN8eQ/HlXfgdW2KMgztCUQ5nwGjYiCV
         mR3wfShS4g79/N7XlbdfUGEdf/d7tJmcuG+NhywOPp4ja/gDVoMd5r4bogQHvZO+XfJS
         JSyJ1QDvpOI5otwI49D7jx8pOuQaAy6MPrtLpGQYx3B0OalizV+9/ajS/qwl/9wiUeGR
         f4dIIDnYdOqoyyonq4irP18EPEpQQVSk4Oax5IW1kD4dr/YFGfj6WbZuodvJEIw9DH/t
         tKTxFKGSt2/4iKShrH6e7qoVURh7jh2mvdFTX9h5ctS56Qy35gWkeb5lbCTedAacGh13
         AorA==
X-Forwarded-Encrypted: i=1; AKwUvByXl2hiz+jwNclzVemSji6OjZhieo7TLn0+UQ2X+hoPkHkv/Fw+1fl+Su/+qIRmIbH1ozhdzM6CfnM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfYDPSdHIBYU1sbQIcWSSMp6E4/J1Zg3tGXJBkkpxV1ZhpE6Jk
	BR5GoLod38P0BKj+ydXy5LoJBzdUNh6wJUm3OqbXlY4pucEXTfcO5/s=
X-Gm-Gg: AYBFou3SOxBTlCT5ql/Os8DDxAmmz/aKdHPEMp5kWczKzmytJ5LuBH0u1H6o0a8npmn
	5EC+JVSKxHDz4rvkusMVjBSJnhZJ8FOSoIRhF4dKi7X3HcPX7q8MbSZ/kLV4pjz3REn9Gn8xNpv
	qr3UHe7X3UjY3/84BFsxILhPekAtUhMGyzI1Z6QFiBAPDuBc3TMJK3ZHnVZCpSWQg5ZN8eS5MEU
	98SjZenjDAphU8pgz1v2Rd19QE961dhAsHNFWVyyAN84p37wcZIzxHlCxJ9flhERw3o94H9v0WU
	ct3f8gI15YpY3b46GHGrUQDIvzVzprOSU1my3AiP+ZbF8RjgW86GiS1Xwe6HDRQnVEukmjbiDer
	oZbB34wKadEzEofMqnR93DLjx+Ukpkw29px1HVjydDbmpCpbAfr7Fy17jN6RO7ZG4sjnBP03y57
	ixjtAEPNHAW8vOsJQsMlfcbZ4JzpK1jT0yBMbIiPERQwzS/opzORSh/ldOKfyrXLynUg7WtBuqf
	uL+LbSIZNUM5L4NPSvS1ufhr2HhUnlxPsbykEX/DMeWdHreboHRga9DBBsO1ssY4kfMfztj+977
	0CaLsbZnfGgn3CICBk1sm3AiFTdC6oHwCIElK5Zcbc5UHvz/V0XUMdPA9OyReA==
X-Received: by 2002:a05:7300:de06:b0:35e:9c54:d41b with SMTP id 5a478bee46e88-36a2017372amr6688850eec.21.1793264437342;
        Thu, 29 Oct 2026 02:00:37 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.02.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:00:36 -0700 (PDT)
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
Subject: [RFC PATCH 10/14] power/supply: add support for x86 macs in macsmc-power
Date: Thu, 29 Oct 2026 04:52:07 -0400
Message-ID: <20261029085504.3547-11-atharvatiwarilinuxdev@gmail.com>
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

Make macsmc-power work on Intel Macs, as a replacement for
acpi-sbs. It exposes a lot more sensors than acpi-sbs, such
as voltage, current, power, temperature, charge and health
info, and also the adapter state.

It also adds a charge limit, which acpi-sbs doesn't offer.

And now we have power stats on non-mobile macs as well (iMacs,
MacPros,etc), using macsmc-ac.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/power/supply/macsmc-power.c | 751 ++++++++++++++++++++++------
 1 file changed, 606 insertions(+), 145 deletions(-)

diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/macsmc-power.c
index ced37a701..1d64d8185 100644
--- a/drivers/power/supply/macsmc-power.c
+++ b/drivers/power/supply/macsmc-power.c
@@ -7,8 +7,11 @@
  * on Apple Silicon systems.
  *
  * Copyright The Asahi Linux Contributors
+ *
+ * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/devm-helpers.h>
@@ -80,12 +83,16 @@ struct macsmc_power {
 	char serial_number[MAX_STRING_LENGTH];
 	char mfg_date[MAX_STRING_LENGTH];
 
+	bool has_battery;
+
 	/* Supported feature flags based on SMC key presence */
 	bool has_chwa; /* Charge limit (Modern firmware) */
-	bool has_chls; /* Charge limit (Older firmware) */
+	bool has_chls; /* Charge limit (Older firmware And New firmware on Intel macs) */
 	bool has_ch0i; /* Force discharge (Older firmware) */
 	bool has_ch0c; /* Inhibit charge (Older firmware) */
 	bool has_chte; /* Inhibit charge (Modern firmware) */
+	bool has_pd0r; /* AC Adapter current power in watts (Old Intel macs) */
+
 	/*
 	 * Battery critical key is 1 byte and charge key is little endian
 	 * (Modern firmware)
@@ -94,7 +101,9 @@ struct macsmc_power {
 
 	u8 num_cells;
 	int nominal_voltage_mv;
+	unsigned long long adapter_status;
 
+	struct acpi_device *adapter;
 	struct notifier_block nb;
 	struct work_struct critical_work;
 	bool emergency_shutdown_triggered;
@@ -195,6 +204,37 @@ static int macsmc_battery_get_status(struct macsmc_power *power)
 	return POWER_SUPPLY_STATUS_CHARGING;
 }
 
+static int macsmc_battery_acpi_get_status(struct macsmc_power *power)
+{
+	int ret;
+	s16 vs16;
+	u16 vu16;
+
+	ret = apple_smc_read_s16(power->smc, SMC_KEY(B0AC), &vs16);
+	if (ret < 0)
+		return ret;
+
+	ret = apple_smc_read_u16(power->smc, SMC_KEY(BRSC), &vu16);
+	if (ret < 0)
+		return ret;
+
+	vu16 = swab16(vu16);
+	vs16 = (s16)swab16(vs16);
+
+	if (power->adapter_status) {
+		if (vu16 == 100 && vs16 <= 0)
+			return POWER_SUPPLY_STATUS_FULL;
+
+		if (vs16 > 0)
+			return POWER_SUPPLY_STATUS_CHARGING;
+
+		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+	}
+
+	return POWER_SUPPLY_STATUS_DISCHARGING;
+}
+
+
 static int macsmc_battery_get_charge_behaviour(struct macsmc_power *power)
 {
 	int ret;
@@ -322,6 +362,198 @@ static int macsmc_battery_get_capacity_level(struct macsmc_power *power)
 		return POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
 }
 
+static int macsmc_battery_acpi_get_capacity_level(struct macsmc_power *power)
+{
+	int ret;
+	u16 vu16;
+
+	ret = apple_smc_read_u16(power->smc, SMC_KEY(BRSC), &vu16);
+	if (ret < 0)
+		return ret;
+
+	vu16 = swab16(vu16);
+
+	if (vu16 <= 5)
+		return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+	if (vu16 <= 20)
+		return POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+	if (vu16 <= 80)
+		return POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+	if (vu16 < 100)
+		return POWER_SUPPLY_CAPACITY_LEVEL_HIGH;
+
+	return POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+}
+
+static int macsmc_battery_acpi_read_f32_scaled(struct apple_smc *smc, smc_key key,
+	int *p, int scale)
+{
+	u32 fval;
+	u64 val;
+	int ret, exp;
+
+	ret = apple_smc_read_u32(smc, key, &fval);
+	if (ret < 0)
+		return ret;
+
+	val = (u64)((fval & GENMASK(22, 0)) | BIT(23));
+	exp = ((fval >> 23) & 0xff) - 127 - 23;
+
+	val *= (u64)scale;
+
+	if (exp > 63)
+		val = U64_MAX;
+	else if (exp < -63)
+		val = 0;
+	else if (exp < 0)
+		val >>= -exp;
+	else if (exp != 0 &&
+		 (val & ~((1ULL << (64 - exp)) - 1)))
+		val = U64_MAX;
+	else
+		val <<= exp;
+
+	if (fval & BIT(31)) {
+		if (val > (u64)INT_MAX + 1)
+			*p = INT_MIN;
+		else
+			*p = -(int)val;
+	} else {
+		if (val > INT_MAX)
+			*p = INT_MAX;
+		else
+			*p = (int)val;
+	}
+
+	return 0;
+}
+
+static int macsmc_battery_acpi_read(struct apple_smc *smc, smc_key key, int *val,
+	int scale)
+{
+	int ret;
+	struct apple_smc_key_info info;
+
+	ret = apple_smc_get_key_info(smc, key, &info);
+	if (ret)
+		return ret;
+
+	switch (info.type_code) {
+	/* 32-bit IEEE 754 float */
+	case __SMC_KEY('f', 'l', 't', ' '): {
+		int flt_ = 0;
+
+		ret = macsmc_battery_acpi_read_f32_scaled(smc, key, &flt_, scale);
+		if (ret)
+			return ret;
+
+		*val = flt_;
+		break;
+	}
+
+	/* 3.13 fixed point decimal */
+	case __SMC_KEY('f', 'p', '3', 'd'): {
+		u16 fp3d;
+
+		ret = apple_smc_read_u16(smc, key, &fp3d);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp3d), scale, BIT(13));
+		break;
+	}
+
+	/* 5.11 fixed point decimal */
+	case __SMC_KEY('f', 'p', '5', 'b'): {
+		u16 fp5b;
+
+		ret = apple_smc_read_u16(smc, key, &fp5b);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp5b), scale, BIT(11));
+		break;
+	}
+
+	/* 8.8 fixed point decimal */
+	case __SMC_KEY('f', 'p', '8', '8'): {
+		u16 fp88;
+
+		ret = apple_smc_read_u16(smc, key, &fp88);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp88), scale, BIT(8));
+		break;
+	}
+
+	/* 3.12 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '3', 'c'): {
+		s16 sp3c;
+
+		ret = apple_smc_read_s16(smc, key, &sp3c);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp3c), scale, BIT(12));
+		break;
+	}
+
+	/* 4.11 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '4', 'b'): {
+		s16 sp4b;
+
+		ret = apple_smc_read_s16(smc, key, &sp4b);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp4b), scale, BIT(11));
+		break;
+	}
+
+	/* 5.10 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '5', 'a'): {
+		s16 sp5a;
+
+		ret = apple_smc_read_s16(smc, key, &sp5a);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp5a), scale, BIT(10));
+		break;
+	}
+
+	/* 6.9 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '6', '9'): {
+		s16 sp69;
+
+		ret = apple_smc_read_s16(smc, key, &sp69);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp69), scale, BIT(9));
+		break;
+	}
+
+	/* 7.8 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '7', '8'): {
+		s16 sp78;
+
+		ret = apple_smc_read_s16(smc, key, &sp78);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp78), scale, BIT(8));
+		break;
+	}
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static s16 macsmc_swap_b0rm(struct macsmc_power *power, s16 b0rm)
 {
 	/* B0RM was Big Endian, likely pass through from TI gas gauge */
@@ -343,7 +575,10 @@ static int macsmc_battery_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = macsmc_battery_get_status(power);
+		if (power->smc->is_acpi)
+			val->intval = macsmc_battery_acpi_get_status(power);
+		else
+			val->intval = macsmc_battery_get_status(power);
 		ret = val->intval < 0 ? val->intval : 0;
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -359,36 +594,71 @@ static int macsmc_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0TF), &vu16);
-		val->intval = vu16 == 0xffff ? 0 : vu16 * 60;
+		if (power->smc->is_acpi)
+			val->intval = vu16 == 0xffff ? 0 : swab16(vu16) * 60;
+		else
+			val->intval = vu16 == 0xffff ? 0 : vu16 * 60;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		ret = apple_smc_read_u8(power->smc, SMC_KEY(BUIC), &vu8);
-		val->intval = vu8;
+		if (power->smc->is_acpi) {
+			ret = apple_smc_read_u16(power->smc, SMC_KEY(BRSC), &vu16);
+			val->intval = swab16(vu16);
+		} else {
+			ret = apple_smc_read_u8(power->smc, SMC_KEY(BUIC), &vu8);
+			val->intval = vu8;
+		}
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
-		val->intval = macsmc_battery_get_capacity_level(power);
+		if (power->smc->is_acpi)
+			val->intval = macsmc_battery_acpi_get_capacity_level(power);
+		else
+			val->intval = macsmc_battery_get_capacity_level(power);
 		ret = val->intval < 0 ? val->intval : 0;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0AV), &vu16);
-		val->intval = vu16 * 1000;
+		if (power->smc->is_acpi)
+			val->intval = swab16(vu16) * 1000;
+		else
+			val->intval = vu16 * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		ret = apple_smc_read_s16(power->smc, SMC_KEY(B0AC), &vs16);
-		val->intval = vs16 * 1000;
+		if (power->smc->is_acpi)
+			val->intval = (s16)swab16(vs16) * 1000;
+		else
+			val->intval = vs16 * 1000;
 		break;
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		ret = apple_smc_read_s32(power->smc, SMC_KEY(B0AP), &vs32);
-		val->intval = vs32 * 1000;
+		if (power->smc->is_acpi) {
+			ret = macsmc_battery_acpi_read(power->smc, SMC_KEY(B0AP),
+					&val->intval, 1000000);
+			if (ret < 0)
+				return ret;
+
+			val->intval = -val->intval;
+			}
+		else {
+			ret = apple_smc_read_s32(power->smc, SMC_KEY(B0AP), &vs32);
+			val->intval = vs32 * 1000;
+		}
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(BITV), &vu16);
-		val->intval = vu16 * 1000;
+		if (power->smc->is_acpi)
+			val->intval = swab16(vu16) * 1000;
+		else
+			val->intval = vu16 * 1000;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 		/* Calculate total max design voltage from per-cell maximum voltage */
-		ret = apple_smc_read_u16(power->smc, SMC_KEY(BVVN), &vu16);
-		val->intval = vu16 * 1000 * power->num_cells;
+		if (power->smc->is_acpi) {
+			ret = apple_smc_read_u16(power->smc, SMC_KEY(BCMV), &vu16);
+			val->intval = swab16(vu16) * 1000 * power->num_cells;
+		} else {
+			ret = apple_smc_read_u16(power->smc, SMC_KEY(BVVN), &vu16);
+			val->intval = vu16 * 1000 * power->num_cells;
+		}
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		/* Lifetime min */
@@ -400,17 +670,36 @@ static int macsmc_battery_get_property(struct power_supply *psy,
 		ret = apple_smc_read_s16(power->smc, SMC_KEY(BLPX), &vs16);
 		val->intval = vs16 * 1000;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		if (power->has_chls) {
+			ret = apple_smc_read_u16(power->smc, SMC_KEY(CHLS), &vu16);
+			val->intval = vu16 & 0xFF;
+		} else {
+			ret = apple_smc_read_u8(power->smc, SMC_KEY(BCLM), &vu8);
+			val->intval = vu8;
+		}
+		break;
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0RC), &vu16);
 		val->intval = vu16 * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
-		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0RI), &vu16);
-		val->intval = vu16 * 1000;
+		if (power->smc->is_acpi) {
+			ret = apple_smc_read_u16(power->smc, SMC_KEY(CHBI), &vu16);
+			val->intval = swab16(vu16) * 1000;
+		} else {
+			ret = apple_smc_read_u16(power->smc, SMC_KEY(B0RI), &vu16);
+			val->intval = vu16 * 1000;
+		}
 		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0RV), &vu16);
-		val->intval = vu16 * 1000;
+		if (power->smc->is_acpi) {
+			ret = apple_smc_read_u16(power->smc, SMC_KEY(CHBV), &vu16);
+			val->intval = swab16(vu16) * 1000;
+		} else {
+			ret = apple_smc_read_u16(power->smc, SMC_KEY(B0RV), &vu16);
+			val->intval = vu16 * 1000;
+		}
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0DC), &vu16);
@@ -418,11 +707,17 @@ static int macsmc_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0FC), &vu16);
-		val->intval = vu16 * 1000;
+		if (power->smc->is_acpi)
+			val->intval = swab16(vu16) * 1000;
+		else
+			val->intval = vu16 * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0RM), &vu16);
-		val->intval = macsmc_swap_b0rm(power, vu16) * 1000;
+		if (power->smc->is_acpi)
+			val->intval = swab16(vu16) * 1000;
+		else
+			val->intval = macsmc_swap_b0rm(power, vu16) * 1000;
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0DC), &vu16);
@@ -430,15 +725,37 @@ static int macsmc_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_FULL:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0FC), &vu16);
-		val->intval = vu16 * power->nominal_voltage_mv;
+		if (power->smc->is_acpi) {
+			if (ret < 0)
+				return ret;
+
+			u16 voltage;
+
+			ret = apple_smc_read_u16(power->smc, SMC_KEY(B0AV), &voltage);
+			val->intval = swab16(vu16) * swab16(voltage);
+		} else
+			val->intval = vu16 * power->nominal_voltage_mv;
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0RM), &vu16);
-		val->intval = macsmc_swap_b0rm(power, vu16) * power->nominal_voltage_mv;
+		if (power->smc->is_acpi) {
+			if (ret < 0)
+				return ret;
+
+			u16 voltage;
+
+			ret = apple_smc_read_u16(power->smc, SMC_KEY(B0AV), &voltage);
+			val->intval = swab16(vu16) * swab16(voltage);
+		} else
+			val->intval = macsmc_swap_b0rm(power, vu16) * power->nominal_voltage_mv;
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
-		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0AT), &vu16);
-		val->intval = vu16 - 2732; /* Kelvin x10 to Celsius x10 */
+		if (power->smc->is_acpi)
+			ret = macsmc_battery_acpi_read(power->smc, SMC_KEY(TB0T), &val->intval, 10);
+		else {
+			ret = apple_smc_read_u16(power->smc, SMC_KEY(B0AT), &vu16);
+			val->intval = vu16 - 2732; /* Kelvin x10 to Celsius x10 */
+		}
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		ret = apple_smc_read_s64(power->smc, SMC_KEY(BAAC), &vs64);
@@ -446,7 +763,10 @@ static int macsmc_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0CT), &vu16);
-		val->intval = vu16;
+		if (power->smc->is_acpi)
+			val->intval = swab16(vu16);
+		else
+			val->intval = vu16;
 		break;
 	case POWER_SUPPLY_PROP_SCOPE:
 		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
@@ -489,6 +809,15 @@ static int macsmc_battery_set_property(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
 		return macsmc_battery_set_charge_behaviour(power, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		if (val->intval > 100 || val->intval < 1)
+			return -EINVAL;
+		if (power->has_chls) {
+			u16 vu16 = val->intval & 0xFF;
+
+			return apple_smc_write_u16(power->smc, SMC_KEY(CHLS), vu16);
+		}
+		return apple_smc_write_u8(power->smc, SMC_KEY(BCLM), (u8) val->intval);
 	default:
 		return -EINVAL;
 	}
@@ -500,6 +829,8 @@ static int macsmc_battery_property_is_writeable(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
 		return true;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		return true;
 	default:
 		return false;
 	}
@@ -524,12 +855,47 @@ static int macsmc_ac_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
-		ret = apple_smc_read_u32(power->smc, SMC_KEY(CHIS), &vu32);
-		val->intval = !!vu32;
+		if (power->smc->is_acpi) {
+			if (power->has_battery)
+				val->intval = power->adapter_status;
+			else
+				val->intval = 1;
+		} else {
+			ret = apple_smc_read_u32(power->smc, SMC_KEY(CHIS), &vu32);
+			val->intval = !!vu32;
+		}
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		if (power->has_battery)
+			ret = macsmc_battery_acpi_read(power->smc, SMC_KEY(ID0R),
+					&val->intval, 1000000);
+		else
+			ret = macsmc_battery_acpi_read(power->smc, SMC_KEY(ID2R),
+					&val->intval, 1000000);
+		break;
+	case POWER_SUPPLY_PROP_POWER_NOW:
+		if (power->has_pd0r)
+			ret = macsmc_battery_acpi_read(power->smc, SMC_KEY(PD0R),
+					&val->intval, 1000000);
+		else if (power->has_battery)
+			ret = macsmc_battery_acpi_read(power->smc, SMC_KEY(PDTR),
+					&val->intval, 1000000);
+		else
+			ret = macsmc_battery_acpi_read(power->smc, SMC_KEY(PD2R),
+					&val->intval, 1000000);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret = apple_smc_read_u16(power->smc, SMC_KEY(AC-n), &vu16);
-		val->intval = vu16 * 1000;
+		if (power->smc->is_acpi) {
+			if (power->has_battery)
+				ret = macsmc_battery_acpi_read(power->smc, SMC_KEY(VD0R),
+						&val->intval, 1000000);
+			else
+				ret = macsmc_battery_acpi_read(power->smc, SMC_KEY(VD2R),
+						&val->intval, 1000000);
+		} else {
+			ret = apple_smc_read_u16(power->smc, SMC_KEY(AC-n), &vu16);
+			val->intval = vu16 * 1000;
+		}
 		break;
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(AC-i), &vu16);
@@ -537,7 +903,10 @@ static int macsmc_ac_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_INPUT_POWER_LIMIT:
 		ret = apple_smc_read_u32(power->smc, SMC_KEY(ACPW), &vu32);
-		val->intval = vu32 * 1000;
+		if (power->smc->is_acpi)
+			val->intval = swab32(vu32) * 1000;
+		else
+			val->intval = vu32 * 1000;
 		break;
 	default:
 		return -EINVAL;
@@ -634,6 +1003,23 @@ static int macsmc_power_event(struct notifier_block *nb, unsigned long event, vo
 	return NOTIFY_DONE;
 }
 
+static void macsmc_power_acpi_notify(acpi_handle handle, u32 event, void *context)
+{
+	struct macsmc_power *power = context;
+
+	if (event == 0x80) {
+		acpi_status status = acpi_evaluate_integer(power->adapter->handle, "_PSR", NULL,
+								&power->adapter_status);
+		if (ACPI_FAILURE(status))
+			return;
+
+		power->adapter_status = !!power->adapter_status;
+		power_supply_changed(power->batt);
+		power_supply_changed(power->ac);
+	}
+}
+
+
 static int macsmc_power_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -670,15 +1056,19 @@ static int macsmc_power_probe(struct platform_device *pdev)
 	 * Check for battery presence.
 	 * B0AV is a fundamental key.
 	 */
+	if (smc->is_acpi && apple_smc_read_flag(power->smc, SMC_KEY(BBIN), &flag) == 0 && flag)
+		has_battery = true;
+
 	if (apple_smc_read_u16(power->smc, SMC_KEY(B0AV), &vu16) == 0 &&
 	    macsmc_battery_get_status(power) > POWER_SUPPLY_STATUS_UNKNOWN)
 		has_battery = true;
 
+	power->has_battery = has_battery;
 	/*
 	 * Check for AC adapter presence.
 	 * CHIS is a fundamental key.
 	 */
-	if (apple_smc_key_exists(smc, SMC_KEY(CHIS)))
+	if (apple_smc_key_exists(smc, SMC_KEY(CHIS)) || smc->is_acpi)
 		has_ac_adapter = true;
 
 	if (!has_battery && !has_ac_adapter)
@@ -694,118 +1084,156 @@ static int macsmc_power_probe(struct platform_device *pdev)
 
 		nprops = 0;
 
-		/* Fundamental properties */
-		props[nprops++] = POWER_SUPPLY_PROP_STATUS;
-		props[nprops++] = POWER_SUPPLY_PROP_PRESENT;
-		props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_NOW;
-		props[nprops++] = POWER_SUPPLY_PROP_CURRENT_NOW;
-		props[nprops++] = POWER_SUPPLY_PROP_POWER_NOW;
-		props[nprops++] = POWER_SUPPLY_PROP_CAPACITY;
-		props[nprops++] = POWER_SUPPLY_PROP_CAPACITY_LEVEL;
-		props[nprops++] = POWER_SUPPLY_PROP_TEMP;
-		props[nprops++] = POWER_SUPPLY_PROP_CYCLE_COUNT;
-		props[nprops++] = POWER_SUPPLY_PROP_HEALTH;
-		props[nprops++] = POWER_SUPPLY_PROP_SCOPE;
-		props[nprops++] = POWER_SUPPLY_PROP_MODEL_NAME;
-		props[nprops++] = POWER_SUPPLY_PROP_SERIAL_NUMBER;
-		props[nprops++] = POWER_SUPPLY_PROP_MANUFACTURE_YEAR;
-		props[nprops++] = POWER_SUPPLY_PROP_MANUFACTURE_MONTH;
-		props[nprops++] = POWER_SUPPLY_PROP_MANUFACTURE_DAY;
-
-		/* Extended properties usually present */
-		props[nprops++] = POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW;
-		props[nprops++] = POWER_SUPPLY_PROP_TIME_TO_FULL_NOW;
-		props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN;
-		props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN;
-		props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_MIN;
-		props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_MAX;
-		props[nprops++] = POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT;
-		props[nprops++] = POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
-		props[nprops++] = POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE;
-		props[nprops++] = POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN;
-		props[nprops++] = POWER_SUPPLY_PROP_CHARGE_FULL;
-		props[nprops++] = POWER_SUPPLY_PROP_CHARGE_NOW;
-		props[nprops++] = POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN;
-		props[nprops++] = POWER_SUPPLY_PROP_ENERGY_FULL;
-		props[nprops++] = POWER_SUPPLY_PROP_ENERGY_NOW;
-		props[nprops++] = POWER_SUPPLY_PROP_CHARGE_COUNTER;
-
-		/* Detect features based on key availability */
-		if (apple_smc_key_exists(smc, SMC_KEY(CHTE)))
-			power->has_chte = true;
-		if (apple_smc_key_exists(smc, SMC_KEY(CH0C)))
-			power->has_ch0c = true;
-		if (apple_smc_key_exists(smc, SMC_KEY(CH0I)))
-			power->has_ch0i = true;
-
-		ret = apple_smc_get_key_info(power->smc, SMC_KEY(BCF0), &info);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to determine BCF0 key size\n");
-			return ret;
-		}
-		if (info.size == 1)
-			power->fw_ge_27 = true;
-		else if (info.size == 4)
-			power->fw_ge_27 = false;
-		else {
-			dev_err(&pdev->dev, "Unexpected BCF0 key size %d\n", info.size);
-			return -EIO;
-		}
-
-		/* Reset "Optimised Battery Charging" flags to default state */
-		if (power->has_chte)
-			apple_smc_write_u32(smc, SMC_KEY(CHTE), 0);
-		else if (power->has_ch0c)
-			apple_smc_write_u8(smc, SMC_KEY(CH0C), 0);
-
-		if (power->has_ch0i)
-			apple_smc_write_u8(smc, SMC_KEY(CH0I), 0);
-
-		apple_smc_write_u8(smc, SMC_KEY(CH0K), 0);
-		apple_smc_write_u8(smc, SMC_KEY(CH0B), 0);
-
-		/* Configure charge behaviour if supported */
-		if (power->has_ch0i || power->has_ch0c || power->has_chte) {
-			props[nprops++] = POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR;
-
-			power->batt_desc.charge_behaviours =
-				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO);
+		if (smc->is_acpi) {
+			props[nprops++] = POWER_SUPPLY_PROP_STATUS;
+			props[nprops++] = POWER_SUPPLY_PROP_PRESENT;
+			props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_NOW;
+			props[nprops++] = POWER_SUPPLY_PROP_CURRENT_NOW;
+			props[nprops++] = POWER_SUPPLY_PROP_CAPACITY;
+			props[nprops++] = POWER_SUPPLY_PROP_CAPACITY_LEVEL;
+			props[nprops++] = POWER_SUPPLY_PROP_TEMP;
+			props[nprops++] = POWER_SUPPLY_PROP_CYCLE_COUNT;
+			props[nprops++] = POWER_SUPPLY_PROP_HEALTH;
+			props[nprops++] = POWER_SUPPLY_PROP_SCOPE;
+			props[nprops++] = POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
+			props[nprops++] = POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE;
+			props[nprops++] = POWER_SUPPLY_PROP_TIME_TO_FULL_NOW;
+			props[nprops++] = POWER_SUPPLY_PROP_CHARGE_FULL;
+			props[nprops++] = POWER_SUPPLY_PROP_CHARGE_NOW;
+			props[nprops++] = POWER_SUPPLY_PROP_ENERGY_FULL;
+			props[nprops++] = POWER_SUPPLY_PROP_ENERGY_NOW;
+
+			if (apple_smc_key_exists(smc, SMC_KEY(CHLS)))
+				power->has_chls = true;
+			if (power->has_chls || apple_smc_key_exists(smc, SMC_KEY(BCLM)))
+				props[nprops++] = POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD;
+			if (apple_smc_key_exists(smc, SMC_KEY(B0AP)))
+				props[nprops++] = POWER_SUPPLY_PROP_POWER_NOW;
+			if (apple_smc_key_exists(smc, SMC_KEY(B0TE)))
+				props[nprops++] = POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW;
+			if (apple_smc_key_exists(smc, SMC_KEY(BITV)))
+				props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN;
+			if (apple_smc_key_exists(smc, SMC_KEY(BCMV)))
+				props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN;
+
+			if (apple_smc_key_exists(smc, SMC_KEY(BC3V)))
+				power->num_cells = 3;
+			else
+				power->num_cells = 2;
+		} else {
+			/* Fundamental properties */
+			props[nprops++] = POWER_SUPPLY_PROP_STATUS;
+			props[nprops++] = POWER_SUPPLY_PROP_PRESENT;
+			props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_NOW;
+			props[nprops++] = POWER_SUPPLY_PROP_CURRENT_NOW;
+			props[nprops++] = POWER_SUPPLY_PROP_POWER_NOW;
+			props[nprops++] = POWER_SUPPLY_PROP_CAPACITY;
+			props[nprops++] = POWER_SUPPLY_PROP_CAPACITY_LEVEL;
+			props[nprops++] = POWER_SUPPLY_PROP_TEMP;
+			props[nprops++] = POWER_SUPPLY_PROP_CYCLE_COUNT;
+			props[nprops++] = POWER_SUPPLY_PROP_HEALTH;
+			props[nprops++] = POWER_SUPPLY_PROP_SCOPE;
+			props[nprops++] = POWER_SUPPLY_PROP_MODEL_NAME;
+			props[nprops++] = POWER_SUPPLY_PROP_SERIAL_NUMBER;
+			props[nprops++] = POWER_SUPPLY_PROP_MANUFACTURE_YEAR;
+			props[nprops++] = POWER_SUPPLY_PROP_MANUFACTURE_MONTH;
+			props[nprops++] = POWER_SUPPLY_PROP_MANUFACTURE_DAY;
+
+			/* Extended properties usually present */
+			props[nprops++] = POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW;
+			props[nprops++] = POWER_SUPPLY_PROP_TIME_TO_FULL_NOW;
+			props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN;
+			props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN;
+			props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_MIN;
+			props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_MAX;
+			props[nprops++] = POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT;
+			props[nprops++] = POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
+			props[nprops++] = POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE;
+			props[nprops++] = POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN;
+			props[nprops++] = POWER_SUPPLY_PROP_CHARGE_FULL;
+			props[nprops++] = POWER_SUPPLY_PROP_CHARGE_NOW;
+			props[nprops++] = POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN;
+			props[nprops++] = POWER_SUPPLY_PROP_ENERGY_FULL;
+			props[nprops++] = POWER_SUPPLY_PROP_ENERGY_NOW;
+			props[nprops++] = POWER_SUPPLY_PROP_CHARGE_COUNTER;
+
+			/* Detect features based on key availability */
+			if (apple_smc_key_exists(smc, SMC_KEY(CHTE)))
+				power->has_chte = true;
+			if (apple_smc_key_exists(smc, SMC_KEY(CH0C)))
+				power->has_ch0c = true;
+			if (apple_smc_key_exists(smc, SMC_KEY(CH0I)))
+				power->has_ch0i = true;
+
+			ret = apple_smc_get_key_info(power->smc, SMC_KEY(BCF0), &info);
+			if (ret) {
+				dev_err(&pdev->dev, "Failed to determine BCF0 key size\n");
+				return ret;
+			}
+			if (info.size == 1)
+				power->fw_ge_27 = true;
+			else if (info.size == 4)
+				power->fw_ge_27 = false;
+			else {
+				dev_err(&pdev->dev, "Unexpected BCF0 key size %d\n", info.size);
+				return -EIO;
+			}
+
+			/* Reset "Optimised Battery Charging" flags to default state */
+			if (power->has_chte)
+				apple_smc_write_u32(smc, SMC_KEY(CHTE), 0);
+			else if (power->has_ch0c)
+				apple_smc_write_u8(smc, SMC_KEY(CH0C), 0);
 
 			if (power->has_ch0i)
-				power->batt_desc.charge_behaviours |=
-					BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE);
-
-			if (power->has_chte || power->has_ch0c)
-				power->batt_desc.charge_behaviours |=
-					BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE);
+				apple_smc_write_u8(smc, SMC_KEY(CH0I), 0);
+
+			apple_smc_write_u8(smc, SMC_KEY(CH0K), 0);
+			apple_smc_write_u8(smc, SMC_KEY(CH0B), 0);
+
+			/* Configure charge behaviour if supported */
+			if (power->has_ch0i || power->has_ch0c || power->has_chte) {
+				props[nprops++] = POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR;
+
+				power->batt_desc.charge_behaviours =
+					BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO);
+
+				if (power->has_ch0i)
+					power->batt_desc.charge_behaviours |=
+						BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE);
+
+				if (power->has_chte || power->has_ch0c)
+					power->batt_desc.charge_behaviours |=
+						BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE);
+			}
+
+			/* Detect charge limit method (CHWA vs CHLS) */
+			if (apple_smc_read_flag(power->smc, SMC_KEY(CHWA), &flag) == 0)
+				power->has_chwa = true;
+			else if (apple_smc_read_u16(power->smc, SMC_KEY(CHLS), &vu16) >= 0)
+				power->has_chls = true;
+
+			/* Fetch identity strings */
+			apple_smc_read(smc, SMC_KEY(BMDN), power->model_name,
+				       sizeof(power->model_name) - 1);
+			apple_smc_read(smc, SMC_KEY(BMSN), power->serial_number,
+				       sizeof(power->serial_number) - 1);
+			apple_smc_read(smc, SMC_KEY(BMDT), power->mfg_date,
+				       sizeof(power->mfg_date) - 1);
+
+			apple_smc_read_u8(power->smc, SMC_KEY(BNCB), &power->num_cells);
+			power->nominal_voltage_mv = MACSMC_NOMINAL_CELL_VOLTAGE_MV *
+							power->num_cells;
+
+			/* Enable critical shutdown notifications by reading status once */
+			macsmc_battery_read_bcf0(power, &val32);
 		}
-
-		/* Detect charge limit method (CHWA vs CHLS) */
-		if (apple_smc_read_flag(power->smc, SMC_KEY(CHWA), &flag) == 0)
-			power->has_chwa = true;
-		else if (apple_smc_read_u16(power->smc, SMC_KEY(CHLS), &vu16) >= 0)
-			power->has_chls = true;
-
 		if (nprops > MACSMC_MAX_BATT_PROPS)
 			return -ENOMEM;
 
 		power->batt_desc.properties = props;
 		power->batt_desc.num_properties = nprops;
 
-		/* Fetch identity strings */
-		apple_smc_read(smc, SMC_KEY(BMDN), power->model_name,
-			       sizeof(power->model_name) - 1);
-		apple_smc_read(smc, SMC_KEY(BMSN), power->serial_number,
-			       sizeof(power->serial_number) - 1);
-		apple_smc_read(smc, SMC_KEY(BMDT), power->mfg_date,
-			       sizeof(power->mfg_date) - 1);
-
-		apple_smc_read_u8(power->smc, SMC_KEY(BNCB), &power->num_cells);
-		power->nominal_voltage_mv = MACSMC_NOMINAL_CELL_VOLTAGE_MV * power->num_cells;
-
-		/* Enable critical shutdown notifications by reading status once */
-		macsmc_battery_read_bcf0(power, &val32);
-
 		psy_cfg.drv_data = power;
 		power->batt = devm_power_supply_register(dev, &power->batt_desc, &psy_cfg);
 		if (IS_ERR(power->batt)) {
@@ -829,16 +1257,27 @@ static int macsmc_power_probe(struct platform_device *pdev)
 		/* Online status is fundamental */
 		props[nprops++] = POWER_SUPPLY_PROP_ONLINE;
 
-		/* Input power limits are usually available */
-		if (apple_smc_key_exists(power->smc, SMC_KEY(ACPW)))
-			props[nprops++] = POWER_SUPPLY_PROP_INPUT_POWER_LIMIT;
-
-		/* macOS 15.4+ firmware dropped legacy AC keys (AC-n, AC-i) */
-		if (apple_smc_read_u16(power->smc, SMC_KEY(AC-n), &vu16) >= 0) {
-			props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_NOW;
-			props[nprops++] = POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
+		if (smc->is_acpi) {
+			props[nprops++] = POWER_SUPPLY_PROP_CURRENT_NOW;
+			props[nprops++] = POWER_SUPPLY_PROP_POWER_NOW;
+			if (apple_smc_key_exists(power->smc, SMC_KEY(PD0R)))
+				power->has_pd0r = true;
+			/* MacBookPro5,x and 7,x dosent have VD0R key or any equivalent */
+			if (!power->has_battery || apple_smc_key_exists(power->smc, SMC_KEY(VD0R)))
+				props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_NOW;
+			if (apple_smc_key_exists(power->smc, SMC_KEY(ACPW)))
+				props[nprops++] = POWER_SUPPLY_PROP_INPUT_POWER_LIMIT;
+		} else {
+			/* Input power limits are usually available */
+			if (apple_smc_key_exists(power->smc, SMC_KEY(ACPW)))
+				props[nprops++] = POWER_SUPPLY_PROP_INPUT_POWER_LIMIT;
+
+			/* macOS 15.4+ firmware dropped legacy AC keys (AC-n, AC-i) */
+			if (apple_smc_read_u16(power->smc, SMC_KEY(AC-n), &vu16) >= 0) {
+				props[nprops++] = POWER_SUPPLY_PROP_VOLTAGE_NOW;
+				props[nprops++] = POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
+			}
 		}
-
 		if (nprops > MACSMC_MAX_AC_PROPS)
 			return -ENOMEM;
 
@@ -858,9 +1297,26 @@ static int macsmc_power_probe(struct platform_device *pdev)
 	if (!power->batt && !power->ac)
 		return -ENODEV;
 
-	power->nb.notifier_call = macsmc_power_event;
-	blocking_notifier_chain_register(smc->event_handlers, &power->nb);
+	if (!smc->is_acpi) {
+		power->nb.notifier_call = macsmc_power_event;
+		blocking_notifier_chain_register(smc->event_handlers, &power->nb);
+	} else if (power->has_battery) {
+		power->adapter = acpi_dev_get_first_match_dev("ACPI0003", NULL, -1);
+		if (!power->adapter)
+			return -ENODEV;
 
+		ret = acpi_dev_install_notify_handler(power->adapter, ACPI_DEVICE_NOTIFY,
+					macsmc_power_acpi_notify, power);
+		if (ret)
+			return ret;
+
+		acpi_status status = acpi_evaluate_integer(power->adapter->handle, "_PSR", NULL,
+					&power->adapter_status);
+		if (ACPI_FAILURE(status))
+			return -EIO;
+
+		power->adapter_status = !!power->adapter_status;
+	}
 	return 0;
 }
 
@@ -868,7 +1324,11 @@ static void macsmc_power_remove(struct platform_device *pdev)
 {
 	struct macsmc_power *power = dev_get_drvdata(&pdev->dev);
 
-	blocking_notifier_chain_unregister(power->smc->event_handlers, &power->nb);
+	if (!power->smc->is_acpi)
+		blocking_notifier_chain_unregister(power->smc->event_handlers, &power->nb);
+	else
+		acpi_dev_remove_notify_handler(power->adapter, ACPI_DEVICE_NOTIFY,
+				macsmc_power_acpi_notify);
 }
 
 static const struct platform_device_id macsmc_power_id[] = {
@@ -891,3 +1351,4 @@ MODULE_LICENSE("Dual MIT/GPL");
 MODULE_DESCRIPTION("Apple SMC battery and power management driver");
 MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
 MODULE_AUTHOR("Michael Reeves <michael.reeves077@gmail.com>");
+MODULE_ALIAS("platform:macsmc-power");
-- 
2.55.0

