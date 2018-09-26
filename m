Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E978C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 13:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19EE206B6
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 13:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19EE206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeIZUDg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:03:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46648 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeIZUDg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 16:03:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 888B518A;
        Wed, 26 Sep 2018 06:50:33 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7623F3F5B3;
        Wed, 26 Sep 2018 06:50:31 -0700 (PDT)
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-4-jean-philippe.brucker@arm.com>
 <09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
 <20180925132627.vbdotr23o7lqrmnd@8bytes.org>
 <b33a1911-e100-586b-b8df-eb04312ecffd@linux.intel.com>
 <754d495d-d016-f42f-5682-ba4a75a618e0@arm.com>
 <20180926124527.GD18287@8bytes.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <1f53c6f1-4e7a-1451-1abc-a7bca4a2359d@arm.com>
Date:   Wed, 26 Sep 2018 14:50:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180926124527.GD18287@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/09/2018 13:45, Joerg Roedel wrote:
> On Wed, Sep 26, 2018 at 11:20:34AM +0100, Jean-Philippe Brucker wrote:
>> Yes, at the moment it's difficult to guess what device drivers will
>> want, but I can imagine some driver offering SVA to userspace, while
>> keeping a few PASIDs for themselves to map kernel memory. Or create mdev
>> devices for virtualization while also allowing bare-metal SVA. So I
>> think we should aim at enabling these use-cases in parallel, even if it
>> doesn't necessarily need to be possible right now.
> 
> Yeah okay, but allowing these use-cases in parallel basically disallows
> giving any guest control over a device's pasid-table, no?
All of these use-cases require the host to manage the PASID tables, so
while any one of them is enabled, we can't give a guest control over the
PASID tables. But allowing these use-cases in parallel doesn't change that.

There is an ambiguity: I understand "(3) SVA in VM guest" as SVA for a
device-assignable interface assigned to a guest, using vfio-mdev and the
new Intel vt-d architecture (right?). That case does require the host to
allocate and manage PASIDs (because the PCI device is shared between
multiple VMs).

For the "classic" vfio-pci case, "SVA in guest" still means giving the
guest control over the whole PASID table.

Thanks,
Jean
