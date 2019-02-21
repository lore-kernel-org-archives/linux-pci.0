Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BE2C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 07:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA712148D
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 07:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfBUH4h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:56:37 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:35295 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUH4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 02:56:37 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 0420D100D940C;
        Thu, 21 Feb 2019 08:56:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AB831173A2E; Thu, 21 Feb 2019 08:56:34 +0100 (CET)
Date:   Thu, 21 Feb 2019 08:56:34 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, okaya@kernel.org, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 4/4] PCI: hotplug: Add quirk For Dell nvme pcie
 switches
Message-ID: <20190221075634.uih5ysqwkna7cku4@wunner.de>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
 <20190220012031.10741-5-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220012031.10741-5-mr.nuke.me@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 19, 2019 at 07:20:30PM -0600, Alexandru Gagniuc wrote:
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -952,3 +952,23 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0400,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> +
> +

Duplicate newline.


> +static void fixup_dell_nvme_backplane_switches(struct pci_dev *pdev)

Can we have a little code comment above the function such as:

+/*
+ * Dell <product name> NVMe storage backplanes disable in-band presence
+ * (PCIe r5.0 sec X.Y.Z) but neglect to set the corresponding flag in the
+ * Slot Capabilities 2 register.
+ */


> +	if (pdev->subsystem_vendor != PCI_VENDOR_ID_DELL
> +		|| pdev->subsystem_device != 0x1fc7)

This looks a little unpolished, how about:

+	if (pdev->subsystem_vendor != PCI_VENDOR_ID_DELL ||
+	    pdev->subsystem_device != 0x1fc7)


> +		return;
> +
> +	pdev->no_in_band_presence = 1;
> +}
> +
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_PLX, 0x9733,

By convention there's no blank line between the closing curly brace
and the DECLARE_PCI_FIXUP_CLASS_FINAL().

If the quirk is x86-specific, please enclose it in "#ifdef CONFIG_X86"
to reduce kernel footprint on other arches.

Thanks,

Lukas
