Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58730 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab2EXI4g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 May 2012 04:56:36 -0400
Received: by pbbrp8 with SMTP id rp8so11164809pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 24 May 2012 01:56:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXgR5w09LgWDbFzg6EajEoMLY0DHmvA8DndmvnCcBRSZg@mail.gmail.com>
References: <CAEH94Ljfjiu3MPLz8_P=1JSJS=hQVY_CJ4kZ=8Oq+0VpweGA4Q@mail.gmail.com>
	<CAJSP0QXgR5w09LgWDbFzg6EajEoMLY0DHmvA8DndmvnCcBRSZg@mail.gmail.com>
Date: Thu, 24 May 2012 16:56:35 +0800
Message-ID: <CAEH94Lh0gmHSR1ugVFg0ZhtFTahb9LQJsxjWZzwqzNLSO0aVug@mail.gmail.com>
Subject: Re: PCI: cardbus bridge
From: Zhi Yong Wu <zwu.kernel@gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: linux-pci@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2012 at 4:37 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Thu, May 24, 2012 at 9:26 AM, Zhi Yong Wu <zwu.kernel@gmail.com> wrote:
>> Does anyone let me know what cardbus bridge is used for? What is the
>> difference between it and comon pci bridge?
>
> CardBus is PCMCIA (PC Card):
>
> http://en.wikipedia.org/wiki/PC_Card#CardBus
>
> It's not used very much anymore.  There is PCI <-> PCMCIA integration
> and that's why you see it come up in PCI code.
got it. thanks.
>
>> By the way, someone usually mentioned pci host bridge, pci root
>> bridge. What the differences among them are?
>
> I'm not sure what the exact difference is.  PCI "root" bridge refers
> to the hierarchical nature of PCI, while PCI "host" bridge refers to
You mean that PCI "root" bridge is one alias of another some bridge?
> connecting the computer to the PCI bus.
I guess that PCI "host" bridge is the one which connects PCI bus 0 to
host bus, and it should be contained in PMC chipset (PCI Bridge and
Memory Controller)
>
> If you want to know the exact meanings, try the PCI and PCI Express
> specifications.
>
> Stefan



-- 
Regards,

Zhi Yong Wu
