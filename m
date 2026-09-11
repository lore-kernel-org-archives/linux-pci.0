Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D4440A3E
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169768; cv=none; b=eRsAvLvSSnjfmtgk9Xqh3VA3NvLS8SlK94565ECj6mNzj3FrToHhTBvtv51c5mF8kbNSG2HmJCJT2FrUl3XLNK7U0UxEtHi9ItoQgPBiREf0UPEdROnw8SYMZA4rLgrfLpEN5VYhm+33T6X24ZD1AUuJ4elkL95/Rk7LUQ5HWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169768; c=relaxed/simple;
	bh=J/jQK56h9wDwCDpAQwgf0gACTUTfBrKcYQEPP0WTr0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bB+DlTyFUOBjgee7YkA0Yt04doknVilfkq0s6broEBpBE1wPqems15EWuJr+y6/BnveQ9pm9ZZCB5rJFIXr3epjalWQbrAlbG7NykxxmoOEW1Brr4aVLKTTRDA7XU6eyeQZ2AbOwWRqajAanc+sPTm2OXxh7vFpBoRe3CitiYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E3Zk9Zzn; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E3Zk9Zzn"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso1793732a91.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169766; x=1789774566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/JrxdF8t+QTOTmJ7fVNc0ZXDeEsvlNdyHKnTguJqLTM=;
        b=nwrKOYrhd2xEQPoX/LrjSLO9Wkz1uYpyDQTL5tL+uuo60oe7jQo7QJH+WOoecXsKx/
         8hHSiW8S/rIYw4ndj/phIok8ha2x6rPBcf6XSc6sHWno77NrDxDnPZmxI75I9rF8bufh
         N4UBacH1cCkJ44mhN+I4TluNH6Gt84uqkVJCLOjjV6yM/izJTid2gKwT/YGf9qbyH2U+
         +/XaiSejKMIdkbeC+eOjtgECYYaNzeWD+BDYZNzbiWM/CT+S8PCEWnP/2NNvcXUg6fHy
         TOJALnnnMhWnRyRTa5M8LtTfu/NvabyY0UJEmUykRUl5J/RxY/AfIJq9J9MRnwW9vK2x
         7EPQ==
X-Gm-Message-State: AFuF++lHDpJ/SEbMIKvRoKAhrHvTNwSEXagyjupTTmkO8bLAHMc7dhLS
	d+ZUaDIB78jLhjnrOjcPNMw/Qn/zhOT2tsoTsLr34Zma4pvjjVB2SFCXyfs73cOkZaIemokvQnI
	up+UeDVTaIa360h7BFAeAWtSIVvOlbbpc7jLODJdcPV/0T4wpa96DDW7EE0Mj6qb/Or77SklnnX
	Vxbt3l9rPMNHlDKmcfQUOuaGOlxlYKdCmyFMyL4KtnleK6Zm13vwE7kmg505xZIifCAt5Xnk65o
	DsJsBMzw9UnIHby
X-Gm-Gg: AYBFou30R3CHwhLnbvZKUWKGHGLUdW/Kdx8CBJx8jdEu+valU/yBbGdLKmycOgnLiNU
	FNinKZk7iETd8JTItyrY/fjf6UPpMb2ZCCUSSEHdWYLm4KLgrQJqrmEG1Vaa2pY3YafRslIHMXG
	tRMtGO7q05fAb6tT0wKT/jHAv9gTqvNLQ1AzQFD756K0aiiQOjGdsKLxPZ74smiLpRaUxhhlGr2
	iPTaKDC8myJAAOCq9TXYr98fejAT1MTKj5irM0y8sGfyMM/5WCobJ6bsCvVIDBpb6SMNsXtygry
	fqEwJbrUmjfdWpVUWgI9ELElKW3xjcoe4pIH7G9TDwTVaSOxOq2jiSpZBND0uaho0NN78AgCav7
	T/Vy1ghZN7Ai+rTdkchcyUfDStNWydEOqcj2ZjmSuCBF6RgnWlNL37k7pfiGvu7eseTyguSCGu2
	6Raae63LfD/koWL1z4uwYLSqWnQWG900bl8rNd
X-Received: by 2002:a17:90b:1f91:b0:398:9bd5:4910 with SMTP id 98e67ed59e1d1-39dbc7205aemr748057a91.23.1789169766087;
        Fri, 11 Sep 2026 16:36:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39d95edba31sm2319916a91.3.2026.09.11.16.36.05
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:36:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91051512080so23792266d6.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169765; x=1789774565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/JrxdF8t+QTOTmJ7fVNc0ZXDeEsvlNdyHKnTguJqLTM=;
        b=E3Zk9ZznFByGm2NVXamdt+pvR25Ts6S5gSb3WvtN3XcHq0yz9MeAe+u7mJbFdTxf6b
         nDFLorSfa0XCHqOhqqQBNdEGMlKwzToIW26lPQHhmGaquoz60JoBJ0cDNy4D483QVN3Z
         6djL+hpORd95oLH+QX+Z/RG5gtmXUS/3liWGc=
X-Received: by 2002:a05:6214:ca8:b0:8ef:e0d0:9fae with SMTP id 6a1803df08f44-9121d8f1169mr10167486d6.14.1789169765016;
        Fri, 11 Sep 2026 16:36:05 -0700 (PDT)
X-Received: by 2002:a05:6214:ca8:b0:8ef:e0d0:9fae with SMTP id 6a1803df08f44-9121d8f1169mr10166536d6.14.1789169763636;
        Fri, 11 Sep 2026 16:36:03 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:36:02 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 09/13] PCI: brcmstb: Declare and assign quirk EARLY_PERST_ASSERT
Date: Fri, 11 Sep 2026 19:35:34 -0400
Message-Id: <20260911233541.1650895-10-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911233541.1650895-1-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Declare and assign a quirk where PERST# must be asserted prior to an
internal bus being turned on.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e2284e114241..dfd703571091 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -296,6 +296,8 @@ struct inbound_win {
 #define CFG_QUIRK_32BIT_PCI_OPS			BIT(3)
 /* PCIe HW does not have an internal bus timer */
 #define CFG_QUIRK_NO_RGR1_TIMER			BIT(4)
+/* PCIe PERST# must be asserted before internal bridge turned on */
+#define CFG_QUIRK_EARLY_PERST_ASSERT		BIT(5)
 
 /* FLAGS */
 #define BFLAG(pcie, flag)			((pcie)->cfg->flags & CFG_FLG_ ## flag)
@@ -1159,8 +1161,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	if (ret)
 		return ret;
 
-	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
-	if (pcie->cfg->soc_base == BCM2711) {
+	if (BQUIRK(pcie, EARLY_PERST_ASSERT)) {
+		/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
 		ret = pcie->cfg->perst_set(pcie, 1);
 		if (ret) {
 			pcie->cfg->bridge_sw_init_set(pcie, 0);
@@ -1965,6 +1967,7 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
+	.quirks		= CFG_QUIRK_EARLY_PERST_ASSERT,
 };
 
 static const struct pcie_cfg_data bcm2712_cfg = {
-- 
2.34.1

