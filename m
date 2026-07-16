Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A030D40F
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784172141; cv=none; b=HKuZ7YXCVKMb3wM2bNdOKzpPDBy7vXBVj7ghjUQMxwBpINOwnfKWdVcOPMhdvz1eLLfa2J4ubJ4qal2aGPMqQqB0HDUgCD9Z16mkddYndPTtBjA1OYVl0q9UA/rzMvGOEN3p41VfLWQCRIGE2ghM7anYkgtTYJZ80/SxuvGGGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784172141; c=relaxed/simple;
	bh=elJNDpCx9A/ond//LPRjsJyfG8dwc8CRwQsb3uFhM1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQjN94fg+NNa3Upm4QPRI847R/bmEdrh5dDwVRkEYR3Ef4PvmCklGHQ7a8+UVkucLZyXnaG/OijNJnzo/YEoD1JMx1x0VcTmoSbJsEOP/gJt6syih+YUwha8eGOh7PC9VZlSW7Ohcv+O3mqZ7cYpgfoOrmn8FBrzSgVUMdYIQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=J6Ik8eSu; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="J6Ik8eSu"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ee2c048acso1910617b3.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 20:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1784172139; x=1784776939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KmLTscAEY1O1j8tiZ/+N1t1kAFbbT11AKs1SQQgixyU=;
        b=J6Ik8eSuFh/1cZpGV9JPf7sYDwmS4U6P47jPX3VKNdcP2ylT6VNr/HMsNsaglt/Q0E
         QH2jU+RdLFcN0TZPQm9JY9U1BBpNLoJKJHCmmn5WbpP4f0D3xF1DT37MioeeVg9m7LTf
         4FlMgvIY5h18rQAyotTR/Q9tDoPOA98/rp/gXVwX68pvK6mRVKXDlMMd6LkIv+DPa43H
         ghS2uuhX9T10WJWUbRIIAU/5oYNdiMD7NOiTDLDQqmmSggk9oCMVcYgPIsPOE3iTPvju
         BoyX8kilw5I2qQjbNVL1/yAkJrXVDQMAwZujaDCI0UA1zePNAc3PtkTmoc8CgnGG5FAx
         Kk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784172139; x=1784776939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmLTscAEY1O1j8tiZ/+N1t1kAFbbT11AKs1SQQgixyU=;
        b=Xd7rJCIGTXRWYO6HnTk6icPV8H0HUUiv1a5cCFKaAOE06E07QBGHBIy2JjKoF1Tx1F
         pErF5t3hUw2CqQV+F4VmxSmiMxqLr3TxjsxGdZJy4ttaABxNImugaPp/MtIgd+73ZL3M
         zYf3ZJ5Ka6A1iMmMXvbYs+ADfWNnwrlqAZB8pMEMIZt8YYvXnai7beqtnSPlLq6HiXhj
         VYY+3DUWog1DnlqZM/vPzVU9EGosIAUA9TTQNGBBSQm10nuQfhq+3XmAGyUqnH24vOdf
         Xl47ByktQ/yhJINcm1pE758S0ii+GFWOwSfn6TcSPpac4OgRFsVT53Fw9ZnOV8uYyE1g
         7NiQ==
X-Gm-Message-State: AOJu0YzcZAqlABncx9Pt3jHLOiM141iHrn3NfPo/yklqHc40fe7LwoNd
	hHk1kZQSSECZKiZcaXyScQU8P6NZcOXXZQrizlx2wGmH6rcFZhZSmISyey3FoXPlxf0=
X-Gm-Gg: AfdE7cky8iThjatOI9hzYQkJL73KJc526+76R5+d1O8LqHcJxq9CGtkeN6oRSBgD467
	MPZSmErDtf6cSGGx/IAPPe8sZnff6gw++/92kmwqM4jYBzc2Umg8NCUyzjh3x5z7+oMYABt+Pnd
	KJ0DqaglH+zjCdDGVAl5odfbHWJbGrmN0VYm/wMI0BztvDAUqCaQwai+RZn0MG+sH1vXhYBuNgY
	QEG4yUHUQUwC/f0ot8z+I+/41p1cbyU+T0uNZjUzuM26aIwvmwFJgEo/l0P6dJWWEtMjsknm4Wf
	8BDJUaOlE2EPdMmOoUwLNstSUruGTB1w6CVpO0PV57Hev8c8moJG7zlumzKfLrSGIohQL+QEknq
	+7BGjkA8sDPRa6ZNlmfasI97aeiCce5s75Zq4hcp+Qlcy3qi+AHPaBJMxcEIdMAdd1XAHLmZT07
	2rgKdIlbzd3/YP4OBaAo9VzNd5KfdQERbgAIMx++KsbA30T2Zev0TlPo+TLA==
X-Received: by 2002:a05:690c:c86:b0:7f5:87d3:c38c with SMTP id 00721157ae682-81ebb136b12mr83075437b3.21.1784172138727;
        Wed, 15 Jul 2026 20:22:18 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:56e1:f9cd:8869:2218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6befb688sm185039127b3.14.2026.07.15.20.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 20:22:18 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 15 Jul 2026 22:21:54 -0500
Subject: [PATCH 1/2] PCI: Move Spacemit vendor and device ID to
 linux/pci_Ids.h
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-rtw89-spacemit-k3-v1-1-e577bc63706b@oss.tenstorrent.com>
References: <20260715-rtw89-spacemit-k3-v1-0-e577bc63706b@oss.tenstorrent.com>
In-Reply-To: <20260715-rtw89-spacemit-k3-v1-0-e577bc63706b@oss.tenstorrent.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yixun Lan <dlan@kernel.org>, 
 Ping-Ke Shih <pkshih@realtek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-wireless@vger.kernel.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1

Move the vendor and device IDs for Spacemit PCIe Root Complexes to
include/linux/pci_ids.h so that they can be referenced elsewhere.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 4 ----
 include/linux/pci_ids.h                       | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 680acc93f5395..7b0bc1802954a 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -21,10 +21,6 @@
 
 #include "pcie-designware.h"
 
-#define PCI_VENDOR_ID_SPACEMIT		0x201f
-#define PCI_DEVICE_ID_SPACEMIT_K1	0x0001
-#define PCI_DEVICE_ID_SPACEMIT_K3	0x0002
-
 /* Offsets and field definitions for link management registers */
 #define K1_PHY_AHB_IRQ_EN			0x0000
 #define PCIE_INTERRUPT_EN		BIT(0)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1c9d40e09107d..d6f26cacc8e35 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2640,6 +2640,10 @@
 #define PCI_VENDOR_ID_SUNIX		0x1fd4
 #define PCI_DEVICE_ID_SUNIX_1999	0x1999
 
+#define PCI_VENDOR_ID_SPACEMIT		0x201f
+#define PCI_DEVICE_ID_SPACEMIT_K1	0x0001
+#define PCI_DEVICE_ID_SPACEMIT_K3	0x0002
+
 #define PCI_VENDOR_ID_HINT             0x3388
 #define PCI_DEVICE_ID_HINT_VXPROII_IDE 0x8013
 

-- 
2.43.0

