Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:31083 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbbA2Bax (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jan 2015 20:30:53 -0500
Message-ID: <54C98D25.1090004@huawei.com>
Date: Thu, 29 Jan 2015 09:30:13 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Vrabel <david.vrabel@citrix.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [Xen-devel] [PATCH v2] PCI: Add guard to avoid mapping a invalid
 msix base address
References: <1422409937-1875-1-git-send-email-wangyijing@huawei.com> <20150128181358.GA17623@google.com> <54C94F0E.5020901@oracle.com> <CAErSpo6+VHMx-CrTUFMbkBUWG-u+ueRaUJHHT=0P4OUNvrudRg@mail.gmail.com>
In-Reply-To: <CAErSpo6+VHMx-CrTUFMbkBUWG-u+ueRaUJHHT=0P4OUNvrudRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>
>> Right, I think it does.
>>
>> One question: do we need to check flags for IORESOURCE_DISABLED as well?
>> Currently IORESOURCE_DISABLED and IORESOURCE_UNSET are set together for PCI
>> so it probably doesn't matter right now but if this changes we won't want to
>> use BAR that's disabled, will we?
> 
> That's a good question.  My intent was to use IORESOURCE_DISABLED for
> cases where we don't want to even try to assign resources to a BAR,
> e.g., for BARs that want more than 4GB of space when the kernel isn't
> compiled with support for 64-bit BARs.  In that case, I intended to
> set IORESOURCE_UNSET as well.
> 
> So I think we're OK with only testing IORESOURCE_UNSET.
> 
> Yijing, do you want to expand this patch to fix
> xen_initdom_setup_msi_irqs() as well?

I'm willing to do.

Thanks!
Yijing.

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing

