Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs130.luxsci.com ([72.32.115.17]:35097 "EHLO rs130.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375Ab2LJXM1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Dec 2012 18:12:27 -0500
Message-ID: <50C66C2A.7010102@firmworks.com>
Date: Mon, 10 Dec 2012 13:11:38 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Grant Likely <grant.likely@secretlab.ca>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: pci and pcie device-tree binding - range No cells
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com> <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com> <50C601B6.2080107@monstr.eu> <20121210214323.6EA733E0921@localhost> <1355179097.19932.5.camel@pasglop>
In-Reply-To: <1355179097.19932.5.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/10/2012 12:38 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2012-12-10 at 21:43 +0000, Grant Likely wrote:
>>> Sorry for my pci ignorance (have never got hw for mb/zynq)
>>> I just want to get better overview how we should we our drivers to
>> be compatible.
>>>
>>> Does it mean that pci is supposed be always 64 bit wide?
>>> And there is no option to have just 32bit values.
>>
>> Yes, PCIe addressing is always 64 bits wide. Even on 32bit PCI systems
>> we use 64 bit PCI addressing in the device tree.
> 
> Right. The size & format of an address cell for PCI is specified in the
> OF PCI bindings and we follow that binding. It's always 3 cells.

.. and the reason why it must be 3 cells, even if the host PCI bus only
supports 32-bit addressing, is because a plug-in PCI card has no way of
knowing what the host supports.


> 
> Cheers,
> Ben.
> 
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
