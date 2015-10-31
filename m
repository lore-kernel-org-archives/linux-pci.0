Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34946 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbbJaBxY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2015 21:53:24 -0400
MIME-Version: 1.0
In-Reply-To: <5633E570.6040906@oracle.com>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
	<5633E570.6040906@oracle.com>
Date: Fri, 30 Oct 2015 18:53:23 -0700
Message-ID: <CAE9FiQU5YkwFVuEiDOCT+BDrrSLGhTiDfW7GZV6qVtBRKDBpDw@mail.gmail.com>
Subject: Re: [PATCH v8 00/61] PCI: Resource allocation cleanup for v4.4
From: Yinghai Lu <yinghai@kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 2:47 PM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> I applied patches 1-8 and 11-16 to 4.3.0-rc7 to test on sparc platforms. I
> am seeing a "can't claim BAR" message on a T4:
>
> pci 0000:04:00.0: can't claim BAR 6 [mem 0x84000000000-0x8400000ffff]:
> address conflict with 0000:04:00.0 [mem 0x84000000000-0x840007fffff]

PCI: scan_bus[/pci@400/pci@1/pci@0/pci@0/pci@0] bus no 4
  * /pci@400/pci@1/pci@0/pci@0/pci@0/display@0
    create device, devfn: 0, type: display
    class: 0x30000 device name: 0000:04:00.0
    parse addresses (80 bytes) @ fff8001fffe34f40
  start: 84000000000, end: 840007fffff, i: 10
  start: 84000800000, end: 8400081ffff, i: 14
  start: 85100000000, end: 8510000007f, i: 18
  start: 84000000000, end: 8400000ffff, i: 30

so the BAR 6 the ROM bar is overlapping with BAR0.
and the ROM bar get rejected.

Looks like only the device BAR6 is not assigned form OF?

Thanks

Yinghai
