Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28264C004D1
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 03:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38462156D
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 03:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38462156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeI0Jk6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 05:40:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:63080 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbeI0Jk5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 05:40:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 20:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,308,1534834800"; 
   d="scan'208";a="86914106"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 26 Sep 2018 20:22:50 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 26 Sep 2018 20:22:49 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 26 Sep 2018 20:22:48 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.183]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.37]) with mapi id 14.03.0319.002;
 Thu, 27 Sep 2018 11:22:46 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 03/10] iommu/sva: Manage process address spaces
Thread-Topic: [PATCH v3 03/10] iommu/sva: Manage process address spaces
Thread-Index: AQHUUQbeYoKTwka2WEyXMYBJUUEZKaT/0+gAgACqp4CAAKmhgIAAtMQAgAAoe4CAABIbgIABZMTA
Date:   Thu, 27 Sep 2018 03:22:46 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D0CC48@SHSMSX104.ccr.corp.intel.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
        <20180920170046.20154-4-jean-philippe.brucker@arm.com>
        <09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
        <20180925132627.vbdotr23o7lqrmnd@8bytes.org>
        <b33a1911-e100-586b-b8df-eb04312ecffd@linux.intel.com>
        <754d495d-d016-f42f-5682-ba4a75a618e0@arm.com>
        <20180926124527.GD18287@8bytes.org>
 <1f53c6f1-4e7a-1451-1abc-a7bca4a2359d@arm.com>
In-Reply-To: <1f53c6f1-4e7a-1451-1abc-a7bca4a2359d@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjQ4YzRkY2ItNTdjNi00YTM0LTg5MzctZTIzZWM3YmRmMjYxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYzVaeHdXT3VkK1E1ZFJSSk03TWhFNnBwREtPV05hTGVKaW5pdGxtcDg0cXlERFZHZ2pcL2ZxOCs4d1AzNDJrbTEifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Jean-Philippe Brucker
> Sent: Wednesday, September 26, 2018 9:50 PM
> Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
> 
> On 26/09/2018 13:45, Joerg Roedel wrote:
> > On Wed, Sep 26, 2018 at 11:20:34AM +0100, Jean-Philippe Brucker wrote:
> >> Yes, at the moment it's difficult to guess what device drivers will
> >> want, but I can imagine some driver offering SVA to userspace, while
> >> keeping a few PASIDs for themselves to map kernel memory. Or create mdev
> >> devices for virtualization while also allowing bare-metal SVA. So I
> >> think we should aim at enabling these use-cases in parallel, even if it
> >> doesn't necessarily need to be possible right now.
> >
> > Yeah okay, but allowing these use-cases in parallel basically disallows
> > giving any guest control over a device's pasid-table, no?
> All of these use-cases require the host to manage the PASID tables, so
> while any one of them is enabled, we can't give a guest control over the
> PASID tables. But allowing these use-cases in parallel doesn't change that.
> 
> There is an ambiguity: I understand "(3) SVA in VM guest" as SVA for a
> device-assignable interface assigned to a guest, using vfio-mdev and the
> new Intel vt-d architecture (right?). That case does require the host to
> allocate and manage PASIDs (because the PCI device is shared between
> multiple VMs).

Correct. For such case, we give host the charge to allocate and manage PASIDs.
And the reason is correct.

> 
> For the "classic" vfio-pci case, "SVA in guest" still means giving the
> guest control over the whole PASID table.

No, if giving guest control over the whole PASID table, it means guest may have
its own PASID namespace. right? And for vfio-mdev case, it gets PASID from host.
So there would be multiple PASID namespaces. Thinking about the following scenario:

A PF/VF assigned to a VM via "classic" vfio-pci. And an assignable-device-interface
assigned to this VM via vfio-mdev. If an application in this VM tries to manipulate
these two "devices", it should have the same PASID programmed to them. right?
But as the above comments mentioned, for vfio-pci case, it would get a PASID from
its own PASID namespace. While the vfio-mdev case would get a PASID from host.
This would result in conflict.

So I would like we get host to allocate and manage the whole PASID table, so that
to cover possible combinations of vfio-pci passthru and vfio-mdev passthru.

> 
> Thanks,
> Jean

Regards,
Yi Liu
