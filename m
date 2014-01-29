Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:61196 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbaA2KGm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 05:06:42 -0500
MIME-Version: 1.0
In-Reply-To: <20140129061722.GB23833@verge.net.au>
References: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk>
	<1390754945-28142-2-git-send-email-ben.dooks@codethink.co.uk>
	<52E6559D.6090708@cogentembedded.com>
	<52E65EAD.9000909@codethink.co.uk>
	<20140129061722.GB23833@verge.net.au>
Date: Wed, 29 Jan 2014 11:06:42 +0100
Message-ID: <CAMuHMdVSWM5wYeA1OarFEv_yYCJR1FSm5Ercjyc5qtcVameSsw@mail.gmail.com>
Subject: Re: [PATCH 1/8] pci-rcar-gen2: add of match table
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Simon Horman <horms@verge.net.au>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	linux-kernel@lists.codethink.co.uk,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 29, 2014 at 7:17 AM, Simon Horman <horms@verge.net.au> wrote:
>> >>+static struct of_device_id rcar_pci_of_match[] = {
>> >>+    { .compatible = "renesas,pci-r8a7790", },
>> >
>> >    Why only H2 SoC, if the driver is for both Gen2 SoCs?
>>
>> I can add a "renesas,pci-rcar-gen2" as a fallback match however
>> I've not got anything other than an r8a7790 to test on. Also the
>> compatible properties are preferably named after the soc.
>
> I'm not sure what the "best practice" is here but I propose that
> you add both "renesas,pci-rcar-gen2" and "renesas,pci-r8a7790" now.

To the driver or to the '90 DTS?

If the DTS says

    compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2"

then the driver can just live with "renesas,pci-rcar-gen2" for now.

> And that "renesas,pci-r8a7791" can be added once the code has been
> integrated and tested on that platform.

And later we can add

    compatible = "renesas,pci-r8a7791", "renesas,pci-rcar-gen2"

to the '91 DTS if it turns out to be compatible.

If the '91 turns out to be incompatible, or partially compatible, the driver
can be updated later to handle both "renesas,pci-r8a7790" and
"renesas,pci-r8a7791" and differentiate between them.

(That's what I was instructed to do with SPI ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
