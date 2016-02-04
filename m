Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] add new platform driver for PCI RC
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <helgaas@kernel.org>
References: <cover.1454349430.git.jpinto@synopsys.com>
 <56B242F0.6040704@synopsys.com> <20160203183844.GC10879@localhost>
 <2915520.tvWP9ESSNu@wuerfel>
CC: Joao Pinto <Joao.Pinto@synopsys.com>, <Vineet.Gupta1@synopsys.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56B331BF.2000406@synopsys.com>
Date: Thu, 4 Feb 2016 11:10:55 +0000
MIME-Version: 1.0
In-Reply-To: <2915520.tvWP9ESSNu@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd and Bjorn,

On 2/3/2016 9:01 PM, Arnd Bergmann wrote:
> On Wednesday 03 February 2016 12:38:44 Bjorn Helgaas wrote:
>> On Wed, Feb 03, 2016 at 06:12:00PM +0000, Joao Pinto wrote:
>>
>>> - replace "snps,pcie-synopsys" for "snps,pcie-synopsys-ipk"?
>>
>> This is a question for Arnd.
>>
>>> - rename the driver to pcie-synopsys-ipk?
>>
>> It doesn't seem necessary to me to include both "synopsys" and "ipk" in the
>> filename and the driver name.  Take a look at what the existing drivers do,
>> and do something similar.
> 
> The "synopsys" can go away, it's already in the vendor field of the
> string. "ipk" is still a bit unspecific, I was hoping to see a specific
> chip and/or version of the PCIe part. Something like
> 
> 	compatible = "snps,ipk2040-pcie", "snps,ipk-pcie", "snps,dw-pcie-1.23", "snps,dw-pcie";
> 
> which would indicate that there is a chip called "ipk2040" in a family called "ipk",
> and this includes the designware pcie implementation in version 1.23.
> 

"snps,dw-pcie" seems a good idea!

>>> - update the devicetree documentation referring that the ranges also include the
>>> config space
>>
>> Another one for Arnd.
> 
> This one is wrong, the ranges should *not* include the config space, and if they
> currently do, you must change the driver. The generic dw-pcie driver still
> accepts the config space in the ranges for backwards compatibility with some
> of the earlier front-ends that mistakenly did this, but new driver should not
> do the same, and we should probably add some code in the common driver to
> prevent it for front-ends other than the ones we have to keep compatibility with.
> 

I am going to remove the config space from the ranges and test the driver.

> 	Arnd
> 

Thanks.
