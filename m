Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1027C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 23:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAC920896
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 23:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAC920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeIZFpI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:45:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:29622 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbeIZFpI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 01:45:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 16:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,304,1534834800"; 
   d="scan'208";a="89342273"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga002.fm.intel.com with ESMTP; 25 Sep 2018 16:35:06 -0700
Cc:     baolu.lu@linux.intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        jcrouse@codeaurora.org, alex.williamson@redhat.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, eric.auger@redhat.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, andrew.murray@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, ashok.raj@intel.com,
        xuzaibo@huawei.com, liguozhu@hisilicon.com, okaya@codeaurora.org,
        bharatku@xilinx.com, ilias.apalodimas@linaro.org,
        shunyong.yang@hxt-semitech.com
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
To:     Joerg Roedel <joro@8bytes.org>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-4-jean-philippe.brucker@arm.com>
 <09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
 <20180925132627.vbdotr23o7lqrmnd@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b33a1911-e100-586b-b8df-eb04312ecffd@linux.intel.com>
Date:   Wed, 26 Sep 2018 07:33:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925132627.vbdotr23o7lqrmnd@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Joerg,

On 09/25/2018 09:26 PM, Joerg Roedel wrote:
> On Tue, Sep 25, 2018 at 11:15:40AM +0800, Lu Baolu wrote:
>> This might be problematic for vt-d (and other possible arch's which use
>> PASID other than SVA). When vt-d iommu works in scalable mode, a PASID
>> might be allocated for:
>>
>> (1) SVA
>> (2) Device Assignable Interface (might be a mdev or directly managed
>>      within a device driver).
>> (3) SVA in VM guest
>> (4) Device Assignable Interface in VM guest
>>
>> So we can't expect that an io_mm pointer was associated with each PASID.
>> And this code might run into problem if the pasid is allocated for
>> usages other than SVA.
> 
> So all of these use-cases above should work in parallel on the same
> device, just with different PASIDs?

No. It's not required.

> Or is a device always using only one
> of the above modes at the same time?

A device might use one or multiple modes described above at the same
time.

Best regards,
Lu Baolu
