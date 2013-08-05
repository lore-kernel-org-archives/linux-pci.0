Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:49985 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab3HEVJ1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 17:09:27 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so7532250oag.12
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2013 14:09:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4ANAE3ggEcaJhFvGEpP48y37CxnXedn6cFt1gscPR-gw@mail.gmail.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
	<1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
	<CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
	<CAE9FiQU3DSZGFSENxy84bQ_URurWUAh2secoq5KN7c3BVXb9OQ@mail.gmail.com>
	<20130805195149.GA19127@google.com>
	<CAE9FiQXjL+=9XqUiFCmJNkU8vedbjs82cvxjGGBZnzaWN0HgTg@mail.gmail.com>
	<CAErSpo4ANAE3ggEcaJhFvGEpP48y37CxnXedn6cFt1gscPR-gw@mail.gmail.com>
Date: Mon, 5 Aug 2013 14:09:27 -0700
Message-ID: <CAE9FiQVJZWFBvOJPna_CFo=Pt2hGXmx39Q278f+0BOwV_38oRQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in pbus_size_io()
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 5, 2013 at 1:59 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> then, we should drop that 4k capping.
>> I was thinking there could be strange or wild res with bigger than 4k.
>
> If there *were* an I/O BAR larger than 4KB, how should it be handled?
> I don't think capping the alignment to 4KB sounds like the best way.
> For example, a 16KB I/O BAR would still need to be aligned on 16KB.
>
> And I think capping to 4KB as you did above will break the powerpc
> pcibios_window_alignment() implementation.  For example, if
> pcibios_window_alignment() returned 16KB, and we later capped it to
> 4KB, we're going to allocate space for the bridge window with the
> wrong alignment.

Agree.
