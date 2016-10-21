Return-Path: <jpmpinto@gmail.com>
Return-Path: <jpmpinto@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20161021162251.GD9007@localhost>
References: <20161018082549.10905-1-l.stach@pengutronix.de>
 <20161021153142.GB9007@localhost> <20161021162251.GD9007@localhost>
From: =?UTF-8?Q?Jo=C3=A3o_Pinto?= <jpmpinto@gmail.com>
Date: Fri, 21 Oct 2016 17:44:10 +0100
Message-ID: <CAMcwGNRbMKZY2m0ahd2zaJ2G1_h6O104C8brteY2eAmU0rM5CQ@mail.gmail.com>
Subject: Re: [PATCH resend] PCI: designware: fix register access before host init
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>,
	linux-pci@vger.kernel.org, Gary Bisson <gary.bisson@boundarydevices.com>,
	kernel@pengutronix.de, patchwork-lst@pengutronix.de,
	Niklas Cassel <niklas.cassel@axis.com>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>,
	jose.abreu@synopsys.com, Jesper Nilsson <jespern@axis.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi,
Sorry for replying directly from gmail, I don't have the Linux
environment ready yet :)
Niklas patch is the one that should be applied, because in the
host_init  we need to know if the iATU is in Unroll or in Legacy mode.

Thanks.

2016-10-21 17:22 GMT+01:00 Bjorn Helgaas <helgaas@kernel.org>:
> [+cc Joao, Niklas, Carlos, Jose, Jesper]
>
> On Fri, Oct 21, 2016 at 10:31:42AM -0500, Bjorn Helgaas wrote:
>> On Tue, Oct 18, 2016 at 10:25:49AM +0200, Lucas Stach wrote:
>> > The function used to determine if iATU unroll is available will read
>> > a RC register. This is not possible and will result in a system hang
>> > if the RC is still in reset, so it is only safe to call this function
>> > after host_init() has been called.
>>
>> I'm sure Joao tested a0601a470537 somewhere, so I assume this hang only
>> happens on certain systems?
>>
>> I'm wondering if this is suggesting something that's currently done
>> differently across the drivers but could be done more similarly.
>>
>> > Fixes: a0601a470537 (PCI: designware: Add iATU Unroll feature)
>> > Reported-by: Gary Bisson <gary.bisson@boundarydevices.com>
>> > Tested-by: Gary Bisson <gary.bisson@boundarydevices.com>
>> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> > ---
>> >  drivers/pci/host/pcie-designware.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>> > index 035f50c03281..74510508fafc 100644
>> > --- a/drivers/pci/host/pcie-designware.c
>> > +++ b/drivers/pci/host/pcie-designware.c
>> > @@ -637,11 +637,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>> >             }
>> >     }
>> >
>> > -   pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
>> > -
>> >     if (pp->ops->host_init)
>> >             pp->ops->host_init(pp);
>> >
>> > +   pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
>> > +
>
> Niklas suggested this exact change earlier [1], but Joao pointed out the
> problem with calling dw_pcie_iatu_unroll_enabled() after calling
> pp->ops->host_init():
>
>   dw_pcie_host_init
>     pp->ops->host_init
>       dw_pcie_setup_rc
>         dw_pcie_prog_outbound_atu
>           if (pp->iatu_unroll_enabled)
>             ...
>     pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled()
>
> We check iatu_unroll_enabled in dw_pcie_prog_outbound_atu() before it
> has been set.
>
> Niklas' second patch [2] looks like a better fix.  Can you guys take a
> look and see if you agree?
>
> [1] http://lkml.kernel.org/r/b53d5807-8199-5789-6184-e37324a1d79e@axis.com
> [2] http://lkml.kernel.org/r/1476482095-26289-1-git-send-email-niklass@axis.com
>
>> >     pp->root_bus_nr = pp->busn->start;
>> >     if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> >             bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
>> > --
>> > 2.9.3
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
