Return-Path: <SRS0=zWEc=DI=gmail.com=geert.uytterhoeven@kernel.org>
Return-Path: <SRS0=zWEc=DI=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20171212171658.GA53955@bhelgaas-glaptop.roam.corp.google.com>
References: <1512641720-4715-1-git-send-email-geert+renesas@glider.be> <20171212171658.GA53955@bhelgaas-glaptop.roam.corp.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Dec 2017 19:07:21 +0100
Message-ID: <CAMuHMdWSML1sC+03g8YUa5N9KUuj+R7sTSRDj26oAz=OTLMjeQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: rcar: Misc error path fixes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>,
	Phil Edworthy <phil.edworthy@renesas.com>, linux-pci <linux-pci@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Dec 12, 2017 at 6:16 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Dec 07, 2017 at 11:15:18AM +0100, Geert Uytterhoeven wrote:
>> This patch series fixes two issues in the error path for the R-Car PCIe
>> host bridge driver.
>>
>> The first issue is triggered easily by not having a PCIe card inserted,
>> and may cause a crash.
>>
>> Thanks!
>>
>> Geert Uytterhoeven (2):
>>   PCI: rcar: Fix use-after-free in probe error path
>>   PCI: rcar: Handle rcar_pcie_parse_request_of_pci_ranges() failures
>>
>>  drivers/pci/host/pcie-rcar.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> The first fixes ddd535f1ea3eb27e, which appeared in v4.14-rc1.  The
> second fixes 5d2917d469faab72, which appeared in v4.5-rc1.
>
> After the merge window I normally just pull in critical fixes and
> fixes to things we merged during the window.
>
> I think the first makes sense for v4.15 because it can cause a crash
> with no obvious way to debug it.  The second one feels like v4.16
> material to me.
>
> Thoughts?  We're trying to sort out how to handle this sort of thing
> between Lorenzo and myself, so I apologize for the confusion here.

Sounds fine to me.
The first one happens all the time if no PCIe card is present.
The second one is non-critical.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
