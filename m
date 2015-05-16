Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38751 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbEPPXA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 May 2015 11:23:00 -0400
Received: by igcau1 with SMTP id au1so19464006igc.1
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2015 08:22:59 -0700 (PDT)
Date: Sat, 16 May 2015 10:22:56 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Miller <davem@davemloft.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@samba.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
 in of parsing
Message-ID: <20150516152256.GI31666@google.com>
References: <1428452669-24824-1-git-send-email-yinghai@kernel.org>
 <1428464944.4947.69.camel@kernel.crashing.org>
 <CAE9FiQVwKpUB2Qh+_sqO363BfZz2ueoUxe=0ZYM1SE=ONquvdA@mail.gmail.com>
 <1428480074.18187.8.camel@kernel.crashing.org>
 <CAE9FiQU=SHqopf_eZWBufD5-LNo_Lv_SH=iptOhFUuPGLgcxAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQU=SHqopf_eZWBufD5-LNo_Lv_SH=iptOhFUuPGLgcxAw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 08, 2015 at 03:38:42PM -0700, Yinghai Lu wrote:
> On Wed, Apr 8, 2015 at 1:01 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> 
> > Use a different flag to indicate the BAR policy or temporarily tweak a
> > local copy of the resource flag during BAR assignment or whatever you
> > prefer to fix the original problem but do *not* change the Linux overall
> > view of that BAR to lie about prefetchability.
> 
> ok, will give it a try.

Ping, any updates on this?
