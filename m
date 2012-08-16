Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:60221 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab2HPD0M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Aug 2012 23:26:12 -0400
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Wed, 15 Aug 2012 23:26:11 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 05ECAC90049
	for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 23:26:09 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7G3Q83B160616
	for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 23:26:08 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7G3Q64B007368
	for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 00:26:08 -0300
Date: Thu, 16 Aug 2012 11:26:02 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Ram Pai <linuxram@us.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] methods to access resources of a struct pci_dev
Message-ID: <20120816032602.GN2449@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20120618050333.GA13469@ram-ThinkPad-T61>
 <CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
 <CAErSpo40Ok9NuMm0zxGnZ0DmFmGT19Y23JC4BCQV1RSxsmakCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo40Ok9NuMm0zxGnZ0DmFmGT19Y23JC4BCQV1RSxsmakCw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 15, 2012 at 03:25:06PM -0600, Bjorn Helgaas wrote:
> On Mon, Jun 18, 2012 at 12:30 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Sun, Jun 17, 2012 at 10:03 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> >> PCI: methods to access resources of struct pci_dev
> >>
> >> Currently pci_dev structure holds an array of 17 PCI resources; six base
> >> BARs, one ROM BAR, four BRIDGE BARs, six sriov BARs.  This is wasteful.
> >> A bridge device just needs the 4 bridge resources. A non-bridge device
> >> just needs the six base resources and one ROM resource. The sriov
> >> resources are needed only if the device has SRIOV capability.
> >>
> >> The pci_dev structure needs to be re-organized to avoid unnecessary
> >> bloating.  However too much code outside the pci-bus driver, assumes the
> >> internal details of the pci_dev structure, thus making it hard to
> >> re-organize the datastructure.
> >>
> >> As a first step this patch provides generic methods to access the
> >> resource structure of the pci_dev.
> >>
> >> Once this patch is accepted, I have another 40+ patches that modify all
> >> the files that directly access the resource structure, to use the new
> >> methods provided in the first step.
> >>
> >> Finally we can re-organize the resource structure in the pci_dev
> >> structure and correspondingly update the methods.
> >
> > I have patchset on this, please check
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> >  for-pci-for-each-res-addon
> 
> I don't like the pci_dev.resource[] table very well either, and I
> don't like the fact that drivers access it directly.  So I do think we
> need some sort of abstraction that lets us change the way we store the
> resources without affecting the callers.
> 
> Both of these (Ram's patch:
> http://marc.info/?l=linux-pci&m=133999604128815&w=2 and Yinghai's
> patch: http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=cd192f0ed93203ef6bac2a44c138899190fb5793)
> have a similar approach of adding many iterators.
> 
> Yinghai's adds:
>     for_each_pci_dev_all_resource
>     for_each_pci_dev_nobridge_resource
>     for_each_pci_dev_base_resource
>     for_each_pci_dev_base_norom_resource
>     for_each_pci_dev_base_iov_norom_resource
>     for_each_pci_dev_noiov_resource
>     for_each_pci_dev_std_resource
>     for_each_pci_dev_iov_resource
>     for_each_pci_dev_bridge_resource
>     for_each_pci_dev_addon_resource
> 
> Ram's adds:
>     for_each_resource
>     for_each_std_resource
>     for_each_std_and_rom_resource
>     for_each_sriov_resource
>     for_each_bridge_resource
> 
> It seems like we have a combinatorial explosion of iterators based on
> various orthogonal selectors (base, rom, iov, bridge window).  That
> doesn't seem understandable or maintainable to me.
> 
> I wonder if we could get by with *one* iterator, and select the
> resources of interest either by supplying a bitmask of things we care
> about, or by doing similar filtering in the caller.

I am fine with this approach. I have never encountered the need for 'no'
based iterator like 'for_each_pci_dev_noiov_resource' or
'for_each_pci_dev_base_norom_resource'. While abstracting the code and
replacing explicit references to the resources in various peices of code
including the drivers, I just encountered the need for the 'yes' based
iterators like the one that I added.

However if there is a need for 'no' based iterators, it should be easy
to incorporate them using flags. Something like

for_each_pci_resource(dev, res, i, flags)

where flags can be 
#define PCI_STD_RES 0x01
#define PCI_ROM_RES 0x02
#define PCI_BRIDGE_RES 0x04
#define PCI_IOV_RES 0x08
#define PCI_ALL_RES PCI_STD_RES|PCI_ROM_RES|PCI_BRIDGE_RES|PCI_IOV_RES
#define PCI_NOSTD_RES PCI_ALL_RES&(^PCI_STD_RES)
#define PCI_NOIOV_RES PCI_ALL_RES&(^PCI_IOV_RES)
so on and so forth

Yinghai if you are ok with this approach, let me code up all the
iterators. You can incorporate your patches based on those iterators and
I can change all my 40+ patches that change various driver sources to
use this iterator.

agree?
RP

