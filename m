Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29243DEDA
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169765; cv=none; b=s3ZbPjHWb1LiZIEE6P6H3oTglDA60NWqjfIse1zF07cu8uAdJ7H6NehaEg/56dM4eNQoy5A7vbybJ1Zdky/Dkzb8/SaNaIINw+vBcq87IkhmHZHTYw+zOShrb/g6LuKFbWAyWbq/Y0ZaEdzQFya/Op+53a66e09p2wc9Ghepk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169765; c=relaxed/simple;
	bh=IOzcB3Bmrz2d/LpZV9YPGC7WVt70Kz1xAnQJkxk+nKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XqZuaAXsRyfB2ibpVi+X19rp9p03Ri1J2DkNmQ4eiEWQ3PZADoJ8JcfxPuX4eNDInQ+AFdYWOAyKc1Z576HoZr9iVY+3+bT6T0Me1BViWEy8jIAAd3i7+npP9HH//1Ix71dxVB6bT2x0VbJ8NYqzN8Utf4ZVJOZhLakfiCjxbl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bmh0DkUG; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bmh0DkUG"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1563273a91.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169764; x=1789774564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=URIpbMJfCXSfu2fCsU8nZeVa+T330OFxkgZkw90cYgk=;
        b=DWS/NjGffqZKW/fifAIyjOanSEG8QyqnxDXucIzSdBlB/jtxV/b61pNptvewQ6KEvf
         nx6AbDG/Ksrju2FP7ntry8WG6FlS5eAvRDhNWBFInelinF7f2qd8bRwZHungWTQIrt1Q
         tcW1hdjdA9qdtK3Dke3kU2WThC+Li4f60q89wsq3wNXamDSvpPcqiIVrLXr4knb5x5Ua
         9TWro9cmJzgS4Gu1sZPckDghrDTWcu8hbfBXtqnlAhXmbn+4mCnt1axdoHg6vHhWBIwS
         7Qr5tx6GiNuvHpZ4CoBTNXadRzCb3C6xw9BPjlKyAu2DIC+d4idh27EuF0RJnKexPwpN
         JFSA==
X-Gm-Message-State: AFuF++mWusHEdyKD445eI4lb93+vmF+e3jv4QdYY68jXGwnxEa9hxiSk
	pXW0O+DckZSl5ZAF+PRdcAZEwFqLQ/PTHv1pWgD4wrOr8QL+Skh3gQnehDnf3Eet6xEMJSfPCa/
	eNjQ4wBBeznYtOjl/6xWklJfiJWgQkjx+f25VOtbA6vU9YL4PWgZ9+zvf0hsw+6jIT3C/xjqiCV
	aDEa3tGgOJZ9+mm9EjeQUrungm3GEhoQXzAbcM5Xncy0e+ZafLHmCjLsBR+Nd9V4wm54vHjC7pp
	3ncrCweOikwVpmL
X-Gm-Gg: AYBFou3REIMvcbB4/s5Xy1XA8QJHLm34VMPAq9Ky7gNVSdgwd0l0yIA0fhbdh8zTpgj
	WUZziID+Mxu72vOI6LotGPe5JnUNMN0qFiPhXlYMS6mZbjSZwXpFm34U+ULPw6z0H5E9e/Ram+9
	LH8BDT2/NlSoSZWA6Hot30yDGBhYGMRXZFk+jQTqaLNY2rtQ8/T7y56XbUS5YvRjPfrklJBtC4V
	lRye7teKWUOoxrsxWDevG92fWHkOtPrlhccw0T7cXplyG4uPQYGImFxirQd7uqF/BtoqgroONtZ
	GbdYYgfq2oOgT0FSZADt1u4NTuXQGkBd3dLRwvsaLwnoWiqOnRD3r/szBGXRJlxF9yOeDK+yLxN
	v5dAQCGWElJMiNng4ceCWl24it0GBeEEKHAMrcYttFkku5490IwLZJ/Mc5VNWZ6yk5S2VUKvb+y
	3EAwpi53bA5ba/y0SsZjoKh/Mls2HD25WtwCbC
X-Received: by 2002:a17:90b:5605:b0:398:b17b:3bd2 with SMTP id 98e67ed59e1d1-39d9bbc9177mr10205833a91.4.1789169763562;
        Fri, 11 Sep 2026 16:36:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39d9d510200sm542685a91.2.2026.09.11.16.36.02
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:36:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9104417215aso30312086d6.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169762; x=1789774562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=URIpbMJfCXSfu2fCsU8nZeVa+T330OFxkgZkw90cYgk=;
        b=bmh0DkUGP2C2lyTfkz4LfPvUJnyKpl/ZMo1CKOQMQr2EJ+P5U/YtEjGwaUQb/T+jRp
         moyS/1Bo2kCM4V9UEY8N5+SJpey9g7nUsCFbP1OGgZIJ9Nxqoi1Vq7ssdTVifFv9h/5A
         Y+sB0LIbYl9Bg7agZ3fsmkJFsTWcIhPwCWBQo=
X-Received: by 2002:ad4:5e8b:0:b0:910:63f9:29f9 with SMTP id 6a1803df08f44-91212086712mr89710956d6.10.1789169761867;
        Fri, 11 Sep 2026 16:36:01 -0700 (PDT)
X-Received: by 2002:ad4:5e8b:0:b0:910:63f9:29f9 with SMTP id 6a1803df08f44-91212086712mr89710446d6.10.1789169761388;
        Fri, 11 Sep 2026 16:36:01 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:36:01 -0700 (PDT)
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
Subject: [PATCH 08/13] PCI: brcmstb: Declare and assign quirk NO_RGR1_TIMER
Date: Fri, 11 Sep 2026 19:35:33 -0400
Message-Id: <20260911233541.1650895-9-james.quinlan@broadcom.com>
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

Very few SoCs do not have an internal bus timer whose timeout value may be
adusted for L1SS operation.  Declare this as a quirk and assign it
accordingly.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index be414d346855..e2284e114241 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -294,6 +294,8 @@ struct inbound_win {
 #define CFG_QUIRK_OB_WIN_MAXSZ_128MB		BIT(2)
 /* PCIe HW can only access config space with 32bit R/W */
 #define CFG_QUIRK_32BIT_PCI_OPS			BIT(3)
+/* PCIe HW does not have an internal bus timer */
+#define CFG_QUIRK_NO_RGR1_TIMER			BIT(4)
 
 /* FLAGS */
 #define BFLAG(pcie, flag)			((pcie)->cfg->flags & CFG_FLG_ ## flag)
@@ -1339,8 +1341,8 @@ static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
 	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
 	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
 
-	/* 7712 does not have this (RGR1) timer */
-	if (pcie->cfg->soc_base == BCM7712)
+	/* Don't do access if there is no timer */
+	if (BQUIRK(pcie, NO_RGR1_TIMER))
 		return;
 
 	/* Each unit in timeout register is 1/216,000,000 seconds */
@@ -1971,7 +1973,8 @@ static const struct pcie_cfg_data bcm2712_cfg = {
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.post_setup	= brcm_pcie_post_setup_bcm2712,
-	.quirks		= CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN,
+	.quirks		= CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN |
+		CFG_QUIRK_NO_RGR1_TIMER,
 	.num_inbound_wins = 10,
 };
 
@@ -2028,6 +2031,7 @@ static const struct pcie_cfg_data bcm7712_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.soc_base	= BCM7712,
 	.num_inbound_wins = 10,
+	.quirks		= CFG_QUIRK_NO_RGR1_TIMER,
 };
 
 static const struct of_device_id brcm_pcie_match[] = {
-- 
2.34.1

