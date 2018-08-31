Return-Path: <SRS0=5T7n=LO=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=5T7n=LO=linux.intel.com=mika.westerberg@kernel.org>
Date: Fri, 31 Aug 2018 16:51:35 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Keith Busch <keith.busch@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sinan Kaya <okaya@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v2] PCI: Equalize hotplug memory for non/occupied slots
Message-ID: <20180831135135.GO2283@lahna.fi.intel.com>
References: <1535667120-3002-1-git-send-email-jonathan.derrick@intel.com>
 <1535667120-3002-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1535667120-3002-2-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 30, 2018 at 04:12:00PM -0600, Jon Derrick wrote:
> Currently, a hotplug bridge will be given hpmemsize additional memory if
> available, in order to satisfy any future hotplug allocation
> requirements.
> 
> These calculations don't consider the current memory size of the hotplug
> bridge/slot, so hotplug bridges/slots which have downstream devices will
> get their current allocation in addition to the hpmemsize value.
> 
> This makes for possibly undesirable results with a mix of unoccupied and
> occupied slots (ex, with hpmemsize=2M):
> 
> 02:03.0 PCI bridge: <-- Occupied
> 	Memory behind bridge: d6200000-d64fffff [size=3M]
> 02:04.0 PCI bridge: <-- Unoccupied
> 	Memory behind bridge: d6500000-d66fffff [size=2M]
> 
> This change considers the current allocation size when using the
> hpmemsize parameter to make the reservations predictable for the mix of
> unoccupied and occupied slots:
> 
> 02:03.0 PCI bridge: <-- Occupied
> 	Memory behind bridge: d6200000-d63fffff [size=2M]
> 02:04.0 PCI bridge: <-- Unoccupied
> 	Memory behind bridge: d6400000-d65fffff [size=2M]
> 
> The calculation for IO (hpiosize) should be similar, but platform
> firmwares I've encountered (including QEMU) provide strict allocations
> for IO and would not provide free IO resources for hotplug buses
> in order to prove this calculation.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
