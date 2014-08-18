Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 18 Aug 2014 22:35:47 +0100
From: Liviu Dudau <liviu@dudau.co.uk>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@arm.linux.org.uk>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Device Tree ML <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 00/12] Support for creating generic PCI host bridges
 from DT
Message-ID: <20140818213546.GD13147@bart.dudau.co.uk>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <20140818142622.GP20043@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140818142622.GP20043@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 18, 2014 at 03:26:22PM +0100, Catalin Marinas wrote:
> On Tue, Aug 12, 2014 at 05:25:13PM +0100, Liviu Dudau wrote:
> > This is my updated attempt at adding support for generic PCI host
> > bridge controllers that make use of device tree information to
> > configure themselves. This version incorporates Catalin's proposal
> > for managing domain numbers that got Bjorn's approval. I am now requesting
> > ACKs from the relevant maintainers as I would like to get the upstream ball
> > rolling.
> 
> As this series kept me busy on a long flight, you can add:

Damn, I don't know wether I should be proud or scared.

> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks! :)

Liviu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...

