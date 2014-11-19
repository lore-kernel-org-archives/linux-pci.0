Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:42264 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbaKSCP5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 21:15:57 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
	Wed, 19 Nov 2014 12:15:40 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 981B72BB0047
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2014 13:15:34 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAJ2FB1N40763446
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2014 13:15:11 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAJ2FXSX017441
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2014 13:15:34 +1100
Message-ID: <1416363332.5704.18.camel@au1.ibm.com>
Subject: Re: [PATCH V9 03/18] PCI: Add weak pcibios_iov_resource_size()
 interface
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Donald Dutile <ddutile@redhat.com>,
	Myron Stowe <myron.stowe@redhat.com>
Date: Wed, 19 Nov 2014 13:15:32 +1100
In-Reply-To: <20141119011243.GA23467@google.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
	 <1414942894-17034-4-git-send-email-weiyang@linux.vnet.ibm.com>
	 <20141119011243.GA23467@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-11-18 at 18:12 -0700, Bjorn Helgaas wrote:
> 
> Can you help me understand this?
> 
> We have previously called sriov_init() on the PF.  There, we sized the VF
> BARs, which are in the PF's SR-IOV Capability (SR-IOV spec sec 3.3.14).
> The size we discover is the amount of space required by a single VF, so
> sriov_init() adjusts PF->resource[PCI_IOV_RESOURCES + i] by multiplying
> that size by PCI_SRIOV_TOTAL_VF, so this PF resource is now big enough to 
> hold the VF BAR[i] areas for all the possible VFs.

So I'll let Richard (Wei) answer on the details but I'll just chime in
about the "big picture". This isn't about changing the spacing between VFs
which is handled by the system page size.

This is about the way we create MMIO windows from the CPU to the VF BARs.

Basically, we have a (limited) set of 64-bit windows we can create that
are divided in equal sized segments (256 of them), each segment assigned
in HW to one of our Partitionable Endpoints (aka domain).

So even if we only ever create 16 VFs for a device, we need to use an
entire of these windows, which will use 256*VF_size and thus allocate
that much space. Also the window has to be naturally aligned.

We can then assign the VF BAR to a spot inside that window that corresponds
to the range of PEs that we have assigned to that device (which typically
isn't going to be the beginning of the window).

Cheers,
Ben.


