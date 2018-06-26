Return-Path: <SRS0=GkLM=JM=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=GkLM=JM=linux.intel.com=mika.westerberg@kernel.org>
Date: Tue, 26 Jun 2018 13:00:22 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] PCI: shpchp: NULL pointer fix and cleanups
Message-ID: <20180626100022.GV2558@lahna.fi.intel.com>
References: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2018 at 05:59:33PM -0500, Bjorn Helgaas wrote:
> The first patch fixes a NULL pointer dereference reported by Marc and would
> be targeted for v4.18.
> 
> The others simplify the shpchp probe path and would be for v4.19.

Thanks for taking care of this, Bjorn!

For the whole series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
