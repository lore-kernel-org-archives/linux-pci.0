Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:35989 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbdLMRV2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Dec 2017 12:21:28 -0500
Subject: Re: [PATCH v5 01/18] PCI: dwc: Use the DMA-API to get the MSI address
To: Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>, <Gustavo.Pimentel@synopsys.com>
References: <20171120133222.27771-1-niklas.cassel@axis.com>
 <20171120133222.27771-2-niklas.cassel@axis.com>
 <20171130152843.GC12096@red-moon> <20171213135953.GA30833@axis.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <ff784f40-a629-b9cb-0d85-d1356eb69a38@synopsys.com>
Date: Wed, 13 Dec 2017 17:21:22 +0000
MIME-Version: 1.0
In-Reply-To: <20171213135953.GA30833@axis.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Niklas,

Às 1:59 PM de 12/13/2017, Niklas Cassel escreveu:
> On Thu, Nov 30, 2017 at 03:28:43PM +0000, Lorenzo Pieralisi wrote:
>> Jingoo, Joao,
>>
>> I am expecting your testing on the series and ACKs on the dwc related
>> patches please, according to v4 review - I will mark them as needs
>> review/ACK waiting for you to chime in.
>>
>> v4 thread:
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_833882_&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=CQAV8rCgm2jd7m3iSWL5vBbGTqSc7yN3N7zeQDz-ZUY&s=mqyDi45qm4qE0jcm0KviYAoLHmMXMMIWEW-gAR0RKOw&e=
>>
> 
> Hello Lorenzo, Jingoo, Joao,
> 
> Tomorrow another 2 weeks has passed.
> V1 of this patch series was posted on 2017-10-13.

Sorry, I have been tight up with a debug session and not able to check this out.
Adding Gustavo in CC that is now also working in PCI software development.
I am going to check the code ASAP and we will test it as soon as the debug is
finished.

Thanks.

> 
> I'm a bit worried that this patch series will not make it to linux-next
> in time for this patch series to be included in the 4.16 pull request.
> 
> Here is the V5 patch series:
> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_project_linux-2Dpci_list_-3Fseries-3D14364&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=CQAV8rCgm2jd7m3iSWL5vBbGTqSc7yN3N7zeQDz-ZUY&s=qXtUHFXK7_nCndQob0I0qDByBdJsL7rRjZ9cx7c847U&e=
> 
> Perhaps any maintainer of a designware based PCIe driver could
> help out and test this patch series?
> 
> Regards,
> Niklas
> 
