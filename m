Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:36037 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbdHQIaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2017 04:30:46 -0400
Cc: shawn.lin@rock-chips.com, Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: PCIe oops for NULL pointer dereference during next-20170807 and
 next-20170815
To: Joerg Roedel <joro@8bytes.org>
References: <c6ae57b6-1175-4ba4-b66d-d2f5393d06fc@rock-chips.com>
 <2ac52f40-c34f-6c31-b8db-868c40a977a3@rock-chips.com>
 <20170817075825.GR30515@8bytes.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <858f0baf-b43c-185c-d03d-5be032d9da64@rock-chips.com>
Date: Thu, 17 Aug 2017 16:30:35 +0800
MIME-Version: 1.0
In-Reply-To: <20170817075825.GR30515@8bytes.org>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/8/17 15:58, Joerg Roedel wrote:
> On Thu, Aug 17, 2017 at 03:02:31PM +0800, Shawn Lin wrote:
>> So should we revert this commit or maybe we could add some checking
>> into gic-v2m and gic-v3-its to see if the dev is iommu-capable? If not,
>> we should create another routine to map MSI msg.
> 
> Yes, fixing this in gic code is the right approach. I usually don't
> revert patches to hide problems somewhere else.
>

Ok, then I post a patch for fixing that in gic code. Thanks.


> 
> Regards,
> 
> 	Joerg
> 
> 
> 
> 
