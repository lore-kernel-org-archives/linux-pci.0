Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:58828 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab1LGJZl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Dec 2011 04:25:41 -0500
Received: from /spool/local
	by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Wed, 7 Dec 2011 04:25:40 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pB79Pb21287778
	for <linux-pci@vger.kernel.org>; Wed, 7 Dec 2011 04:25:37 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pB79Pa7g012508
	for <linux-pci@vger.kernel.org>; Wed, 7 Dec 2011 04:25:37 -0500
Date: Wed, 7 Dec 2011 17:25:31 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 1/1]PCI: defer enablement of SRIOV BARS
Message-ID: <20111207092531.GF19129@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <CAErSpo58okGsDW4dOK4i0g_RUejkuQa=iw2uQ5HAJJZCwFtsbw@mail.gmail.com>
 <20111007232516.GF2980@ram-ThinkPad-T61>
 <1318057168.29415.333.camel@pasglop>
 <20111008075353.GK2980@ram-ThinkPad-T61>
 <1318060793.29415.347.camel@pasglop>
 <20111102140325.004b9dad@jbarnes-desktop>
 <20111103013014.GB393@ram-ThinkPad-T61>
 <20111106023310.GA2383@ram-ThinkPad-T61>
 <20111205103202.29faf6e1@jbarnes-desktop>
 <CAE9FiQXx_nkOFP2S=hXKyjcFHh4R4f5c+J-aCiDoYS=3Tgdmqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQXx_nkOFP2S=hXKyjcFHh4R4f5c+J-aCiDoYS=3Tgdmqw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 07, 2011 at 12:22:47AM -0800, Yinghai Lu wrote:
> On Mon, Dec 5, 2011 at 10:32 AM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> > On Sun, 6 Nov 2011 10:33:10 +0800
> > Ram Pai <linuxram@us.ibm.com> wrote:
> >
> >>
> >>   NOTE: Note, there is subtle change in the pci_enable_device() API.
> >>   Any driver that depends on SRIOV BARS to be enabled in pci_enable_device()
> >>   can fail.
> >>
> >> ---
> >
> > Applied to my for-linus branch, thanks.
> >
> 
> please don't push to linus now.
> 
> this one causes regression.
> 
> please check attached patch.
> 
> Thanks
> 
> Yinghai

> [PATCH] pci: Fix hotplug of Express Module with pci bridges
> 
> Found hotplug of one setup does not work with recent change in pci tree.
> 
> After checking the bridge conf setup, found bridges get assigned, but not get enabled.
> 
> Finally found following commit, simplely ignore bridge resource when enabling pci device.
> 
> | commit bbef98ab0f019f1b0c25c1acdf1683c68933d41b
> | Author: Ram Pai <linuxram@us.ibm.com>
> | Date:   Sun Nov 6 10:33:10 2011 +0800
> |
> |    PCI: defer enablement of SRIOV BARS
> |...
> |    NOTE: Note, there is subtle change in the pci_enable_device() API.  Any
> |    driver that depends on SRIOV BARS to be enabled in pci_enable_device()
> |    can fail.
> 
> Put back bridge resource and ROM resource checking to fix the problem.
> 
> That should fix regression like BIOS does not assign correct resource to bridge.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/pci.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/pci/pci.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci.c
> +++ linux-2.6/drivers/pci/pci.c
> @@ -1139,7 +1139,11 @@ static int __pci_enable_device_flags(str
>  	if (atomic_add_return(1, &dev->enable_cnt) > 1)
>  		return 0;		/* already enabled */
>  
> -	for (i = 0; i < PCI_ROM_RESOURCE; i++)
> +	/* only skip sriov related */
> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
> +		if (dev->resource[i].flags & flags)
> +			bars |= (1 << i);
> +	for (i = PCI_BRIDGE_RESOURCES; i < DEVICE_COUNT_RESOURCE; i++)
>  		if (dev->resource[i].flags & flags)
>  			bars |= (1 << i);
>  

Oops. My patch inadvertently dropped ROM and BRIDGE resources.

This patch is right. However would it help if we did something like this
to avoid some code duplication?

	for (i = 0; i < DEVICE_COUNT_RESOURCE;
		i == PCI_ROM_RESOURCE ? PCI_BRIDGE_RESOURCES: i++)
		if (dev->resource[i].flags & flags)
			bars |= (1 << i);

RP

