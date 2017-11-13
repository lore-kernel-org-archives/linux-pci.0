Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43942 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdKMIFn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2017 03:05:43 -0500
MIME-Version: 1.0
In-Reply-To: <20171113070034.f546eqqbxzab2s2d@verge.net.au>
References: <20171108092806.10335-1-marek.vasut+renesas@gmail.com>
 <20171108092806.10335-3-marek.vasut+renesas@gmail.com> <20171110090918.jirrnejohfdpcxbo@verge.net.au>
 <22cec1d9-dc11-e210-d527-0f39f7b2bccd@gmail.com> <20171113070034.f546eqqbxzab2s2d@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Nov 2017 09:05:41 +0100
Message-ID: <CAMuHMdV+XhDU60PnROTii1k_1odw4o5QGebzSZqYzxBhV3V6gg@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: rcar: Add the suspend/resume for pcie-rcar driver
To: Simon Horman <horms@verge.net.au>
Cc: Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Simon,

On Mon, Nov 13, 2017 at 8:00 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Nov 10, 2017 at 10:53:07PM +0100, Marek Vasut wrote:
>> On 11/10/2017 10:09 AM, Simon Horman wrote:
>> > On Wed, Nov 08, 2017 at 10:28:06AM +0100, Marek Vasut wrote:
>> >> @@ -872,11 +902,25 @@ static const struct irq_domain_ops msi_domain_ops = {
>> >>    .map = rcar_msi_map,
>> >>  };
>> >>
>> >> +static void rcar_pcie_hw_enable_msi(struct rcar_pcie *pcie)
>> >> +{
>> >> +  struct rcar_msi *msi = &pcie->msi;
>> >> +  unsigned long base;
>> >> +
>> >> +  /* setup MSI data target */
>> >> +  base = virt_to_phys((void *)msi->pages);
>> >
>> > Why do you need to cast to void *?
>> > I expect such casting can be done implicitly.
>>
>> Because __get_free_pages() returns unsigned long and that's what's used
>> to assign msi->pages . And virt_to_phys() expects void * instead, thus
>> the cast.
>
> Right, but I don't think one should ever need to explicitly cast
> to or from void *. What mean is, can you just remove "(void *)" without

In general, I agree ("casts are evil").

> changing any behaviour?

In this particular case, there's no way around the cast, as __get_free_pages()
returns unsigned long because of historical reasons (if written today, it
would return a pointer for sure).

Other exceptions are storing integral types in of_device_id.data (which is
void *), and storing private data pointers in Scsi_Host.hostdata (which is
unsigned long).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
