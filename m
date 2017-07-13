Return-Path: <SRS0=tpkN=6Q=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=tpkN=6Q=intel.com=keith.busch@kernel.org>
Date: Thu, 13 Jul 2017 13:24:33 -0400
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	timur@codeaurora.org, alex.williamson@redhat.com,
	vikrams@codeaurora.org, Lorenzo.Pieralisi@arm.com,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4] PCI: handle CRS returned by device after FLR
Message-ID: <20170713172432.GB14716@localhost.localdomain>
References: <1499375234-23928-1-git-send-email-okaya@codeaurora.org>
 <20170713121758.GL4486@bhelgaas-glaptop.roam.corp.google.com>
 <0bcc0b00-1ad3-6866-32ab-15da8ea1821e@codeaurora.org>
 <20170713162915.GA14716@localhost.localdomain>
 <78020acc-c2b6-423c-38a0-251f86ffa8a9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <78020acc-c2b6-423c-38a0-251f86ffa8a9@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 13, 2017 at 12:42:44PM -0400, Sinan Kaya wrote:
> On 7/13/2017 12:29 PM, Keith Busch wrote:
> > That wording is just confusing. It looks to me the 1 second polling is
> > to be used following a reset if CRS is not implemented.
> > 
> >   https://pcisig.com/sites/default/files/specification_documents/ECN_RN_29_Aug_2013.pdf
> > 
> > "
> >   Through the mechanisms defined by this ECR, we can avoid the long,
> >   architected, fixed delays following various forms of reset before
> >   software is permitted to perform its first Configuration Request. These
> >   delays are very large:
> > 
> >   1 second if Configuration Retry Status (CRS) is not used
> > "
> > 
> > It goes on to say CRS is usually much lower, but doesn't specify an
> > upper bound either.
> > 
> 
> I see, we got caught on spec language where we don't know what 'its' is. 

Well, I don't know for certain if your original interpretation is
incorrect. Just saying the CRS intention doesn't explicitly stand out to me.

On a side note, I'll also see if I can get clarification on what
expectations the hardware people have for this particular product. Your
observation seems a little high to me, but I don't know if that's
outside the product's limits.
