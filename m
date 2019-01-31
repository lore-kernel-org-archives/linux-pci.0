Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761FFC169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 22:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF772084A
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 22:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfAaWkF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:40:05 -0500
Received: from ale.deltatee.com ([207.54.116.67]:51748 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfAaWkF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 17:40:05 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gpL00-0004to-7g; Thu, 31 Jan 2019 15:39:57 -0700
To:     Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
        Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>
References: <20190131185656.17972-1-logang@deltatee.com>
 <345197a6-89e6-c0de-5f7b-a646b5f396c9@intel.com>
 <bafe9db4-6d5b-0453-d7e7-e49e9293dd01@deltatee.com>
 <ea7b7c3c-8ed5-51ec-022a-7d28a5afce82@intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <29f7e3fe-5354-6156-1243-7248ffb2249f@deltatee.com>
Date:   Thu, 31 Jan 2019 15:39:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ea7b7c3c-8ed5-51ec-022a-7d28a5afce82@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: epilmore@gigaio.com, fancer.lancer@gmail.com, allenbh@gmail.com, joro@8bytes.org, bhelgaas@google.com, jdmason@kudzu.us, linux-kselftest@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, dave.jiang@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 0/9] Support using MSI interrupts in ntb_transport
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-31 1:58 p.m., Dave Jiang wrote:
> 
> On 1/31/2019 1:48 PM, Logan Gunthorpe wrote:
>>
>> On 2019-01-31 1:20 p.m., Dave Jiang wrote:
>>> Does this work when the system moves the MSI vector either via software
>>> (irqbalance) or BIOS APIC programming (some modes cause round robin
>>> behavior)?
>>
>> I don't know how irqbalance works, and I'm not sure what you are
>> referring to by BIOS APIC programming, however I would expect these
>> things would not be a problem.
>>
>> The MSI code I'm presenting here doesn't do anything crazy with the
>> interrupts, it allocates and uses them just as any PCI driver would. The
>> only real difference here is that instead of a piece of hardware sending
>> the IRQ TLP, it will be sent through the memory window (which, from the
>> OS's perspective, is just coming from an NTB hardware proxy alias).
>>
>> Logan
> Right. I did that as a hack a while back for some silicon errata 
> workaround. When the vector moves, the address for the LAPIC changes. So 
> unless it gets updated, you end up writing to the old location and lose 
> all the new interrupts. irqbalance is a user daemon that rotates the 
> system interrupts around to ensure that not all interrupts are pinned on 
> a single core. 

Yes, that would be a problem if something changes the MSI vectors out
from under us. Seems like that would be a bit difficult to do even with
regular hardware. So far I haven't seen anything that would do that. If
you know of where in the kernel this happens I'd be interested in
getting a pointer to the flow in the code. If that is the case this MSI
stuff will need to get much more complicated...

> I think it's enabled by default on several distros. 

> Although MSIX has nothing to do with the IOAPIC, the mode that the APIC 
> is programmed can have an influence on how the interrupts are delivered. 
> There are certain Intel platforms (I don't know if AMD does anything 
> like that) puts the IOAPIC in a certain configuration that causes the 
> interrupts to be moved in a round robin fashion. I think it's physical 
> flat mode? I don't quite recall. Normally on the low end Xeons. It's 
> probably worth doing a test run with the irqbalance daemon running and 
> make sure you traffic stream doesn't all of sudden stop.

I've tested with irqbalance running and haven't found any noticeable
difference.

Logan
