Return-Path: <SRS0=Gu+H=NO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7745CC65C22
	for <linux-pci@archiver.kernel.org>; Sat,  3 Nov 2018 01:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3029720831
	for <linux-pci@archiver.kernel.org>; Sat,  3 Nov 2018 01:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DlpTlZQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3029720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeKCK5T (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 3 Nov 2018 06:57:19 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:55116 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeKCK5T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Nov 2018 06:57:19 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6236410C0EC5;
        Fri,  2 Nov 2018 18:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541209666; bh=RK9Ud9mkm4EU37LFwb50++Keku2tR1KdQQdMXnFUGpo=;
        h=Date:In-Reply-To:References:From:Subject:To:CC:From;
        b=DlpTlZQBzqQjPdIaLKGTicPffHefkSPZq9M2GvTuDyeKeHzhFR0H+pUBgSF1d+jE7
         nS0mImLkw8PyeeNuEPuMYnlscnFBaHeNd+ljvj6+l4UWqCXnp/OFy0/qedrlcDdumY
         iew0CQVClHHWmFTqRxE3qZ0r6MnjDhhyYtRug8L7d7ufaBHb7KX20v6/OOfHNi+zj2
         SsOL0skgpCVWjNiEAMsW0VnhnFXxg1AAA5ZNm6+9lVNWryte69J6NayUgoF9t0IZBh
         sBRX0NcBW8Fr2PgzfJFb+O0RFgQDdQD1yazPEuZOX5SAse4lP+lVlp5J7W4SRZ6jhc
         4lA7CugYD+fiQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5433754E7;
        Fri,  2 Nov 2018 18:47:46 -0700 (PDT)
Received: from US01WEHTC3.internal.synopsys.com (10.15.84.232) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 2 Nov 2018 18:47:46 -0700
Received: from te-lab16 (10.13.184.20) by US01WEHTC3.internal.synopsys.com
 (10.15.84.231) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 2 Nov
 2018 18:47:44 -0700
Received: by te-lab16 (sSMTP sendmail emulation); Fri, 02 Nov 2018 18:47:44
 -0700
Date:   Fri, 2 Nov 2018 18:47:44 -0700
Message-ID: <8faa039d80ba1f8ab2c7192a237ff8431d5cdc4a.1541209477.git.thinhn@synopsys.com>
In-Reply-To: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
References: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
Subject: [PATCH 2/2] pci: quirks: Override Synopsys USB 3.x HAPS device driver
To:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC:     Thinh Nguyen <thinh.nguyen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.184.20]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Synopsys USB 3.x host HAPS platform has a class code of
PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, these
devices should use dwc3-haps driver. Set driver_override to dwc3-haps
for these platforms.

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
---
 drivers/pci/quirks.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6bc27b7fd452..5f7c3ade7749 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -618,6 +618,27 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
 		quirk_amd_nl_class);
 
+/*
+ * Synopsys USB 3.x host HAPS platform has a class code of
+ * PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, these
+ * devices should use dwc3-haps driver. Set driver_override to dwc3-haps for
+ * these platforms.
+ */
+static void quirk_synopsys_haps(struct pci_dev *pdev)
+{
+	/* Use dwc3-haps driver instead of xhci-pci */
+	pdev->driver_override = "dwc3-haps";
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SYNOPSYS,
+			PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3,
+			quirk_synopsys_haps);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SYNOPSYS,
+			PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI,
+			quirk_synopsys_haps);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SYNOPSYS,
+			PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31,
+			quirk_synopsys_haps);
+
 /*
  * Let's make the southbridge information explicit instead of having to
  * worry about people probing the ACPI areas, for example.. (Yes, it
-- 
2.11.0

