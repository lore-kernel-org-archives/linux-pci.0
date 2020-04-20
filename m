Return-Path: <SRS0=9FxQ=6E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223C7C38A30
	for <linux-pci@archiver.kernel.org>; Mon, 20 Apr 2020 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2652145D
	for <linux-pci@archiver.kernel.org>; Mon, 20 Apr 2020 17:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgDTRyG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:54:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:45202 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgDTRyG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 13:54:06 -0400
IronPort-SDR: zb+8wNYFb09fS5659I0GPbXMwCPlPFLBXDouzgt9FLuUXJqNClAixJUwCpSMN7CUJizvuwqiYo
 qEyjrktest/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 10:54:06 -0700
IronPort-SDR: kdDOj1y7f6trU6kPQ5wxGBWvK0JePPgGbvmXJHPmsJ+ZGniULkrCF4maY84gIiH+A1cupWUOgq
 88rw83vO5E0A==
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="455785222"
Received: from labenne1-mobl.amr.corp.intel.com (HELO [10.135.61.52]) ([10.135.61.52])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 10:54:05 -0700
From:   "Sean V Kelley" <sean.v.kelley@linux.intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Jay Fang" <f.fangjian@huawei.com>, mj@ucw.cz,
        linux-pci@vger.kernel.org, huangdaode <huangdaode@hisilicon.com>
Subject: Re: [PATCH v5 2/2] pciutils: Decode Compute eXpress Link DVSEC
Date:   Mon, 20 Apr 2020 10:54:04 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <5BAF4A09-E300-42CB-97A4-194BBFF3DFC9@linux.intel.com>
In-Reply-To: <20200420174747.GA48539@google.com>
References: <20200420174747.GA48539@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20 Apr 2020, at 10:47, Bjorn Helgaas wrote:

> Hi Jay, thanks for taking a look at this!
>
> On Mon, Apr 20, 2020 at 09:21:27AM -0700, Sean V Kelley wrote:
>> On 18 Apr 2020, at 1:36, Jay Fang wrote:
>>> On 2020/4/15 8:47, Sean V Kelley wrote:
>>>>
>>>> [1] https://www.computeexpresslink.org/
>>>>
>>>> Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
>>>> ---
>>>>  lib/header.h        |  20 +++
>>>
>>>> +
>>>> +static int
>>>> +is_cxl_cap(struct device *d, int where)
>>>> +{
>>>> +  u32 hdr;
>>>> +  u16 w;
>>>> +
>>>> +  if (!config_fetch(d, where + PCI_DVSEC_HEADER1, 8))
>>>> +    return 0;
>>>> +
>>>> +  /* Check for supported Vendor */
>>>> +  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER1);
>>>> +  w = BITS(hdr, 0, 16);
>>>> +  if (w != PCI_VENDOR_ID_INTEL)
>>>
>>> I don't think here checking is quite right. Does only Intel support 
>>> CXL?
>>> Other Vendors should also be considered.
>>
>> In the absence of currently available hardware, I was attempting to 
>> limit
>> false positive noise.  I’m happy to avoid the check on the vendor 
>> if there
>> were to exist a definitive supported list.  Bjorn suggested that I 
>> check for
>> vendor ID with DVSEC ID for now.  As hardware enters the market, I 
>> can
>> surely revise this with an update when the CXL group publishes a 
>> list.
>
> The Vendor ID check cannot be avoided.  Vendor IDs are allocated by
> the PCI-SIG, but the DVSEC ID is vendor-defined so there cannot be a
> global "CXL capability" DVSEC ID.
>
> CXL *could* work through the PCI-SIG and define a new CXL Extended
> Capability that could make this generic.  But apparently they've
> chosen to use the DVSEC mechanism instead.
>
>>>> +  /* Check for Designated Vendor-Specific ID */
>>>> +  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER2);
>>>> +  w = BITS(hdr, 0, 16);
>>>> +  if (w == PCI_DVSEC_ID)
>
> However, this is slightly wrong.  The name "PCI_DVSEC_ID" implies that
> there can only be one DVSEC ID and it is vendor-independent, but
> neither is true.
>
> This value is allocated by Intel, so we must check for the Intel
> Vendor ID first.  And Intel may define several DVSEC capabilities for
> different purposes, so the name should also mention CXL.
>
> So this should be "PCI_DVSEC_INTEL_CXL" or something similar.
>
> But that doesn't mean other vendors need to define their own DVSEC
> IDs for CXL.  The spec (PCIe r5.0, sec 7.9.6) says:
>
>   [The DVSEC Capability] allows PCI Express component vendors to use
>   the Extended Capability mechanism to expose vendor-specific
>   registers that can be present in components by a variety of
>   vendors.
>
> Any vendor that implements this CXL DVSEC the same way Intel does can
> tag it with PCI_VENDOR_ID_INTEL and PCI_DVSEC_INTEL_CXL.

Good point.  I will revise.

Thanks,

Sean

>
> Note that there are two types of vendor-specific capabilities:
>
>   1) Vendor-Specific Extended Capability (VSEC).  The structure and
>   definition are defined by the *Function* Vendor ID (from offset 0 in
>   config space) and the VSEC ID in the capability.
>
>   2) Designated Vendor-Specific Extended Capability (DVSEC).  The
>   structure and definition are defined by the *DVSEC* Vendor ID (from
>   the DVSEC capability, *not* the vendor of the Function) and the
>   DVSEC ID in the capability.
>
> This CXL capability is the latter, of course.
>
> Bjorn
