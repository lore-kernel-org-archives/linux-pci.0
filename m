Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] add new platform driver for PCI RC
To: Arnd Bergmann <arnd@arndb.de>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	"Bjorn Helgaas" <helgaas@kernel.org>
References: <cover.1454600622.git.jpinto@synopsys.com>
 <4427983.0G6mVNKP5W@wuerfel> <56B4B6FB.1040500@synopsys.com>
 <3217683.43eupG8Vx4@wuerfel>
CC: <Vineet.Gupta1@synopsys.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56B4C4CE.2020303@synopsys.com>
Date: Fri, 5 Feb 2016 15:50:38 +0000
MIME-Version: 1.0
In-Reply-To: <3217683.43eupG8Vx4@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/5/2016 3:43 PM, Arnd Bergmann wrote:
> On Friday 05 February 2016 14:51:39 Joao Pinto wrote:
>>
>> It is a driver that is useful for PCIe RC prototyping and to be a reference
>> platform driver for DesignWare PCIe RC, I don't know if merging some of the
>> driver's code into pcie-designware is really necessary depends on the usefulness
>> of it. I would suggest that bigger step to be done in a 2nd stage since I will
>> be around to maintain what's necessary. Agree?
>>
>> I made a patch that is applicable to Bjorn's host/pcie-synopsys that tries to
>> match your suggestions and Bjorn's. Could you please comment check it?
> 
> I think it would be useful to do this as generic as possible, and you seem
> to be the right person to integrate it into the generic driver as you have
> access to the hardware documents. Normally the folks writing the drivers
> are just guessing based on what little information they get out of manuals
> or vendor-provided drivers, but I'm sure that not all of that makes sense.

Arnd, sure and I would love to be useful and improve the dw pci ecosystem, but
maybe now we should submit the driver as suggested in "[PATCH] synopsys pcie rc
generic platform driver update" and then make in a future intervention.

Bjorn, could you please comment? Should we go now with this driver version and
in the future we make the changes suggested by Arnd?

> 
> 	Arnd
> 

Joao
