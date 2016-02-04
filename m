Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:56902 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756129AbcBDSGC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 13:06:02 -0500
Subject: Re: AMD-Vi: Unable to write to IOMMU perf counter.
To: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	linux-pci@vger.kernel.org
References: <56B365E0.4020100@01019freenet.de> <56B37292.1000201@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <helgaas@kernel.org>,
	iommu <iommu@lists.linux-foundation.org>
From: Andreas Hartmann <andihartmann@freenet.de>
Message-ID: <56B39009.90401@maya.org>
Date: Thu, 4 Feb 2016 18:53:13 +0100
MIME-Version: 1.0
In-Reply-To: <56B37292.1000201@amd.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/04/2016 at 04:47 PM, Suravee Suthikulanit wrote:
> Hi Andreas,
> 
> On 2/4/2016 8:53 AM, Andreas Hartmann wrote:
>> Hello!
>>
>> The following happens with Linux 4.4.1 during boot on an MSI A78M-E35
>> board. Additionally, I attached the complete dmesg.
> 
> I was working on upstreaming changes to the AMD IOMMU Perf to fix some
> of the similar issue I saw on a different platform.  Would you please
> check to see if this patch series would fix this?
> 
> https://lkml.org/lkml/2016/1/1/141


This patchset seems to fix the problem.

[    1.264639] AMD-Vi: IOMMU performance counters supported

But there seems to be a problem with the location of
perf_event_amd_iommu.h in the patch - I had to fix the complete
perf_event_amd_iommu.h related patches to get them applied to 4.4. and
finally compiled.


Thanks,
Andreas
