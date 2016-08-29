Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Mon, 29 Aug 2016 13:52:31 -0400
From: Keith Busch <keith.busch@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] vmd: allocate irq lists with correct msix count
Message-ID: <20160829175231.GF19986@localhost.localdomain>
References: <1472491142-13783-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472491142-13783-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 29, 2016 at 11:19:01AM -0600, Jon Derrick wrote:
> To reduce the amount of memory required for irq lists, only allocate
> their space after calling pci_msix_enable_range which may reduce the
> number of msix vectors allocated.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Looks good. 

Reviewed-by: Keith Busch <keith.busch@intel.com>
