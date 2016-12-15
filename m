Return-Path: <SRS0=jqRC=X6=linaro.org=bjorn.andersson@kernel.org>
Return-Path: <SRS0=jqRC=X6=linaro.org=bjorn.andersson@kernel.org>
Date: Thu, 15 Dec 2016 14:26:00 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	svarbanov@mm-sol.com, linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kevin Hilman <khilman@linaro.org>,
	Simon Horman <horms+renesas@verge.net.au>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] bus: simple-pm: add support to pm clocks
Message-ID: <20161215222600.GR3439@tuxbot>
References: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1479122155-13393-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20161114221447.GH9868@bhelgaas-glaptop.roam.corp.google.com>
 <CAMuHMdUJ8Qn=dR_OMob4BO_4RmY5XemTf_UGM_oJ2VYtBa7Jiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdUJ8Qn=dR_OMob4BO_4RmY5XemTf_UGM_oJ2VYtBa7Jiw@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue 15 Nov 00:23 PST 2016, Geert Uytterhoeven wrote:

> +cc linux-pm
> 
> On Mon, Nov 14, 2016 at 11:14 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > [+cc Geert, Kevin, Simon]
> >
> > On Mon, Nov 14, 2016 at 11:15:53AM +0000, Srinivas Kandagatla wrote:
> >> This patch adds support to pm clocks via device tree, so that the clocks
> >> can be turned on and off during runtime pm. This patch is required for
> >> Qualcomm msm8996 pcie controller which sits on a bus with its own
> >> power-domain and clocks.
> >>
> >> Without this patch the clock associated with the bus are never turned on.
> >>
> >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >
> > I don't see a formal maintainer for drivers/bus/simple-pm-bus.c, but I'd
> > like an ack or at least a review from Geert or Simon.
> 
> Thanks for letting me know!
> 
> >> ---
> >>  drivers/bus/simple-pm-bus.c | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
> >> index c5eb46c..63b7e8c 100644
> >> --- a/drivers/bus/simple-pm-bus.c
> >> +++ b/drivers/bus/simple-pm-bus.c
> >> @@ -11,6 +11,7 @@
> >>  #include <linux/module.h>
> >>  #include <linux/of_platform.h>
> >>  #include <linux/platform_device.h>
> >> +#include <linux/pm_clock.h>
> >>  #include <linux/pm_runtime.h>
> >>
> >>
> >> @@ -22,17 +23,26 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
> >>
> >>       pm_runtime_enable(&pdev->dev);
> >>
> >> -     if (np)
> >> +     if (np) {
> >> +             of_pm_clk_add_clks(&pdev->dev);
> 
> This should work out-of-the-box (that's the actual purpose of this driver),
> if the platform code that registers your PM Domain would take care
> of registering the clocks needed for PM management of the bus.
> 

Hi Geert,

I'm having problems finding any code that would make this work
"out-of-the-box".  The DT binding documents a clocks property but I
can't find any code referencing this in the kernel.

I see that Srinivas interpreted your response as that we should fold the
clocks in behind the power-domain, rather than referencing them from the
bus - but this seems awkward and would indicate the DT binding being
wrong. Perhaps I'm just misunderstanding the design here?

Which "platform code" do you refer to, can you help me by pointing me to
the code that handles the zb_clk in the Renesas case?

> Adding of_pm_clk_add_clks() here will start managing all clocks of the bus,
> which may not be wanted on all platforms.
> 

It would not be strange to do so in the "simple" implementation for the
bus, allowing custom behavior to be implemented in a more specific
driver for a platform with custom needs.

Regards,
Bjorn
