Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34067C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 22:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DCE2147C
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 22:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfBGWRd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:17:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:57815 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfBGWRd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 17:17:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 14:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="114531980"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2019 14:17:32 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 93F8C5802E1;
        Thu,  7 Feb 2019 14:17:32 -0800 (PST)
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
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
Date:   Thu, 7 Feb 2019 14:16:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/7/19 12:38 PM, Sinan Kaya wrote:
>
> On 2/7/2019 1:41 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> + * As per PCI spec, If page aligned request bit is set, it indicates
>> + * the untranslated address is always aligned to a 4096 byte boundary.
>> + */
>> +int pci_ats_page_aligned(struct pci_dev *pdev)
>> +{
>> +    u16 cap;
>> +
>> +    if (!pdev->ats_cap)
>> +        return 0;
>> +
>> +    pci_read_config_word(pdev, pdev->ats_cap + PCI_ATS_CAP, &cap);
>
> If I remember this right, aligned request is only supported on ATS v1.1
> but not supported on v1.0.
Its added in v1.1.
>
> Can you please check the spec?
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

