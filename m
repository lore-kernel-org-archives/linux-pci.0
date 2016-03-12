Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35193 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbcCLBGH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2016 20:06:07 -0500
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVAPfb-PYGQoRJzXdn3NAOK-X25M9pWvR2m7_9qT5qQ+w@mail.gmail.com>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
	<1456366370-28995-7-git-send-email-yinghai@kernel.org>
	<20160310174030.GB17238@localhost>
	<CAE9FiQVAPfb-PYGQoRJzXdn3NAOK-X25M9pWvR2m7_9qT5qQ+w@mail.gmail.com>
Date: Fri, 11 Mar 2016 17:06:05 -0800
Message-ID: <CA+55aFx3=r5FUZ1JaJsc=xjvw5tV45g7RF_Szsg2atpbxpxVpw@mail.gmail.com>
Subject: Re: [PATCH v10 06/59] PCI: Kill wrong quirk about M7101
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Meelis Roos <mroos@linux.ee>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 11, 2016 at 2:08 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> Maybe Linus could have some hint about that quirk?
>
> commit 34f550135e349102bd065488eabbbb217ab27f0d
> Author: Linus Torvalds <torvalds@linuxfoundation.org>
> Date:   Fri Nov 23 15:32:20 2007 -0500
>
>     Import 2.3.49pre2

Gah. That's marked as 2007, but that's an import of a much older
change, and 2.3.49 is way back in the last century.

But I looked at the datasheet for the M1543 PMU, and can confirm that
there's nothing at e0/e2 according to that datasheet. The PMU IO bases
show up at 0x10, and the SMB IO base at 0x14 in that doc..

Those kinds of things sometimes change between revisions, and it's
possible that there were versions that had them at that e0/e2 area,
and it got moved to the standard PCI BAR locations later.

I was definitely involved in these things, but my memory just doesn't
go back far enough to haev a clue what is going on. The only one I
remember working on myself was the PIIX4 one.

Removing it based on current datasheets and a failure of a known sparc
setup sounds reasonable.

                Linus
