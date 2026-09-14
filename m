Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD9C1F1513
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349130; cv=none; b=hgTf+TtbCf7EFAbyJuzYJ+5hCWhQR7R+U+BjG38JvgfMYabOmBCHSFpjv8v13jWiB1pD14oqTOUXfF6S+ankI5I8lF2Ss2gU1Ee9B+7pNix8RWS6CkanZrM1w7CLfUsoVx6+Unzcq4KhrNuxqYKRCZZ5jO0i1u5+ib1/pH0XSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349130; c=relaxed/simple;
	bh=eXfBSuniCbak0GSWT9wfeSNolwscYW7BzECTm6dHHhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUPCLuFictKhBUEmWKHs3UwK2W6FV9aavBvrGgjQmHrt/85a8dX8S1OX2LZGbjrMGafr7EVr20+DfyU6jo2SHu40NnZyHUSLso/EgcPCL8Q2k8g8PrnDfA2lVp+YnOGGUhkOXvfXFbb+P2xVZXo4JVBjHKle9fCZeyJWG5iqRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoQ8LPrj; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoQ8LPrj"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa7so180778385a.1
        for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 18:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789349128; x=1789953928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U2puI8JZTx0wpWRfnIxgyvB4+ydTJdupfLTFQLJ2yXw=;
        b=qoQ8LPrjiff8RFZmmBb4DdHU6caDBL83o8vIgcz+nxH5qPVstui5r6991GOkPwBmvb
         WnUgV3s8u+aQyXt98xHER/QTyCRTg4hEs6uAL+Ynzmq6DjUzcUrNXVFJNdbtQq2OGljZ
         ouQ7TPACtsONfv724HvClflHfFsDERSy9xroP/Eat7GMJUzCMAbukywVripHH1tpNIKo
         PsOHpbkGfgmC8IF1XZbwx5URUL4Z+yM3OaV5UNQowl4g7dducOPiRwBZf3sotJfX1qbo
         BL9Chq7PIDe7wtRae8NUcvsEh6yRbG6FNu6S2H4MSA14KB3+ExAqVHsXO7upKnsbOabg
         T3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789349128; x=1789953928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U2puI8JZTx0wpWRfnIxgyvB4+ydTJdupfLTFQLJ2yXw=;
        b=n343gw24Ku8olm/Sc42R8Ikf887fYyP9pTjUPbP290mU+XIbHPvloBG8+J+GuH06NE
         joIFxyXnccV4VFgvyXqjtVoA/xpACpPcBRCYFvsGtwHEta7YeSTv1ibCsapxgK2Flghr
         bRWqppT1gxgtkMmgQ3betAiu08CPm/DlWb3CfPCqmSJxByXAec+gwiOWnHNJIyYWgpZT
         93cAu920XaMwI4RSvmf7+rNFzmfFPfhx0R7gSGtPx64V2ef1Y2lLaFwICPb2uolZ18kA
         PZfI7T1jl8GOlt2dIWVyBvO+MUOxvLr495dd1AbuYkksGElpWA/wbdRFatNzLYBHib/r
         yl3Q==
X-Gm-Message-State: AFuF++lG/KBAxp0zmM2pJspxgdcHu+F4VFbooNyINwcGnWVoIodz9snI
	e6glcw1joM0HUecd3i/7/95fKylc46PETB1lQfaMg9LGLXVZyIAVv2w=
X-Gm-Gg: AYBFou2Bl6IleU4izOoHPgFPO61Mt6PRaIiBd3vBkTKVusfG8HFys/GPopJ16791ouf
	W/eTq08wg6dUNZHIY4X5o5CdFU48ihaIY/lexZuWwZZ+zdWz7vXl2VeT/dSWDO10raiMujk8pGd
	SDbFjj2flvmafgaqzQiOOSC/hS5A/OETaBOxn371CsP/9Z2cdFEdROo2pcMtvKf9UWy5K2CLZqL
	zcCji2ueum0EiXtVrwIOoy4sO9/gsUkrmqo2u637w7pEe1VZkUIBwZxiquf2vZB6RsYHh0yDFqe
	PcCY51OtfzUSMyCsKnF472iGs/duWESS85/YgedtWjL3szFIREDiBx72UpD8COoxNwqukM31poX
	MT4SSecsi2OYRjzN1NVOuFGOtiQrGiWqNn9SzoXuArtiQY6qGLesvaoz2j8XrSHWdX3jQPAKbAJ
	45k1o2gokmNSmdfq61fMVuvP/h3lQAW2Z4nyi5IYkmvUaUlGg0gCeKfFVfD6UASbVhWXrajIQNG
	+7yiNZsOcJjEkBZxzLiCvaSacM5ooGi2T3L04uUXBQ1/i7edvFVn5182ZegrLRaNVp8DP+xYlpA
	lLNFRiES/296GAo3Ingy1FVdEuRdL2U0Cg==
X-Received: by 2002:a05:620a:31a6:b0:939:e6de:f0f6 with SMTP id af79cd13be357-93a29966d87mr77789385a.27.1789349127692;
        Sun, 13 Sep 2026 18:25:27 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e809fd0bsm850352585a.33.2026.09.13.18.25.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 18:25:27 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 2/2] PCI: shpchp: Balance PCI device enable on teardown
Date: Sun, 13 Sep 2026 21:24:34 -0400
Message-ID: <20260914012434.47010-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260914012434.47010-1-mhun512@gmail.com>
References: <20260914012434.47010-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

shpc_init() enables the PCI device, but neither initialization failure
after that point nor shpchp_release_ctlr() balances the enable.

Disable the device after releasing the controller resources. Route
reservation failures directly to the device cleanup, while failures
before pci_enable_device() succeeds continue to skip it.

The missing disable is already present in the initial Git import.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Assisted-by: OpenAI:GPT-5.6
---
This patch depends on patch 1's error-unwind labels.
Validated with an ARM64 W=1 object build and strict checkpatch.
No hardware runtime, IRQ-failure injection or hotplug testing was done.

diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
index 4492c7d..e00e4fb 100644
--- a/drivers/pci/hotplug/shpchp_hpc.c
+++ b/drivers/pci/hotplug/shpchp_hpc.c
@@ -572,6 +572,7 @@ void shpchp_release_ctlr(struct controller *ctrl)
 
 	iounmap(ctrl->creg);
 	release_mem_region(ctrl->mmio_base, ctrl->mmio_size);
+	pci_disable_device(ctrl->pci_dev);
 }
 
 int shpchp_power_on_slot(struct slot *slot)
@@ -936,7 +937,7 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
 	if (!request_mem_region(ctrl->mmio_base, ctrl->mmio_size, MY_NAME)) {
 		ctrl_err(ctrl, "Cannot reserve MMIO region\n");
 		rc = -1;
-		goto abort;
+		goto abort_disable_device;
 	}
 
 	ctrl->creg = ioremap(ctrl->mmio_base, ctrl->mmio_size);
@@ -1045,6 +1046,8 @@ abort_disable_msi:
 	iounmap(ctrl->creg);
 abort_release_region:
 	release_mem_region(ctrl->mmio_base, ctrl->mmio_size);
+abort_disable_device:
+	pci_disable_device(pdev);
 abort:
 	return rc;
 }
