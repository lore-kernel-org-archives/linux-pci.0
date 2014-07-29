Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65023 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbaG2MJo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jul 2014 08:09:44 -0400
Message-ID: <53D78EF7.8070203@linux.intel.com>
Date: Tue, 29 Jul 2014 20:09:27 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Joerg Roedel <joro@8bytes.org>
CC: David Woodhouse <dwmw2@infradead.org>,
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
Subject: Re: [Patch Part3 V4 00/21] Enable support of Intel DMAR device hotplug
References: <1405059585-10620-1-git-send-email-jiang.liu@linux.intel.com> <20140729104932.GC9809@8bytes.org>
In-Reply-To: <20140729104932.GC9809@8bytes.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks Joerg, will resend remaining patches after 3.17 merging window.

On 2014/7/29 18:49, Joerg Roedel wrote:
> On Fri, Jul 11, 2014 at 02:19:24PM +0800, Jiang Liu wrote:
>> Patch 1-13 are bugfixes and code improvement for current drivers.
> 
> Okay, I applied these for now (1-13 only) so that you don't have to
> rebase everything next time.
> 
>> Patch 14-17 enhances DMAR framework to support hotplug
>> Patch 18 enhances Intel interrupt remapping driver to support hotplug
>> Patch 19 enhances error handling in Intel IR driver
>> Patch 20 enhance Intel IOMMU to support hotplug
>> Patch 21 enhance ACPI pci_root driver to handle DMAR units
> 
> For these I'd like to see some reviews/acked-bys/tested-bys so that we
> gain more confidence on them.
> 
> 
> 	Joerg
> 
