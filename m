Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:58653 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbaIETAu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Sep 2014 15:00:50 -0400
Received: by mail-qa0-f54.google.com with SMTP id x12so11642069qac.27
        for <linux-pci@vger.kernel.org>; Fri, 05 Sep 2014 12:00:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5898856.RmRf87KNto@wuerfel>
References: <1407512045-26969-1-git-send-email-geert+renesas@glider.be>
 <20140905174122.GD8080@google.com> <20140905202044.4c166a43@free-electrons.com>
 <5898856.RmRf87KNto@wuerfel>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 5 Sep 2014 13:00:29 -0600
Message-ID: <CAErSpo4sEQN6T9knuh4U2x9BCUODJheaAf3S8+W4U4oC-C7mMA@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Fix uninitialized variable in mvebu_get_tgt_attr()
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 5, 2014 at 12:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 05 September 2014 20:20:44 Thomas Petazzoni wrote:
>> Hum, I think I would actually prefer something like:
>>
>>                 if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
>>                         rtype = IORESOURCE_IO;
>>                 else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
>>                         rtype = IORESOURCE_MEM;
>> +               else
>> +                       continue;
>>
>> So that we're explicit with the fact that we only care about I/O and
>> MEM32 resource types.
>
> Agreed, that looks better than my patch as well.

I like it better, too, but we still need the "range += rangesz" part,
so I don't think it will work.  I suppose that could be moved to the
update expression of the "for" loop.  Or, since we don't use "i" in
the loop at all, maybe we could do something like this:

    for (; range < rend; range += rangesz)
