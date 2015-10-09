Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42358 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbbJIPHO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Oct 2015 11:07:14 -0400
Date: Fri, 9 Oct 2015 17:07:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/9] pci: mvebu: fix memory leaks and refcount leaks
Message-ID: <20151009150710.GJ14688@lunn.ch>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
 <E1ZiRIs-0004Id-AN@rmk-PC.arm.linux.org.uk>
 <20151009165240.3ba17ece@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151009165240.3ba17ece@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 09, 2015 at 04:52:40PM +0200, Thomas Petazzoni wrote:
> Russell,
> 
> On Sat, 03 Oct 2015 19:13:02 +0100, Russell King wrote:
> 
> > +	ret = devm_add_action(dev, mvebu_pcie_port_clk_put, port);
> 
> I didn't know about devm_add_action(). Definitely very useful for such
> situations.

I was also surprised by this. Nice.
 
> > @@ -1052,10 +1086,12 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> >  
> >  		ret = mvebu_pcie_parse_port(pcie, port, child);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			of_node_put(child);
> >  			return ret;
> > -		else if (ret == 0)
> > +		} else if (ret == 0) {
> >  			continue;
> > +		}
> 
> This is not trivial. If I understand correctly,
> for_each_available_child_of_node() will automatically release the
> reference on the previous node and take the reference on the new one
> before entering the loop code. So in the skipping case, we don't need
> to release the reference as it will be done by the next iteration of
> the loop, but in the error case, since we are unexpectedly breaking the
> loop, we need to do it manually.
> 
> The sort of tricky thing that should be documented near
> for_each_child_of_node(), since I believe a lot of code gets this
> wrong.

Sounds like a good candidate for a coccinelle script. Maybe you could
ask Julia Lawall?

    Andrew
