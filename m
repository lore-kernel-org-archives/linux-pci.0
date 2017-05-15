Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:48498 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934117AbdEOLNr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 07:13:47 -0400
Subject: Re: [RFC] pci: adding new interrupt api to pcie-designware
To: Murali Karicheri <m-karicheri2@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>, <kishon@ti.com>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <marc.zyngier@arm.com>
References: <5593732728f7c7f5e8c58ac49f394e688bcc192d.1494332566.git.jpinto@synopsys.com>
 <5915E0F2.2070109@ti.com>
CC: <linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <de48ca7f-149c-9c64-85b0-7e9fa66920cb@synopsys.com>
Date: Mon, 15 May 2017 12:13:35 +0100
MIME-Version: 1.0
In-Reply-To: <5915E0F2.2070109@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Murali,

Às 5:21 PM de 5/12/2017, Murali Karicheri escreveu:
> On 05/09/2017 08:33 AM, Joao Pinto wrote:
>> This is a proposal for the update of the interrupt API in pcie-designware.
>>
>> *SoC specific drivers*
>> All SoC specific drivers that use the common infrastructure (pci-qcom,
>> pci-artpec6, pci-exynos, pci-imx6) were updated to be compatible.
>> Other SoC specific drivers like pci-dra7, pci-armada8k, pci-hisi, pci-spear13xx
>> and pci-layerscape will also work fine.
>>
>> *Work still to be done - need some inputs*
>> The pci-keystone driver is the one that I would appreciate some opinions, since
>> it uses the "old" dw_pcie_msi_chip. I think we have 3 options:
>>
>> a) Keep the old API + new API in pcie-designware just for pci-keystone to use
>> the dw_pcie_msi_chip structure
>> b) Move the old API from pcie-designware to pci-keystone for it to use the
>> dw_pcie_msi_chip structure
>> c) Adapt pci-keystone to use the new API also
>>
>> *Tests*
>> I made tests with a PCI 4.80 Core IP, using pcie-designware-plat driver.
>> I used an MSI-only Endpoint and a MSI/MSIX Endpoint and the APi adapted very
>> well to the situation.
>>
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
>> ---
>>  drivers/pci/dwc/pci-exynos.c           |  18 --
>>  drivers/pci/dwc/pci-imx6.c             |  18 --
>>  drivers/pci/dwc/pcie-artpec6.c         |  18 --
>>  drivers/pci/dwc/pcie-designware-host.c | 342 +++++++++++++++++----------------
>>  drivers/pci/dwc/pcie-designware-plat.c |  15 --
>>  drivers/pci/dwc/pcie-designware.h      |   6 +-
>>  drivers/pci/dwc/pcie-qcom.c            |  15 --
>>  7 files changed, 179 insertions(+), 253 deletions(-)

[...]

> 
> What do you see the challenge in porting the PCI-Keystone driver to the new
> interrupt API (option c)? I haven't had a chance to review your patches and recent
> changes in Linux kernel for PCI as we are currently using v4.9 kernel for
> our platforms. One key difference in the PCI Core used in Keystone SoC is that
> the MSI is not implemented using standard registers as in newer PCI Designware
> core. It uses application register space for MSI interrupts. Given that
> is the case, do you see any issue in porting the driver to the new API?
> 
> I should be able to test your patch on Keystone.
> 

I don't see any issue in porting it, and I have sent a RFC patch-set in Friday
including the porting of the keystone SoC driver. If you could test it with the
new API it would be great, just to have a sanity check.

A v2 of the RFC will be sent soon, so I would suggest for you to wait until v2
is available, that way you could test with the latest.

Thanks for the help,
Joao
