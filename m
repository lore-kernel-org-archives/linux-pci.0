Return-Path: <SRS0=zr6k=EE=ncentric.com=koen.vandeputte@kernel.org>
Return-Path: <SRS0=zr6k=EE=ncentric.com=koen.vandeputte@kernel.org>
Subject: Re: [PATCH] imx6: fix pcie enumeration
To: Niklas Cassel <niklas.cassel@axis.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 bhelgaas@google.com, Richard Zhu <hongxing.zhu@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 Joao Pinto <Joao.Pinto@synopsys.com>, Jingoo Han <jingoohan1@gmail.com>
References: <20180104202430.GC189897@bhelgaas-glaptop.roam.corp.google.com>
 <a2d7afee-7a41-6da6-e5a4-a36a6fcde55d@ncentric.com>
 <20180105123206.GA24511@e107981-ln.cambridge.arm.com>
 <ebf30c78-b772-6214-f441-c86ae7fdba7e@ncentric.com>
 <20180105171828.GC24933@red-moon>
 <5bc70c34-45b2-5aed-eb06-f8ecfe859fd0@ncentric.com>
 <20180108110015.GA32027@red-moon>
 <1684b8c6-1006-948b-f4f9-c9aaf9cf26a8@ncentric.com>
 <3c4b9de6-de1d-55a4-5f44-b3815fa5bf85@axis.com>
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <fc45cad1-6202-9ec8-618f-2b0fe4096bfa@ncentric.com>
Date: Tue, 9 Jan 2018 14:58:34 +0100
MIME-Version: 1.0
In-Reply-To: <3c4b9de6-de1d-55a4-5f44-b3815fa5bf85@axis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 2018-01-09 14:48, Niklas Cassel wrote:
> <snip>

>>       /* setup bus numbers */
>>       val = dw_pcie_readl_rc(pp, PCI_PRIMARY_BUS);
>>       val &= 0xff000000;
>> -    val |= 0x00010100;
>> +    val |= 0x00ff0100;
>>       dw_pcie_writel_rc(pp, PCI_PRIMARY_BUS, val);
>>
>>       /* setup command register */
>>
>>
>> Above version logically fixes it for all dwc devices using a bridge after the RC, not only imx6.
>> If this is fine, I would submit the patch above and drop the current one.
> I can confirm that commit a20c7f36bd3d ("PCI: Do not allocate more buses than
> available in parent") broke enumerating PCIe devices behind a PCIe switch
> on ARTPEC-6 (which uses the DWC IP).
> (FTR, arch/arm/boot/dts/artpec6.dtsi specifies bus-range = <0x00 0xff>).
>
> This patch resolves the problem.
> (I verified on linux-next: next-20180109).
>
> However, note that I had to patch the file
> drivers/pci/dwc/pcie-designware-host.c
> rather than
> drivers/pci/host/pcie-designware.c,
> which this patch suggests.
Above internally used example patch is based on kernel 4.9.74, where 
this file hasn't moved/renamed yet to dwc subfolder
I'll post a proper one shortly for the upstream tree.

Thanks for testing,

Koen
> Please feel free to submit a new patch with:
>
> Tested-by: Niklas Cassel <niklas.cassel@axis.com>
>
