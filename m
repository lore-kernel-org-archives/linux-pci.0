Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36324 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbbDHFj4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2015 01:39:56 -0400
MIME-Version: 1.0
In-Reply-To: <1428464944.4947.69.camel@kernel.crashing.org>
References: <1428452669-24824-1-git-send-email-yinghai@kernel.org>
	<1428464944.4947.69.camel@kernel.crashing.org>
Date: Tue, 7 Apr 2015 22:39:55 -0700
Message-ID: <CAE9FiQVwKpUB2Qh+_sqO363BfZz2ueoUxe=0ZYM1SE=ONquvdA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in
 of parsing
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Miller <davem@davemloft.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@samba.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 7, 2015 at 8:49 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2015-04-07 at 17:24 -0700, Yinghai Lu wrote:
>> For device resource PREF bit setting under bridge 64-bit pref resource,
>> we need to make sure only set PREF for 64bit resource, so set IORESOUCE_MEM_64
>> for 64bit resource during of device resource flags parsing.
>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
>
> These patches (from the above BZ) aren't right for one thing: You
> shouldn't set the IORESOURCE_PREFETCH in the resource itself. This
> *will* break stuff.
>
> You can put the resource in a prefetchable region indeed, if you
> are on a PCIe-only path (though we should have some arch flag
> to check that the host bridge indeed doesn't do any prefetch,
> on powerpc we are good there).

The patch is at:

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=1a3ec5e7b00dcd9cac24efe3d65bfccf82597ce5

and we limit to set pref bit for pcie end devices mmio 64bit resource.

>
> But you can't set the "prefetch" bit on the resource because that would
> be losing the indication that this resource has side effects. This bit
> is used in some cases to enable store gathering when mmap'ing via sysfs
> and can be used for similar uses by drivers.

Any pointer for that?

>
> It's one thing to say "you can put non-prefetch BARs in prefetch windows
> on that path", it's another one to completely make the BAR looks like
> it's prefetchable when it's not.

Too hard for me to tell the difference.

        Yinghai
