Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34440 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964888AbbLQNlR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2015 08:41:17 -0500
MIME-Version: 1.0
In-Reply-To: <20151217133058.GA20372@katana>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
	<1450358557-28376-3-git-send-email-phil.edworthy@renesas.com>
	<20151217133058.GA20372@katana>
Date: Thu, 17 Dec 2015 14:41:16 +0100
Message-ID: <CAMuHMdWfOo7=g9F_qmhM65yct0P=F3QvkVkHMggBJRLA0gCPYQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: rcar: Support runtime PM link state L1 handling
 in pcie-rcar
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 17, 2015 at 2:30 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> +             /* Wait until we are in L1 */
>> +             while (!(val & L1FAEG))
>> +                     val = rcar_pci_read_reg(pcie, PMSR);
>
> No timeout?

And no cpu_relax() in each iteration.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
