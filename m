Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36358 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbbJPVer (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Oct 2015 17:34:47 -0400
Date: Fri, 16 Oct 2015 16:34:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Message-ID: <20151016213443.GD21346@localhost>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 02, 2015 at 11:25:03AM +0100, Phil Edworthy wrote:
> Fixes and changes to get PCIe working on ARM64 with mulitple instances.
> 
> I've tested these on ARM (Koelsch board), and it works fine.
> I've also tested on ARM64 (Salvator-X board), but I currently have an issue
> with inbound PCI accesses. I am reasonably sure that this problem is hardware
> related.
> 
> Phil Edworthy (4):
>   PCI: rcar-pcie: Make PCI aware of the IO resources
>   PCI: rcar-pcie: Remove dependency on ARM-specific struct hw_pci
>   PCI: rcar-pcie: Set root bus nr to that provided in DT
>   PCI: rcar-pcie: Fix IO offset for multiple instances

This all looks pretty reasonable to me, but I'm waiting for an ack from
Simon before merging it.

Bjorn
