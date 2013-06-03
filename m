Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nodalink.pck.nerim.net ([62.212.105.220]:52985 "EHLO
	paradis.irqsave.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab3FCVZ5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2013 17:25:57 -0400
Date: Mon, 3 Jun 2013 23:27:23 +0200
From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>
To: Don Dutile <ddutile@redhat.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, alex.williamson@redhat.com
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
Message-ID: <20130603212723.GG4094@irqsave.net>
References: <20130601121320.GC5157@irqsave.net>
 <51ACE340.1030406@redhat.com>
 <20130603192958.GB31044@irqsave.net>
 <51AD02B1.8070503@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <51AD02B1.8070503@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >I was asking this because the PF driver should reset the PF while the VF are
> >used by VFIO/QEMU when the PF doesn't respond anymore.
> >
> What your VF does while your PF is being reset is PF (& VF) dependent.
> A 'good design' would not impact the VF operation, other than to stall it until
> the PF completed reset.  My experience, though, is that the PF has to be brought
> up to some level of functionality to share the physical resources with the VFs.

When the PF does an FLR the hardware go back to its default state, the SR-IOV
configuration is gone and the VFs disappears from the bus.
Then the restore state function of the kernel reset code would bring the SR-IOV
PF configuration back.

The hardware also have a privately owned SR-IOV related configuration in the PF
configuration space. This configuration is used to configure the VFs resources.
(memory)

Best regards

Benoît Canet
