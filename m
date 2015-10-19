Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50155 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbbJSAYZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 Oct 2015 20:24:25 -0400
Date: Mon, 19 Oct 2015 09:24:22 +0900
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Message-ID: <20151019002422.GB20599@verge.net.au>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <20151016213443.GD21346@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151016213443.GD21346@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 16, 2015 at 04:34:43PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 02, 2015 at 11:25:03AM +0100, Phil Edworthy wrote:
> > Fixes and changes to get PCIe working on ARM64 with mulitple instances.
> > 
> > I've tested these on ARM (Koelsch board), and it works fine.
> > I've also tested on ARM64 (Salvator-X board), but I currently have an issue
> > with inbound PCI accesses. I am reasonably sure that this problem is hardware
> > related.
> > 
> > Phil Edworthy (4):
> >   PCI: rcar-pcie: Make PCI aware of the IO resources
> >   PCI: rcar-pcie: Remove dependency on ARM-specific struct hw_pci
> >   PCI: rcar-pcie: Set root bus nr to that provided in DT
> >   PCI: rcar-pcie: Fix IO offset for multiple instances
> 
> This all looks pretty reasonable to me, but I'm waiting for an ack from
> Simon before merging it.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

