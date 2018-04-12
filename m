Return-Path: <SRS0=RiBJ=HB=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=RiBJ=HB=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 12 Apr 2018 17:13:34 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	Jake Oshins <jakeo@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	"Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Message-ID: <20180412161334.GA5803@e107981-ln.cambridge.arm.com>
References: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
 <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
 <20180412132003.GC145698@bhelgaas-glaptop.roam.corp.google.com>
 <9832EE81-01B3-44AB-8B3D-EEA32AED07E0@microsoft.com>
 <BL0PR2101MB1108227C3E52DE4462A9F93CCABC0@BL0PR2101MB1108.namprd21.prod.outlook.com>
 <F8BC8B81-D3A4-40F7-95F4-CAF77A7917B7@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F8BC8B81-D3A4-40F7-95F4-CAF77A7917B7@microsoft.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 12, 2018 at 03:56:42PM +0000, Sridhar Pitchai wrote:
>     > 
>     >     >> I am still not happy with this patch.
>     >     >>
>     >     >> -  You do not explain at all the dependency on commit 0c195567a8f6 and
>     >     >>    you should because that's fundamental, if that patch is not present
>     >     >>    this revert breaks the kernel as per previous discussions[1].
>     >     >> -  You are sending this patch to all stable kernels that contain the
>     >     >>    commit you are fixing - some that may not contain the commit above
>     >     >>    (that was merged in v4.14), you are breaking those kernels, if not
>     >     >>    explain me why please
>     > 
>     >     >If there's a dependency on 0c195567a8f6, I totally agree that
>     >     >needs to be cleared up.  I was assuming that turned out to be
>     >     >irrelevant.
>     > That is right. There is no dependency on 0c195567a8f6. We just need to revert
>     > 4a9b0933bdfc.
>     
>     > This patch should only be applied to later versions after  0c195567a8f6" (transparent VF).
>     > Otherwise it causes long & random names of VF NICs for bonding. That will make bonding
>     > config difficult, especially for auto config.
>     
>     >Thanks,
>     >- Haiyang
> Ok. I will update the patch, as Lorenzo suggested. 

Please update your email client quoting policy so that it does not add
unnecessary indentation spaces, for long threads this gets messy.

If you send a patch to a specific stable version you have to test it
first thing on that stable version before adding a stable tag, reverting
a patch from stable kernels is the last thing we want to do - that's the
reason why I keep complaining.

Thanks,
Lorenzo
