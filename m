Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413AD40587A
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154268; cv=none; b=eaI6HeOhP7UuvPYfddUCReShnL4GX388Fb/ZJ2iR0xdL2lk4XAlgAa7xO2RxyVlsqFS8BfMfvUUORzoPh613cOrhDXSxKNrfEdP4EKkt54p+/xaXpjW88bLVS6zKUSrMFVPv91Rsots90Qw3iru6E756l1lpPQ1VtGSKON/O8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154268; c=relaxed/simple;
	bh=iy90S821r7vCDS/x2YS8oV7bzZLylqWa3kEXWERJwVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5dR5+4pyo/dAMcjQ0hvOr1oaey43Y9uZUK+1bnjwXMVAOk3HR/6Iav7/zDmaHcen8MrjBUUwZs2Im5O+l23AxhGsOHPyWkiumCZd52G38LJHWiZlmZNPs5mBcDLuEGpzpiMn9PGgqHPVBlXSOYgNXLQvMxtMQYzEXdA0rGykqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=EYJ4tiol; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="EYJ4tiol"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954afac04bso31110755e9.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 05:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785154264; x=1785759064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eP95ZPeS8Uq3g1fOmw+bjaH0iUiNCmHgM7HcfPKHBbU=;
        b=EYJ4tiolXMB9K4I7VyAdvmfJo/35YYBtC3CVcNmvY5y8A2yP0kgabVnhUAjecwRnXe
         ploOeHaQUGNY2DZyGu4iXKlpXVqrg5IKuLIoA+XGsPlvWjEst2B0pefL106veJ+SAf1D
         YlTl3ecI/3s8VdXM2aSHahf5gB3q7/aBgOH/KDx+c4FfNoLKTjHCK6xKHi9B9wICsiZh
         PS0gx6HKSGqWbRrHbPeryVRQX9NmXxX5GE5SJ/uPlH/IR/dlNyNaBpbmtuOYkKrUUniK
         w+HczXV6b46VaildrhR5lwyN4dt9shnp1mSCEXrwfAe69dd3X/gNF3Fe/CrLqELs+vKI
         Pd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154264; x=1785759064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eP95ZPeS8Uq3g1fOmw+bjaH0iUiNCmHgM7HcfPKHBbU=;
        b=Wgq84rpNYmFh6Ji4LtGo/9LTx9HeaAxT0K1ibz2HhfazQAr+b0tkZ3e2UeU0829TYV
         OycOHsY2X9eeD0tBPVXQUuHnwxg2yUc0uT9NDKnv3uNODisK1KjvEgSrNXXOHgGDvKMn
         Yg9sam9CnEmnFjYrX+Is8UwpBJqwxWQA5Z8Jcio1Xp4BJMpPTeAyc8+rhfse43A8Rd7o
         pbh3iMKSYaSb53Us0t4a5Ctfxa6pnHglooiZG2kOTXNSxQ/K6+kQzxbMo137tWKEtPrq
         PAqSYkTTfEBzG7XZH1T1umBl0YE+8cPBXJ66uF+FxG5o2SAcmDf+tBChCQJgh/1nzX44
         cpOg==
X-Forwarded-Encrypted: i=1; AHgh+RrzpGUQ9ImmrVuV1+zsiqacAnrhv7J1mIZJSSieoitvgjPIcNxJ18kj2ggevatrYd4PCZpcrXN624c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDy6DOlpSBEAdLvkKEqG5VKTsNoWKB+ek7DfiXkDfwhGp30VC
	mzRl0YltuwmvQLPeq+1PzW/q2wwa+hBDVfvM0c5NobTYgMrbsGSSvmuh8RrASqaRKpE=
X-Gm-Gg: AR+sD11O8umJGCMa/loaNHPwXPDI2QRNmzPGvHvdJhUgFqWP/Mbjv29WfGLiW9toanC
	kWx9Yjc791kXjTjj/cEo27NaywuaGDEqiQsdHmiLesWuBUu+B75NGYd1/IBJsjtjsS1EAaZSlWd
	gITh/sJdoJSsWc9o7BzzN9JBJ/sZKzchEwHYw7kKzbBDM+5iiLBAeQ6azmOngh2dWYoVWaJUWig
	yQrINRLV2QaGKENToFi3x1TDi4F7Nyz/0vHuaTGwD9kNlagxbrFV7D6c5P6Zr0XEY5MZUm09utg
	1UgukZDIOu+ShKoQPGpCd/Sqrl4VfsKR9ncNtTeBKrhkDyYfFGV44mjhjeX30FkqV21Rq98NBjz
	WJ60cAAYgAcLWnKVqWuFq8SR2JgAYw3oCJFMNpNXLeh2eG6mzOuCWpDcZJTlEJ60rxRQdgED1pW
	6aBXTKhE+cRUTSkk0nBY8=
X-Received: by 2002:a05:600c:c16d:b0:493:f822:ac5e with SMTP id 5b1f17b1804b1-496b56f1308mr96598005e9.23.1785154264182;
        Mon, 27 Jul 2026 05:11:04 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f302f8sm211778055e9.12.2026.07.27.05.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:11:03 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 13:10:44 +0100
Subject: [PATCH 6/9] ACPI: dptf: drop unused assignment of
 acpi_device_id::driver_data
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-acpi-refactor-v1-6-ff900aa326ee@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785154252; l=2541;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=iy90S821r7vCDS/x2YS8oV7bzZLylqWa3kEXWERJwVk=;
 b=xtjCUJ6GoOgZ2wQg74HHYnEspaLZYECRG9U7Vj6yWa7RCTMDKR/PPofo9LHHFL+JQcluuW2hy
 eZmvz7mleUPCfxpwOQK6HZOn8zKRUipnuMO2pGX8LYu72eHBr9MdCzM
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

These modules set the acpi_device_id::driver_data to 0 but
the field is not actually used within the module, we can
just drop it from the table.

While we are at it - used a named initializer for the
acpi_device_id::id field to increase readability and
drop explicitly setting the list terminator fields.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/acpi/dptf/dptf_pch_fivr.c | 14 +++++++-------
 drivers/acpi/dptf/dptf_power.c    | 38 +++++++++++++++++++-------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index 8d7e555929d3..d23867f70b28 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -147,13 +147,13 @@ static void pch_fivr_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id pch_fivr_device_ids[] = {
-	{"INTC1045", 0},
-	{"INTC1049", 0},
-	{"INTC1064", 0},
-	{"INTC106B", 0},
-	{"INTC10A3", 0},
-	{"INTC10D7", 0},
-	{"", 0},
+	{ .id = "INTC1045" },
+	{ .id = "INTC1049" },
+	{ .id = "INTC1064" },
+	{ .id = "INTC106B" },
+	{ .id = "INTC10A3" },
+	{ .id = "INTC10D7" },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, pch_fivr_device_ids);
 
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index 55ccbb8ddbe3..065831bce8c0 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -224,25 +224,25 @@ static void dptf_power_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id int3407_device_ids[] = {
-	{"INT3407", 0},
-	{"INT3532", 0},
-	{"INTC1047", 0},
-	{"INTC1050", 0},
-	{"INTC1060", 0},
-	{"INTC1061", 0},
-	{"INTC1065", 0},
-	{"INTC1066", 0},
-	{"INTC106C", 0},
-	{"INTC106D", 0},
-	{"INTC10A4", 0},
-	{"INTC10A5", 0},
-	{"INTC10D8", 0},
-	{"INTC10D9", 0},
-	{"INTC1100", 0},
-	{"INTC1101", 0},
-	{"INTC10F7", 0},
-	{"INTC10F8", 0},
-	{"", 0},
+	{ .id = "INT3407" },
+	{ .id = "INT3532" },
+	{ .id = "INTC1047" },
+	{ .id = "INTC1050" },
+	{ .id = "INTC1060" },
+	{ .id = "INTC1061" },
+	{ .id = "INTC1065" },
+	{ .id = "INTC1066" },
+	{ .id = "INTC106C" },
+	{ .id = "INTC106D" },
+	{ .id = "INTC10A4" },
+	{ .id = "INTC10A5" },
+	{ .id = "INTC10D8" },
+	{ .id = "INTC10D9" },
+	{ .id = "INTC1100" },
+	{ .id = "INTC1101" },
+	{ .id = "INTC10F7" },
+	{ .id = "INTC10F8" },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
 

-- 
2.43.0

