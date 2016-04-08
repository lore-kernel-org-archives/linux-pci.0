Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36460 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcDHFuW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2016 01:50:22 -0400
MIME-Version: 1.0
In-Reply-To: <CA+55aFyhXkzU_-RXNKoh83gz8XKwNqdJmGATXa+-MhT7bzvn2w@mail.gmail.com>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
	<1460074573-7481-45-git-send-email-yinghai@kernel.org>
	<CA+55aFyhXkzU_-RXNKoh83gz8XKwNqdJmGATXa+-MhT7bzvn2w@mail.gmail.com>
Date: Thu, 7 Apr 2016 22:50:20 -0700
Message-ID: <CAE9FiQVd0FzfGf0L6+DZWs+MULC7_sA6YAx+mvbeUrx+ZUSbDQ@mail.gmail.com>
Subject: Re: [PATCH v11 44/60] PCI: Add alt_size ressource allocation support
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

On Thu, Apr 7, 2016 at 5:56 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I'm not excited about the whole "alternate aligment".
>
> Maybe the kernel should just accept the smaller alignment. If the
> minimum alignment we use is bigger than necessary, then we're just
> wrong about it, and perhaps we should just use the smaller alignment
> that the bios used.

Look like I did not make it clearly in this change log.

Current kernel code sizing is searching smallest alignment, so call it
min_align scheme.

Some bios is using different way: It use smallest size instead, but it
could have bigger alignment
than min_align, so I call it alt_size scheme.

PROs for min_align: it can be used to calculate upper parent bridges
easily and safely.
CONs for min_align: it could generate more bigger required size.

PROs for alt_size: it try to search smaller size, esp for under 4G mmio space.
CONs for alt_size: it could have much bigger alignment, and need to
calculate the upper
bridge alt_size carefully. We end it up with try out to search the
upper bridge alt_size.

Current min_align code still have other problem: it can not handle block that
size is bigger than alignment, and it would generate wrong/too big align/size.

In the patch set, We
1. fix the min_align scheme to use try out way to find right min_align even
block size if bigger than block alignment.
2. add alt_size scheme, it will search alt_size/alt_align, that have
smaller size
   a. compare that with min_align/min_size, if alt_size is not smaller
than min_size
       just dump alt_size. otherwise record alt_size.
   b. later if we fail to get allocation with min_align, we retry alt_size.

So we still keep the old way as usual, and only handle some extra
corner case like
1. BIOS use small size and big align allocation, and in kernel we are doing pci
device remove or rescan.
2. We have couple layers of bridges that min_align scheme is wasting space.
and we have tight mmio under 4G.

Please let me know if I describe it clearly this time, otherwise I
would extract sample output
from patches and post here.

Thanks

Yinghai
