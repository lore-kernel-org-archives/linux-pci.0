Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:34711 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbHFQDM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 12:03:12 -0400
Received: by iodb91 with SMTP id b91so25775501iod.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2015 09:03:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150729160701.GC31170@google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20150729160701.GC31170@google.com>
Date: Thu, 6 Aug 2015 09:03:11 -0700
Message-ID: <CAE9FiQWBuTq2gH_-UjrCrOgtgFw05=RLXXAqkWFz4cTxHPCcdA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] PCI: Fix ATS deadlock
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Gregor Dick <gdick@solarflare.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 9:07 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 20, 2015 at 07:13:49PM -0500, Bjorn Helgaas wrote:
>> Gregor reported a deadlock [1] when enabling a VF that supports ATS.
>> This series is intended to fix that.  The second patch should be enough to
>> fix the deadlock; the rest are simplification and cleanup.
>>
>> These are based on v4.2-rc2.
>>
>> [1] http://permalink.gmane.org/gmane.linux.kernel.iommu/9433
>>
>> Changes between v1 and v2:
>>   - Remove use of pci_ats_enabled() (intel-iommu.c)
>>   - Call pci_ats_queue_depth() only once per device and cache result
>>     (intel-iommu.c)
>>   - Remove pci_ats_enabled() interface
>>   - Stop caching queue depth in pci_dev to save space
>>   - Add PF refcount of how many associated VFs have ATS enabled
>>   - Add comment that ATS must be enabled on PF before on VFs
>>   - Require ATS to be disabled on all VFs and PF before changing STU
>>
>>
>> ---
>>
>> Bjorn Helgaas (11):
>>       iommu/vt-d: Cache PCI ATS state and Invalidate Queue Depth
>>       PCI: Allocate ATS struct during enumeration
>>       PCI: Embed ATS info directly into struct pci_dev
>>       PCI: Reduce size of ATS structure elements
>>       PCI: Rationalize pci_ats_queue_depth() error checking
>>       PCI: Inline the ATS setup code into pci_ats_init()
>>       PCI: Use pci_physfn() rather than looking up physfn by hand
>>       PCI: Clean up ATS error handling
>>       PCI: Move ATS declarations to linux/pci.h so they're all together
>>       PCI: Stop caching ATS Invalidate Queue Depth
>>       PCI: Remove pci_ats_enabled()
>
> I applied these to a pci/iommu branch for v4.3.  Let me know if you see any
> issues.

looks like this branch causes hang on system with qlogic/emulex cards.

exclude the branch, will make kernel work again.

Yinghai
