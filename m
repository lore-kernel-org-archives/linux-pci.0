Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:38257 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752094AbaCUOGt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 10:06:49 -0400
Message-ID: <532C4774.20803@codethink.co.uk>
Date: Fri, 21 Mar 2014 15:06:44 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
MIME-Version: 1.0
To: Phil.Edworthy@renesas.com
CC: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
Subject: Re: [PATCH v4 1/9] PCI: host: rcar: Add Renesas R-Car PCIe driver
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com> <1395397968-6242-2-git-send-email-phil.edworthy@renesas.com> <27671657.LuGQtNBfqX@wuerfel> <OF038A7DC3.59E6288A-ON80257CA2.004AF404-80257CA2.004CDD76@eu.necel.com>
In-Reply-To: <OF038A7DC3.59E6288A-ON80257CA2.004AF404-80257CA2.004CDD76@eu.necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 21/03/14 14:59, Phil.Edworthy@renesas.com wrote:
> Hi Arnd,
>
> Thanks for the review.
>
>
>>> +static int __init pcie_init(void)
>>> +{
>>> +   return platform_driver_probe(&rcar_pcie_driver, rcar_pcie_probe);
>>> +}
>>> +subsys_initcall(pcie_init);
>>
>> Why so early?
> Good catch, copied from another PCIe driver!

I think you can change it to use module_driver() instead of the
init_call.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
