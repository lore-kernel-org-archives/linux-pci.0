Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1A0C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 10:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AE72145D
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 10:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AE72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeIYQjr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:39:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48670 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeIYQjr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 12:39:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF4CC7A9;
        Tue, 25 Sep 2018 03:32:52 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43EA63F5B7;
        Tue, 25 Sep 2018 03:32:49 -0700 (PDT)
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
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
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <5aff8dc0-9ce7-5018-e78e-770279681cbc@arm.com>
Date:   Tue, 25 Sep 2018 11:32:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/09/2018 04:15, Lu Baolu wrote:
>> +     /* If an io_mm already exists, use it */
>> +     spin_lock(&iommu_sva_lock);
>> +     idr_for_each_entry(&iommu_pasid_idr, io_mm, i) {
> 
> This might be problematic for vt-d (and other possible arch's which use
> PASID other than SVA). When vt-d iommu works in scalable mode, a PASID
> might be allocated for:
> 
> (1) SVA
> (2) Device Assignable Interface (might be a mdev or directly managed
>      within a device driver).
> (3) SVA in VM guest
> (4) Device Assignable Interface in VM guest
> 
> So we can't expect that an io_mm pointer was associated with each PASID.

Yes as discussed on the previous series, we'll need to move the PASID
allocator outside of iommu-sva at some point, and even outside of
drivers/iommu since device driver might want to use the PASID allocator
without an IOMMU.

To be usable by all consumers of PASIDs, that allocator will need the
same interface as IDR, so I don't think we have a problem here. I
haven't had time or need to write such allocator yet (and don't plan to
do it as part of this series), but I drafted an interface, that at least
fulfills the needs of SVA.

* Single system-wide PASID space
* Multiple consumers, each associating their own structure to PASIDs.
  Each consumer gets a token.
* Device drivers might want to use both SVA and private PASIDs for a
  device at the same time.
* In my opinion "pasid" isn't the right name, "ioasid" would be better
  but that's not important.

typedef unsigned int pasid_t;

/* Returns consumer token */
void *pasid_get_consumer();
void pasid_put_consumer(void *consumer);

/* Returns pasid or invalid (pasid_t)(-1) */
pasid_t pasid_alloc(void *consumer, pasid_t min, pasid_t max,
                    void *private);
void pasid_remove(pasid_t pasid);

/* Iterate over PASIDs for this consumer. Func returns non-zero to stop
iterating */
int pasid_for_each(void *consumer, void *iter_data,
		   int (*func)(void *iter_data, pasid_t pasid,
			       void *private));
/* Returns priv data or NULL */
void *pasid_find(void *consumer, pasid_t pasid);

Thanks,
Jean

> And this code might run into problem if the pasid is allocated for
> usages other than SVA.
> 
> Best regards,
> Lu Baolu

