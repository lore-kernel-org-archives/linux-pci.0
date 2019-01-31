Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE54C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 23:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BBA20B1F
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 23:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfAaXsL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:48:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:47404 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfAaXsL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 18:48:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 15:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,546,1539673200"; 
   d="scan'208";a="315362362"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.255.72.219]) ([10.255.72.219])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2019 15:48:09 -0800
Subject: Re: [PATCH 0/9] Support using MSI interrupts in ntb_transport
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>
References: <20190131185656.17972-1-logang@deltatee.com>
 <345197a6-89e6-c0de-5f7b-a646b5f396c9@intel.com>
 <bafe9db4-6d5b-0453-d7e7-e49e9293dd01@deltatee.com>
 <ea7b7c3c-8ed5-51ec-022a-7d28a5afce82@intel.com>
 <29f7e3fe-5354-6156-1243-7248ffb2249f@deltatee.com>
 <7e3eed52-8e3a-c472-392a-5dc5689290ae@intel.com>
 <5f8b1616-a005-7658-978f-16466fcc3886@deltatee.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <d46ce09c-d493-3d63-a854-b68a09345a75@intel.com>
Date:   Thu, 31 Jan 2019 16:48:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <5f8b1616-a005-7658-978f-16466fcc3886@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/31/2019 4:41 PM, Logan Gunthorpe wrote:
>
> On 2019-01-31 3:46 p.m., Dave Jiang wrote:
>> I believe irqbalance writes to the file /proc/irq/N/smp_affinity. So
>> maybe take a look at the code that starts from there and see if it would
>> have any impact on your stuff.
> Ok, well on my system I can write to the smp_affinity all day and the
> MSI interrupts still work fine.

Maybe your code is ok then. If the stats show up in /proc/interrupts 
then you can see it moving to different cores.

> The MSI code is a bit difficult to trace and audit with all the
> different chips and the parent chips which I don't have a good
> understanding of. But I can definitely see that it could be possible for
> some chips to change the address as smp_affinitiy will eventually
> sometimes call msi_domain_set_affinity() which does seem to recompose
> the message and write it back to the chip.
>
> So, I could relatively easily add a callback to msi_desc to catch this
> and resend the MSI address/data. However, I'm not sure how this is ever
> done atomically. It seems like there would be a race while the device
> updates its address where old interrupts could be triggered. This race
> would be much longer for us when sending this information over the NTB
> link. Though, I guess if the only change is that it encodes CPU
> information in the address then that would not be an issue. However, I'm
> not sure I can say that for certain without a comprehensive
> understanding of all the IRQ chips.
>
> Any thoughts on this?

Yeah I'm not sure what to do about it either as I'm not super familiar 
with that area either. Just making note of what I encountered. And you 
are right, the updated info has to go over NTB for the other side to 
write to the updated place. So there's a lot of latency involved.



>
> Logan
