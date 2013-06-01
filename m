Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nodalink.pck.nerim.net ([62.212.105.220]:51842 "EHLO
	paradis.irqsave.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab3FAMTG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Jun 2013 08:19:06 -0400
Date: Sat, 1 Jun 2013 14:13:21 +0200
From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>
To: linux-pci@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, alex.williamson@redhat.com
Subject: SR-IOV PF reset and QEMU VFs VFIO passthrough
Message-ID: <20130601121320.GC5157@irqsave.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hello,

I may have soon the PF driver of an SR-IOV card to code and make work with
QEMU/KVM so I have the following questions.

In an AMD64 setup where QEMU use VFIO to passthrough the VFs of an SR-IOV card
to a guest will the consequences of a PF FLR be handled fine by QEMU and the
guest ?

I read that pci_reset_function would call pci_restore_state restoring the SR-IOV
configuration after the reset of the PF.

The ways the hardware work means that the VFs would disappear and reappear in a
short lapse of time.

Will these events be handled by the kernel pci hotplug code ?

Given that the PF driver restore the PF config space after the reset will /sys
files used by QEMU disappear and reappear messing the QEMU VFIO passthrough or
will it goes smoothly ?

Best regards

Benoît Canet
