Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35870 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbbHGBGf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 21:06:35 -0400
Received: by igbij6 with SMTP id ij6so22278672igb.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2015 18:06:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWBuTq2gH_-UjrCrOgtgFw05=RLXXAqkWFz4cTxHPCcdA@mail.gmail.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20150729160701.GC31170@google.com>
	<CAE9FiQWBuTq2gH_-UjrCrOgtgFw05=RLXXAqkWFz4cTxHPCcdA@mail.gmail.com>
Date: Thu, 6 Aug 2015 18:06:34 -0700
Message-ID: <CAE9FiQXcj7Y+tqXPoFmYAuw-cTdpg1rzVzbkuGd-hA9O=QveXw@mail.gmail.com>
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

On Thu, Aug 6, 2015 at 9:03 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Jul 29, 2015 at 9:07 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>
>>> Bjorn Helgaas (11):
>>>       iommu/vt-d: Cache PCI ATS state and Invalidate Queue Depth
>>>       PCI: Allocate ATS struct during enumeration
>>>       PCI: Embed ATS info directly into struct pci_dev
>>>       PCI: Reduce size of ATS structure elements
>>>       PCI: Rationalize pci_ats_queue_depth() error checking
>>>       PCI: Inline the ATS setup code into pci_ats_init()
>>>       PCI: Use pci_physfn() rather than looking up physfn by hand
>>>       PCI: Clean up ATS error handling
>>>       PCI: Move ATS declarations to linux/pci.h so they're all together
>>>       PCI: Stop caching ATS Invalidate Queue Depth
>>>       PCI: Remove pci_ats_enabled()
>>
>> I applied these to a pci/iommu branch for v4.3.  Let me know if you see any
>> issues.
>
> looks like this branch causes hang on system with qlogic/emulex cards.
>
> exclude the branch, will make kernel work again.

first patch has problem:

7b98d2d02887f8d422e05323241a5fa36b2a371e is the first bad commit
commit 7b98d2d02887f8d422e05323241a5fa36b2a371e
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon Jul 20 09:10:36 2015 -0500

    iommu/vt-d: Cache PCI ATS state and Invalidate Queue Depth

    We check the ATS state (enabled/disabled) and fetch the PCI ATS Invalidate
    Queue Depth in performance-sensitive paths.  It's easy to cache these,
    which removes dependencies on PCI.

    Remember the ATS enabled state.  When enabling, read the queue depth once
    and cache it in the device_domain_info struct.  This is similar to what
    amd_iommu.c does.

    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

:040000 040000 e8597ffc4955b097ff3c80cbfa0e074c71761521
33b5491120a2aa89437b43d8020c7cce5339ab41 M    drivers
