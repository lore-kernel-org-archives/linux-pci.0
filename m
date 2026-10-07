Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978F49A3B7
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370192; cv=none; b=MYFtdHpKWZgQ8g5FgC4c67AFzyZRTjhvx6Ob44JncsBuCcijG66HrFjjc/bGUzAgYxLxGHmLUl+qE053X+IAt9NfeSL5/yslL8bzszK4ztJZk8hRzHtP6QiWn/ThyrimwjVoCOUqIz9FdPNTXJ3gE6JybebNxsde3FLse13xuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370192; c=relaxed/simple;
	bh=5B1H9FA7mZy/gFbNTlCD7iwhPS8Ucq4yIS3VU3Z7Aio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8NjuPdVeybuZzaEsk3nOIHJJ+pRRscfOFco3ph6NMHLNyy7n6mJ6Z0uGCS9dCaHeG2OyqmNihHcPvvV0U7RGzin6aj2c+qoV1neRbWKPFKFHSrpAsQSKoOCBtFOhfa9t/KQrNPqh0TbxIhW7pgyqoivcHX6ttqmOlsY0oih2Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMGUdK1O; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMGUdK1O"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso1137302a12.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2026 03:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791370143; x=1791974943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KiCqXelSwhsxxAotTgryiWxi3hHYLhT7SYQdblGbV2w=;
        b=KMGUdK1OpSDMw4BfTyYR8pEniuILqLBYG2dGQWn1ANmOUfrDDq89hdYnoCcnhi9Znz
         PG9LnDcm1TJws9+lVP2aoRrL4Yi43fLCrjub1WcWf11N3Uw4eoEUH6PxEbLw/4ArcEab
         vjMsBdA1jh1fBWEChxRjjOzeilpf5J+jvEFIP9QfMyHy8/Bel+dewyxSg6Q5708Pv5IR
         8CzF4nQUXtoCQN738tnATSgXsvc9XQatrGhdgexLyAkErW+lOl1uD0fqp8s8gNY073ki
         YDpJhnvLCQBACCWJRFVK08EivOSxqvAjLKUTeP/4GnvzKkhwHifLjgauGQXNKEaXJgFB
         IAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791370143; x=1791974943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KiCqXelSwhsxxAotTgryiWxi3hHYLhT7SYQdblGbV2w=;
        b=nBP6Qn5ZFWuCnGH9WyG49oSpUI9w7vYY93+uE5p8wx4XSMz2oRRtM1lBWVGoAPiDrO
         MgrsYDljVla7vLUrXx4mNygObOo37b8Z/69H0+P1vJrHCB6rdhV2rBCS/i/QKGnuTpDA
         oUAxSnl/bHF7BKAzvHOIAAIOqIhMLd58RciEazWCQnbpJZeShA3frtKmIYxY0EiE8d+T
         iMNt4jT9Uv/s7gVw+GeMWxR8FKTLk+mOXITsaStJTomOodjkigBpUehb7A/RXHkBOLhT
         QWFCoTmGXJEPXevfzca6eumyO5qTobtlrYc9qYuQ6dXzSaxuKVxrLSbd2Fha/tDKyrp7
         947w==
X-Forwarded-Encrypted: i=1; AKwUvBzUj7/voVimO4E4Ascl3IdBJ/Tyz7n3YWywm5+nzl4nIEB5neOUDpNrCMbTIK+3dglOd6MMsX+IgjM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwMBddXSs+wKejYkofxknxl+vtwt6FcdQDI9lSY8Hl3m4UYaj3
	Nob0q03OKRGAoODul0KmcRBKBqSJSBuHuGQpYV5iP1Pmyfd7zEImV2SN
X-Gm-Gg: AYBFou2sbTqlfiXi+XLW+SIYhNgWAI0veAXjckv7/QyJ1yCUk644vHadpnZ+z+OW8Yk
	7v9rC1bumG3hdW5GG5I1k1WWZTC9iqALJjDAMZuESRHRsHN6Ig+5sdIhERSgoAFd8kdT/VNU2fP
	Gd6Jw+xwF94ZadDfjl/e2YEm5AEO4/KCHHhVY4LHhrAS9gBQ/0YvHEVhVj+sTCLXSBAZaZKsBpS
	VCD+lOJoHwsqMAlqduGw1Ch2fWYxxCanwxBrUruSM3aROFy/bOj0+N7vRe2TBueEGYgQMkTVdTV
	1+0N201p72A92R/0ODSNB0spPFhTrc8+/TNcZHAFRsGDnsXWtM8efYV5lgxsPbh0V4hQcEOFZ4w
	0HXGq+KA4OshapaC1Y/NcWUP5Bpcv+gd1/Fm8nX97FATf6pbodxBAdNuuRn6XKg37/OpC4Lz31x
	sbFBCV70HZ+bffA/KKa5xYDzm8GoirjS2fYMjcfJlH+jJThmpmyf+UzOvlL0o5dBUKAKooUOIJc
	8MVq8zxS1KD9fXBELBUOTDVuVhBC/zcgah6S+oSszLdu/HuePW42WoWfy0CBi1SAQ6+BHum5PAT
	z7oyZEkiwwAY0w==
X-Received: by 2002:a17:90b:3c04:b0:3a0:a83d:dd0c with SMTP id 98e67ed59e1d1-3a8a08514e6mr1600840a91.17.1791370143411;
        Wed, 07 Oct 2026 03:49:03 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a85afe9ef9sm9119961a91.12.2026.10.07.03.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 03:49:03 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kwilczynski@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/2] PCI: tegra194: propagate REFCLK select GPIO errors
Date: Wed,  7 Oct 2026 17:48:47 +0700
Message-ID: <20261007104847.507776-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007104847.507776-1-phucduc.bui@gmail.com>
References: <20261007104847.507776-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

devm_gpiod_get_optional() returns NULL when the optional GPIO is not
present, but may return -EPROBE_DEFER or other errors.

The current code treats GPIO lookup errors as if the GPIO were not
present.

Check the return value and propagate errors from the REFCLK select GPIO
lookup.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 767e11216196..5ebe01f72833 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1207,18 +1207,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
 							     "nvidia,refclk-select",
 							     GPIOD_OUT_HIGH);
-	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
-		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
-		const char *level = KERN_ERR;
-
-		if (err == -EPROBE_DEFER)
-			level = KERN_DEBUG;
-
-		dev_printk(level, pcie->dev,
-			   dev_fmt("Failed to get REFCLK select GPIOs: %d\n"),
-			   err);
-		pcie->pex_refclk_sel_gpiod = NULL;
-	}
+	if (IS_ERR(pcie->pex_refclk_sel_gpiod))
+		return dev_err_probe(pcie->dev, PTR_ERR(pcie->pex_refclk_sel_gpiod),
+				     "Failed to get REFCLK select GPIOs\n");
 
 	return 0;
 }
-- 
2.43.0

