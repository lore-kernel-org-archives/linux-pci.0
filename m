Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:54239 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476Ab3J3DFe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Oct 2013 23:05:34 -0400
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <zhenghch@linux.vnet.ibm.com>;
	Tue, 29 Oct 2013 23:05:33 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id BB2C738C803B
	for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2013 23:05:29 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r9U35U7550462744
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2013 03:05:30 GMT
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r9U35TKW031147
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2013 01:05:30 -0200
Message-ID: <1383102327.8618.0.camel@stefan-ThinkPad-T420>
Subject: Re: [PATCH] lspci: Skip scanning empty slot in sysfs_fill_slots
From: Zheng Huai Cheng <zhenghch@linux.vnet.ibm.com>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Date: Wed, 30 Oct 2013 11:05:27 +0800
In-Reply-To: <mj+md-20131029.120828.26872.nikam@ucw.cz>
References: <526F4EB4.4090101@linux.vnet.ibm.com>
	 <mj+md-20131029.120828.26872.nikam@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-10-29 at 13:09 +0100, Martin Mares wrote:
> Hello!
> 
> > When slot is empty, lspci will report "pcilib: sysfs_fill_slots:
> > Couldn't parse entry address 0000:01",this is because address entry will
> > only contain domain and bus number when the slot is empty.
> > 
> > [root@uselp6 ~]# cat /sys/bus/pci/slots/U5802.001.RCHB059-P1-C7/address
> > 0000:01

> Is this behavior intentional?  It does not make much sense to me.
> 
> 				Have a nice fortnight
although I am not a expert in PCI, seems this related to PCI hotplug.
And I also found a description in kernel source code

"
Placeholder slots:
In most cases, @pci_bus, @slot_nr will be sufficient to uniquely
identify a slot. There is one notable exception - pSeries (rpaphp),
where the @slot_nr cannot be determined until a device is actually
inserted into the slot. In this scenario, the caller may pass -1 for
@slot_nr.The following semantics are imposed when the caller passes
@slot_nr == -1. First, we no longer check for an existing %struct
pci_slot, as there may be many slots with @slot_nr of -1.  The other
change in semantics is user-visible, which is the 'address' parameter
presented in sysfs will consist solely of a dddd:bb tuple, where dddd is
the PCI domain of the %struct pci_bus and bb is the bus number. In other
words, the devfn of the 'placeholder' slot will not be
displayed.                             
"

so when slots are empty in some cases, "address" solely contain dddd:bb
tuple. But lspci will originally assume address in dddd:dd:dd tuple. so
we should skip dddd:bb case in sysfs_fill_slots

