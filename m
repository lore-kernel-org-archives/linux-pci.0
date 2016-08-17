Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49792 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbcHQVBF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Aug 2016 17:01:05 -0400
Date: Wed, 17 Aug 2016 16:01:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: jingoohan1@gmail.com, pratyush.anand@gmail.com,
	bhelgaas@google.com, Joao.Pinto@synopsys.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] PCI: designware: let dw_pcie_link_up() beware of
 LTSSM training bit
Message-ID: <20160817210100.GD27353@localhost>
References: <1470823623-1360-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470823623-1360-1-git-send-email-jszhang@marvell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 10, 2016 at 06:07:01PM +0800, Jisheng Zhang wrote:
> patch1 is a trivial clean up: move the parameters for wait for link
> into the core pcie-designware.c
> 
> Since link may be UP but still in link training, if so, we can't think
> the link is up and operating correctly. So patch2 teaches
> dw_pcie_link_up() beware of the PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit.
> 
> Since v1:
>   - add Joao's Ack
>   - rebased on v4.8-rc1
> 
> Jisheng Zhang (2):
>   PCI: designware: mv parameters for wait for link into
>     pcie-designware.c
>   PCI: designware: let dw_pcie_link_up() beware of LTSSM training bit
> 
>  drivers/pci/host/pcie-designware.c | 11 +++++++++--
>  drivers/pci/host/pcie-designware.h |  5 -----
>  2 files changed, 9 insertions(+), 7 deletions(-)

Applied to pci/host-designware for v4.9, thanks, Jisheng.
