Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC038D3F1
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225228; cv=none; b=SldbmZi6+LCHuYBsg35yQK39eJs8ei8AVBwaWC36w3rg/Cg1/vDv+jV1BG1SfP81XKAQ92SdX7/i4nnsVPm7P7yWrwzS2dy/HiCWKSKhbm21af+a/EqDYuJhbYeEFlYPOUbEd9q3xygiTC3gK8/YCbUqBizBFUFSw5qe/cEqaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225228; c=relaxed/simple;
	bh=6MU93lD7oPCvVgWA1NeStXtYPktufCBo3mj6HDbyAGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5+jFlKCeOv+93LbY6go1dj4vbQOsKYCYxfKBugyW6pgvUYdRMFs2paXmhJhkkVMWRbat3hBfYMBm3KAvRTV8PKDv2V/dHAcMaUxNZD5MEakaks76vtcilZ1PwkkIdpmVmX+Jy1Uqn2LSe6Vzn0NcvNVTzMt4eoVB7zq9uVP4io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=xavhA7YA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="xavhA7YA"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-930f618435cso362701185a.3
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788225224; x=1788830024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y08cvUPAERT8DtacgubgZYXObs4Ve5NXsThRcrzdsK4=;
        b=xavhA7YADyS0y7zPAa/fYaLchuSN1gH/eSjP4m9qT/go9icu306dzxGooqf6+jyjV8
         9SYrEFNK1GeSDKiafUERFvPEoqfSpXorrckVa4nyu5qOto+mspMpb2oq5sTK6xgAYtX0
         dRnUNjM4tGGWrbK+jvZ24NDNlTMIigWt11/pKQear/A962//jLUqDc6NQ89ErOpQ/6WN
         4KEbG9336UVO3657LS2/C4N8CZuiJE5uFCgcrO3UaKRy/FSCu4xkWKp/7n/vcq1/+cTN
         gYwUlVReVCl5iKhgK5y4muNboGcf+CzpeKKiHzhx8EFvCzaWS96HGmHp6W9V8sLVUpoE
         +nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788225224; x=1788830024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y08cvUPAERT8DtacgubgZYXObs4Ve5NXsThRcrzdsK4=;
        b=M9ArRyo10QBba2xnO+x//v5hmidRm3ZtcQAyanj8PTVgcPofp8nrldfU4n5pRMmIvF
         PRc9aN1Ps7VK0ipcgmk+81vto/tCFjdvZsO1V+vYuYlLyEVyFC7YDBSG0sI7sAr6tWaD
         TRmkO8Ny5/h4p5pHSockHyqTRuTlTVFIEVTQhcQnhSPPkoahbWHA4zecQJI2MxIzsGCl
         ug1azMmkgX/1BZdlVeh9yE6Q7iSmnRB9IG0RCF7x/LzedSO1HmNvOV3d8LFffHbNj9R4
         jYERfm+kT7cOO8BucJYtBTIp1aYQ2z5aDKNAR/0ddBuVyPCU4mvP+vgzm77vX/153oFS
         +QpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr899jtwiZCbQdAmtGFtU0g4gBYSGZRqD+ZAL3PuQ/FiJvXX72HnVrbsPQ6/mw+Hh9O/58lcBoOZwI=@vger.kernel.org
X-Gm-Message-State: AFuF++kPWPIz/NFqAa5dGEt0CieZCglDLGqY8Vn6L6kgtVEQ6n2qM+lq
	fbnxob2h4Im5xCAnRcQ3JnqdxX80ga515cT+dSPcrxyjh8lbtH/ovvrbQ6UEaOdVE6I=
X-Gm-Gg: AR+sD10BtVKQAloqsTaKphytEdHrTfmMJRM8jADf4Q64dh8+EZTu+hi7cHOfhMvIEXG
	9MJLV1RA+N1jF6gKt/IyNvaZSU5A8bFnb/yiKiqerGt8TWZEOman0azGBjm/hu0Zr+Me9hPSmWo
	U2jY38tvlIIGFeQteVTeMe8bbC4IUMcBru2vlkNlQQYDv3NUX9mBEof6nKuU0R3izYL+Er7Y52G
	jUf2NeQw8AzILN1/zTwLER2fOjwhMpPJF8Mt2i1wYkNrHVQP1I/dzyUjYFLFRL3AyLO1/Djw9r2
	S6jYYvdPFKhZtcPPOQGUCynnQDAzBcoeq3HHWzTbAOBC+g+WdVSX9mQoPz7vW5W/FetLk6NMex8
	VktGxrtXW4L2lPHISYPIxGz7mBLM9P3tiUuV/x5L7enq/q8ml64xJQIL4YPD/lCeGcs4c5opCpN
	5n9pTwY5wWkXtQVLjmLNXAthHDcK3+UONJoWkkHQiTarNjF39SWdPCWSfBNirIcYwK
X-Received: by 2002:a05:620a:2991:b0:939:36f3:fea8 with SMTP id af79cd13be357-93936f400d5mr1392214385a.25.1788225224521;
        Mon, 31 Aug 2026 18:13:44 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391740a307sm581347285a.42.2026.08.31.18.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:13:44 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org,
	saravanak@kernel.org
Cc: herve.codina@bootlin.com,
	daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] PCI: of: drop the reg_num argument to of_pci_set_address()
Date: Mon, 31 Aug 2026 20:13:34 -0500
Message-ID: <20260901011338.1323243-2-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901011338.1323243-1-elder@riscstar.com>
References: <20260901011338.1323243-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reg_num argument passed to of_pci_set_address() is always zero,
so get rid of it.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/of_property.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 75a358f73e694..505226b876c56 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -52,7 +52,7 @@ enum of_pci_prop_compatible {
 };
 
 static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
-			       u32 reg_num, u32 flags, bool reloc)
+			       u32 flags, bool reloc)
 {
 	if (pdev) {
 		prop[0] = FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
@@ -61,7 +61,7 @@ static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
 	} else
 		prop[0] = 0;
 
-	prop[0] |= flags | reg_num;
+	prop[0] |= flags;
 	if (!reloc) {
 		prop[0] |= OF_PCI_ADDR_FIELD_NONRELOC;
 		prop[1] = upper_32_bits(addr);
@@ -131,7 +131,7 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
 			continue;
 
 		val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
-		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
+		of_pci_set_address(pdev, rp[i].parent_addr, val64, flags,
 				   false);
 		if (pci_is_bridge(pdev)) {
 			memcpy(rp[i].child_addr, rp[i].parent_addr,
@@ -164,7 +164,7 @@ static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset *ocs,
 	struct of_pci_addr_pair reg = { 0 };
 
 	/* configuration space */
-	of_pci_set_address(pdev, reg.phys_addr, 0, 0, 0, true);
+	of_pci_set_address(pdev, reg.phys_addr, 0, 0, true);
 
 	return of_changeset_add_prop_u32_array(ocs, np, "reg", (u32 *)&reg,
 					       sizeof(reg) / sizeof(u32));
@@ -458,7 +458,7 @@ static int of_pci_host_bridge_prop_ranges(struct pci_host_bridge *bridge,
 		/* PCI bus address */
 		val64 = res->start;
 		of_pci_set_address(NULL, &ranges[ranges_sz],
-				   val64 - window->offset, 0, flags, false);
+				   val64 - window->offset, flags, false);
 		ranges_sz += OF_PCI_ADDRESS_CELLS;
 
 		/* Host bus address */
-- 
2.53.0

