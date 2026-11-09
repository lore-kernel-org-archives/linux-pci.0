Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258527;
	b=KcabkVXKG1gGTIyhOi7ZSvErMDzvqFUjT4lQwBQi3yJO34AaVsYFA21gxJ/QVLPVf8br
	 EIIf7YtbTpFbvuf3PfwDTFSDy3f/nZ2yzbCU//zeJxwzgxffS7l+dBnE7FcSJV6vKOuYt
	 ScxLV9V35BJgJw9M4UzVB88R2mGkzaQi34Oa9PEsyHKW6aswMkTRb3JzudyiaJAYe/E3O
	 +eNFP1fF83rzSGsrtTm6yxB7X/t7iuhw/9a4go0SznxUvNogDwLdiguFeKtPHYDDRN3N3
	 RiTPr9MQWEwes11JWr3FTmGazXNIw8QP/57ziIfDy3OVjVpz6XsCvDqtY0Z+Naedzew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258527;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=k7Uod4cn46FqgZz9VTSa/JbWa6ohQqRfe87QBFy7cuw=;
	b=p3R6oG7IpeJyBK/dZm3HvkKwZJum8Kga6etbNMfWdOuaQFAndbsjJjLiy3482l2qqCC/
	 7r3zhkI8iGiZGbfh35JsU6KvHezw/WK0845i6J0zOpgXyf7eUzwrxFMkW/AULJ/4JaLtT
	 adoyapHFqUAevfKTU19rXGhjwZr7QreOIhzqiHJUxdl0fvvpZIBUyBi1TLaa6EB61Pru9
	 bOGgIeQGTOlS7pwMzL/bG7nPMeXeKVDQZAb4VWdLMzmh95qlFov2X5m6on4xCoeUqjmv2
	 Iu4VqEemkh7873YFXkfjJUJ2hiTjoe9fxdoY1uZH/dQ/so2ygxI+XHE1zSHY8VTJScg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SMTYeiXi;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36560A261F;
	Mon,  9 Nov 2026 21:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB36560A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SMTYeiXi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258526; x=1825794526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4TrGuO5kxp3e94UG0jegPIT7BsFPldAxp1qeNSG5tiA=;
  b=SMTYeiXi+TQh2HPxSx0Obegg8+gm1tyeCIglVPVAoIm5C5NAD9WuAncx
   SUTkvVHQFVw6qnRnZ2jxIZGFf+55mKjQqeSqYJHHiIFUYlMtXkUdo1kSq
   pCPLss5cLScKnrhdrQONn1BrDvPx8mHcxfDyVwereIDNUkgCO/YYH0rT3
   rsWe8h2/4nduAUd/UiJRSxDEfGUGesxNLZw7GD2JbgD9n+jEnPbMwfHsY
   FCqz8wW/CaaiauB0GrwBq3K2NtZRDZYJo/OjWNhBSsId3c7e3tbj69joY
   SLQeEcsxbldMAZ0aWOhRrAmnn+QFD3qWlI/aNMoq3rwzQ1F+e271gb1bC
   w==;
X-CSE-ConnectionGUID: tG9eWdPYSAurOW7qXlsZ6A==
X-CSE-MsgGUID: IFtotMhNRAWBVVEmrVALkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3004795"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3004795"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:46 -0800
X-CSE-ConnectionGUID: v8ORlNCGRQaFl95JGnje2w==
X-CSE-MsgGUID: IH8R4BIxRyqzd+CbuMw16w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9746909"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 09/11] PCI: Move CardBus legacy mode quirk to setup-cardbus.c
Date: Mon,  9 Nov 2026 23:07:09 +0200
Message-ID: <20261109210714.3862-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

quirk_cardbus_legacy() disables the legacy i82365 mode of CardBus
bridges. It was originally applied even without CardBus support to keep
the i82365 driver away from CardBus bridges, but that driver was removed
by commit b3c26ea81ccc ("pcmcia: remove obsolete host controller
drivers").

CardBus bridges are no longer set up when CONFIG_CARDBUS is not set, so
the quirk only matters with CARDBUS. Move it to setup-cardbus.c.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Cc: Dominik Brodowski <linux@dominikbrodowski.net>

 drivers/pci/quirks.c        | 13 -------------
 drivers/pci/setup-cardbus.c | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..78f6df5d4d19 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1286,19 +1286,6 @@ static void quirk_vt82c598_id(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id);
 
-/*
- * CardBus controllers have a legacy base address that enables them to
- * respond as i82365 PCMCIA controllers.  We don't want them to do this.
- */
-static void quirk_cardbus_legacy(struct pci_dev *dev)
-{
-	pci_write_config_dword(dev, PCI_CB_LEGACY_MODE_BASE, 0);
-}
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
-			PCI_CLASS_BRIDGE_CARDBUS, 8, quirk_cardbus_legacy);
-DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_ANY_ID, PCI_ANY_ID,
-			PCI_CLASS_BRIDGE_CARDBUS, 8, quirk_cardbus_legacy);
-
 /*
  * Following the PCI ordering rules is optional on the AMD762. I'm not sure
  * what the designers were smoking but let's not inhale...
diff --git a/drivers/pci/setup-cardbus.c b/drivers/pci/setup-cardbus.c
index 0de82d7fde68..ef35393aca1b 100644
--- a/drivers/pci/setup-cardbus.c
+++ b/drivers/pci/setup-cardbus.c
@@ -316,3 +316,18 @@ int pci_cardbus_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 
 	return max;
 }
+
+#ifdef CONFIG_PCI_QUIRKS
+/*
+ * CardBus controllers have a legacy base address that enables them to
+ * respond as i82365 PCMCIA controllers.  We don't want them to do this.
+ */
+static void quirk_cardbus_legacy(struct pci_dev *dev)
+{
+	pci_write_config_dword(dev, PCI_CB_LEGACY_MODE_BASE, 0);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
+			PCI_CLASS_BRIDGE_CARDBUS, 8, quirk_cardbus_legacy);
+DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_ANY_ID, PCI_ANY_ID,
+			PCI_CLASS_BRIDGE_CARDBUS, 8, quirk_cardbus_legacy);
+#endif /* CONFIG_PCI_QUIRKS */
-- 
2.47.3

