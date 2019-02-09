Return-Path: <SRS0=+kTV=QQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C3BC169C4
	for <linux-pci@archiver.kernel.org>; Sat,  9 Feb 2019 01:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D97D217D8
	for <linux-pci@archiver.kernel.org>; Sat,  9 Feb 2019 01:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBIBDy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 20:03:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:18529 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBIBDy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 20:03:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 17:03:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,349,1544515200"; 
   d="scan'208";a="132709095"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 08 Feb 2019 17:03:53 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id B9DF05802BB;
        Fri,  8 Feb 2019 17:03:53 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
To:     Sinan Kaya <okaya@kernel.org>, bhelgaas@google.com,
        joro@8bytes.org, dwmw2@infradead.org
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
 <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
 <32ec3293-28ea-8f0f-f801-0370b4cf0453@kernel.org>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <351a1a1d-2517-5021-e7cd-99d700e17f4c@linux.intel.com>
Date:   Fri, 8 Feb 2019 17:02:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <32ec3293-28ea-8f0f-f801-0370b4cf0453@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/7/19 5:58 PM, Sinan Kaya wrote:
>
> On 2/7/2019 5:16 PM, sathyanarayanan kuppuswamy wrote:
>>> If I remember this right, aligned request is only supported on ATS v1.1
>>> but not supported on v1.0.
>> Its added in v1.1.
>
> This means that you should probably have some kind of version check
> here.

There is no version field in ATS v1.0 spec. Also, If I follow the 
history log in PCI spec, I think ATS if first added at v1.2. Please 
correct me if I am wrong.

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

