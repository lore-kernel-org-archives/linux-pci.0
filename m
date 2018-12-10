Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1747DC5CFFE
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 22:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE11520821
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 22:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="i4SAyggz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE11520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeLJWIF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:08:05 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:40160 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeLJWIF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2018 17:08:05 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BE0C424E00CA;
        Mon, 10 Dec 2018 14:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544479684; bh=cXIKGvlQhfQVAE+Ow9Yinuk2QOC8OnJ7yl7c95eFIpA=;
        h=Date:In-Reply-To:References:From:Subject:To:CC:From;
        b=i4SAyggzgYiPWb9Fi87L6fxpI5+yCrOf7Kf770z6ahQrkd7KI5l/JxEtUNb0LVxYr
         ubdIqbB8uHpprprAaEuw4/6uFAYX+Hsczfrp+Y6Ix3Tajf2A5iP9/caWkYpFTcYWpC
         2wMBmx+2fq22wm+sASz44VP9OS4qxOE1o0hOUNdwTRNAX/nAgDR/1CZK4EmMgLNGlN
         T3sX0wnXTnGWtNtQK/UYOJrY8qE1Nfk5khjqynooultBX0idp8+/pzVNIKzL2AVBaN
         RfNLdHWmAEn2Zz1G3NBEvK2v5zHVzivTm1FHHTEO7VwT27Kn/gNX0DL9Y0ubz3G4r1
         xudUwyVmokHnw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id A2DED545D;
        Mon, 10 Dec 2018 14:08:04 -0800 (PST)
Received: from US01WEHTC2.internal.synopsys.com (10.12.239.237) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 10 Dec 2018 14:08:04 -0800
Received: from te-lab16 (10.13.184.20) by US01WEHTC2.internal.synopsys.com
 (10.12.239.238) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 10 Dec
 2018 14:08:01 -0800
Received: by te-lab16 (sSMTP sendmail emulation); Mon, 10 Dec 2018 14:08:01
 -0800
Date:   Mon, 10 Dec 2018 14:08:01 -0800
Message-ID: <8994fd7d7ee2bf5c1b32ce5bca25be4beb4405b5.1544478969.git.thinhn@synopsys.com>
In-Reply-To: <3aa06c4e54bf98a59e510d7a833934fce4b0083b.1544478969.git.thinhn@synopsys.com>
References: <3aa06c4e54bf98a59e510d7a833934fce4b0083b.1544478969.git.thinhn@synopsys.com>
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
Subject: [PATCH v2 2/2] PCI: Override Synopsys USB 3.x HAPS device class
To:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-usb@vger.kernel.org>
CC:     John Youn <john.youn@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.184.20]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Synopsys USB 3.x host HAPS platform has a class code of
PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, these
devices should use dwc3-haps driver. Change these devices' class code to
PCI_CLASS_SERIAL_USB_DEVICE to prevent the xhci-pci driver from claiming
them.

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
---
Change in v2:
- Revise title to fit PCI patches' convention
- Override pci class instead of driver

 drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4700d24e5d55..c84f81c42a1f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -618,6 +618,32 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
 		quirk_amd_nl_class);
 
+/*
+ * Synopsys USB 3.x host HAPS platform has a class code of
+ * PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, these
+ * devices should use dwc3-haps driver. Change these devices' class code to
+ * PCI_CLASS_SERIAL_USB_DEVICE to prevent the xhci-pci driver from claiming
+ * them.
+ */
+static void quirk_synopsys_haps(struct pci_dev *pdev)
+{
+	u32 class = pdev->class;
+
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3:
+	case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI:
+	case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31:
+		pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
+		pci_info(pdev, "PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
+			 class, pdev->class);
+		break;
+	default:
+		return;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
+			 quirk_synopsys_haps);
+
 /*
  * Let's make the southbridge information explicit instead of having to
  * worry about people probing the ACPI areas, for example.. (Yes, it
-- 
2.11.0

