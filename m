Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34444 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbbJUW7k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2015 18:59:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWzRbXOZCsPueERgw1gE=LpDxEkf_sYCvyJErUr+qgzow@mail.gmail.com>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	<1444340359-8011-4-git-send-email-yinghai@kernel.org>
	<20151020215714.GI8224@localhost>
	<CAE9FiQVC+r=7NrCvwq9+1XVQD9CGf_3+-4VO9kFPSGqMTR5cBw@mail.gmail.com>
	<CAE9FiQUdKdyipTw3KSVL0Kr1FFvki5Un3NuUuXpw4TXoWi1Tpg@mail.gmail.com>
	<20151021023522.GJ8224@localhost>
	<CAE9FiQXXP8-5hNvKXuh5mu6Xu_9yFufmpZaXv0V95TwBBnxCpA@mail.gmail.com>
	<20151021185046.GD1583@localhost>
	<CAE9FiQWzRbXOZCsPueERgw1gE=LpDxEkf_sYCvyJErUr+qgzow@mail.gmail.com>
Date: Wed, 21 Oct 2015 15:59:39 -0700
Message-ID: <CAE9FiQXpdw+e2BXDwvRnzUs8D1gdngz61nXFV5xKy9TLsvEvUw@mail.gmail.com>
Subject: Re: [PATCH v7 03/60] sparc/PCI: Unify pci_register_region()
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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

On Wed, Oct 21, 2015 at 3:32 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Oct 21, 2015 at 11:50 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> Lots of other architectures have both mem32 and mem64 apertures.  You
>> haven't explained what's unique about sparc yet.  Does
>> pci_find_parent_resource() not work on sparc?  If not, is that because the
>> resource tree looks different on sparc than on other architectures?  If so,
>> is that difference something intentional that we want to keep, or should we
>> converge on a single resource tree format across all architectures?
>
> In the new pci_register_legacy_regions(), we only have root bus.
> but current pci_find_parent_resource is taking pci dev.
>
> So will need to change it to take bus instead, please check if you are ok
> with following, then I would update other two.

Never mind, I could just one dummy pci device to work around it.
so don't need to change that.

Thanks

Yinghai
