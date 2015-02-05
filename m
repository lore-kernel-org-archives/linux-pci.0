Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 4 Feb 2015 17:56:07 -0800
From: Vinod Koul <vinod.koul@intel.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	Len Brown <lenb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Thierry Reding <treding@nvidia.com>,
	Mike Travis <travis@sgi.com>, Tony Luck <tony.luck@intel.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [Patch v2 17/22] resources: Move struct resource_list_entry from
 ACPI into resource core
Message-ID: <20150205015607.GM4489@intel.com>
References: <1422442660-455-1-git-send-email-jiang.liu@linux.intel.com>
 <1422442660-455-18-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422442660-455-18-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 28, 2015 at 06:57:35PM +0800, Jiang Liu wrote:
> Currently ACPI, PCI and pnp all implement the same resource list
> management with different data structure. We need to transfer from
> one data structure into another when passing resources from one
> subsystem into another subsystem. Sp move struct resource_list_entry
Typo				    ^^
> from ACPI into resource core, so it could be reused by different
> subystems and avoid the data structure conversion.
> 
> Introduce dedicated header file resource_ext.h instead of embedding
> it into ioport.h to avoid header file inclusion order issues.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpss.c     |    6 ++--
>  drivers/acpi/acpi_platform.c |    2 +-
>  drivers/acpi/resource.c      |   13 +++----
>  drivers/dma/acpi-dma.c       |    8 ++---
For dmaengine:

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod

