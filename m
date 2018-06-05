Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] PCI: cadence: Update cdns_pcie_ep_raise_irq
 function signature
To: Alan Douglas <adouglas@cadence.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
References: <cover.1526576613.git.gustavo.pimentel@synopsys.com>
 <4994f263efbf6a2cb952d3d9839fb3b1737efde9.1526576613.git.gustavo.pimentel@synopsys.com>
 <aa86d9b7-d715-2a21-6a94-be927e55b51b@ti.com>
 <SN6PR07MB4512F3B395D731FF14EBDB8ED8670@SN6PR07MB4512.namprd07.prod.outlook.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e9de6853-9c55-2dc9-0de0-0faa075714db@ti.com>
Date: Tue, 5 Jun 2018 10:51:16 +0530
MIME-Version: 1.0
In-Reply-To: <SN6PR07MB4512F3B395D731FF14EBDB8ED8670@SN6PR07MB4512.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Monday 04 June 2018 08:38 PM, Alan Douglas wrote:
> On 31 May 2018 11:51, Kishon Vijay Abraham I  wrote:
>> Hi Alan,
>>
>> On Thursday 17 May 2018 10:39 PM, Gustavo Pimentel wrote:
>>> Change cdns_pcie_ep_raise_irq() signature, namely the interrupt_num
>>> variable type from u8 to u16 to accommodate 2048 maximum MSI-X
>>> interrupts.
>>>
>>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>> Acked-by: Alan Douglas <adouglas@cadence.com>
>>
>> Do you want to add MSI-X support to cadence PCIe?
>>
> I do want to add MSI-X support, in fact I have done some tests with a
> modified cadence driver with this set, so plan to submit a patch later.
> 

cool, glad to hear!

Thanks
Kishon
