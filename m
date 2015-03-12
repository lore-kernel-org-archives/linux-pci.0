Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:39624 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbbCLVJA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2015 17:09:00 -0400
Received: by oifz81 with SMTP id z81so1389024oif.6
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2015 14:08:59 -0700 (PDT)
Date: Thu, 12 Mar 2015 16:08:56 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hauke Mehrtens <hauke@hauke-m.de>,
	Paul Bolle <pebolle@tiscali.nl>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/4] pci: iproc: Add Broadcom iProc PCIe support
Message-ID: <20150312210856.GF7346@google.com>
References: <1426097169-20805-1-git-send-email-rjui@broadcom.com>
 <1426097169-20805-4-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426097169-20805-4-git-send-email-rjui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 11, 2015 at 11:06:08AM -0700, Ray Jui wrote:
> This adds the support for Broadcom iProc PCIe controller
> 
> pcie-iproc.c servers as the common core driver, and front-end bus
> interface needs to be added to support different bus interfaces
> 
> pcie-iproc-pltfm.c contains the support for the platform bus interface
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ...

> +static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
> +{
> +	u8 hdr_type;
> +	u32 link_ctrl;
> +	u16 pos, link_status;
> +	int link_is_active = 0;
> +
> +	/* make sure we are not in EP mode */
> +	pci_bus_read_config_byte(bus, 0, PCI_HEADER_TYPE, &hdr_type);
> +	if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE) {
> +		dev_err(pcie->dev, "in EP mode, hdr=0x08%x\n", hdr_type);

"0x08%x" doesn't look right.  I changed it to "%#02x"; is that what you
intended?
