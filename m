Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:41507 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeHTLgb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Aug 2018 07:36:31 -0400
Date: Mon, 20 Aug 2018 10:21:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] PCI: pciehp: Mask AER surprise link down error if
 hotplug is enabled
Message-ID: <20180820082150.r4q47ppqqclaschd@wunner.de>
References: <20180818065126.77912-1-okaya@kernel.org>
 <20180818065126.77912-2-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180818065126.77912-2-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2018 at 11:51:10PM -0700, Sinan Kaya wrote:
> +static int pciehp_control_surprise_error(struct controller *ctrl, bool enable)

The return value isn't checked, so this could return void.


> @@ -280,6 +303,9 @@ static int pciehp_probe(struct pcie_device *dev)
>  
>  	pciehp_check_presence(ctrl);
>  
> +	/* We want exclusive control of link down events in hotplug driver */
> +	pciehp_control_surprise_error(ctrl, false);
> +
>  	return 0;

Hm, if the platform firmware hasn't granted native hotplug control to OSPM,
or if some other hotplug driver than pciehp is used, shouldn't surprise down
be ignored by error recovery as well?  If yes, the mask would have to be set
in generic code somewhere in drivers/pci/probe.c I guess, based on the
is_hotplug_bridge bit in struct pci_dev.

(Interestingly, PCI_ERR_UNCOR_MASK is already changed in probe.c by
program_hpp_type2().  That seems to be ACPI-specific code, which kind
of begs the question why it's not in pci-acpi.c?)

Thanks,

Lukas
