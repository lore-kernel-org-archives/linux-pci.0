Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:61298 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbaIWWyA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 18:54:00 -0400
Received: by mail-ig0-f171.google.com with SMTP id hn15so5513073igb.16
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2014 15:53:59 -0700 (PDT)
Date: Tue, 23 Sep 2014 16:53:56 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] PCI: designware: Fix IO resource end address calculation
Message-ID: <20140923225356.GG27117@google.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
 <1411482540-31297-2-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411482540-31297-2-git-send-email-Minghuan.Lian@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Mohit, Jingoo]

On Tue, Sep 23, 2014 at 10:28:57PM +0800, Minghuan Lian wrote:
> End address should be equal to start_addr + size - 1.
> The patch fixes PCI IO resource end address calculation.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
>  drivers/pci/host/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 0f3cb2a..c19184f7 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -459,7 +459,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  			pp->io.end = min_t(resource_size_t,
>  					   IO_SPACE_LIMIT,
>  					   range.pci_addr + range.size
> -					   + global_io_offset);
> +					   + global_io_offset - 1);
>  			pp->io_size = resource_size(&pp->io);
>  			pp->io_bus_addr = range.pci_addr;
>  			pp->io_base = range.cpu_addr;
> -- 
> 1.9.1
> 
