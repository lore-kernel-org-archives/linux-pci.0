Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41267 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752238Ab3JCMGz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Oct 2013 08:06:55 -0400
Date: Thu, 3 Oct 2013 14:06:48 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: mvebu - Support a bridge with no IO port
 window
Message-ID: <20131003140648.52734cfc@skate>
In-Reply-To: <1380650281-16175-2-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
	<1380650281-16175-2-git-send-email-jgunthorpe@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Tue,  1 Oct 2013 11:58:01 -0600, Jason Gunthorpe wrote:
> Make pcie-io-aperture and the IO port MBUS ID in ranges optional.
> If not provided the bridge reports to Linux that IO space mapping is
> not supported and refuses to configure an IO mbus window.
> 
> This allows both complete disable (do not specify pcie-io-aperture) and
> per-port disable (do not specify a IO target ranges entry for the port)
> 
> Most PCIE devices these days do not require IO support to function,
> so having an option to disable it in the driver is useful.
> 
> This depends on 'bus: mvebu-mbus: Fix optional pcie-mem/io-aperture properties'
> to work properly.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

This doesn't work here, I get multiple warnings "Attempt to set IO when
IO is disabled" :

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at /home/thomas/projets/linux-2.6/drivers/pci/host/pci-mvebu.c:302 mvebu_pcie_wr_conf+0x2c0/0x44c()
Device: mvebu-pcie
Attempt to set IO when IO is disabled
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12.0-rc1-00003-ga85b362 #6
[<c0015798>] (unwind_backtrace+0x0/0xf8) from [<c0011770>] (show_stack+0x10/0x14)
[<c0011770>] (show_stack+0x10/0x14) from [<c0372c08>] (dump_stack+0x70/0x8c)
[<c0372c08>] (dump_stack+0x70/0x8c) from [<c001d5bc>] (warn_slowpath_common+0x64/0x88)
[<c001d5bc>] (warn_slowpath_common+0x64/0x88) from [<c001d674>] (warn_slowpath_fmt+0x30/0x40)
[<c001d674>] (warn_slowpath_fmt+0x30/0x40) from [<c0187080>] (mvebu_pcie_wr_conf+0x2c0/0x44c)
[<c0187080>] (mvebu_pcie_wr_conf+0x2c0/0x44c) from [<c01770fc>] (pci_bus_write_config_word+0x60/0x78)
[<c01770fc>] (pci_bus_write_config_word+0x60/0x78) from [<c03708b4>] (__pci_bus_size_bridges+0x708/0x7c0)
[<c03708b4>] (__pci_bus_size_bridges+0x708/0x7c0) from [<c03701e0>] (__pci_bus_size_bridges+0x34/0x7c0)
[<c03701e0>] (__pci_bus_size_bridges+0x34/0x7c0) from [<c00134c4>] (pci_common_init_dev+0x1b0/0x2dc)
[<c00134c4>] (pci_common_init_dev+0x1b0/0x2dc) from [<c04a3f68>] (mvebu_pcie_probe+0x444/0x48c)
[<c04a3f68>] (mvebu_pcie_probe+0x444/0x48c) from [<c01b69dc>] (platform_drv_probe+0x18/0x1c)
[<c01b69dc>] (platform_drv_probe+0x18/0x1c) from [<c01b5858>] (driver_probe_device+0xf4/0x210)
[<c01b5858>] (driver_probe_device+0xf4/0x210) from [<c01b5a00>] (__driver_attach+0x8c/0x90)
[<c01b5a00>] (__driver_attach+0x8c/0x90) from [<c01b3eb8>] (bus_for_each_dev+0x54/0x88)
[<c01b3eb8>] (bus_for_each_dev+0x54/0x88) from [<c01b4f60>] (bus_add_driver+0xd4/0x258)
[<c01b4f60>] (bus_add_driver+0xd4/0x258) from [<c01b6038>] (driver_register+0x78/0xf4)
[<c01b6038>] (driver_register+0x78/0xf4) from [<c01b6bc0>] (platform_driver_probe+0x1c/0xa0)
[<c01b6bc0>] (platform_driver_probe+0x1c/0xa0) from [<c0008878>] (do_one_initcall+0xe4/0x140)
[<c0008878>] (do_one_initcall+0xe4/0x140) from [<c0492b60>] (kernel_init_freeable+0xfc/0x1c4)
[<c0492b60>] (kernel_init_freeable+0xfc/0x1c4) from [<c036f0cc>] (kernel_init+0x8/0xe4)
[<c036f0cc>] (kernel_init+0x8/0xe4) from [<c000e3d8>] (ret_from_fork+0x14/0x3c)
---[ end trace 70bc10e370e10347 ]---

> +static inline bool mvebu_has_ioport(struct mvebu_pcie_port *port)
> +{
> +	return port->io_target == -1 && port->io_attr == -1;

Are you sure the logic is not reverted here? I.e, this shouldn't be !=
-1 in both cases?

> +}
> +
>  static bool mvebu_pcie_link_up(struct mvebu_pcie_port *port)
>  {
>  	return !(readl(port->base + PCIE_STAT_OFF) & PCIE_STAT_LINK_DOWN);
> @@ -292,6 +297,12 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
>  		return;
>  	}
>  
> +	if (!mvebu_has_ioport(port)) {
> +		dev_WARN(&port->pcie->pdev->dev,
> +			 "Attempt to set IO when IO is disabled\n");
> +		return;
> +	}
> +
>  	/*
>  	 * We read the PCI-to-PCI bridge emulated registers, and
>  	 * calculate the base address and size of the address decoding
> @@ -405,9 +416,12 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
>  		break;
>  
>  	case PCI_IO_BASE:
> -		*value = (bridge->secondary_status << 16 |
> -			  bridge->iolimit          <<  8 |
> -			  bridge->iobase);
> +		if (!mvebu_has_ioport(port))
> +			*value = 0;
> +		else
> +			*value = (bridge->secondary_status << 16 |
> +				  bridge->iolimit          <<  8 |
> +				  bridge->iobase);

While I do understand that you're returning 0 for iolimit and iobase,
I'm not sure why the secondary status is affected by the value of
mvebu_has_ioport().

>  static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
> -			      unsigned long type, int *tgt, int *attr)
> +			      unsigned long type,
> +			      unsigned int *tgt,
> +			      unsigned int *attr)
>  {
>  	const int na = 3, ns = 2;
>  	const __be32 *range;
>  	int rlen, nranges, rangesz, pna, i;
>  
> +	*tgt = -1;
> +	*attr = -1;
> +
>  	range = of_get_property(np, "ranges", &rlen);
>  	if (!range)
>  		return -EINVAL;
> @@ -798,16 +821,15 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
>  	}
>  
>  	mvebu_mbus_get_pcie_io_aperture(&pcie->io);
> -	if (resource_size(&pcie->io) == 0) {
> -		dev_err(&pdev->dev, "invalid I/O aperture size\n");
> -		return -EINVAL;
> -	}
>  
> -	pcie->realio.flags = pcie->io.flags;
> -	pcie->realio.start = PCIBIOS_MIN_IO;
> -	pcie->realio.end = min_t(resource_size_t,
> -				  IO_SPACE_LIMIT,
> -				  resource_size(&pcie->io));
> +	if (resource_size(&pcie->io) != 0) {
> +		pcie->realio.flags = pcie->io.flags;
> +		pcie->realio.start = PCIBIOS_MIN_IO;
> +		pcie->realio.end = min_t(resource_size_t,
> +					 IO_SPACE_LIMIT,
> +					 resource_size(&pcie->io));
> +	} else
> +		pcie->realio = pcie->io;
>  
>  	/* Get the bus range */
>  	ret = of_pci_parse_bus_range(np, &pcie->busn);
> @@ -864,12 +886,12 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
>  			continue;
>  		}
>  
> -		ret = mvebu_get_tgt_attr(np, port->devfn, IORESOURCE_IO,
> -					 &port->io_target, &port->io_attr);
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "PCIe%d.%d: cannot get tgt/attr for io window\n",
> -				port->port, port->lane);
> -			continue;
> +		if (resource_size(&pcie->io) != 0)
> +			mvebu_get_tgt_attr(np, port->devfn, IORESOURCE_IO,
> +					   &port->io_target, &port->io_attr);
> +		else {
> +			port->io_target = -1;
> +			port->io_attr = -1;
>  		}
>  
>  		port->base = mvebu_pcie_map_registers(pdev, child, port);

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
