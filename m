Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:44039 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbeERXoq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2018 19:44:46 -0400
Cc: shawn.lin@rock-chips.com, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:next 20/20] drivers/pci/host/pcie-rockchip-host.c:996:8:
 error: implicit declaration of function
 'devm_of_pci_get_host_bridge_resources'; did you mean
 'pci_get_host_bridge_device'?
To: kbuild test robot <lkp@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <201805190219.c7Xmu3Iw%fengguang.wu@intel.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <861cce96-95db-0a5f-7e25-88e41aa06322@rock-chips.com>
Date: Sat, 19 May 2018 07:43:58 +0800
MIME-Version: 1.0
In-Reply-To: <201805190219.c7Xmu3Iw%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

On 2018/5/19 2:46, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> head:   f8d3ac43d8cd4cfba337a50794c26c7ca89d86ac
> commit: f8d3ac43d8cd4cfba337a50794c26c7ca89d86ac [20/20] Merge branch 'lorenzo/pci/rockchip'

Seems Jan's patchset reworking of_pci_get_host_bridge_resources()
to devm_of_pci_get_host_bridge_resources() which touches pcie-rockchip,
but series reworking rockchip driver to support EP had been in Lorenzo's
pci/rockchip branch for quite some days in advance. Then the merge fails
to build.


> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>          git checkout f8d3ac43d8cd4cfba337a50794c26c7ca89d86ac
>          # save the attached .config to linux build tree
>          make ARCH=i386
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/pci/host/pcie-rockchip-host.c: In function 'rockchip_pcie_probe':
>>> drivers/pci/host/pcie-rockchip-host.c:996:8: error: implicit declaration of function 'devm_of_pci_get_host_bridge_resources'; did you mean 'pci_get_host_bridge_device'? [-Werror=implicit-function-declaration]
>       err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             pci_get_host_bridge_device
>     cc1: some warnings being treated as errors
> --
>     /kbuild/src/cocci/drivers/pci/host/pcie-rockchip-host.c: In function 'rockchip_pcie_probe':
>>> /kbuild/src/cocci/drivers/pci/host/pcie-rockchip-host.c:996:8: error: implicit declaration of function 'devm_of_pci_get_host_bridge_resources'; did you mean 'pci_get_host_bridge_device'? [-Werror=implicit-function-declaration]
>       err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             pci_get_host_bridge_device
>     cc1: some warnings being treated as errors
> 
> vim +996 drivers/pci/host/pcie-rockchip-host.c
> 
>     944	
>     945	static int rockchip_pcie_probe(struct platform_device *pdev)
>     946	{
>     947		struct rockchip_pcie *rockchip;
>     948		struct device *dev = &pdev->dev;
>     949		struct pci_bus *bus, *child;
>     950		struct pci_host_bridge *bridge;
>     951		struct resource_entry *win;
>     952		resource_size_t io_base;
>     953		struct resource	*mem;
>     954		struct resource	*io;
>     955		int err;
>     956	
>     957		LIST_HEAD(res);
>     958	
>     959		if (!dev->of_node)
>     960			return -ENODEV;
>     961	
>     962		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rockchip));
>     963		if (!bridge)
>     964			return -ENOMEM;
>     965	
>     966		rockchip = pci_host_bridge_priv(bridge);
>     967	
>     968		platform_set_drvdata(pdev, rockchip);
>     969		rockchip->dev = dev;
>     970		rockchip->is_rc = true;
>     971	
>     972		err = rockchip_pcie_parse_host_dt(rockchip);
>     973		if (err)
>     974			return err;
>     975	
>     976		err = rockchip_pcie_enable_clocks(rockchip);
>     977		if (err)
>     978			return err;
>     979	
>     980		err = rockchip_pcie_set_vpcie(rockchip);
>     981		if (err) {
>     982			dev_err(dev, "failed to set vpcie regulator\n");
>     983			goto err_set_vpcie;
>     984		}
>     985	
>     986		err = rockchip_pcie_host_init_port(rockchip);
>     987		if (err)
>     988			goto err_vpcie;
>     989	
>     990		rockchip_pcie_enable_interrupts(rockchip);
>     991	
>     992		err = rockchip_pcie_init_irq_domain(rockchip);
>     993		if (err < 0)
>     994			goto err_deinit_port;
>     995	
>   > 996		err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
>     997							    &res, &io_base);
>     998		if (err)
>     999			goto err_remove_irq_domain;
>    1000	
>    1001		err = devm_request_pci_bus_resources(dev, &res);
>    1002		if (err)
>    1003			goto err_free_res;
>    1004	
>    1005		/* Get the I/O and memory ranges from DT */
>    1006		resource_list_for_each_entry(win, &res) {
>    1007			switch (resource_type(win->res)) {
>    1008			case IORESOURCE_IO:
>    1009				io = win->res;
>    1010				io->name = "I/O";
>    1011				rockchip->io_size = resource_size(io);
>    1012				rockchip->io_bus_addr = io->start - win->offset;
>    1013				err = pci_remap_iospace(io, io_base);
>    1014				if (err) {
>    1015					dev_warn(dev, "error %d: failed to map resource %pR\n",
>    1016						 err, io);
>    1017					continue;
>    1018				}
>    1019				rockchip->io = io;
>    1020				break;
>    1021			case IORESOURCE_MEM:
>    1022				mem = win->res;
>    1023				mem->name = "MEM";
>    1024				rockchip->mem_size = resource_size(mem);
>    1025				rockchip->mem_bus_addr = mem->start - win->offset;
>    1026				break;
>    1027			case IORESOURCE_BUS:
>    1028				rockchip->root_bus_nr = win->res->start;
>    1029				break;
>    1030			default:
>    1031				continue;
>    1032			}
>    1033		}
>    1034	
>    1035		err = rockchip_pcie_cfg_atu(rockchip);
>    1036		if (err)
>    1037			goto err_unmap_iospace;
>    1038	
>    1039		rockchip->msg_region = devm_ioremap(dev, rockchip->msg_bus_addr, SZ_1M);
>    1040		if (!rockchip->msg_region) {
>    1041			err = -ENOMEM;
>    1042			goto err_unmap_iospace;
>    1043		}
>    1044	
>    1045		list_splice_init(&res, &bridge->windows);
>    1046		bridge->dev.parent = dev;
>    1047		bridge->sysdata = rockchip;
>    1048		bridge->busnr = 0;
>    1049		bridge->ops = &rockchip_pcie_ops;
>    1050		bridge->map_irq = of_irq_parse_and_map_pci;
>    1051		bridge->swizzle_irq = pci_common_swizzle;
>    1052	
>    1053		err = pci_scan_root_bus_bridge(bridge);
>    1054		if (err < 0)
>    1055			goto err_unmap_iospace;
>    1056	
>    1057		bus = bridge->bus;
>    1058	
>    1059		rockchip->root_bus = bus;
>    1060	
>    1061		pci_bus_size_bridges(bus);
>    1062		pci_bus_assign_resources(bus);
>    1063		list_for_each_entry(child, &bus->children, node)
>    1064			pcie_bus_configure_settings(child);
>    1065	
>    1066		pci_bus_add_devices(bus);
>    1067		return 0;
>    1068	
>    1069	err_unmap_iospace:
>    1070		pci_unmap_iospace(rockchip->io);
>    1071	err_free_res:
>    1072		pci_free_resource_list(&res);
>    1073	err_remove_irq_domain:
>    1074		irq_domain_remove(rockchip->irq_domain);
>    1075	err_deinit_port:
>    1076		rockchip_pcie_deinit_phys(rockchip);
>    1077	err_vpcie:
>    1078		if (!IS_ERR(rockchip->vpcie12v))
>    1079			regulator_disable(rockchip->vpcie12v);
>    1080		if (!IS_ERR(rockchip->vpcie3v3))
>    1081			regulator_disable(rockchip->vpcie3v3);
>    1082		if (!IS_ERR(rockchip->vpcie1v8))
>    1083			regulator_disable(rockchip->vpcie1v8);
>    1084		if (!IS_ERR(rockchip->vpcie0v9))
>    1085			regulator_disable(rockchip->vpcie0v9);
>    1086	err_set_vpcie:
>    1087		rockchip_pcie_disable_clocks(rockchip);
>    1088		return err;
>    1089	}
>    1090	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 


-- 
Best Regards
Shawn Lin
