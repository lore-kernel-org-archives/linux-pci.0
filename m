Return-Path: <SRS0=lRfe=YF=intel.com=ashok.raj@kernel.org>
Return-Path: <SRS0=lRfe=YF=intel.com=ashok.raj@kernel.org>
Date: Thu, 22 Dec 2016 15:45:08 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	rwright@hpe.com, ashok.raj@intel.com
Subject: Re: possible dmar_init_reserved_ranges() error
Message-ID: <20161222234508.GA20924@otc-nc-03>
References: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
 <20161222162713.GF17255@8bytes.org>
 <20161222202803.GA16855@bhelgaas-glaptop.roam.corp.google.com>
 <20161222233238.GA20861@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161222233238.GA20861@otc-nc-03>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

None in the platform group say they know about this. So i'm fairly sure
we don't do that on Intel hardware (x86). 

I'm not sure about the usage, it appears maybe it was a hack 
pre-virtualization for some direct access?  (just wild guessing)

On Thu, Dec 22, 2016 at 03:32:38PM -0800, Raj, Ashok wrote:
> Let me check and keep you posted if we have such platforms to make sure if
> we need this considerations for _TRA.

Cheers,
Ashok
