Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:38888 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519Ab2HVKP7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Aug 2012 06:15:59 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Wed, 22 Aug 2012 06:15:58 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C0CB0C90042
	for <linux-pci@vger.kernel.org>; Wed, 22 Aug 2012 06:15:56 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7MAFuQJ174024
	for <linux-pci@vger.kernel.org>; Wed, 22 Aug 2012 06:15:56 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7MAFmYG031585
	for <linux-pci@vger.kernel.org>; Wed, 22 Aug 2012 07:15:56 -0300
Date: Wed, 22 Aug 2012 18:15:33 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH v2 ]pci: pci resource iterator
Message-ID: <20120822101533.GA2332@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20120618050333.GA13469@ram-ThinkPad-T61>
 <CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
 <CAErSpo40Ok9NuMm0zxGnZ0DmFmGT19Y23JC4BCQV1RSxsmakCw@mail.gmail.com>
 <20120816032602.GN2449@ram-ThinkPad-T61>
 <CAE9FiQW08aoQBiy+37x-VMYrG-OunqzfuRpB1JhDAgNL3AxEuw@mail.gmail.com>
 <20120816044104.GQ2449@ram-ThinkPad-T61>
 <20120821151245.GA2356@ram-ThinkPad-T61>
 <CAE9FiQUW2rB8X18=X6hVb-ZV8AnoL4RA+8P7897vHxwjj63bsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUW2rB8X18=X6hVb-ZV8AnoL4RA+8P7897vHxwjj63bsg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 21, 2012 at 04:22:52PM -0700, Yinghai Lu wrote:
> On Tue, Aug 21, 2012 at 8:13 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> > PCI: pci resource iterator
> >
> > Currently pci_dev structure holds an array of 17 PCI resources; six base
> > BARs, one ROM BAR, four BRIDGE BARs, six sriov BARs.  This is wasteful.
> > A bridge device just needs the 4 bridge resources. A non-bridge device
> > just needs the six base resources and one ROM resource. The sriov
> > resources are needed only if the device has SRIOV capability.
> >
> > The pci_dev structure needs to be re-organized to avoid unnecessary
> > bloating.  However too much code outside the pci-bus driver, assumes the
> > internal details of the pci_dev structure, thus making it hard to
> > re-organize the datastructure.
> >
> > As a first step this patch provides generic methods to access the
> > resource structure of the pci_dev.
> >
> > Once this patch is accepted, I have another 40+ patches that modify all
> > the files that directly access the resource structure, to use the new
> > methods provided in the first step.
> >
> > Finally we can re-organize the resource structure in the pci_dev
> > structure and correspondingly update the methods.
> >
> > This patch is compile tested only.
> >
> > Changelog:
> >         Consolidated iterator interface as per Bjorn's suggestion.
> >
> > +#define for_each_pci_resource(dev, res, flag) \
> > +       for (res = pci_next_resource(dev, NULL, flag); res; \
> > +                       res = pci_next_resource(dev, res, flag))
> > +
> 
> We may need to keep the idx, so we could make the converting more granularity.
> 
> because some loop body is still using the idx.
> 
> also there is some abusing pci bridge resource as addon resources.
> and we need to remove the abusing at first ---
> that is addressed by:
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=5eb48c3c998257386f67a7570778872ec600138f
> 
>  PCI: Add addon_resource support for pci_dev
> 
> and later we may remove the idx in the for_each_pci_resource()
> 
> Please check updated version of your patch that keep the idx.

by exposing idx through the interface, we are exposing the implementation to
the enduser. I want the end user not know that the resources are 
structured as a array. This will help easily restructure resources
in the pci_dev structure to whatever implementation we want, linked list
or hash or whatever...

Why can't the addon resource be hidden behind the interface? something
like this?

static inline struct resource *pci_next_resource(struct pci_dev *pdev,
                       struct resource *res, int flag)
{
       int i = res? pci_resource_number(pdev, res) : -1;

       while (++i < PCI_NUM_RESOURCES) {
               if ((i >= 0 && i < PCI_ROM_RESOURCE) && (flag & PCI_STD_RES))
                       return pci_get_std_resource(pdev, i);
               else if ((i == PCI_ROM_RESOURCE) && (flag & PCI_ROM_RES))
                       return pci_get_rom_resource(pdev);
               else if ((i <= PCI_IOV_RESOURCE_END) && (flag & PCI_IOV_RES))
                       return pci_get_sriov_resource(pdev, i-PCI_IOV_RESOURCES);
               else if ((i <= PCI_BRIDGE_RESOURCE_END) && (flag & PCI_BRIDGE_RES))
                       return pci_get_bridge_resource(pdev, i-PCI_BRIDGE_RESOURCES);
       }

       if (flag & PCI_ADDON_RES) {
       		if ( i == PCI_NUM_RESOURCES) {
       			// return the first element of the addon list;
		} else {
			// return the next element in the list;
		}		
       }
       return NULL;
}

