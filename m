Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:63691 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbaBKXXK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2014 18:23:10 -0500
Received: by mail-ig0-f177.google.com with SMTP id k19so9855087igc.4
        for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2014 15:23:09 -0800 (PST)
Date: Tue, 11 Feb 2014 16:23:06 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Marta Rybczynska <rybczynska@gmail.com>,
	linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] PCI hotplug: cpqphp: hex vs decimal typo in
 cpqhpc_probe()
Message-ID: <20140211232306.GB21057@google.com>
References: <20140210152350.GA24189@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140210152350.GA24189@elgon.mountain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 10, 2014 at 06:23:50PM +0300, Dan Carpenter wrote:
> This is a static checker fix and I can't test it, but from the context
> it definitely looks like hexidecimal 0x20 was intended here instead of
> decimal 20.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to pci/misc for v3.15, thanks a lot!

Bjorn

> diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
> index 31273e155e6c..037e2612c5bd 100644
> --- a/drivers/pci/hotplug/cpqphp_core.c
> +++ b/drivers/pci/hotplug/cpqphp_core.c
> @@ -920,12 +920,12 @@ static int cpqhpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  				bus->max_bus_speed = PCI_SPEED_100MHz_PCIX;
>  				break;
>  			}
> -			if (bus_cap & 20) {
> +			if (bus_cap & 0x20) {
>  				dbg("bus max supports 66MHz PCI-X\n");
>  				bus->max_bus_speed = PCI_SPEED_66MHz_PCIX;
>  				break;
>  			}
> -			if (bus_cap & 10) {
> +			if (bus_cap & 0x10) {
>  				dbg("bus max supports 66MHz PCI\n");
>  				bus->max_bus_speed = PCI_SPEED_66MHz;
>  				break;
