Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A2C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 22:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153DC2086C
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 22:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfAaWwV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:52:21 -0500
Received: from ale.deltatee.com ([207.54.116.67]:51886 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfAaWwV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 17:52:21 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gpLBr-0004zn-0x; Thu, 31 Jan 2019 15:52:11 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <20190131185656.17972-1-logang@deltatee.com>
 <20190131185656.17972-3-logang@deltatee.com>
 <20190131223932.GR229773@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <74993e67-cdc5-234a-d26c-5c0177a0299a@deltatee.com>
Date:   Thu, 31 Jan 2019 15:52:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131223932.GR229773@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: marc.zyngier@arm.com, tglx@linutronix.de, epilmore@gigaio.com, fancer.lancer@gmail.com, dave.jiang@intel.com, allenbh@gmail.com, joro@8bytes.org, jdmason@kudzu.us, linux-kselftest@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/9] PCI/MSI: Support allocating virtual MSI interrupts
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-31 3:39 p.m., Bjorn Helgaas wrote:
> I assume you'll merge this along with the rest of the series, so:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>> index 784fb52b9900..6458ab049852 100644
>> --- a/include/linux/msi.h
>> +++ b/include/linux/msi.h
>> @@ -88,6 +88,7 @@ struct msi_desc {
>>  				__u8	multi_cap	: 3;
>>  				__u8	maskbit		: 1;
>>  				__u8	is_64		: 1;
>> +				__u8    is_virtual      : 1;
> 
> You did the right thing by using the same style as what's already
> here, but does anybody know why are we using __u8 and __u16 here?
> 
> Those typedefs are in include/uapi/asm-generic/int-l64.h, which
> suggests they're for things exported to user space, but I don't think
> that's the case here, so I'm wondering if we could someday replace
> these with u8 and u16.  Obviously that wouldn't be part of *this*
> series.

Yes, I was also confused by this. But I always follow the "when-in-rome"
rule. My understanding is the same as yours is that __u8 should be used
for userspace compatibility which doesn't apply here. If there is
consensus on this being wrong, I'd be happy to write a cleanup patch
that fixes it separate from this series.
>> +/*
>> + * Virtual interrupts allow for more interrupts to be allocated
>> + * than the device has interrupts for. These are not programmed
>> + * into the devices MSI-X table and must be handled by some
> 
> s/devices/device's/

Fixed for when I send v2.

Logan
