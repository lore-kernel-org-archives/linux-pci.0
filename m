Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nodalink.pck.nerim.net ([62.212.105.220]:52896 "EHLO
	paradis.irqsave.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab3FCT2d (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2013 15:28:33 -0400
Date: Mon, 3 Jun 2013 21:29:59 +0200
From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>
To: Don Dutile <ddutile@redhat.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, alex.williamson@redhat.com
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
Message-ID: <20130603192958.GB31044@irqsave.net>
References: <20130601121320.GC5157@irqsave.net>
 <51ACE340.1030406@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <51ACE340.1030406@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >to a guest will the consequences of a PF FLR be handled fine by QEMU and the
> >guest ?
> >
> the reset occurs long before the device is passed to the guest.

I was asking this because the PF driver should reset the PF while the VF are
used by VFIO/QEMU when the PF doesn't respond anymore.

> The PF driver doesn't do the config space restore -- it's done in PCI core code.
> >files used by QEMU disappear and reappear messing the QEMU VFIO passthrough or
> As stated above, the devices don't disappear from the device tree, so they don't
> get removed/added to the /sys(/bus/pci/...) files.
> 
> >will it goes smoothly ?
> >
> it goes smoothly today.... :-/

Happy to read that thanks for the answer.

Best regards

Benoît Canet
