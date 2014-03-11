Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 11 Mar 2014 09:46:41 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Liviu Dudau <liviu@dudau.co.uk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 6/6] pci: Add support for creating a generic
 host_bridge from device tree
Message-ID: <20140311094641.GA27064@e106497-lin.cambridge.arm.com>
References: <1394020137-1830-1-git-send-email-Liviu.Dudau@arm.com>
 <1469359.kil5iaOqdU@wuerfel>
 <20140310215600.GA14968@bart.dudau.co.uk>
 <4254618.BlpDUOctDb@wuerfel>
MIME-Version: 1.0
In-Reply-To: <4254618.BlpDUOctDb@wuerfel>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 11, 2014 at 06:50:24AM +0000, Arnd Bergmann wrote:
> On Monday 10 March 2014 21:56:00 Liviu Dudau wrote:
> > 
> > PCI_IOBASE is always defined. See the discussion with Russell on this subject.
> > 
> > include/asm-generic/io.h has at line 118:
> > 
> > #ifndef PCI_IOBASE
> > #define PCI_IOBASE ((void __iomem *) 0)
> > #endif
> 
> That is only defined for those that use asm-generic/pci.h, which most architectures
> don't.

I think it is defined for anyone that #includes <asm-generic/io.h>. There is no other
#ifdef around that.

>  
> > I will go with my idea tomorrow. arm64 overwrite the implementation anyway, I
> > find it cleaner rather than having to do #ifdefs and/or ifs.
> 
> I'd really hope we can get to a point where arm64 doesn't need any architecture
> specific code for this. It doesn't do anything special.

I agree.

Best regards,
Liviu

> 
> 	Arnd
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

