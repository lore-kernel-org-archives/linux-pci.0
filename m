Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646F41C2E0
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812486; cv=none; b=Bp4PkYtvxaDmrSEiWRY6ICQ06S8AAJi8ScVyE0BIiqrBgyDLjX3aKXZajvRii5eY7DYcHxd8FDz3Rf/KaRzSFYeJuBuUi28E9G3/jkLylehIFCVqmFozJojp+xOuBuDOhizysB41vP+gtm9i83yPVd4DUF1GSCtVGPbhj+MICsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812486; c=relaxed/simple;
	bh=SLfJF+f1phQyf5LKp3ecFcQcmYovSj6A5k7lfOkQV0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HfBC6H3oHR4w6MNBD3nAdOuLjJtQDqfyAt2Fn5bQY9HG5rcVSr1JCC1TNEBvf06l0Utxr2e1QbNncPCCjbzSF+ciH5JViht+uXsvvNMRCaOKZkcv2t8FTlqjHFWtGIbgfa8PjCC3r/tKfSDAm2RlZe9eWkOAWIabCHdJGcynsho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GO49zmrB; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GO49zmrB"
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-5c2c0df0b45so1688673e0c.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 13:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788812478; x=1789417278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iMNzlSvlaMkiP/A6FBG1e+Aok0NB3tA8jnJAebpaqaw=;
        b=FrvbvTcoooCD343mzxur7FEOa9lGz3k4pwKRLXvymbZqejAx8yohMB0wvRst3+OC72
         shRTQyvIib758hcYwzz95d5D9KB5ywa2yoa0dzqgPJS0/xjV0u1u+Mz7vHbr5U4LT7An
         otF0kr3+1gSVcWkN/mEeNBBL/UzLha8PtoJxAP6kT3uLPkfFvYM5lYWX+NVF4NJcttDX
         RISnw3jkVop+phtku5QF9x81OWYyJxVOOYAE+BLprSQEFxZmlmWbrKU+PLUOWoMPEH84
         41vZoPsVSXQ5nUj1NSWjRXbXXg89Sb1HNLc2HApkiusWRlJBNa3Bpl9muLJO8JSWq+l5
         3WDg==
X-Forwarded-Encrypted: i=1; AKwUvByCRyh1QrXdg9uoPl5BI8wNMcihEmtnpSx6cRgG1zFENk4t+70qgY+maAPNrjSKhPiyqDfFaHIev6I=@vger.kernel.org
X-Gm-Message-State: AFuF++kEr4OzCFu8MnJm9cUGHDplQ/dFoMBFCYa51tcy80tPl6g3EBus
	VTlfLB0vpSzK9VeW7+x4tSYg22i9HQHpYU8jRVVNM9DhpQiFGw2ITQycNAGCE6DK8TBrhvQvXr9
	8epf2anCpTQDU5gEaiIfsEIMbb1u0WqQvgbs/LfcexSsF4jybvhEXZBLa438zOBfiR1glqGlYQ0
	RsRbBOsdqApG9602z+rCQ8/qJlDvhjcE2Sx5ItcNnmTLj4z9IVE6jzBmjlJq8jeDO11ZTXL01g1
	cprk1FUK05ZG8Y=
X-Gm-Gg: AYBFou2YerGHmQxHumZfe3Mqz1RhqzbtNekVjvo2Q3slg5R+xaS3emi/yOrEGln0Ghh
	dHeLPztu7M45vP47OWrFw8Q9nttJhTcuVsTdi9LAOlP9nDBwk3IhUJXFQ3zJ1N0Yr3TIIQL7MSZ
	7AxHQK6bEQDED9txphwL5rPdNx8b5U7YLeu+C1P4GXuSIWu55x/6UfK2aLph7HhybMKJIQRmgZj
	tirS0VUJZcRTLEGEs/McmRmk/z/YOAlpTSPaAy+1FE5mdr/vgjs94DS/AhlFRCXOY2Hb9R6+E8w
	EcjlajT+3pNR7MiUjUjsHX3/KLPI6m4bvAlj+4QE1tx/xzTqYj38kl26LH4hIf2mZMmYAFXntfI
	vC0DvD4eA7BcsCrnuUHLFG42Oef93SnPmlEM9h1sP9UdOyXHpa9etrP6ePCjWAJbcxaQ259/gDW
	J9sViKXVCFiE2c7dc56D3gRz85aIJ8d0M8J8I=
X-Received: by 2002:a05:6122:8b03:b0:5c0:fb8d:9993 with SMTP id 71dfb90a1353d-5c7ed38607amr10001521e0c.0.1788812478222;
        Mon, 07 Sep 2026 13:21:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c7ec232ce8sm5518342e0c.5.2026.09.07.13.21.18
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2026 13:21:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5308a3825deso14254281cf.2
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788812477; x=1789417277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iMNzlSvlaMkiP/A6FBG1e+Aok0NB3tA8jnJAebpaqaw=;
        b=GO49zmrBh1rPwPmT98bOao46u+UKCwiNpHqdcmYPhCOif6ADT8cVmNbUeZkkRS4lYJ
         IeUXNQpIXupb/RsH2eqv16XxijoOtQmyVZPM0yiGfGgeYGZthjc18sCI73z4QQWXGmCf
         HfsSOZvPaBDoIwKJ8+MOzthFTbR/XX1bHFn1c=
X-Forwarded-Encrypted: i=1; AKwUvBzFFX2irzJ2nDL/FoqnlmS2fzZ2SchV41xDOxo8wJxIcEAgKXjabBTosXtPOL56f06mems7AC2qqwA=@vger.kernel.org
X-Received: by 2002:a05:622a:4a89:b0:52d:8743:bc83 with SMTP id d75a77b69052e-530549f8267mr27752951cf.34.1788812477582;
        Mon, 07 Sep 2026 13:21:17 -0700 (PDT)
X-Received: by 2002:a05:622a:4a89:b0:52d:8743:bc83 with SMTP id d75a77b69052e-530549f8267mr27752461cf.34.1788812477145;
        Mon, 07 Sep 2026 13:21:17 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541992e4sm94946891cf.21.2026.09.07.13.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:21:15 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
Subject: [PATCH] PCI: Add ACS quirks for Broadcom BCM57412/57416 NICs
Date: Mon,  7 Sep 2026 13:20:20 -0700
Message-ID: <20260907202020.2525301-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>

The older Broadcom BCM57412/57416 NICs may be multi-function devices.
While they don't advertise ACS capabilities, peer-to-peer transactions
are not possible between the individual functions. So it is ok to treat
them as fully isolated.

Add ACS quirks for these 2 devices so the functions can be in
independent IOMMU groups and attached individually to userspace
applications using VFIO.

Signed-off-by: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..191dbe87a09b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5182,7 +5182,9 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
 	{ PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
 	/* Broadcom multi-function device */
+	{ PCI_VENDOR_ID_BROADCOM, 0x16D6, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x16D7, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x16D8, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1750, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1751, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1752, pci_quirk_mf_endpoint_acs },
-- 
2.51.0

