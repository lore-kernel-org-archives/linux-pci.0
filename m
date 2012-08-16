Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:34330 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab2HPElN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 00:41:13 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Wed, 15 Aug 2012 22:41:12 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8DFA719D803E
	for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 22:41:10 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7G4f9kt173274
	for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 22:41:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7G4f8GI012178
	for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 22:41:09 -0600
Date: Thu, 16 Aug 2012 12:41:04 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] methods to access resources of a struct pci_dev
Message-ID: <20120816044104.GQ2449@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20120618050333.GA13469@ram-ThinkPad-T61>
 <CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
 <CAErSpo40Ok9NuMm0zxGnZ0DmFmGT19Y23JC4BCQV1RSxsmakCw@mail.gmail.com>
 <20120816032602.GN2449@ram-ThinkPad-T61>
 <CAE9FiQW08aoQBiy+37x-VMYrG-OunqzfuRpB1JhDAgNL3AxEuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQW08aoQBiy+37x-VMYrG-OunqzfuRpB1JhDAgNL3AxEuw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 15, 2012 at 09:11:03PM -0700, Yinghai Lu wrote:
> On Wed, Aug 15, 2012 at 8:26 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> > On Wed, Aug 15, 2012 at 03:25:06PM -0600, Bjorn Helgaas wrote:
> >
> > I am fine with this approach. I have never encountered the need for 'no'
> > based iterator like 'for_each_pci_dev_noiov_resource' or
> > 'for_each_pci_dev_base_norom_resource'. While abstracting the code and
> > replacing explicit references to the resources in various peices of code
> > including the drivers, I just encountered the need for the 'yes' based
> > iterators like the one that I added.
> >
> > However if there is a need for 'no' based iterators, it should be easy
> > to incorporate them using flags. Something like
> >
> > for_each_pci_resource(dev, res, i, flags)
> >
> > where flags can be
> > #define PCI_STD_RES 0x01
> > #define PCI_ROM_RES 0x02
> > #define PCI_BRIDGE_RES 0x04
> > #define PCI_IOV_RES 0x08
> > #define PCI_ALL_RES PCI_STD_RES|PCI_ROM_RES|PCI_BRIDGE_RES|PCI_IOV_RES
> > #define PCI_NOSTD_RES PCI_ALL_RES&(^PCI_STD_RES)
> > #define PCI_NOIOV_RES PCI_ALL_RES&(^PCI_IOV_RES)
> > so on and so forth
> >
> > Yinghai if you are ok with this approach, let me code up all the
> > iterators. You can incorporate your patches based on those iterators and
> > I can change all my 40+ patches that change various driver sources to
> > use this iterator.
> 
> Do you mean that you will have updated patch for
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=cd192f0ed93203ef6bac2a44c138899190fb5793
> ?

Yes.

> 
> if it is that case, i am ok, and then I could use scripts to update
> following patches.

Ok. Will have it your way soon.
RP

