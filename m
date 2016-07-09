Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:36333 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756699AbcGIUBy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2016 16:01:54 -0400
Date: Sat, 9 Jul 2016 22:01:51 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, vfio-users@redhat.com,
	tglx@linutronix.de
Subject: Re: The same IOMMU group for igb and its igbvf siblings
Message-ID: <20160709200151.GA27170@breakpoint.cc>
References: <20160709191600.GA26115@breakpoint.cc>
 <20160709134403.0feb2150@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160709134403.0feb2150@t450s.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016-07-09 13:44:03 [-0600], Alex Williamson wrote:
> The root port device IDs translate to a Skylake platform, which is a
> "client" processor.  Core-i3/5/7 and even Xeon E3 fit into this

It is an E3-1230 v5

> category and they do not support ACS on the processor root ports.  This
> groups everything downstream of those root ports together and even
> binds together separate sub-hierarchies when the root ports are joined
> in a multifunction slot.  Without ACS we cannot guarantee that
> peer-to-peer DMA does not occur through redirection prior to IOMMU
> translation.

So it is not a missing BIOS knob but a missing CPU feature.

> The easiest solution is to move the card to one of the PCH sourced root
> ports (ie. downstream of root ports at 00:1c.*).  As of kernel v4.7-rc1
> we have quirks for the Sunrise Point PCH to work around the botched
> implementation of ACS found in this chipset.  Pretty much all Intel
> client processors have the same story, no ACS in the processor root
> ports, quirks to enable ACS in the PCH root ports.  Xeon E5 and higher
> as well as "High End Desktop Processors" (based on E5) support ACS
> correctly (though the PCH root ports need and already have quirks for
> ACS).

bah. Not sure if another slot is possible / available but thanks for the
hint.

> There exists a non-upstream patch to override ACS, which does nothing
> to solve the isolation problem, it just allows you to gamble with data
> integrity, which is why it really has no place upstream.  The IGB
> devices you note in pci_dev_acs_enabled are quirks for the IGB PFs.
> Intel has confirmed that there is isolation between the PFs, so when
> installed into topology that does have ACS support, this allows the PFs
> to be put into separate groups.  Since the point at which your system
> lacks isolation is upstream of the PFs, this doesn't help you.  Thanks,

Thank you for the explanation.

> Alex

Sebastian
