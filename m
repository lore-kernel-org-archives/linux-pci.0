Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 May 2014 11:23:58 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-hotplug@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [Patch Part3 V2 00/21] Enable support of Intel DMAR device
 hotplug
Message-ID: <20140519092358.GB17056@8bytes.org>
References: <1399359932-28972-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399359932-28972-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey David,

On Tue, May 06, 2014 at 03:05:11PM +0800, Jiang Liu wrote:
> Patch 1-13 are bugfixes and code improvement for current drivers.
> Patch 14-17 enhances DMAR framework to support hotplug
> Patch 18 enhances Intel interrupt remapping driver to support hotplug
> Patch 19 enhances error handling in Intel IR driver
> Patch 20 enhance Intel IOMMU to support hotplug
> Patch 21 enhance ACPI pci_root driver to handle DMAR units

Have you had a chance to look into this patch-set? I'll wonder whether
it should be merged for 3.16.


	Joerg


