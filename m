Return-Path: <SRS0=5Tji=6O=suse.de=jroedel@kernel.org>
Return-Path: <SRS0=5Tji=6O=suse.de=jroedel@kernel.org>
Date: Tue, 11 Jul 2017 13:49:48 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
	Alexander Deucher <Alexander.Deucher@amd.com>,
	Samuel Sieb <samuel@sieb.net>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Message-ID: <20170711114948.GA6244@suse.de>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <20170615140421.GB25710@suse.de>
 <20170615191545.GB12735@bhelgaas-glaptop.roam.corp.google.com>
 <20170616162923.GE25710@suse.de>
 <20170710165358.GD20365@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170710165358.GD20365@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Mon, Jul 10, 2017 at 11:53:58AM -0500, Bjorn Helgaas wrote:
> I'm still confused.  Per Samuel
> (6dd9dbac-9b65-bc7c-bb08-413a05d09fc8@sieb.net):
> 
> Samuel> The other patch seems to fix this issue without disabling ATS.
> Samuel> Isn't that better?
> 
> and Alex
> (BN6PR12MB1652DF4130FC792B71DD9974F7C00@BN6PR12MB1652.namprd12.prod.outlook.com):
> 
> Alex> I talked to our validation team and ATS was validated on Stoney,
> Alex> so this patch is just working around something else.  The other
> Alex> patch fixes it and is a valid optimization ...
> 
> I'm confused about what this "other patch" is and whether we want that
> one, this one, or both.

The other patches floating around lowered the ATS flush-rate from the
AMD IOMMU driver, which makes the issue disappear as well. But the issue
only disappeared, it is not solved and could probably still be
reproduced with a GPU usage pattern that increases the ATS flush-rate.

So blacklisting the device for ATS is still the safest thing we could do
here.


Regards,

	Joerg
