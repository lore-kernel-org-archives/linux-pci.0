Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33627 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbcCLI0G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 12 Mar 2016 03:26:06 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1603120951320.32556@math.ut.ee>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
	<1456366370-28995-7-git-send-email-yinghai@kernel.org>
	<20160310174030.GB17238@localhost>
	<CAE9FiQVAPfb-PYGQoRJzXdn3NAOK-X25M9pWvR2m7_9qT5qQ+w@mail.gmail.com>
	<alpine.LRH.2.20.1603120951320.32556@math.ut.ee>
Date: Sat, 12 Mar 2016 00:26:04 -0800
Message-ID: <CAE9FiQWeq=VssPtW86KcOuW5rLr+t5628Fid7e4RG_R_gZ+Aaw@mail.gmail.com>
Subject: Re: [PATCH v10 06/59] PCI: Kill wrong quirk about M7101
From: Yinghai Lu <yinghai@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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

On Fri, Mar 11, 2016 at 11:52 PM, Meelis Roos <mroos@linux.ee> wrote:
>> On Thu, Mar 10, 2016 at 9:40 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Wed, Feb 24, 2016 at 06:11:57PM -0800, Yinghai Lu wrote:
>> >> Meelis reported that qla2000 driver does not get loaded on one sparc system.
>> >>
>> >> schizo f00732d0: PCI host bridge to bus 0001:00
>> >> pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe01ffffff] (bus address [0x0000-0xffffff])
>> >> pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] claimed by ali7101 ACPI
>> >> pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] claimed by ali7101 SMB
>> >> pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
>> >>
>> >> So the quirk for M7101 claim the io range early.
>
> But why did it work until 4.2 and only with 4.3 the allocations broke?
>

My understanding is we really install the root bus resource and try to
do the sanitary checking
for device resource.

Or did you find exact commit between 4.2 and 4.3 cause the problem ?

Thanks

Yinghai
