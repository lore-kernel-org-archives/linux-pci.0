Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08771C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 22:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC47A2154B
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 22:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC47A2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeI0FMo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:12:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:29396 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbeI0FMo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 01:12:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 15:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,308,1534834800"; 
   d="scan'208";a="95104711"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 26 Sep 2018 15:56:56 -0700
Date:   Wed, 26 Sep 2018 15:58:22 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
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
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
Message-ID: <20180926155822.167cccb3@jacob-builder>
In-Reply-To: <20180926124527.GD18287@8bytes.org>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
        <20180920170046.20154-4-jean-philippe.brucker@arm.com>
        <09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
        <20180925132627.vbdotr23o7lqrmnd@8bytes.org>
        <b33a1911-e100-586b-b8df-eb04312ecffd@linux.intel.com>
        <754d495d-d016-f42f-5682-ba4a75a618e0@arm.com>
        <20180926124527.GD18287@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 26 Sep 2018 14:45:27 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> On Wed, Sep 26, 2018 at 11:20:34AM +0100, Jean-Philippe Brucker wrote:
> > Yes, at the moment it's difficult to guess what device drivers will
> > want, but I can imagine some driver offering SVA to userspace, while
> > keeping a few PASIDs for themselves to map kernel memory. Or create
> > mdev devices for virtualization while also allowing bare-metal SVA.
> > So I think we should aim at enabling these use-cases in parallel,
> > even if it doesn't necessarily need to be possible right now.  
> 
> Yeah okay, but allowing these use-cases in parallel basically
> disallows giving any guest control over a device's pasid-table, no?
> 
For VT-d 3 (which is the only revision to support PASID), PASID table
is always controlled by the host driver. Guest SVA usage would bind
PASID with gCR3.
But I thought ARM (https://lkml.org/lkml/2018/9/18/1082) is using bind
PASID table approach which gives guest control of the device PASID
table. I don't know if that is intended for any parallel use of PASID
on the same device.
> I am just asking because I want to make up my mind about the necessary
> extensions to the IOMMU-API.
> 
One extension, we will need and being developed is bind_guest_pasid()
for guest SVA usage.
Usage:
1. guest allocate a system wide PASID for SVA
2. guest write PASID to its PASID table
3. PASID cache flush results in bind PASID (from guest) to device
4. Host IOMMU driver install gCR3s of the PASID to device PASID table
(ops.bind_guest_pasid)

Thanks,

Jacob
> 
> Regards,
> 
> 	Joerg
> 

[Jacob Pan]
