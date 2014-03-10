Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11312 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbaCJIq7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Mar 2014 04:46:59 -0400
Message-ID: <531D7BE8.7060103@linux.intel.com>
Date: Mon, 10 Mar 2014 16:46:32 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Joerg Roedel <joro@8bytes.org>, Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: Re: [Patch Part2 V2 15/17] iommu/vt-d, PCI: update DRHD/RMRR/ATSR
 device scope caches when PCI hotplug happens
References: <1392790057-32434-1-git-send-email-jiang.liu@linux.intel.com>	 <1392790057-32434-16-git-send-email-jiang.liu@linux.intel.com> <1394130319.9994.28.camel@i7.infradead.org>
In-Reply-To: <1394130319.9994.28.camel@i7.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,
	Good suggestion! It should make hotplug logic simpler too.
Will try to work out some patches for it.
Thanks!
Gerry

On 2014/3/7 2:25, David Woodhouse wrote:
> On Wed, 2014-02-19 at 14:07 +0800, Jiang Liu wrote:
>> Current Intel DMAR/IOMMU driver assumes that all PCI devices
>> associated
>> with DMAR/RMRR/ATSR device scope arrays are created at boot time and
>> won't change at runtime, so it caches pointers of associated PCI
>> device
>> object. That assumption may be wrong now due to:
>> 1) introduction of PCI host bridge hotplug
>> 2) PCI device hotplug through sysfs interfaces.
> ...
>> This patch introduces a new mechanism to update the DRHD/RMRR/ATSR
>> device scope caches by hooking PCI bus notification.
> 
> Hm, this seems overly complex. Can't we just abandon the
> dmaru->devices[] array completely? In dmar_find_matched_drhd_unit()
> can't we just compare the path in the scope entries directly to the PCI
> device we are trying to find a DRHD for?
> 
> We then cache the result in dev->archdata.iommu for ever (well, until
> hot-unplug) anyway, so it shouldn't even be any less efficient to do it
> on demand, right?
> 
> That's true at least for dmar_find_matched_drhd_unit(). Perhaps we'd
> need to find a way to cache the result for
> dmar_find_matched_atsr_unit()?
> 
