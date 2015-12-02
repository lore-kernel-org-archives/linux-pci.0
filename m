Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36459 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbLBE0I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2015 23:26:08 -0500
MIME-Version: 1.0
In-Reply-To: <565E0FC6.9040209@oracle.com>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
	<5633E570.6040906@oracle.com>
	<CAE9FiQU5YkwFVuEiDOCT+BDrrSLGhTiDfW7GZV6qVtBRKDBpDw@mail.gmail.com>
	<1448314314.15591.1.camel@oracle.com>
	<CAE9FiQWiWvOuW3gKRKSDWwPTzNAE7w=u2UiA=XSAXMscxJe2SQ@mail.gmail.com>
	<565E0FC6.9040209@oracle.com>
Date: Tue, 1 Dec 2015 20:26:06 -0800
Message-ID: <CAE9FiQVox=6O3obs7LfFsmyAg3aamEVDp1wSOG1vSxrfLZ8CAA@mail.gmail.com>
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

On Tue, Dec 1, 2015 at 1:23 PM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
> The device does work with this patch.

Good.

> Doesn't this warning mean BAR6
> resources could not be reserved which means the device driver may not be
> able to get the BAR6 resource at some point if another device grabs the
> unreserved resource?

Current sparc pci only have checking, does not have assign unassigned
bar from firmware.

because firmware does not assign resource to that BAR6, the driver may
not need that bar at all.

>
> David M had pointed out an issue with how OF driver uses the same address
> range for all ROMs enabling them only one at a time. That seems to be in
> play here in the issue I am seeing. Does this patch series need to address
> this?

That trick may have problem when we have devices under bridge. as bridge
window need to be setup at first.

If the driver really need to use that trick, it should borrow from BAR0 (MEM)
instead.

Thanks

Yinghai
