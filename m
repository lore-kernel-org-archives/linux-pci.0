Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:32846 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751176AbbJIOwn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 10:52:43 -0400
Date: Fri, 9 Oct 2015 16:52:40 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/9] pci: mvebu: fix memory leaks and refcount leaks
Message-ID: <20151009165240.3ba17ece@free-electrons.com>
In-Reply-To: <E1ZiRIs-0004Id-AN@rmk-PC.arm.linux.org.uk>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
	<E1ZiRIs-0004Id-AN@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Russell,

On Sat, 03 Oct 2015 19:13:02 +0100, Russell King wrote:

> +	ret = devm_add_action(dev, mvebu_pcie_port_clk_put, port);

I didn't know about devm_add_action(). Definitely very useful for such
situations.

> @@ -1052,10 +1086,12 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  		struct mvebu_pcie_port *port = &pcie->ports[i];
>  
>  		ret = mvebu_pcie_parse_port(pcie, port, child);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			of_node_put(child);
>  			return ret;
> -		else if (ret == 0)
> +		} else if (ret == 0) {
>  			continue;
> +		}

This is not trivial. If I understand correctly,
for_each_available_child_of_node() will automatically release the
reference on the previous node and take the reference on the new one
before entering the loop code. So in the skipping case, we don't need
to release the reference as it will be done by the next iteration of
the loop, but in the error case, since we are unexpectedly breaking the
loop, we need to do it manually.

The sort of tricky thing that should be documented near
for_each_child_of_node(), since I believe a lot of code gets this
wrong. See:

   http://lxr.free-electrons.com/source/arch/arm/mach-shmobile/pm-rmobile.c#L367
   http://lxr.free-electrons.com/source/drivers/phy/phy-miphy365x.c#L564

and many more.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
