Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:44562 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281Ab3HEUws (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 16:52:48 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so7277868oah.23
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2013 13:52:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130805195149.GA19127@google.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
	<1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
	<CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
	<CAE9FiQU3DSZGFSENxy84bQ_URurWUAh2secoq5KN7c3BVXb9OQ@mail.gmail.com>
	<20130805195149.GA19127@google.com>
Date: Mon, 5 Aug 2013 13:52:47 -0700
Message-ID: <CAE9FiQXjL+=9XqUiFCmJNkU8vedbjs82cvxjGGBZnzaWN0HgTg@mail.gmail.com>
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

On Mon, Aug 5, 2013 at 12:51 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> @@ -848,8 +848,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>>               }
>>       }
>>
>> -     if (min_align > io_align)
>> -             min_align = io_align;
>> +     if (min_align > PCI_P2P_DEFAULT_IO_ALIGN)
>> +             min_align = PCI_P2P_DEFAULT_IO_ALIGN;
>
> But I still don't understand this one.  As far as I can tell,
> "min_align > 4096" can happen only for arch-specific I/O window
> requirements.  It can never happen because of a large device I/O BAR.
>
> Let's assume "min_align = window_alignment(bus, IORESOURCE_IO)" above set
> min_align to 16KB because that's what pnv_pci_window_alignment() returned.
> Why would we cap it to 4KB here?  I think we should set this:
>
>     b_res->start = 16384;
>     b_res->end = b_res->start + size0 - 1;
>     b_res->flags |= IORESOURCE_STARTALIGN;
>
> to indicate that the bridge needs a 16KB-aligned I/O window.
>
> In what case do we need to cap min_align to 4KB?
>
>>       size0 = calculate_iosize(size, min_size, size1,
>>                       resource_size(b_res), min_align);

then, we should drop that 4k capping.
I was thinking there could be strange or wild res with bigger than 4k.

Thanks

Yinghai
