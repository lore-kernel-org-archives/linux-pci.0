Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F1F2D0C7B
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315292; cv=none; b=U1Ts2u6yC1t2+uAVj2UN4wAA4a8odFsKPPNh/UWF4BbrNAI3kPw4LWhkVdn+q95jZLOjvUqriIiMJeSR1fgkWzENopizSkOddf3wlYplyxrpfidU1xcpLNdJVH6Wd1qVsfjj4BTbGIye0VJzzujIuq+9YqGEBWFPKDfgGreS/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315292; c=relaxed/simple;
	bh=l/XFNhsX7ERB7yaujlgzJEC3/+9JE4SydtkgZp8Bemg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwVK6sVSGqOucD6+cXCr39QFMZrxMYEzFh2BMIfSuWPeuPvnvuGWhXWnABTdhBbmZLE5RySUP+f560nX0FVUqGMh0bxXK5qdP7u44wdG4q29i7nFTPoZcnG3z6qpGRIxxso+tylqRCce1u+2GcciS6zhGQin8r0HaTyn5H+zKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU/pKziZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU/pKziZ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48068127f00so41410655e9.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 00:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771315290; x=1771920090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF6ZhZceexRomvWkubldKlsxvta1sWwN/u0Zy1Qrmak=;
        b=ZU/pKziZLd2CumEKBPlwgIGSbeZw35K3R3k1vs9uQ+VcfMGslVuPteJhXSopvViZy8
         B6WzQO72TAxRhGovpNEaiAjMmHHf41Or7UUxD708DrnsSPtnOCVbWabdPoCPqTrZBZuz
         2X9M5+oPaKGq4hwZ3nMjmcrkMBet/L5YZaEajEK1K1PnEm1lM+NJRb2YNtvRdb6jASd5
         eba4UYuooAuX7XvSrGUToNt7GHhmVkTsj1AweqYhPTQpMaCQlinLSRC7X59sP9Vk6UMg
         gDpdOyp3h0hqBK7Wv5BbOS4QUMbPNr1Sw3Fl5aYjUtArazE3B3U067xUQziZ9w0Ch5yN
         fW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771315290; x=1771920090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kF6ZhZceexRomvWkubldKlsxvta1sWwN/u0Zy1Qrmak=;
        b=rmGqIqOtA4AvIWSgCwrjiTsDhyvKQX3PV2ixGR0M+cQM7C/nwvQ8FSSTkBgTTC2AeX
         f1DaszQXL5dkatll6qCyb2yn+NhaEEDIDEpusxiz1UnNEVMsoojtdMyUlhASBAT2oxY8
         yb2EAElZ4kwjno11gASH7atwQZDbVcFTJ55EHCjNufYPCCYNJYeCey/+namREHL/kuLR
         OB1CuF84QE6ZkT9irsm6ibiYrz3L2u4R5hY+2GO1WfhWkJ0ugcB3VpCMHCI6TuQBTQuI
         Rxrr7xk6z+DWeWeK0EpZehkXv7OqB0AVzkUPMrfVKoSAFFG79LYroMUtUmQAUl5nKWm8
         B5eg==
X-Forwarded-Encrypted: i=1; AJvYcCVj2WWeB0/AI22Nw00PLfC3em5EIEHCif69kBrDPeniQAinx4br2cPWcwEOMXrSW6MHplZ1mNr0z80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4+lOJDc+T+n0i6gjYZrEd3hFBEbHnWXssw7VVu9CgZSAwrYO
	9m3ohhXzlBNcQxgIDZqqv9z+3CgaE1RpwUMnjkUcqQVCM7SZTfbFYW85
X-Gm-Gg: AZuq6aJR/WE/pYvNYm0CeK1mU0vLuMYAdjT9cOC8Wi6GhJ2OLBdOkZ67dD6hS7T1MAU
	CkvN71nSgQh3MXi+rKF0Vp6lagvqXoMRc6t0gbHG93ajxoel8cPPPECpeS7j+2N0P+YHG16Cy2L
	2UD1pmm5IGORpKrNbUoJjqcsEBfRsF88VmoSaNxsAqmM7rUjwlIc7DifQPTAmIebn1ejiswxktV
	ReS3/7AXa06bIrEoH4noUBBYpDi/3h5tEYscNXjFVtZ51hNvxNylEw4jAmCWNU39G/h/WM9Df4H
	Lo6NUKzRmu8cJ/eTdBvX5oQwnxgqUbCBahqt5fCdbKE8zVdOQxDxLUIEXXTzMB0n9M70ky0J7mV
	1ZVPuMvO5CdoejIBQiwUHr4wx61vXQbW/6ZxOZen5rmBnAcGki9S/JjIrE0zTIgcAXrCo+q/2ft
	PFDIJSsNtl7g6Nftmx36nZPqCCveUSa+CQ+bOKk89kKJHtyJzeZ/0/bsw0fqM=
X-Received: by 2002:a05:600c:a08c:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-48373a5bad7mr216247045e9.22.1771315289461;
        Tue, 17 Feb 2026 00:01:29 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f07:6006:8800:54ea:a0a1:e16b:9ca4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a21cbesm153558775e9.5.2026.02.17.00.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:01:29 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ionut Nechita <sunlightlinux@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [RFC PATCH 1/3] PCI: Add PCIe Gen 7 (128 GT/s) register and speed definitions
Date: Tue, 17 Feb 2026 10:00:58 +0200
Message-ID: <20260217080102.206581-4-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217080102.206581-2-sunlightlinux@gmail.com>
References: <20260217080102.206581-2-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut_n2001@yahoo.com>

Add register definitions for PCIe Gen 7 128 GT/s link speed:

  - PCI_EXP_LNKCAP_SLS_128_0GB (encoding 0x7)
  - PCI_EXP_LNKCAP2_SLS_128_0GB (bit 6 in Supported Link Speeds Vector)
  - PCI_EXP_LNKCTL2_TLS_128_0GT (Target Link Speed 0x7)
  - PCIE_SPEED_128_0GT enum value (0x1a)

Widen pci_dev.supported_speeds from u8 to u16 to accommodate the
expanded Supported Link Speeds Vector which now uses bits 1-7.

PCIe Gen 7 doubles the data rate to 128 GT/s using PAM4 signaling
with mandatory Flit mode encoding (1:1, no overhead), providing
up to 256 GB/s unidirectional (512 GB/s bi-directional) bandwidth
on an x16 link.

Note: Based on the PCIe 7.0 specification announced by PCI-SIG in
2022, targeted for member release in 2025. No hardware exists yet
to validate these definitions.

Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
---
 include/linux/pci.h           | 3 ++-
 include/uapi/linux/pci_regs.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index b5cc0c2b99065..21dd6ea5beb6d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -303,6 +303,7 @@ enum pci_bus_speed {
 	PCIE_SPEED_16_0GT		= 0x17,
 	PCIE_SPEED_32_0GT		= 0x18,
 	PCIE_SPEED_64_0GT		= 0x19,
+	PCIE_SPEED_128_0GT		= 0x1a,
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
@@ -558,7 +559,7 @@ struct pci_dev {
 	struct pci_tsm *tsm;		/* TSM operation state */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
-	u8		supported_speeds; /* Supported Link Speeds Vector */
+	u16		supported_speeds; /* Supported Link Speeds Vector */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
 	/*
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3add74ae25948..fa00c6ca9f382 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -545,6 +545,7 @@
 #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
 #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
 #define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vector bit 5 */
+#define  PCI_EXP_LNKCAP_SLS_128_0GB 0x00000007 /* LNKCAP2 SLS Vector bit 6 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
@@ -693,6 +694,7 @@
 #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_32_0GB	0x00000020 /* Supported Speed 32GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_64_0GB	0x00000040 /* Supported Speed 64GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_128_0GB	0x00000080 /* Supported Speed 128GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		0x30	/* Link Control 2 */
 #define  PCI_EXP_LNKCTL2_TLS		0x000f
@@ -702,6 +704,7 @@
 #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_64_0GT	0x0006 /* Supported Speed 64GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_128_0GT	0x0007 /* Supported Speed 128GT/s */
 #define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
 #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
-- 
2.53.0

