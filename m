Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0189.outbound.protection.outlook.com ([207.46.163.189]:25846
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753362AbaACWh1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 3 Jan 2014 17:37:27 -0500
Message-ID: <1388788641.11795.76.camel@snotra.buserror.net>
Subject: Re: [PATCH 01/12][v3] pci: fsl: derive the common PCI driver to
 drivers/pci/host
From: Scott Wood <scottwood@freescale.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Minghuan Lian <Minghuan.Lian@freescale.com>,
	<linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	Zang Roy-R61911 <r61911@freescale.com>
Date: Fri, 3 Jan 2014 16:37:21 -0600
In-Reply-To: <20131125230116.GA3819@google.com>
References: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
	 <20131125230116.GA3819@google.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-11-25 at 16:01 -0700, Bjorn Helgaas wrote:
> On Wed, Oct 23, 2013 at 06:41:23PM +0800, Minghuan Lian wrote:
> > The Freescale's Layerscape series processors will use ARM cores.
> > The LS1's PCIe controllers is the same as T4240's. So it's better
> > the PCIe controller driver can support PowerPC and ARM
> > simultaneously. This patch is for this purpose. It derives
> > the common functions from arch/powerpc/sysdev/fsl_pci.c to
> > drivers/pci/host/pci-fsl-common.c and leaves the architecture
> > specific functions which should be implemented in arch related files.
> > 
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> 
> It doesn't look like we have a consensus on how to proceed here, so I'm
> ignoring this series for now.  Let me know if there really *is* agreement,
> or if there's some subset of this work that everybody can agree on.  It'd
> be good to make forward progress, even if it's not completely perfect yet.

I'd like to see what this would look like with actual ARM support,
rather than just some theoretical attempts to make it less PPC-dependent
that involve copying PPC stuff that may or may not work well with what
ARM code will expect.

When I replied to Kumar's comment saying that this seemed like a
reasonable interim approach, that was before I saw how much was copied
from places other than fsl_pci files.

-Scott


