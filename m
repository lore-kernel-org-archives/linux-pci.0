Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68FDC43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 13:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FA9216E3
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 13:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FA9216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeI0T4c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:56:32 -0400
Received: from foss.arm.com ([217.140.101.70]:34680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeI0T4c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 15:56:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2A0B7A9;
        Thu, 27 Sep 2018 06:38:13 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.Emea.Arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B75E3F5B7;
        Thu, 27 Sep 2018 06:38:11 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
To:     "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        Robin Murphy <Robin.Murphy@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-4-jean-philippe.brucker@arm.com>
 <09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
 <20180925132627.vbdotr23o7lqrmnd@8bytes.org>
 <b33a1911-e100-586b-b8df-eb04312ecffd@linux.intel.com>
 <754d495d-d016-f42f-5682-ba4a75a618e0@arm.com>
 <20180926124527.GD18287@8bytes.org>
 <1f53c6f1-4e7a-1451-1abc-a7bca4a2359d@arm.com>
 <A2975661238FB949B60364EF0F2C257439D0CC48@SHSMSX104.ccr.corp.intel.com>
Message-ID: <9aedb22e-ff28-7bfd-feeb-ae86802e6400@arm.com>
Date:   Thu, 27 Sep 2018 14:37:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D0CC48@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27/09/2018 04:22, Liu, Yi L wrote:
>> For the "classic" vfio-pci case, "SVA in guest" still means giving the
>> guest control over the whole PASID table.
> 
> No, if giving guest control over the whole PASID table, it means guest may have
> its own PASID namespace. right? And for vfio-mdev case, it gets PASID from host.
> So there would be multiple PASID namespaces. Thinking about the following scenario:
> 
> A PF/VF assigned to a VM via "classic" vfio-pci. And an assignable-device-interface
> assigned to this VM via vfio-mdev. If an application in this VM tries to manipulate
> these two "devices", it should have the same PASID programmed to them. right?
> But as the above comments mentioned, for vfio-pci case, it would get a PASID from
> its own PASID namespace. While the vfio-mdev case would get a PASID from host.
> This would result in conflict.

Ah I see, if the host assigns an ADI via vfio-mdev and a PCI function
via vfio-pci to the same VM, the guest needs to use the paravirtualized
PASID allocator for the PCI device as well, not just the ADI. In fact
all guest PASIDs need to be allocated through one PV channel, even if
the VM has other vIOMMUs that don't support PV. But I suppose that kind
of VM is unrealistic. However for SMMUv3 we'll still use the
bind_pasid_table for vfio-pci and let the guest allocate PASIDs, since
the PASID table lives in guest-physical space.

In any case, for the patch series at hand, it means that iommu-sva will
need assistance from the vt-d driver to allocate PASIDs: host uses the
generic allocator, guest uses the PV one. I guess the mm_alloc() op
could do that?

Thanks,
Jean
