Return-Path: <SRS0=PSII=GX=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=PSII=GX=intel.com=keith.busch@kernel.org>
Date: Mon, 2 Apr 2018 08:23:08 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sinan Kaya <okaya@codeaurora.org>,
	Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH v1] PCI/DPC: Rename from pcie-dpc.c to dpc.c.
Message-ID: <20180402142308.GD28945@localhost.localdomain>
References: <152253566671.104119.5361437405172766528.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152253566671.104119.5361437405172766528.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 31, 2018 at 05:34:26PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Rename from pcie-dpc.c to dpc.c.  The path "drivers/pci/pcie/pcie-dpc.c"
> has more occurrences of "pci" than necessary.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good.

Acked-by: Keith Busch <keith.busch@intel.com>
