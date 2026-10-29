Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264493;
	b=HihnBD4SAXs+lwb7x6s3q0Ao8RqH31uQgibHA1mJrm+jhEn6ND4iD2ypjJk89X/7U2P1
	 5M60wjowE9NUNEBJj9GArNg2Qn6KqQsLB5+5W1OGmxYm8muJexwU/lgxOU70VKt5DMY2G
	 fgGbJcn2gTens08omODeFxMyopsCK5oK+pdrZpnaCzIz//6MkHubzLRLBx0jvgiZnQ2gu
	 7kA/QJVFIwhnS4JtmQ5pqhE51rCzmGhA0WUtL0Pdm7/Sl4s/V48AP4KjVYIYJdvdkDQN5
	 YRgFgPe/9/U6kE4oNWiphYChj/u/UqQ61KBUT4Z1+V8WJpjaFSkc92L/le2zBuvsOZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5ZHPP80P/K5Og+av73zHRl2Ft2Q1yinNFTFs8Wj9Vvw=;
	b=LeFEPD3fe2w8YSH4N5BPDWZvWNmORq3QNEY6hGKuxbtMZqA7A8Vkynf+4xmZzdXjcaxD
	 Btndf1aP922lqXG+n77JKc9xhZc+GZe1OhdkYKCjMIhgalP6IUqn5unBiZmDLDotaJvKV
	 7UWlT7N78U2nVBtZwLwJjoQHt7tvjXLp0M3hFOwN5g9YPsW1V4ojpFXdpL/XPFqZNHJyj
	 tn4HDiaY9+YDJ/J0QGzlmPrwcHfZKJ7AMjttSkSytt4vfVC7fZ2zErvFTlHu6AFJGZhhx
	 xWX1Mb+pMrxSMZsNWN6YHHrBNk2TgtsbxbL1wKLKKLuAure8CQLDonZmKjuh9YBGw3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CA3LCyJ7;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B9606A329
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 09:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 006B9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CA3LCyJ7
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a17a332ecso2726253eec.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264492; x=1793869292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ZHPP80P/K5Og+av73zHRl2Ft2Q1yinNFTFs8Wj9Vvw=;
        b=CA3LCyJ7nJ/xoJVBGK7euuvFzDooHoTkancn1/gOxLVhjkV9W0IXBNdBCqW/OiX92H
         9gXvxbQ5ViuabsM2dJqowCO25Nhn0OnwZtEr0DGEq1trREc/LmtGBEDHIE1+uJOjFOzK
         xc3mXgwxk1dwMn3lfUNHTlk1yX9y2ij0QeRu6KKP3rTNCIj2saYmL0zm0nbzBivHhcUk
         +MUT5NcNWQ+IQenZp4oOj7GXdjUVtpF16UUjZ9VbmIyylrrQjEGl+1U/aQKidV+fsDBe
         +5j+PrkMZuRgJ7aKoCIDWEYqX4gv0aePmwTjEVe1F0VQVTuVNSwHPI5oGlTatJ1SLARt
         DX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264492; x=1793869292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ZHPP80P/K5Og+av73zHRl2Ft2Q1yinNFTFs8Wj9Vvw=;
        b=Tl00gl81VOt+NHYfAwzTIE260BX3EK3kIZ44LqkA5G0IrdlwBEH3UQNmHG7zk+T7Nd
         ng4gntsj/4nh3pFiaP9UTzENxDSO2s7Y4mGgGr+kgd7djLWaAQe77RrWjHphJfHanUAC
         ndrLrLTCh7p4rI8rvOyii1SR07WUJWg2wXOlWHkl5AoTbk3RjtD3ni0/gNFWLiWusBA1
         EY6E21VX9POfZwUEZDWOogX70EAF9ljyDDyvGDGSW9XhLDUqwvQUn+L9ta332rO60IRB
         VGiWNVFbLOHfQu0br3PScdYX8X6cHBjCNSiD32hPJYtErnNI5Mr+niCBAPrlUJofJhYu
         jqOg==
X-Forwarded-Encrypted: i=1; AKwUvBzaj/nN7+N2OCCWR+TmEckUa+0Y2vtAvrabMxuvmh0pGafAPuh4+AXiYlecL/eWZoYBf1lF8jEobVg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjLw0yUD8ZknAK6JrrnDw10nMU4YwSaHakzbskZ4/OncojwefS
	ugWvX+LPm4afMhHCes841+cH6GjOcuXLPYmS4MYuhwuPbj+YhVZmQt8=
X-Gm-Gg: AYBFou3/FkY6APDWsNEgPw59PJhioSo1E+pmh7fLIBDbQUxd5sXEb3FMx/0F0rw0SaV
	xW3HiSBu9vsyU1S4y/j8TlQC4XOoGPM3uVmV0MNlDKL1GrzR1twQVxQZmhpoqvAvlJEY0NQMLsJ
	yKn+PHDWhMPp6PfbahxlSLdIS8JeZjZ0uBNPYdikuYgt1QN8SeY0rmai0auz0lB+QWmeyWExhlK
	X8BKu9G9e6B3FnNkVh5NHSULffjSOFnKAtyV+EIq0qtY3EOdU5d/IHS7RQurPn6kwDn7lkCi4lB
	cYWorvbLNiHHIjkK5yUQBh3oiT+m4tyTc0UqxTF07DEe21/l/06p8opzUZj/ISfLdST5UgjERp0
	zzpPGeca8Mdyhs+VQhCyyo78Y4C9hW9o9Mm4QFPNvqbvIrJEPtDZNsMZFPyNds4oorB8w+WlL4M
	VOJxxwElX0ZOlFEMM5smOQTA2Ns2FNTcFOm3ptPaRXd/gjHta/CuNSct6/BgMVhJ4O6jAwFjeVw
	emjx5eWOGwN6TFy1bytYuXlFknF/z3loXiW8M1H3V3KtNuALhhQp5Ex7mQLfFuTF/mSjJqZRuzF
	Px1ASMrVAr1dPHC0/LsJJRHjLYBy5r6evppBitT6n0/Xd+0EWkdJyvnmothnsw==
X-Received: by 2002:a05:7300:f587:b0:369:fc38:6821 with SMTP id 5a478bee46e88-36a20113296mr6116491eec.12.1793264491785;
        Thu, 29 Oct 2026 02:01:31 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:01:31 -0700 (PDT)
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
Subject: [RFC PATCH 12/14] hwmon/macsmc: add more types
Date: Thu, 29 Oct 2026 04:52:09 -0400
Message-ID: <20261029085504.3547-13-atharvatiwarilinuxdev@gmail.com>
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

SMC keys come in many data types, and Intel Macs use a lot
that macsmc-hwmon couldn't read, such as the signed fixed
point types like sp1e.

Add support for the common integer and fixed point types,
and allow writing fan speeds.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/hwmon/macsmc-hwmon.c | 310 +++++++++++++++++++++++++++++++++++
 1 file changed, 310 insertions(+)

diff --git a/drivers/hwmon/macsmc-hwmon.c b/drivers/hwmon/macsmc-hwmon.c
index 1500ec2cc..2e74dcd66 100644
--- a/drivers/hwmon/macsmc-hwmon.c
+++ b/drivers/hwmon/macsmc-hwmon.c
@@ -221,6 +221,313 @@ static int macsmc_hwmon_read_key(struct apple_smc *smc,
 			*val = (long)ioft;
 		break;
 	}
+	/* unsigned 8-bit integer */
+	case __SMC_KEY('u', 'i', '8', ' '): {
+		u8 ui8 = 0;
+
+		ret = apple_smc_read_u8(smc, sensor->macsmc_key, &ui8);
+		if (ret)
+			return ret;
+
+		*val = ui8 * scale;
+		break;
+	}
+	/* signed 8-bit integer */
+	case __SMC_KEY('s', 'i', '8', ' '): {
+		s8 si8 = 0;
+
+		ret = apple_smc_read_s8(smc, sensor->macsmc_key, &si8);
+		if (ret)
+			return ret;
+
+		*val = si8 * scale;
+		break;
+	}
+	/* unsigned 16-bit integer */
+	case __SMC_KEY('u', 'i', '1', '6'): {
+		u16 ui16 = 0;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &ui16);
+		if (ret)
+			return ret;
+
+		*val = ui16 * scale;
+		break;
+	}
+	/* signed 16-bit integer */
+	case __SMC_KEY('s', 'i', '1', '6'): {
+		s16 si16 = 0;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &si16);
+		if (ret)
+			return ret;
+
+		*val = si16 * scale;
+		break;
+	}
+	/* unsigned 32-bit integer */
+	case __SMC_KEY('u', 'i', '3', '2'): {
+		u32 ui32 = 0;
+
+		ret = apple_smc_read_u32(smc, sensor->macsmc_key, &ui32);
+		if (ret)
+			return ret;
+
+		*val = ui32 * scale;
+		break;
+	}
+	/* signed 32-bit integer */
+	case __SMC_KEY('s', 'i', '3', '2'): {
+		s32 si32;
+
+		ret = apple_smc_read_s32(smc, sensor->macsmc_key, &si32);
+		if (ret)
+			return ret;
+
+		*val = si32 * scale;
+		break;
+	}
+	/* 2.14 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '2', 'e'): {
+		u16 fp2e;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp2e);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp2e), scale, BIT(14));
+		break;
+	}
+
+	/* 3.13 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '3', 'd'): {
+		u16 fp3d;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp3d);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp3d), scale, BIT(13));
+		break;
+	}
+
+	/* 4.12 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '4', 'c'): {
+		u16 fp4c;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp4c);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp4c), scale, BIT(12));
+		break;
+	}
+
+	/* 5.11 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '5', 'b'): {
+		u16 fp5b;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp5b);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp5b), scale, BIT(11));
+		break;
+	}
+
+	/* 6.10 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '6', 'a'): {
+		u16 fp6a;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp6a);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp6a), scale, BIT(10));
+		break;
+	}
+
+	/* 8.8 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '8', '8'): {
+		u16 fp88;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp88);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp88), scale, BIT(8));
+		break;
+	}
+	/* 14.2 fixed point decimal */
+	case __SMC_KEY('f', 'p', 'e', '2'): {
+		/*
+		 * fpe2 is only used for fan stats and fan control
+		 * so precision is not needed
+		 */
+		u16 fpe2;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fpe2);
+		if (ret)
+			return ret;
+
+		*val = (be16_to_cpu(fpe2) >> 2);
+		break;
+	}
+	/* 1.14 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '1', 'e'): {
+		s16 sp1e;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp1e);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp1e), scale, BIT(14));
+		break;
+	}
+
+	/* 2.13 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '2', 'd'): {
+		s16 sp2d;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp2d);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp2d), scale, BIT(13));
+		break;
+	}
+
+	/* 3.12 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '3', 'c'): {
+		s16 sp3c;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp3c);
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
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp4b);
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
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp5a);
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
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp69);
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
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp78);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp78), scale, BIT(8));
+		break;
+	}
+
+	/* 8.7 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '8', '7'): {
+		s16 sp87;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp87);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp87), scale, BIT(7));
+		break;
+	}
+
+	/* 9.6 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '9', '6'): {
+		s16 sp96;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp96);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp96), scale, BIT(6));
+		break;
+	}
+
+	/* 10.5 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', 'a', '5'): {
+		s16 spa5;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &spa5);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(spa5), scale, BIT(5));
+		break;
+	}
+
+	/* 12.3 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', 'c', '3'): {
+		s16 spc3;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &spc3);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(spc3), scale, BIT(3));
+		break;
+	}
+
+	/* 13.2 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', 'd', '2'): {
+		s16 spd2;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &spd2);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(spd2), scale, BIT(2));
+		break;
+	}
+
+	/* 15.0 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', 'f', '0'): {
+		s16 spf0;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &spf0);
+		if (ret)
+			return ret;
+
+		*val = (s16)be16_to_cpu(spf0) * scale;
+		break;
+	}
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -263,6 +570,9 @@ static int macsmc_hwmon_write_key(struct apple_smc *smc,
 	/* unsigned 8-bit integer */
 	case __SMC_KEY('u', 'i', '8', ' '):
 		return apple_smc_write_u8(smc, sensor->macsmc_key, val);
+	/* 14.2 fixed point decimal */
+	case __SMC_KEY('f', 'p', 'e', '2'):
+		return apple_smc_write_u16(smc, sensor->macsmc_key, cpu_to_be16(val << 2));
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.55.0

