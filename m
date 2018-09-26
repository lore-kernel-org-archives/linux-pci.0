Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69486C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 10:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3692082C
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 10:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3692082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeIZQdJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:33:09 -0400
Received: from foss.arm.com ([217.140.101.70]:42348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbeIZQdJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 12:33:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55E2018A;
        Wed, 26 Sep 2018 03:20:54 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0CBC3F5BD;
        Wed, 26 Sep 2018 03:20:50 -0700 (PDT)
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "bharatku@xilinx.com" <bharatku@xilinx.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-4-jean-philippe.brucker@arm.com>
 <09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
 <20180925132627.vbdotr23o7lqrmnd@8bytes.org>
 <b33a1911-e100-586b-b8df-eb04312ecffd@linux.intel.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <754d495d-d016-f42f-5682-ba4a75a618e0@arm.com>
Date:   Wed, 26 Sep 2018 11:20:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <b33a1911-e100-586b-b8df-eb04312ecffd@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/09/2018 00:33, Lu Baolu wrote:
> Hi Joerg,
> 
> On 09/25/2018 09:26 PM, Joerg Roedel wrote:
>> On Tue, Sep 25, 2018 at 11:15:40AM +0800, Lu Baolu wrote:
>>> This might be problematic for vt-d (and other possible arch's which use
>>> PASID other than SVA). When vt-d iommu works in scalable mode, a PASID
>>> might be allocated for:
>>>
>>> (1) SVA
>>> (2) Device Assignable Interface (might be a mdev or directly managed
>>>      within a device driver).
>>> (3) SVA in VM guest
>>> (4) Device Assignable Interface in VM guest
>>>
>>> So we can't expect that an io_mm pointer was associated with each PASID.
>>> And this code might run into problem if the pasid is allocated for
>>> usages other than SVA.
>> 
>> So all of these use-cases above should work in parallel on the same
>> device, just with different PASIDs?
> 
> No. It's not required.
> 
>> Or is a device always using only one
>> of the above modes at the same time?
> 
> A device might use one or multiple modes described above at the same
> time.

Yes, at the moment it's difficult to guess what device drivers will
want, but I can imagine some driver offering SVA to userspace, while
keeping a few PASIDs for themselves to map kernel memory. Or create mdev
devices for virtualization while also allowing bare-metal SVA. So I
think we should aim at enabling these use-cases in parallel, even if it
doesn't necessarily need to be possible right now.

Thanks,
Jean
