Return-Path: <SRS0=z8bL=LO=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=z8bL=LO=intel.com=keith.busch@kernel.org>
Date: Fri, 31 Aug 2018 08:47:21 -0600
From: Keith Busch <keith.busch@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VMD: Set up firmware first if capable
Message-ID: <20180831144721.GA7761@localhost.localdomain>
References: <1535675403-2903-1-git-send-email-jonathan.derrick@intel.com>
 <1535675403-2903-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1535675403-2903-2-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 30, 2018 at 06:30:03PM -0600, Jon Derrick wrote:
> Some VMD devices will want to use firmware first error-handling on the
> entire domain. This is detected by the BIOS setting the VMD endpoint's
> interface to 0x1.
> 
> Detect this condition and propogate it to the entire domain.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Just curious, do you know what happens if you encounter a fatal error in
a VMD domain with FF enabled? Will this create generic hw error source
event for the OS, and if so, does the error record point to the VMD
device as the source, or the device within the domain that actually
sent the ERR_FATAL?

The implementation looks fine to me.

Reviewed-by: Keith Busch <keith.busch@intel.com>
