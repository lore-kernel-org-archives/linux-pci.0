Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1314DC169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 19:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5332229F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 19:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfBKTZq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:25:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:13135 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfBKTZp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 14:25:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 11:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="115378294"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 11 Feb 2019 11:25:45 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id E9B6D5800C6;
        Mon, 11 Feb 2019 11:25:44 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
To:     "Raj, Ashok" <ashok.raj@intel.com>, Sinan Kaya <Okaya@kernel.org>
Cc:     bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
 <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
 <32ec3293-28ea-8f0f-f801-0370b4cf0453@kernel.org>
 <351a1a1d-2517-5021-e7cd-99d700e17f4c@linux.intel.com>
 <815f2621-fc28-bff4-c300-cce7514cfe71@kernel.org>
 <20190211191549.GA12090@otc-nc-03>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <40d67487-3881-2e3b-c2cd-424333b0abc5@linux.intel.com>
Date:   Mon, 11 Feb 2019 11:24:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190211191549.GA12090@otc-nc-03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/11/19 11:15 AM, Raj, Ashok wrote:
> On Fri, Feb 08, 2019 at 11:49:55PM -0500, Sinan Kaya wrote:
>> On 2/8/2019 8:02 PM, sathyanarayanan kuppuswamy wrote:
>>>> This means that you should probably have some kind of version check
>>>> here.
>>> There is no version field in ATS v1.0 spec. Also, If I follow the history
>>> log in PCI spec, I think ATS if first added at v1.2. Please correct me if
>>> I am wrong.
>> v1.2 was incorporated into PCIe spec at that time. However, the ATS spec
>> is old and there could be some HW that could claim to be ATS compatible.
>> I know AMD GPUs declare ATS capability.
> It seems rather odd we have to check for ATS version.
>
> I always assumed unspecified bits (Reserved) must be 0. We only check
> this if ATS is enabled, and this particular bit wasn't given away for another
> feature.
>
> Is it really required to check for ATS version before consuming this?
If the version check is required then, it needs to be added before 
reading "Invalidate Queue Depth" value as well.
>
>
>> See this ECN
>>
>> https://composter.com.ua/documents/ats_r1.1_26Jan09.pdf
>>
>> You need to validate the version field from ATS capability header to be
>> 1 before reading this register.
>>
>> See Table 5-1:  ATS Extended Capability Header

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

