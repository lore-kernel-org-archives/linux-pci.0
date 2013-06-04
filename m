Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nodalink.pck.nerim.net ([62.212.105.220]:53510 "EHLO
	paradis.irqsave.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab3FDPw5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2013 11:52:57 -0400
Date: Tue, 4 Jun 2013 17:54:22 +0200
From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>
To: Don Dutile <ddutile@redhat.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, alex.williamson@redhat.com
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
Message-ID: <20130604155422.GB5991@irqsave.net>
References: <20130601121320.GC5157@irqsave.net>
 <51ACE340.1030406@redhat.com>
 <20130603192958.GB31044@irqsave.net>
 <51AD02B1.8070503@redhat.com>
 <20130603212723.GG4094@irqsave.net>
 <51AD0DB8.8090109@redhat.com>
 <20130603215855.GC31044@irqsave.net>
 <51AD12AB.1000903@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <51AD12AB.1000903@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >>Per the SRIOV spec, yes, but that's in PCIe ext cfg space.
> >>That area of the PCI configuration is not saved or restored by dev-reset.
> >
> >Can a callback be added so PF driver can restore this state ?
> >
> As you pointed out, no need to, unless it's a device-specific,
> PCIe cap structure.  the SRIOV caps are re-instated, as you showed above...

I think this is a device specific structure.

It would be annoying only in case of a PF FLR initiated via /sys or something
external to the PF driver because the PF driver could restore this area after it
initiate an FLR.

Best regards

Benoît Canet
