Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nodalink.pck.nerim.net ([62.212.105.220]:52169 "EHLO
	paradis.irqsave.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab3FBPL6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Jun 2013 11:11:58 -0400
Date: Sun, 2 Jun 2013 17:13:20 +0200
From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>,
	linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
Message-ID: <20130602151320.GB4095@irqsave.net>
References: <20130601121320.GC5157@irqsave.net>
 <1370182302.30975.279.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1370182302.30975.279.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Thanks a lot for the answer.

Best regards

Benoît

> Le Sunday 02 Jun 2013 à 08:11:42 (-0600), Alex Williamson a écrit :
> On Sat, 2013-06-01 at 14:13 +0200, Benoît Canet wrote:
> > Hello,
> > 
> > I may have soon the PF driver of an SR-IOV card to code and make work with
> > QEMU/KVM so I have the following questions.
> > 
> > In an AMD64 setup where QEMU use VFIO to passthrough the VFs of an SR-IOV card
> > to a guest will the consequences of a PF FLR be handled fine by QEMU and the
> > guest ?
> > 
> > I read that pci_reset_function would call pci_restore_state restoring the SR-IOV
> > configuration after the reset of the PF.
> > 
> > The ways the hardware work means that the VFs would disappear and reappear in a
> > short lapse of time.
> > 
> > Will these events be handled by the kernel pci hotplug code ?
> > 
> > Given that the PF driver restore the PF config space after the reset will /sys
> > files used by QEMU disappear and reappear messing the QEMU VFIO passthrough or
> > will it goes smoothly ?
> 
> On an Intel 82576 SR-IOV NIC, a FLR of the PF does not cause the VFs to
> be removed.  It's not clear to me that they continue working across the
> reset, but there is no hotplug.  If there was a hotplug, vfio-pci won't
> release the device while it's in use, so the hotplug would be blocked
> until the devices becomes unused, such as from the VM being shutdown.
> Thanks,
> 
> Alex
> 
> 
