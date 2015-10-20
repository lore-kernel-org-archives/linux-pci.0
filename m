Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:38197 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbJTBgy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2015 21:36:54 -0400
Date: Tue, 20 Oct 2015 10:36:50 +0900
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Message-ID: <20151020013650.GA13721@verge.net.au>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <20151019231634.GA13841@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151019231634.GA13841@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 19, 2015 at 06:16:34PM -0500, Bjorn Helgaas wrote:
> [+cc Geert]
> 
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
> I applied these with Simon's ack to pci/host-rcar for v4.4.
> 
> Note that these are on top of Geert's patch to make rcar build only
> for ARM, which is probably not necessary after you remove the struct
> hw_pci dependency.  I can drop Geert's patch if you want.

I'm happy with that if Geert is.
