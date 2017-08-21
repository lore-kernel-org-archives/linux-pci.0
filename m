Return-Path: <SRS0=GmMG=7X=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=GmMG=7X=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170820212543.GX28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1501861696-25767-1-git-send-email-oza.oza@broadcom.com>
 <1501861696-25767-3-git-send-email-oza.oza@broadcom.com> <20170819210440.GT28977@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPeU4hycT9Kk-ObR1zZ3UUcchMxONuUOga1oJU=_+BkQOw@mail.gmail.com> <20170820212543.GX28977@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Mon, 21 Aug 2017 08:31:36 +0530
Message-ID: <CAMSpPPc2zcEyrWVJE+dtqRSjb-bNn=4AZD04=zxKrCx54oRuZw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] PCI: iproc: add device shutdown for PCI RC
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 21, 2017 at 2:55 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sun, Aug 20, 2017 at 09:06:51AM +0530, Oza Oza wrote:
>> On Sun, Aug 20, 2017 at 2:34 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Fri, Aug 04, 2017 at 09:18:16PM +0530, Oza Pawandeep wrote:
>> >> PERST must be asserted around ~500ms before the reboot is applied.
>> >>
>> >> During soft reset (e.g., "reboot" from Linux) on some iproc based SOCs
>> >> LCPLL clock and PERST both goes off simultaneously.
>> >> This will cause certain Endpoints Intel NVMe not get detected, upon
>> >> next boot sequence.
>> >>
>> >> This is specifically happening with Intel P3700 400GB series.
>> >> Endpoint is expecting the clock for some amount of time after PERST is
>> >> asserted, which is not happening in Stingray (iproc based SOC).
>> >> This causes NVMe to behave in undefined way.
>> >>
>> >> On the contrary, Intel x86 boards will have ref clock running, so we
>> >> do not see this behavior there.
>> >>
>> >> Besides, PCI spec does not stipulate about such timings.
>> >> In-fact it does not tell us, whether PCIe device should consider
>> >> refclk to be available or not to be.
>> >>
>> >> It is completely up to vendor to design their EP the way they want
>> >> with respect to ref clock availability.
>> >
>> > I am unconvinced.  Designing an endpoint that relies on ref clock
>> > timing not guaranteed by the spec does not sound like a way to build
>> > reliable hardware.
>> >
>> > The PCIe Card Electromechanical spec, r2.0, sec 2.2.3 says the clock
>> > goes inactive after PERST# goes active, but doesn't specify how long.
>> > In the absence of a spec requirement, I don't see a reason to assume
>> > other systems preserve the ref clock after PERST#, so if the Intel
>> > device requires clocks for 500ms after PERST#, we should see problems
>> > on other systems.
>>
>> The reason you do not see and most likely you will not see on any
>> other system is
>> because, the ref clock is supplied by on board oscillator.
>> when PERST# is asserted, the ref clock is still available.
>>
>> but in our case, we do not have on-board clock generator, rather we
>> rely on the clock
>> coming from SOC, so if SOC reset is issued, both PERST# and the ref
>> clock goes off simultaneously.
>
> OK.  I'm not a hardware person and will have to take your word for
> this.
>
>> please also refer to the link below which stipulate on clk being
>> active after PERST# being asserted.
>> http://www.eetimes.com/document.asp?doc_id=1279299  [Figure 2:
>> Power-down waveforms]
>
> This is just a copy of Figure 2-13 from the PCIe CEM spec I cited
> above.  It's better to cite the spec itself than an article based on
> the spec.
>
>> however I am not saying that, this article has more to claim than PCIe spec.
>> but, I think the PCIe Card Electromechanical spec leaves the margin
>> for card manufactures to design the card based on the assumption
>> that ref clock could be available after PERST#  is asserted.
>
> The only statement in the spec I'm aware of is that "Clock and JTAG go
> inactive after PERST# goes inactive."  Since there's no required time
> the clock must remain active, a robust card would not assume the clock
> is available at all after PERST.  500ms is a *huge* length of time;
> I'd be very surprised if Intel designed a card that required that.
>
> I don't feel like we really got to the root cause of this, but this
> patch only hurts the iproc reboot time, so I'm OK with it.  I was just
> hoping to avoid slowing down your reboot time.
>

I appreciate your concern and valuable inputs.

However, while writing this patch I shared the similar concern.

And, after multiple discussions this is the best we could do.
reboot is less likely in data centers,
but failing to detect the NVMe after reboot has more severe business
impact than delaying reboot by 500ms.

I will rebase both the patches on top of Lorenzo's patches, and submit v7 today.

Thanks and Regards,
Oza.

>> most of the cards do not assume that, but at the least we have seen that,
>> once particular card which behaves as per the link which I have just
>> pasted above.
>>
>> >
>> > Sec 2.2 says that on power up, the power rails must be stable at least
>> > T(PVPERL) (100ms) and reference clocks must be stable at least
>> > T(PERST-CLK) (100us) before PERST# is deasserted.  I think it's more
>> > likely the problem is here.
>> >
>> > The current iproc_pcie_reset() looks like it sleeps 100ms *after* it
>> > deasserts PERST#.  Should that be *before* deasserting PERST#?
>> >
>>
>> T(PERST-CLK) (100us) before PERST# is deasserted.
>> which we are already waiting for 250us
>>
>> T(PVPERL) (100ms), the power rail is stable much before linux comes up.
>> so I still think we are meeting power up requirements.
>>
>> >> 500ms is just based on the observation and taken as safe margin.
>> >> This patch adds platform shutdown where it should be
>> >> called in device_shutdown while reboot command is issued.
>> >> So in sequence first Endpoint Shutdown (e.g. nvme_shutdown)
>> >> followed by RC shutdown, which issues safe PERST assertion.
>> >>
>> >> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>> >> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> >> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> >>
>> >> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
>> >> index 90d2bdd..9512960 100644
>> >> --- a/drivers/pci/host/pcie-iproc-platform.c
>> >> +++ b/drivers/pci/host/pcie-iproc-platform.c
>> >> @@ -131,6 +131,13 @@ static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
>> >>       return iproc_pcie_remove(pcie);
>> >>  }
>> >>
>> >> +static void iproc_pcie_pltfm_shutdown(struct platform_device *pdev)
>> >> +{
>> >> +     struct iproc_pcie *pcie = platform_get_drvdata(pdev);
>> >> +
>> >> +     iproc_pcie_shutdown(pcie);
>> >> +}
>> >> +
>> >>  static struct platform_driver iproc_pcie_pltfm_driver = {
>> >>       .driver = {
>> >>               .name = "iproc-pcie",
>> >> @@ -138,6 +145,7 @@ static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
>> >>       },
>> >>       .probe = iproc_pcie_pltfm_probe,
>> >>       .remove = iproc_pcie_pltfm_remove,
>> >> +     .shutdown = iproc_pcie_pltfm_shutdown,
>> >>  };
>> >>  module_platform_driver(iproc_pcie_pltfm_driver);
>> >>
>> >> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>> >> index 583cee0..ee40651 100644
>> >> --- a/drivers/pci/host/pcie-iproc.c
>> >> +++ b/drivers/pci/host/pcie-iproc.c
>> >> @@ -627,7 +627,7 @@ static int iproc_pcie_config_write32(struct pci_bus *bus, unsigned int devfn,
>> >>       .write = iproc_pcie_config_write32,
>> >>  };
>> >>
>> >> -static void iproc_pcie_reset(struct iproc_pcie *pcie)
>> >> +static void iproc_pcie_perst_ctrl(struct iproc_pcie *pcie, bool assert)
>> >>  {
>> >>       u32 val;
>> >>
>> >> @@ -639,20 +639,28 @@ static void iproc_pcie_reset(struct iproc_pcie *pcie)
>> >>       if (pcie->ep_is_internal)
>> >>               return;
>> >>
>> >> -     /*
>> >> -      * Select perst_b signal as reset source. Put the device into reset,
>> >> -      * and then bring it out of reset
>> >> -      */
>> >> -     val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
>> >> -     val &= ~EP_PERST_SOURCE_SELECT & ~EP_MODE_SURVIVE_PERST &
>> >> -             ~RC_PCIE_RST_OUTPUT;
>> >> -     iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
>> >> -     udelay(250);
>> >> -
>> >> -     val |= RC_PCIE_RST_OUTPUT;
>> >> -     iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
>> >> -     msleep(100);
>> >> +     if (assert) {
>> >> +             val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
>> >> +             val &= ~EP_PERST_SOURCE_SELECT & ~EP_MODE_SURVIVE_PERST &
>> >> +                     ~RC_PCIE_RST_OUTPUT;
>> >> +             iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
>> >> +             udelay(250);
>> >> +     } else {
>> >> +             val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
>> >> +             val |= RC_PCIE_RST_OUTPUT;
>> >> +             iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
>> >> +             msleep(100);
>> >> +     }
>> >> +}
