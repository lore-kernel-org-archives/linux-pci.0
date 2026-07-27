Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11840A958
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154273; cv=none; b=jlWbXzNlB11bI686ABq8JZlFTyifyms0CBECihCLiSgq74VzbdZBs/vTIWgDsgqgqN9RZ+k4MLzqcw5dZ0NzzzVZuzVkyyAT6qfUI4g8ed6+B8z4ExxDfSYJH4YxTicYQGUR2ZGuRoF/JXNk8E4WSOWlaTsXgP4DBsvt4l9yQjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154273; c=relaxed/simple;
	bh=e3kFwrE54qrR7j9hf08X7x7yaGkc04oEEErLkv2k6T8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JyKTGTek7Qp6T7SxqWlyOTAyvaQyOOtBxZWhcguYUJyzENm2GwhYtXU3iN2IaRG0szbZZ27quh6gLEN+o+WSq8joauVpAuXrr1dXH1MMz8UcIf7vENA79ZdkqAA/sVw/bMo5VfsVEvdvOfsnXcP/ycXzJsWnEZmOKnCS1DywfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=NRwo8yqz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="NRwo8yqz"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493f6de72faso22580975e9.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785154270; x=1785759070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYfNO8HaF8EPi01gt07T8qMMcubFMIJKbbLH4YUzSjU=;
        b=NRwo8yqzNQuu5kW4UhsvJ5FPerztukUJxRy6xG43Fog4unve2p7NDncCHc4PJ+Nwnb
         XN1DmIP70uCTanpVw45qOOctDV5caEgEdRdOYK6PtZ2UzGklNRXBQ+Tw79qIwORh7SNV
         smr0NhGDHyYR0xUG21as6cB/KYvKUZVnzmSdf6ELWZQxgSKUnjDMj4xc9F6ibyhTzCfh
         bfp4DY3h6w9NnVc+iWQj+zLK4OVZINDcGnNYGebtwUeAqPEGprLyUukXPORMdyBRBKOB
         8X+z5ko6cOGKsiIS51T6WUCm9o+IQL41DeWlI16zDSyZeAAExYLeoRftv+qsf8F2Ua16
         1s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154270; x=1785759070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OYfNO8HaF8EPi01gt07T8qMMcubFMIJKbbLH4YUzSjU=;
        b=d5f3id0aQ8C/yLxWgJGfD0G33zyHAxeHcWVXeiceNnkYdYPjychSsOPBXBAoe3jmzX
         F78j4sK1+qwoK/6ctjTP+l1FwAovTow4Fy1Awd/YAcX2piQlmpxn9gGAmnmdqzGQYmbQ
         p1dRbWiJAAVBNDH0S+V9xX0K0j7ZxQ7Rx2HZhNZbRJAGxD8PdEh+LG2AeNixwdX7C1bi
         8b6sr1w4YkuVpA5VoRNgLavjTwUSjeSSOnop3/pIsMVaTPwPZZODfqgnphXhVfMK2BFu
         GyzO6KtpS8Uan6BU3/j712OvGhOUvmgICfivkbiWn+u8Wx8RxZ0m7ifZcfx8lQuS3hKR
         +cUw==
X-Forwarded-Encrypted: i=1; AHgh+RpfxGprv7VzBErjov+UYW185nritlDL62Bk2SrF+GC2kFXRWtfu8+5yvDrdXaauLWYmiA+16wuXwKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwGRhxj7doQlk9DavXt41+n6aiemruv7GOjjotWaqyncrw9M2/
	nC1Lko7MQ/0X5L/DmGaZDrrqN2r7C7pz62hg0ICkqSH3GqojpHY+AdHRRWRy6KAV/w4=
X-Gm-Gg: AR+sD10ph1uqHA7VYljV7wdtvI+PbwkZ9501la4qjbEaRQItWbydoqnbR3AU1Msxfit
	Cex/8YRfbIMtZS47WWns8aLG/HFMtu8M4Y05P7a+4LQ3DSm475gld0mN0CwNUKMhGj/81t7kaFv
	yuV9RpRrAMNSzDN77lFYV92RyZcveVdiICuwB8fKNST8tm65k0tKMHPoaz/FWGaxqodbb1KfLkc
	u3XQwjXLpPgMI6UoaJ18jAMrxjUfKl41lEPAum7Ozyo6/VCcy7OhG7Z/Bl1PWkoLOqzaueskg0C
	NhFxy2wc1f+mAL9CL711wlPPvjhO31gAAFj2PK7RGlS0sz77k+NaUPwTyvIGaVvu4WHRwaMm6gh
	elZ2bTgIEDS0bR4ZENR8bh+HCVEEgtXGxspuNIP10TWYI47yaUTYk5x9Le4EQ4ryphqKvZ8hfbO
	OBeZjyrXU0W8oCfyIOwUlwLDqlGaSrIA==
X-Received: by 2002:a05:600c:4444:b0:495:6b4c:fccc with SMTP id 5b1f17b1804b1-496b5c7182amr98814975e9.10.1785154269911;
        Mon, 27 Jul 2026 05:11:09 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f302f8sm211778055e9.12.2026.07.27.05.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:11:09 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 13:10:47 +0100
Subject: [PATCH 9/9] ACPI: use a named initializer for acpi_device_id::id
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-acpi-refactor-v1-9-ff900aa326ee@thegoodpenguin.co.uk>
References: <20260727-acpi-refactor-v1-0-ff900aa326ee@thegoodpenguin.co.uk>
In-Reply-To: <20260727-acpi-refactor-v1-0-ff900aa326ee@thegoodpenguin.co.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Zhang Rui <rui.zhang@intel.com>, 
 Kai-Heng Feng <kaihengf@nvidia.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Ira Weiny <iweiny@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 nvdimm@lists.linux.dev, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785154252; l=858;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=e3kFwrE54qrR7j9hf08X7x7yaGkc04oEEErLkv2k6T8=;
 b=wsRNozjg+w8drnieAF7pPxdPTk2dePtttYSw8fmP3QMndGXJ0o823SOn3yUNPQaqnRoaKa8AK
 Jq83mLuCTQUCT2D3wimXdXs1iPMiRgklDO0pAf9DdxAeyLqrdnv2PyD
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a named initializer for the acpi_device_id::id field for
readability and drop setting the list terminator fields
explicitly as well to be consistent with the rest of the kernel
code.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 include/linux/acpi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 60ab50cb8930..b34b483d99f5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -805,10 +805,10 @@ int acpi_mrrm_max_mem_region(void);
 #endif
 
 #define ACPI_CMOS_RTC_IDS	\
-	{ "PNP0B00", },		\
-	{ "PNP0B01", },		\
-	{ "PNP0B02", },		\
-	{ "", }
+	{ .id = "PNP0B00" },		\
+	{ .id = "PNP0B01" },		\
+	{ .id = "PNP0B02" },		\
+	{ }
 
 extern bool cmos_rtc_platform_device_present;
 

-- 
2.43.0

