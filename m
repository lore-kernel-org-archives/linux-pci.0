Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51711 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753370Ab2EXIhw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 May 2012 04:37:52 -0400
Received: by lahd3 with SMTP id d3so5730470lah.19
        for <linux-pci@vger.kernel.org>; Thu, 24 May 2012 01:37:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEH94Ljfjiu3MPLz8_P=1JSJS=hQVY_CJ4kZ=8Oq+0VpweGA4Q@mail.gmail.com>
References: <CAEH94Ljfjiu3MPLz8_P=1JSJS=hQVY_CJ4kZ=8Oq+0VpweGA4Q@mail.gmail.com>
Date: Thu, 24 May 2012 09:37:51 +0100
Message-ID: <CAJSP0QXgR5w09LgWDbFzg6EajEoMLY0DHmvA8DndmvnCcBRSZg@mail.gmail.com>
Subject: Re: PCI: cardbus bridge
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Zhi Yong Wu <zwu.kernel@gmail.com>
Cc: linux-pci@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2012 at 9:26 AM, Zhi Yong Wu <zwu.kernel@gmail.com> wrote:
> Does anyone let me know what cardbus bridge is used for? What is the
> difference between it and comon pci bridge?

CardBus is PCMCIA (PC Card):

http://en.wikipedia.org/wiki/PC_Card#CardBus

It's not used very much anymore.  There is PCI <-> PCMCIA integration
and that's why you see it come up in PCI code.

> By the way, someone usually mentioned pci host bridge, pci root
> bridge. What the differences among them are?

I'm not sure what the exact difference is.  PCI "root" bridge refers
to the hierarchical nature of PCI, while PCI "host" bridge refers to
connecting the computer to the PCI bus.

If you want to know the exact meanings, try the PCI and PCI Express
specifications.

Stefan
