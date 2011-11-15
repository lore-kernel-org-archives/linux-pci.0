Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:34923 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756467Ab1KOQIN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Nov 2011 11:08:13 -0500
Message-ID: <af06626e34e32043e3c4974290270ec1.squirrel@webmail.sf-mail.de>
In-Reply-To: <4EC28B93.1060101@redhat.com>
References: <bd3514f0-1a80-45ac-a08e-b327a367b276@zmail15.collab.prod.int.phx2.redhat.com>
    <4EBD73C8.8070407@redhat.com>
    <CAErSpo5eZ=4yqnMFpFjTOqGvK6p4mOmsppJbodeGe+vkjfKdbw@mail.gmail.com>
    <4EBD8714.30401@redhat.com> <4EC12962.2040105@redhat.com>
    <20111114181418.GE4387@parisc-linux.org>
    <4EC28B93.1060101@redhat.com>
Date: Tue, 15 Nov 2011 17:08:10 +0100
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
From: "Rolf Eike Beer" <eike-kernel@sf-tec.de>
To: "Prarit Bhargava" <prarit@redhat.com>
Cc: "Matthew Wilcox" <matthew@wil.cx>,
	"Don Dutile" <ddutile@redhat.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	"James Paradis" <jparadis@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, jbarnes@virtuousgeek.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Trying [v2]....
>
>
> pci: Workaround Stratus broken PCIE hierarchy
>
> Stratus systems have a hierarchy that includes a PCIE Downstream bridge
> connected to a PCIE Upstream bridge and a PCI Downstream bridge.  The
> system
> boots with this wrong hierarchy into a crippled mode (USB doesn't work,
> network doesn't work ...).  Avoiding the Downstream bridge check in
> only_one_child() causes all the bridges to be enumerated and the system
> to function properly.
>
> Unfortunately this hardware is currently available so we should at least
> keep it functional.
>
> [v2]
> - ddutile@redhat.com requested drivers/pci/quirks.c code
> - matthew@will.cx requested that dmi_name_in_vendors() be called only once
> with a static var check
> - added a kernel parameter to enable scanning of all PCIE devices.
>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6f45a73..f478bd5 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3589,6 +3589,9 @@ static int __init pci_setup(char *str)
>  				pcie_bus_config = PCIE_BUS_PERFORMANCE;
>  			} else if (!strncmp(str, "pcie_bus_peer2peer", 18)) {
>  				pcie_bus_config = PCIE_BUS_PEER2PEER;
> +			} else if (!strncmp(str, "pcie_scan_all", 13)) {
> +				printk(KERN_ERR HW_ERR "PCIE: Scanning all devices.\n");
> +				pcie_scan_all = 1;
>  			} else {
>  				printk(KERN_ERR "PCI: Unknown option `%s'\n",
>  						str);

To scan all devices isn't an error, is it? The user has requested this, so
KERN_INFO should be enough.

Eike
