Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:34865 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbcDHGZL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Apr 2016 02:25:11 -0400
Message-ID: <1460096669.31740.19.camel@kernel.crashing.org>
Subject: Re: [PATCH v11 44/60] PCI: Add alt_size ressource allocation support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 08 Apr 2016 16:24:29 +1000
In-Reply-To: <CA+55aFyhXkzU_-RXNKoh83gz8XKwNqdJmGATXa+-MhT7bzvn2w@mail.gmail.com>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
	 <1460074573-7481-45-git-send-email-yinghai@kernel.org>
	 <CA+55aFyhXkzU_-RXNKoh83gz8XKwNqdJmGATXa+-MhT7bzvn2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2016-04-07 at 17:56 -0700, Linus Torvalds wrote:
> Maybe the kernel should just accept the smaller alignment. If the
> minimum alignment we use is bigger than necessary, then we're just
> wrong about it, and perhaps we should just use the smaller alignment
> that the bios used.
> 
> So instead of adding this notion of alternate alignment, maybe we
> should just not be so uptight about our own minimum alignment
> requirements?

On the other hand it's nice to align things at page boundaries when
these resources can possibly be mapped by user space or KVM guests...

Cheers,
Ben.

