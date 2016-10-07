Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754599AbcJGSVa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 14:21:30 -0400
Date: Fri, 7 Oct 2016 13:21:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roy Zang <roy.zang@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/7] PCI: layerscape: Name private struct pointer "ls"
 consistently
Message-ID: <20161007182125.GB30438@localhost>
References: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <HE1PR0402MB27481312F256EBB295800F878BC60@HE1PR0402MB2748.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <HE1PR0402MB27481312F256EBB295800F878BC60@HE1PR0402MB2748.eurprd04.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 07, 2016 at 05:05:05PM +0000, Roy Zang wrote:
> On 10/07/2016 11:42 AM, Bjorn Helgaas wrote:
> > Use a device-specific name, "ls", for struct ls_pcie pointers
> > to hint that this is device-specific information.  No functional change
> > intended.
> how about ls_pcie  instead of ls ?

Done, and re-pushed the branch, thanks!
