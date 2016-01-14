Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] PCI support added to ARC
To: Arnd Bergmann <arnd@arndb.de>
References: <cover.1452611234.git.jpinto@synopsys.com>
 <56977B80.2040600@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E84DC7@us01wembx1.internal.synopsys.com>
 <4888629.rSv29HOrHE@wuerfel>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"linux-snps-arc@lists.infradead.org"
	<linux-snps-arc@lists.infradead.org>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <5697907C.4030602@synopsys.com>
Date: Thu, 14 Jan 2016 17:41:40 +0530
MIME-Version: 1.0
In-Reply-To: <4888629.rSv29HOrHE@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 14 January 2016 05:29 PM, Arnd Bergmann wrote:
> On Thursday 14 January 2016 10:51:32 Vineet Gupta wrote:
>>>>
>>>> A somewhat nicer method would be to have callback pointers in struct
>>>> pci_host_bridge, and call those when they are non-NULL so we can
>>>> remove the global pcibios_* functions from the API. That would also
>>>> bring us a big step closer to having PCI support itself as a loadable
>>>> module, and it would better reflect that those functions are really
>>>> host bridge specific rather than architecture specific. When you use
>>>> the same host bridge on multiple architectures, you typically have
>>>> the same requirements for hacks in there, but each architectures may
>>>> need to support multiple host bridges with different requirements.
>>> Since we will be constantly improving the driver and the core itself, I suggest
>>> that this functions be made __weak and in an update we can turn it struct
>>> pointers just like Arnd suggested. Is this good for you?
>>
>> There is no point in making it weak, w/o a fallback version in generic code. For
>> this series, I suggest you just remove the straggler EXPORT_SYMBOL and respin.
>>
> 
> To clarify: I don't particularly like __weak functions anywhere, but they
> are already common in drivers/pci, so we can add a couple more to reach
> the goal of removing all architecture specific code.

But I see quite a bit of "weak design pattern" in kernel is common when an API
needs to be implemented across arches and it same for most of them. I agree that
this is not as ideal from code flow analysis but saves a lot of duplication.


> However, there should never be a reason to add a __weak function in
> arch code that gets overridden by common code, that would be very confusing
> and not helpful.

Agree. That was never my suggestion anyways. I'd asked __weak version be defined
in common code so we could reuse it and elide the ARC version and at the same time
not breaking others, and in longer run removing the dups elsewhere.

Thx,
-Vineet

> 
> 	Arnd
> 
