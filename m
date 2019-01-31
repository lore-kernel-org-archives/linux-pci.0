Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A16C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 22:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CE52086C
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 22:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfAaWq6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:46:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:63953 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfAaWq6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 17:46:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 14:46:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,546,1539673200"; 
   d="scan'208";a="315346639"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.255.72.219]) ([10.255.72.219])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2019 14:46:56 -0800
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
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <7e3eed52-8e3a-c472-392a-5dc5689290ae@intel.com>
Date:   Thu, 31 Jan 2019 15:46:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <29f7e3fe-5354-6156-1243-7248ffb2249f@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/31/2019 3:39 PM, Logan Gunthorpe wrote:
>
> On 2019-01-31 1:58 p.m., Dave Jiang wrote:
>> On 1/31/2019 1:48 PM, Logan Gunthorpe wrote:
>>> On 2019-01-31 1:20 p.m., Dave Jiang wrote:
>>>> Does this work when the system moves the MSI vector either via software
>>>> (irqbalance) or BIOS APIC programming (some modes cause round robin
>>>> behavior)?
>>> I don't know how irqbalance works, and I'm not sure what you are
>>> referring to by BIOS APIC programming, however I would expect these
>>> things would not be a problem.
>>>
>>> The MSI code I'm presenting here doesn't do anything crazy with the
>>> interrupts, it allocates and uses them just as any PCI driver would. The
>>> only real difference here is that instead of a piece of hardware sending
>>> the IRQ TLP, it will be sent through the memory window (which, from the
>>> OS's perspective, is just coming from an NTB hardware proxy alias).
>>>
>>> Logan
>> Right. I did that as a hack a while back for some silicon errata
>> workaround. When the vector moves, the address for the LAPIC changes. So
>> unless it gets updated, you end up writing to the old location and lose
>> all the new interrupts. irqbalance is a user daemon that rotates the
>> system interrupts around to ensure that not all interrupts are pinned on
>> a single core.
> Yes, that would be a problem if something changes the MSI vectors out
> from under us. Seems like that would be a bit difficult to do even with
> regular hardware. So far I haven't seen anything that would do that. If
> you know of where in the kernel this happens I'd be interested in
> getting a pointer to the flow in the code. If that is the case this MSI
> stuff will need to get much more complicated...

I believe irqbalance writes to the file /proc/irq/N/smp_affinity. So 
maybe take a look at the code that starts from there and see if it would 
have any impact on your stuff.


>
>> I think it's enabled by default on several distros.
>> Although MSIX has nothing to do with the IOAPIC, the mode that the APIC
>> is programmed can have an influence on how the interrupts are delivered.
>> There are certain Intel platforms (I don't know if AMD does anything
>> like that) puts the IOAPIC in a certain configuration that causes the
>> interrupts to be moved in a round robin fashion. I think it's physical
>> flat mode? I don't quite recall. Normally on the low end Xeons. It's
>> probably worth doing a test run with the irqbalance daemon running and
>> make sure you traffic stream doesn't all of sudden stop.
> I've tested with irqbalance running and haven't found any noticeable
> difference.
>
> Logan
