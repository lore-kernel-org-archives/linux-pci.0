Return-Path: <geert.uytterhoeven@gmail.com>
Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20160621164947.GA7603@localhost>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160606230706.20936.13086.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CAMuHMdVgLfTD-BjRZ+gVKgYE8dkDZzQ6DnYtkUs+jVPthJsEdQ@mail.gmail.com>
 <20160621142623.GA29966@localhost> <20160621154100.GA4782@cogentembedded.com> <20160621164947.GA7603@localhost>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Jun 2016 16:19:34 +0200
Message-ID: <CAMuHMdVuwniXPZszPH8jTd8x0j+f__JjT6yY04RA_gw87sQidg@mail.gmail.com>
Subject: Re: [PATCH v1 19/25] PCI: rcar Gen2: Request host bridge window resources
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Rob Herring <robh@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>, Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rfi@lists.rocketboards.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>, Ray Jui <rjui@broadcom.com>,
	linux-tegra@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
	Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Jun 21, 2016 at 6:49 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jun 21, 2016 at 06:41:00PM +0300, Valentine Barshak wrote:
>> On Tue, Jun 21, 2016 at 09:26:23AM -0500, Bjorn Helgaas wrote:
>> > On Tue, Jun 21, 2016 at 12:41:31PM +0200, Geert Uytterhoeven wrote:
>> > > On Tue, Jun 7, 2016 at 1:07 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> > > > Request host bridge window resources so they appear in ioport_resource and
>> > > > iomem_resource and are reflected in /proc/ioports and /proc/iomem.
>> > > >
>> > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> > > > ---
>> > > >  drivers/pci/host/pci-rcar-gen2.c |    4 ++++
>> > > >  1 file changed, 4 insertions(+)
>> > > >
>> > > > diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
>> > > > index 9980a4b..617a6b2 100644
>> > > > --- a/drivers/pci/host/pci-rcar-gen2.c
>> > > > +++ b/drivers/pci/host/pci-rcar-gen2.c
>> > > > @@ -194,6 +194,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
>> > > >         struct rcar_pci_priv *priv = sys->private_data;
>> > > >         void __iomem *reg = priv->reg;
>> > > >         u32 val;
>> > > > +       int ret;
>> > > >
>> > > >         pm_runtime_enable(priv->dev);
>> > > >         pm_runtime_get_sync(priv->dev);
>> > > > @@ -275,6 +276,9 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
>> > > >         /* Add PCI resources */
>> > > >         pci_add_resource(&sys->resources, &priv->io_res);
>> > > >         pci_add_resource(&sys->resources, &priv->mem_res);
>> > > > +       ret = devm_request_pci_bus_resources(priv->dev, &sys->resources);
>> > > > +       if (ret < 0)
>> > > > +               return ret;
>> > > >
>> > > >         /* Setup bus number based on platform device id / of bus-range */
>> > > >         sys->busnr = priv->busnr;
>> > >
>> > > This patch (commit 1bd019707b7c9249d34c5d348f1ef75eb4d83e89 in pci/next)
>> > > broke PCI on r8a7791/koelsch. Dmesg differences are:
>> > >
>> > >  pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
>> > > -pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>> > > -pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
>> > > -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
>> >
>> > This is probably a result of this code in drivers/pci/host/pci-rcar-gen2.c:
>> >
>> >         /*
>> >          * The controller does not support/use port I/O,
>> >          * so setup a dummy port I/O region here.
>> >          */
>> >         priv->io_res.start = priv->mem_res.start;
>> >         priv->io_res.end = priv->mem_res.end;
>> >         priv->io_res.flags = IORESOURCE_IO;
>> >
>> > We try to avoid adding dummy regions like this, but maybe we missed
>> > this one.  I haven't found any email discussion about it yet, so I
>> > don't know what the reason for this one is.  Valentine, do you
>> > remember?
>>
>> I do not, but I think I've found something in my mailbox.
>> Below is the quote from the original conversation with:
>> (Re: [PATCH] pci: Add R-Car Gen2 internal PCI support)
>>
>> [quote starts]
>>  >>+    priv->mem_res = *mem_res;
>>  >>+    /*
>>  >>+     * The controller does not support/use port I/O,
>>  >>+     * so setup a dummy port I/O region here.
>>  >>+     */
>>  >>+    priv->io_res.start = priv->mem_res.start;
>>  >>+    priv->io_res.end = priv->mem_res.end;
>>  >>+    priv->io_res.flags = IORESOURCE_IO;
>>  >>
>>  > I don't understand this.  There's no requirement (at least as far as the
>>  > PCI core is concerned) to supply an I/O aperture at all, and I think it
>>  > would be better if you didn't.
>>  >
>>  > Oh, I see ... maybe pcibios_init_resources() forces you to have an
>>  > I/O resource to avoid having it give you a default one?  And I
>>  > suppose that since you have several host bridges, these dummy I/O
>>  > regions have to be distinct.  Ugh.  Well, I guess this is something
>>  > you'd have to fix here or in the ARM code, it's up to you what to do.
>>
>>  Exactly. This is to avoid assigning default I/O resources.
>> [quote ends]
>
> Oh, right, now I remember.  Thanks for digging that out.
>
> I propose the patches below to remove the requirement for having an
> I/O space.  Any chance one of you could test them?

Thanks!
PCI seems to be working again on r8a7791/koelsch using today's pci/next,
which includes these patches. Lspci shows the USB controllers again.

/proc/iomem gained a few entries:

 ec700000-ec70ffff : /dma-controller@ec700000
 ec720000-ec72ffff : /dma-controller@ec720000
 ec740000-ec7401ff : audmapp
+ee080000-ee0810ff : /pci@ee090000
+  ee080000-ee080fff : 0000:00:01.0
+  ee081000-ee0810ff : 0000:00:02.0
 ee090000-ee090bff : /pci@ee090000
+ee0c0000-ee0c10ff : /pci@ee0d0000
+  ee0c0000-ee0c0fff : 0001:01:01.0
+  ee0c1000-ee0c10ff : 0001:01:02.0
 ee0d0000-ee0d0bff : /pci@ee0d0000
 ee300000-ee301fff : /sata@ee300000
 ee700000-ee7003ff : /ethernet@ee700000

Hence
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
