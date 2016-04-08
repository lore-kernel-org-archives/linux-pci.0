Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34412 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbcDHA4r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:56:47 -0400
MIME-Version: 1.0
In-Reply-To: <1460074573-7481-45-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
	<1460074573-7481-45-git-send-email-yinghai@kernel.org>
Date: Thu, 7 Apr 2016 17:56:46 -0700
Message-ID: <CA+55aFyhXkzU_-RXNKoh83gz8XKwNqdJmGATXa+-MhT7bzvn2w@mail.gmail.com>
Subject: Re: [PATCH v11 44/60] PCI: Add alt_size ressource allocation support
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
> On system with several pcie switches, BIOS allocate very tight resources
> to the bridge bar, and it is not aligned to min_align as kernel allocation
> code.

Ok, this came in after I already replied to the other ones.

I'm not excited about the whole "alternate aligment".

Maybe the kernel should just accept the smaller alignment. If the
minimum alignment we use is bigger than necessary, then we're just
wrong about it, and perhaps we should just use the smaller alignment
that the bios used.

So instead of adding this notion of alternate alignment, maybe we
should just not be so uptight about our own minimum alignment
requirements?

                  Linus
