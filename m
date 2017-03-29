Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:54386 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932317AbdC2LVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2017 07:21:09 -0400
Subject: Re: [PATCH] PCI: dwc: fix crash seen due to missing ops
To: <bhelgaas@google.com>
References: <20170321144354.15452-1-niklass@axis.com>
 <ffb1d92b-a637-2ed9-51d3-6b9fbb790635@synopsys.com>
 <744bf393-4fd8-5e64-423f-f9a033d61106@axis.com>
 <0aec14f1-619a-e6a2-2e1c-1230e373a551@ti.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <a0b82abc-b2ac-ea76-3f24-c580187c0a0e@axis.com>
Date: Wed, 29 Mar 2017 13:21:05 +0200
MIME-Version: 1.0
In-Reply-To: <0aec14f1-619a-e6a2-2e1c-1230e373a551@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn


I think that it might be a good idea to include this for v4.11.
PCIe for artpec-6 SoC works fine on v4.10, if we manage to
include this before v4.11 gets released, PCIe for artpec-6 SoC
will work fine on v4.11 too.


Regards,
Niklas

On 03/27/2017 07:43 AM, Kishon Vijay Abraham I wrote:
(snip)
>>
>> Hello Joao
>>
>> Since commit 442ec4c04d12, we now have two different ops,
>> dw_pcie_ops (ops for dw_pcie) and dw_pcie_host_ops (ops for a pcie_port),
>> note that they are different. The dw_pcie_ops is missing for pcie-artpec6
>> and pcie-designware-plat (since we are using the generic link-up function).
>>
>> Before commit 442ec4c04d12, dw_pcie_writel_dbi had dw_pcie_host_ops as
>> parameter, after the commit it has dw_pcie_ops as parameter.
>> It should crash on pcie-designware-plat as well, since there are other
>> functions, like dw_pcie_link_up, that assumes that pci->ops != null.
>>
>> Another alternative to adding the dummy ops would be to add null checks
>> for all uses off pci->ops in pcie-designware.c.
>> I don't like the idea to sprinkle null checks everywhere pci->ops is used.
> 
> I'm okay either ways.
> 
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
>>
>> One could add a null check in dw_pcie_host_init, but without a dummy ops
>> we would still fail this check, so our drivers would still be non-functional
>> in Linus's tree.
>>
