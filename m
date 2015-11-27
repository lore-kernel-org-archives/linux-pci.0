Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:55383 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450AbbK0UWe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Nov 2015 15:22:34 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ray Jui <rjui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/5] PCI: iproc: Add PAXC interface support
Date: Fri, 27 Nov 2015 21:22:21 +0100
Message-ID: <2502233.oJMLi3GpfH@wuerfel>
In-Reply-To: <1448645868-5730-3-git-send-email-rjui@broadcom.com>
References: <1448645868-5730-1-git-send-email-rjui@broadcom.com> <1448645868-5730-3-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 27 November 2015 09:37:45 Ray Jui wrote:
> 
> +static const struct of_device_id iproc_pcie_of_match_table[] = {
> +       {
> +               .compatible = "brcm,iproc-pcie",
> +               .data = (int *)IPROC_PCIE_PAXB,
> +       }, {
> +               .compatible = "brcm,iproc-pcie-paxc",
> +               .data = (int *)IPROC_PCIE_PAXC,
> +       },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, iproc_pcie_of_match_table);

You seem to only need the identifiers in order to set a single
pointer, so just point to that array directly. Alternatively,
do the more common thing and point to a structure of function
pointers and have different implementations of the low-level
access functions there.

	Arnd
