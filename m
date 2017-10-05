Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751286AbdJERqK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Oct 2017 13:46:10 -0400
Date: Thu, 5 Oct 2017 12:46:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Hanna Hawa <hannah@marvell.com>,
        Yehuda Yitschak <yehuday@marvell.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal
        <miquel.raynal@free-electrons.com>, Victor Gu <xigu@marvell.com>
Subject: Re: [PATCH v2 5/7] PCI: aardvark: disable LOS state by default
Message-ID: <20171005174607.GS25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-6-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170928125838.11887-6-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I assume you mean "ASPM L0s"?

On Thu, Sep 28, 2017 at 02:58:36PM +0200, Thomas Petazzoni wrote:
> From: Victor Gu <xigu@marvell.com>
> 
> Some PCIe devices do not support LOS, and will cause timeouts if the
> root complex forces the LOS state. This patch disables the LOS state
> by default.

Per PCIe r3.1, sec 5.4.1.3, software should not enable L0s in either
direction unless both ends support L0s.

I'm unclear on what the bug is here.  Is the generic ASPM code
incorrectly enabling L0s when one end doesn't support it?  That seems
unlikely, but if so, it should be fixed in the generic ASPM code.

Are both ends advertising L0s support, but there's a hardware erratum
on the Aardvark end that keeps it from working correctly?  If so, we
should say that explicitly and include a reference to a published
hardware erratum.

Something else?

> This is part of fixing bug
> https://bugzilla.kernel.org/show_bug.cgi?id=196339, this commit was
> reported as the user to be important to get a Intel 7260 mini-PCIe
> WiFi card working.

The bugzilla link is a good start, but "reported by the user to be
important" is meaningless by itself.  What we need here is the details
of what's broken and how this fixes it.  Unfortunately the bugzilla
doesn't have those details.

> Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
> Signed-off-by: Victor Gu <xigu@marvell.com>
> Reviewed-by: Evan Wang <xswang@marvell.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> [Thomas: tweak commit log.]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/host/pci-aardvark.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index 23e243135ebe..a173f31853df 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -368,8 +368,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  
>  	advk_pcie_wait_for_link(pcie);
>  
> -	reg = PCIE_CORE_LINK_L0S_ENTRY |
> -		(1 << PCIE_CORE_LINK_WIDTH_SHIFT);
> +	reg = (1 << PCIE_CORE_LINK_WIDTH_SHIFT);
>  	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
>  
>  	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
> -- 
> 2.13.5
> 
