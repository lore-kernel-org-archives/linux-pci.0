Return-Path: <SRS0=BDIa=X7=gmail.com=geert.uytterhoeven@kernel.org>
Return-Path: <SRS0=BDIa=X7=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20161215222600.GR3439@tuxbot>
References: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1479122155-13393-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20161114221447.GH9868@bhelgaas-glaptop.roam.corp.google.com>
 <CAMuHMdUJ8Qn=dR_OMob4BO_4RmY5XemTf_UGM_oJ2VYtBa7Jiw@mail.gmail.com> <20161215222600.GR3439@tuxbot>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Dec 2016 09:33:46 +0100
Message-ID: <CAMuHMdWEejo_pwfFfsu7gZnOCDzLExfh+Y4GLD8yzQnNoH++vw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] bus: simple-pm: add support to pm clocks
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, svarbanov@mm-sol.com,
	linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Kevin Hilman <khilman@linaro.org>, Simon Horman <horms+renesas@verge.net.au>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Thu, Dec 15, 2016 at 11:26 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Tue 15 Nov 00:23 PST 2016, Geert Uytterhoeven wrote:
>> On Mon, Nov 14, 2016 at 11:14 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Mon, Nov 14, 2016 at 11:15:53AM +0000, Srinivas Kandagatla wrote:
>> >> This patch adds support to pm clocks via device tree, so that the clocks
>> >> can be turned on and off during runtime pm. This patch is required for
>> >> Qualcomm msm8996 pcie controller which sits on a bus with its own
>> >> power-domain and clocks.
>> >>
>> >> Without this patch the clock associated with the bus are never turned on.
>> >>
>> >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> >
>> > I don't see a formal maintainer for drivers/bus/simple-pm-bus.c, but I'd
>> > like an ack or at least a review from Geert or Simon.
>>
>> Thanks for letting me know!
>>
>> >> ---
>> >>  drivers/bus/simple-pm-bus.c | 13 ++++++++++++-
>> >>  1 file changed, 12 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
>> >> index c5eb46c..63b7e8c 100644
>> >> --- a/drivers/bus/simple-pm-bus.c
>> >> +++ b/drivers/bus/simple-pm-bus.c

>> >> @@ -22,17 +23,26 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
>> >>
>> >>       pm_runtime_enable(&pdev->dev);
>> >>
>> >> -     if (np)
>> >> +     if (np) {
>> >> +             of_pm_clk_add_clks(&pdev->dev);
>>
>> This should work out-of-the-box (that's the actual purpose of this driver),
>> if the platform code that registers your PM Domain would take care
>> of registering the clocks needed for PM management of the bus.

> I'm having problems finding any code that would make this work
> "out-of-the-box".  The DT binding documents a clocks property but I
> can't find any code referencing this in the kernel.
>
> I see that Srinivas interpreted your response as that we should fold the
> clocks in behind the power-domain, rather than referencing them from the
> bus - but this seems awkward and would indicate the DT binding being
> wrong. Perhaps I'm just misunderstanding the design here?

Platform-wide PM depends heavily on the platform. Instead of adding code to
handle all relevant platforms to all drivers, the generic PM Domain code is
used. The "power-domains" and corresponding PM "clocks" properties may be
added to any device name, depending on the platform.

> Which "platform code" do you refer to, can you help me by pointing me to
> the code that handles the zb_clk in the Renesas case?

See drivers/clk/renesas/clk-mstp.c:cpg_mstp_attach_dev(), which registers
the clocks that are used for PM.
If a PM Domain sets the GENPD_FLAG_PM_CLK flag, these clocks are enabled
resp. disabled by the genpd code when the device is resumed resp. suspend.

>> Adding of_pm_clk_add_clks() here will start managing all clocks of the bus,
>> which may not be wanted on all platforms.
>
> It would not be strange to do so in the "simple" implementation for the
> bus, allowing custom behavior to be implemented in a more specific
> driver for a platform with custom needs.

Doing that means every platform that doesn't want all clocks to be used for
PM need to add custom drivers, while we already handle this in genpd.
Moreover, the same functionality (some clocks are used for PM and/or the
device may be part of a power domain) is needed for non-bus devices, and
thus handled by genpd.

BTW, actually bus drivers are the case that's currently handled special: I'd
rather seen the pm_runtime_*() handling being added to plain simple-bus.
For non-bus drivers, we just add the calls to any driver that may be used on
platforms with clock and/or power domains, but for bus drivers, people wanted
a separate driver (with its own DT binding). Sigh...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
