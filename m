Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35313 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbcDIF3q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 Apr 2016 01:29:46 -0400
MIME-Version: 1.0
In-Reply-To: <CA+55aFy64Wv2tYiX41xFQzPpvNDvwqBv_cDmPh9usQS+KLk_Vg@mail.gmail.com>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
	<CA+55aFy64Wv2tYiX41xFQzPpvNDvwqBv_cDmPh9usQS+KLk_Vg@mail.gmail.com>
Date: Fri, 8 Apr 2016 22:29:44 -0700
Message-ID: <CAE9FiQWisgS-5zgAtZh-evaqCGRxCponD32XU21PBBYY-Gkvxg@mail.gmail.com>
Subject: Re: [PATCH v11 00/60] PCI: Resource allocation cleanup for v4.7
From: Yinghai Lu <yinghai@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 7, 2016 at 5:51 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So please, try to split this up sanely, and let's merge it in sane
> pieces. I see that you have that M7101 quirk removal randomly in the
> middle of this series, for example, and it doesn't seem to be the only
> such random patch. That's entirely independent of all the other
> patches in the series (and I thought I acked it already, but
> whatever).

ok, I will split them in small series.

Bjorn,

Can you review patch 1 - 16, and put them into pci-next at first ?

patch 1-11: parse MEM64 for sparc and other system with OF

patch 12-16: MMIO64 allocation enhancement
        treat non-pref mmio64 if parent bridges are all pcie.
        restore old pref allocation logic if hostbridge does not support mmio64.

Bjorn Helgaas (2):
  PCI: Fix iomem_is_exclusive() checking in pci_mmap_resource()
  alpha/PCI: Only check iomem_is_exclusive() for IORESOURCE_MEM, not
IORESOURCE_IO

Yinghai Lu (58):
  PCI: Add pci_find_bus_resource()
  sparc/PCI: Use correct offset for bus address to resource
  sparc/PCI: Reserve legacy mmio after PCI mmio
  sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
  sparc/PCI: Keep resource idx order with bridge register number
  PCI: Kill wrong quirk about M7101
  powerpc/PCI: Keep resource idx order with bridge register number
  powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
  OF/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
  PCI: Check pref compatible bit for mem64 resource of PCIe device
  PCI: Only treat non-pref mmio64 as pref if all bridges have MEM_64
  PCI: Add has_mem64 for struct host_bridge
  PCI: Only treat non-pref mmio64 as pref if host bridge has mmio64
  PCI: Restore pref MMIO allocation logic for host bridge without mmio64

I will sort out others late.

Thanks

Yinghai
