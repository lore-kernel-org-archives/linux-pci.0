Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:3515
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020Ab3JXEPk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Oct 2013 00:15:40 -0400
From: Zang Roy-R61911 <r61911@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Lian Minghuan-B31939 <B31939@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Wood Scott-B07421 <B07421@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 02/12][v3] pci: fsl: add structure fsl_pci
Date: Thu, 24 Oct 2013 04:15:30 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B3573E3@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
 <1382524894-15164-2-git-send-email-Minghuan.Lian@freescale.com>
 <2B28E421-9B64-4CEC-9E00-8893502CE12F@kernel.crashing.org>
In-Reply-To: <2B28E421-9B64-4CEC-9E00-8893502CE12F@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Wednesday, October 23, 2013 11:11 PM
> To: Lian Minghuan-B31939
> Cc: linuxppc-dev@lists.ozlabs.org list; Arnd Bergmann; Zang Roy-R61911;
> Wood Scott-B07421; Bjorn Helgaas; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 02/12][v3] pci: fsl: add structure fsl_pci
> 
> 
> On Oct 23, 2013, at 5:41 AM, Minghuan Lian wrote:
> 
> > PowerPC uses structure pci_controller to describe PCI controller, but
> > ARM uses structure pci_sys_data. In order to support PowerPC and ARM
> > simultaneously, the patch adds a structure fsl_pci that contains most
> > of the members of the pci_controller and pci_sys_data.
> > Meanwhile, it defines a interface fsl_arch_sys_to_pci() which should
> > be implemented in architecture-specific PCI controller driver to
> > convert pci_controller or pci_sys_data to fsl_pci.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > ---
> > change log:
> > v1-v3:
> > Derived from http://patchwork.ozlabs.org/patch/278965/
> >
> > Based on upstream master.
> > Based on the discussion of RFC version here
> > http://patchwork.ozlabs.org/patch/274487/
> >
> > include/linux/fsl/pci-common.h | 41
> > +++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 41 insertions(+)
> 
> NAK.
> 
> We discussed this some at the ARM Summit this week and the feeling is we
> need to move to a common interface between the various ARCHs.

Can you share more about the *common interface*?
Any plan to implement the  * common interface*?
Thanks.
Roy


