Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35876 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbbDHWim (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2015 18:38:42 -0400
MIME-Version: 1.0
In-Reply-To: <1428480074.18187.8.camel@kernel.crashing.org>
References: <1428452669-24824-1-git-send-email-yinghai@kernel.org>
	<1428464944.4947.69.camel@kernel.crashing.org>
	<CAE9FiQVwKpUB2Qh+_sqO363BfZz2ueoUxe=0ZYM1SE=ONquvdA@mail.gmail.com>
	<1428480074.18187.8.camel@kernel.crashing.org>
Date: Wed, 8 Apr 2015 15:38:42 -0700
Message-ID: <CAE9FiQU=SHqopf_eZWBufD5-LNo_Lv_SH=iptOhFUuPGLgcxAw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in
 of parsing
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
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

On Wed, Apr 8, 2015 at 1:01 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> Use a different flag to indicate the BAR policy or temporarily tweak a
> local copy of the resource flag during BAR assignment or whatever you
> prefer to fix the original problem but do *not* change the Linux overall
> view of that BAR to lie about prefetchability.

ok, will give it a try.

        Yinghai
