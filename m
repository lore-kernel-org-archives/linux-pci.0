Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0740099B
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154265; cv=none; b=tq//CKzz/5k7D/p5kAA5TXlOG3BdDfUAABX8yayS10VH+lmP4US935Yh6p4wecN75zDskXKB9h0yKB17nvrdQ3JGuMoSE0i9fp/lZK+eItS776BcEyW3VfIpFwvaZlwEITKIzl+Ke/SApcv/wPm9rRtCJMJiYcM+uKZzfM06W1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154265; c=relaxed/simple;
	bh=zrA6C2Wn6O6irBjX1A7U6/j0mruV7VakTyxcAWQ/gzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iO3t6lorjZhs2DWHcC7AlL+ydivQMSTUG4mip8L45rBtodPjThoEDfvw+9r3aGqlyM0bc1DQJLThYigf2wdAkBQZu+VHH1rWClAaUg2OQXSg5etrCEby4BkFerIJjAvvTRVtAH9HJgbis/ncM7JMfm85IACbu0j9SHG1Lw3Px5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=oEBuiUli; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="oEBuiUli"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49557167508so25964625e9.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 05:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785154260; x=1785759060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1gHEnus99pEhhk1X+Z0rEei8S8+ToTCVA6TNsBFI+8=;
        b=oEBuiUlitaPuWDqFDtpvUpIh+HMwiOT0NK1GwTnsfR0B6FUM7rMjY2868DJKvyPBvQ
         WcUCWTOZbrsXg4HYjhhmoZQDvat0XqwmCDxZ03ZASKgClzanhoPMKpwG3UB0aIiBz1ey
         CFk2pfkNe9/sioaWPszX8HbLcQqFMIPBs0Grk+yreTmGBDuA2qxck3jL26jg3gsWcmd1
         bG6FTz9jnLmspoJC/XaVuxTPuDV2qzRK4MN8uDNaKpjM0pF599B776b6ebSf3JZ0BGTU
         t2cqSC6cCtyG5B37MNBDGK8helxBqa38Qo+eWhWPLrGhijmBMKzli5S0lw5pqCEHyBo1
         +aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154260; x=1785759060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1gHEnus99pEhhk1X+Z0rEei8S8+ToTCVA6TNsBFI+8=;
        b=aaSQGxB+2wGcsuEkFn6wNhlYP4W6lbeajmSrIDvG+Ud4LMDTcbHi6uu2ecABjwDH3W
         5rD2aotVxDy8PRSyqKPbmmdDdeIq7erWl911gMIFHI7V5PhEmTbk6abRulVEo1JYGO00
         /UvSI4bzJQORpGSTwiwTMOIw7LebzbYy6x/LgWbcauVCgu/COYkfJ2BJmix+6z81wnU1
         EZ+ln2fP/HB2LbLiQoVY0NIYQutBncKFCIyYY42ErAqSVNMIpa2hltEeU9/KCzoBj2nD
         s04c9ICWjG5Ut1+VZ3AarTw1BbEb5XyesahgmbLFXO1RfAyzYuRmIixs2zXEEi6OOGBI
         gL3g==
X-Forwarded-Encrypted: i=1; AHgh+RpNHoclj0RVgIMigJtu0tD3BUFg3cJc34VIXYBhpfLkRP88P2mMENu4eZb7SvF2r6kYmT5Cwjxotts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCjhbjHeRTtr/eKCOJOGsJFt9W64nqId/eXCaYd9FIcZSOlMh8
	e3gphgYdrJd8/lkyHPPxYuAcB40/9r6Oj5H24tQLI+StO70aIkN8+wazef8r3GoRpx8=
X-Gm-Gg: AR+sD12+yaDAMmX4miXaVteI2/IC/GISmgHdFz9kzydaPmKlJawp4FaNHOrssPKOx80
	Vt1ekcj+CF69vyeupyoJICG7apCqVj10Fr6+QM57fGHr9Wl8jfdBhN2gcrME3Ju512dJF92ay7U
	yWvMAIEEkqBGNHsDZAx20zPP5DpN4hclZerpcAkKtBkhA5I2yZINbhLA8xPs88yVg3SLXQ5+EV9
	WDXO12wB/TKgWJDyON1YuXtnUWe+Hf3qhaeBhsKnlVr+yAYYAEShorlJLHoq0qLcHzsmnJQ6Nra
	dqn6ETgS3fqqxkI+AMEihbtJnBdaNuq8kmBNl/eWODNENs1xvEPHR1Agh1Dvl4I4IDbeC8zZiU2
	mRkQyu/3BqV8bS+k9765TYU/KZPh8+EUVL0AX0/gpojVe4j6JNu5/X4MYZGGkre/DmGtLw0/gTc
	3uF8mgUFESmCqYgnamQVYlFDH10ApvMQ==
X-Received: by 2002:a05:600c:1906:b0:495:6b8a:5227 with SMTP id 5b1f17b1804b1-496b56ff17cmr116342545e9.23.1785154260529;
        Mon, 27 Jul 2026 05:11:00 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f302f8sm211778055e9.12.2026.07.27.05.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:11:00 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 13:10:42 +0100
Subject: [PATCH 4/9] ACPI: ghes-nvidia: use a named initializer for
 acpi_device_id::id
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-acpi-refactor-v1-4-ff900aa326ee@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785154252; l=732;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=zrA6C2Wn6O6irBjX1A7U6/j0mruV7VakTyxcAWQ/gzY=;
 b=S6PIbfdwzeRS6uAnwlEAg/bFB4cywsN5K95TfQqHoJbODLCpFQlWBQM/pWKmzNszJMLADygl2
 HXSTp5kuGaRAoubKt8FGxqKuHW3tvNk9iqIksjW5VI4dh0qwHh6QbLA
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a named initializer for the acpi_device_id::id field for
readability.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/acpi/apei/ghes-nvidia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvidia.c
index 597275d81de8..1d3a6997a019 100644
--- a/drivers/acpi/apei/ghes-nvidia.c
+++ b/drivers/acpi/apei/ghes-nvidia.c
@@ -130,7 +130,7 @@ static int nvidia_ghes_probe(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id nvidia_ghes_acpi_match[] = {
-	{ "NVDA2012" },
+	{ .id = "NVDA2012" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, nvidia_ghes_acpi_match);

-- 
2.43.0

