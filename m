Return-Path: <SRS0=tpkN=6Q=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=tpkN=6Q=intel.com=keith.busch@kernel.org>
Date: Thu, 13 Jul 2017 12:29:16 -0400
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	timur@codeaurora.org, alex.williamson@redhat.com,
	vikrams@codeaurora.org, Lorenzo.Pieralisi@arm.com,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4] PCI: handle CRS returned by device after FLR
Message-ID: <20170713162915.GA14716@localhost.localdomain>
References: <1499375234-23928-1-git-send-email-okaya@codeaurora.org>
 <20170713121758.GL4486@bhelgaas-glaptop.roam.corp.google.com>
 <0bcc0b00-1ad3-6866-32ab-15da8ea1821e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0bcc0b00-1ad3-6866-32ab-15da8ea1821e@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 13, 2017 at 11:44:12AM -0400, Sinan Kaya wrote:
> On 7/13/2017 8:17 AM, Bjorn Helgaas wrote:
> >> he spec is calling to wait up to 1 seconds if the device is sending CRS.
> >> The NVMe device seems to be requiring more. Relax this up to 60 seconds.
> > Can you add a pointer to the "1 second" requirement in the spec here?
> > We use 60 seconds in pci_scan_device() and acpiphp_add_context().  Is
> > there a basis in the spec for the 60 second timeout?
> 
> This does not specify a hard limit above on how long SW need to wait. 
> 
> "6.6.2 Function Level Reset
> After an FLR has been initiated by writing a 1b to the Initiate Function Level Reset bit, 
> the Function must complete the FLR within 100 ms.
> 
> While a Function is required to complete the FLR operation within the time limit described above,
> the subsequent Function-specific initialization sequence may require additional time. 
> If additional time is required, the Function must return a Configuration Request Retry Status (CRS) 
> Completion Status when a Configuration Request is received 15 after the time limit above. 
> After the Function responds to a Configuration Request with a Completion status other than CRS, 
> it is not permitted to return CRS until it is reset again."
> 
> However, another indirect reference here tells us it is capped by 1 second below.
> 
> "6.23. Readiness Notifications (RN)
> Readiness Notifications (RN) is intended to reduce the time software needs to
> wait before issuing Configuration Requests to a Device or Function following DRS
> Events or FRS Events. RN includes both the Device Readiness Status (DRS) and
> Function Readiness Status (FRS) mechanisms. These mechanisms provide a direct
> indication of Configuration-Readiness (see 5 Terms and Acronyms entry for “Configuration-Ready”). 
> 
> When used, DRS and FRS allow an improved behavior over the CRS mechanism, and eliminate
> its associated periodic polling time of up to 1 second following a reset."

That wording is just confusing. It looks to me the 1 second polling is
to be used following a reset if CRS is not implemented.

  https://pcisig.com/sites/default/files/specification_documents/ECN_RN_29_Aug_2013.pdf

"
  Through the mechanisms defined by this ECR, we can avoid the long,
  architected, fixed delays following various forms of reset before
  software is permitted to perform its first Configuration Request. These
  delays are very large:

  1 second if Configuration Retry Status (CRS) is not used
"

It goes on to say CRS is usually much lower, but doesn't specify an
upper bound either.
