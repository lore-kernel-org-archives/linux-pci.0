Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:29034 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756983Ab3J1SWO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2013 14:22:14 -0400
Message-ID: <1382984523.3410.23.camel@snotra.buserror.net>
Subject: Re: [PATCH 02/12][v3] pci: fsl: add structure fsl_pci
From: Scott Wood <scottwood@freescale.com>
To: Lian Minghuan-b31939 <B31939@freescale.com>
CC: Kumar Gala <galak@kernel.crashing.org>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Date: Mon, 28 Oct 2013 13:22:03 -0500
In-Reply-To: <526A086E.305@freescale.com>
References: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
	 <1382524894-15164-2-git-send-email-Minghuan.Lian@freescale.com>
	 <2B28E421-9B64-4CEC-9E00-8893502CE12F@kernel.crashing.org>
	 <526A086E.305@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-10-25 at 13:58 +0800, Lian Minghuan-b31939 wrote:
> Hi Kumar,
> 
> please see my comment inline.
> 
> On 10/24/2013 12:11 PM, Kumar Gala wrote:
> > On Oct 23, 2013, at 5:41 AM, Minghuan Lian wrote:
> >
> >> PowerPC uses structure pci_controller to describe PCI controller,
> >> but ARM uses structure pci_sys_data. In order to support PowerPC
> >> and ARM simultaneously, the patch adds a structure fsl_pci that
> >> contains most of the members of the pci_controller and pci_sys_data.
> >> Meanwhile, it defines a interface fsl_arch_sys_to_pci() which should
> >> be implemented in architecture-specific PCI controller driver to
> >> convert pci_controller or pci_sys_data to fsl_pci.
> >>
> >> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> >> ---
> >> change log:
> >> v1-v3:
> >> Derived from http://patchwork.ozlabs.org/patch/278965/
> >>
> >> Based on upstream master.
> >> Based on the discussion of RFC version here
> >> http://patchwork.ozlabs.org/patch/274487/
> >>
> >> include/linux/fsl/pci-common.h | 41 +++++++++++++++++++++++++++++++++++++++++
> >> 1 file changed, 41 insertions(+)
> > NAK.
> >
> > We discussed this some at the ARM Summit this week and the feeling is we need to move to a common interface between the various ARCHs.
> [Minghuan] Do you mean we will use the common interface instead of 
> arch/powerpc/kernel/pci-common.c...
> and arch/arm/kernel/bios32.c?  Who will do the code movement and when 
> will the work be completed? The patches just move the common functions 
> of FSL PCI controller operation which can be re-used by PowerPC and ARM. 
> LS1 is coming, I worry about not having enough time to wait for the move 
> is completed.

I agree -- it can take quite a while to get from "the feeling is we need
to move to a common interface" to actually having something we can use.
If and when this unification is achieved, we can drop this extra layer.
It's a better interim solution than just duplicating the entire driver
and letting them drift apart.

-Scott



