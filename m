Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36055 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbcDHAvW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:51:22 -0400
MIME-Version: 1.0
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Date: Thu, 7 Apr 2016 17:51:21 -0700
Message-ID: <CA+55aFy64Wv2tYiX41xFQzPpvNDvwqBv_cDmPh9usQS+KLk_Vg@mail.gmail.com>
Subject: Re: [PATCH v11 00/60] PCI: Resource allocation cleanup for v4.7
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Yinghai Lu <yinghai@kernel.org>
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

On Thu, Apr 7, 2016 at 5:15 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> After 5b28541552ef (PCI: Restrict 64-bit prefetchable bridge windows
> to 64-bit resources), we have several reports on resource allocation
> failure, and we try to fix the problem with resource clip, and find
> more problems.

Quite frankly, that commit 5b28541552ef is two years old by now, and
went into 3.16.

So whatever problems it caused are kind of water under the bridge.

It worries me a *lot* when there is then a 60-patch series to fix
those alleged problems, because my natural worry ends up being that
the series is as likely to introduce new issues as it is to fix
something that clearly people have been living with for a while now.

I'm not saying that this series is bad, but I *am* saying that at this
point, I'd much rather see this be done as much smaller series, and
merged slowly and carefully. I'm not seeing a lot of people reviewing
the code, but even *with* code review, things like "let's start
allocating from the top of the resource" tends to make me really
really nervous. Because those kinds of patches tend to show problems
even if the code itself was perfectly bug-free, just because it
changes some layout issue and hits some hardware weakness or
undocumented resource allocation issue.

Using tricks like a __weak pcibios_align_end_resource() to only
trigger on one single architecture (despite the naming) makes those
things even subtler.

So please, try to split this up sanely, and let's merge it in sane
pieces. I see that you have that M7101 quirk removal randomly in the
middle of this series, for example, and it doesn't seem to be the only
such random patch. That's entirely independent of all the other
patches in the series (and I thought I acked it already, but
whatever).

Put another way: this is less of a real targeted series, and more of a
random collection of patches. Very few people have the background to
review them, and basically nobody has the ability to test them
(although _individual_ parts of it are obviously testable).

I'd realyl like to see the misc per-device ones separated, for
example. Same for the pure cleanup ones that obviously don't change
any actual semantics. There's a number of those there. And then the
ones that do change real and generic pci allocation code need to be
done in smaller batches so that you don't have "everything changes at
once".

I tried to scan the patches, and I didn't find anything actually
_wrong_. Several looked like "that's an obvious improvement". But
several looked fairly complex, and all _together_ just looked pretty
scary.

              Linus
