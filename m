Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37104 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbbHSHWO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2015 03:22:14 -0400
MIME-Version: 1.0
In-Reply-To: <20150818042135.GZ26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
	<1438039809-24957-34-git-send-email-yinghai@kernel.org>
	<20150818042135.GZ26431@google.com>
Date: Wed, 19 Aug 2015 00:22:13 -0700
Message-ID: <CAE9FiQV1f_xEKk2Jdn+GWdhK0FsYU8AAkOpVUfzthx0C-TaJkA@mail.gmail.com>
Subject: Re: [PATCH v3 33/51] resources: Make allocate_resource return just
 fit resource
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 17, 2015 at 9:21 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 27, 2015 at 04:29:51PM -0700, Yinghai Lu wrote:
>> Find all suitable empty slots and pick one just fit, so we could save
>> the big slot for needed ones later when we have several pcie switches
>> and some bridges get assigned bios and we need to assign others in kernel.
>
> By "just fit," do you mean "best fit"?  "Best fit" is a well-known term, so
> if that's what you mean, let's use it.

Sure. Thanks for dig that URL out.

>
> I couldn't quite parse the PCIe switch stuff here.  How is that relevant to
> this change?

That is most use cases. One parent have several child bridges, and BIOS does
poor jobs and only resources to some child bridges. Kernel need to assign
for others. so before kernel start, parent resource window already have
several blank slots instead of one big chunk. then we need to make sure
first come only take best fit and leave big one for possible late comer.

>
> Allocating memory and building a list in a function that allocates space
> seems like a little bit of a hack.  I think we're holding resource_lock
> anyway; can't we just find a candidate, reserve it, look for another one,
> reserve it, release the larger one, and repeat?

We need to reserve the all avail windows before pick up one window.

for examples: we have window
[0xc0000000, 0xd0000000), and [0xe0000000,0xe1000000)

and we try allocate 0x200000 size resources.

in this patch will reserve [0xc0000000, 0xd0000000) and
[0xe0000000,0xe1000000) at first, then pick [0xe0000000,0xe1000000)
