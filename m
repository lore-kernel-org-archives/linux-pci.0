Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:55805 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755241AbdCUBZ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2017 21:25:26 -0400
Subject: Re: [PATCH] PCI: rockchip: don't leak the PCI resource list
To: Brian Norris <briannorris@chromium.org>
References: <20170320224936.28605-1-briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <108a73fe-f186-f9ef-81be-7941f3db9d7f@rock-chips.com>
Date: Tue, 21 Mar 2017 09:25:16 +0800
MIME-Version: 1.0
In-Reply-To: <20170320224936.28605-1-briannorris@chromium.org>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Brian,

On 2017/3/21 6:49, Brian Norris wrote:
> This list is local to the probe() function. We should free it up in both
> the success case and the error case, but currently we're only freeing it
> in the error case (see commit f1d722b607d6 ("PCI: rockchip: Fix
> rockchip_pcie_probe() error path to free resource list")).
>
> Caught by kmemleak, when doing repeated bind/unbind tests.
>

It doesn't look natural to free it in probe, instead it looks more
like we should do the cleanup work when calling .remove

I didn't know if there is something that still use this resource
, for instance, hotplug? But I noticed it from Bjron's statement[1]
that "The struct resource for each host bridge window must live as long
as the host bridge itself". So I didn't free it when finishing probe.
I guess the proper fix is to do it in pci_remove_root_bus or somewhere
of the cleanup code if I undertand it correctly.


[1]: https://lkml.org/lkml/2017/2/8/802

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/pci/host/pcie-rockchip.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index bd6df7254de4..8087a0698d65 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -1396,6 +1396,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  		goto err_free_res;
>  	}
>  	rockchip->root_bus = bus;
> +	pci_free_resource_list(&res);
>
>  	pci_bus_size_bridges(bus);
>  	pci_bus_assign_resources(bus);
>
