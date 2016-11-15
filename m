Return-Path: <srinivas.kandagatla@linaro.org>
Return-Path: <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 1/3] bus: simple-pm: add support to pm clocks
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1479122155-13393-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20161114221447.GH9868@bhelgaas-glaptop.roam.corp.google.com>
 <CAMuHMdUJ8Qn=dR_OMob4BO_4RmY5XemTf_UGM_oJ2VYtBa7Jiw@mail.gmail.com>
Cc: svarbanov@mm-sol.com, linux-pci <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@linaro.org>, Simon Horman
 <horms+renesas@verge.net.au>, Linux PM list <linux-pm@vger.kernel.org>,
 Rajendra Nayak <rnayak@codeaurora.org>,
 "Nayak, Rajendra" <rjendra@qti.qualcomm.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d61f62d1-7a7e-6d91-d278-0fd922cd77b5@linaro.org>
Date: Tue, 15 Nov 2016 11:25:31 +0000
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUJ8Qn=dR_OMob4BO_4RmY5XemTf_UGM_oJ2VYtBa7Jiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

+ Rajendra (qcom,gdsc author)

On 15/11/16 08:23, Geert Uytterhoeven wrote:
> +cc linux-pm
>
> On Mon, Nov 14, 2016 at 11:14 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> [+cc Geert, Kevin, Simon]
>>
>> On Mon, Nov 14, 2016 at 11:15:53AM +0000, Srinivas Kandagatla wrote:
>>> This patch adds support to pm clocks via device tree, so that the clocks
>>> can be turned on and off during runtime pm. This patch is required for
>>> Qualcomm msm8996 pcie controller which sits on a bus with its own
>>> power-domain and clocks.
>>>
>>> Without this patch the clock associated with the bus are never turned on.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> I don't see a formal maintainer for drivers/bus/simple-pm-bus.c, but I'd
>> like an ack or at least a review from Geert or Simon.
>
> Thanks for letting me know!
>
>>> ---
>>>  drivers/bus/simple-pm-bus.c | 13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
>>> index c5eb46c..63b7e8c 100644
>>> --- a/drivers/bus/simple-pm-bus.c
>>> +++ b/drivers/bus/simple-pm-bus.c
>>> @@ -11,6 +11,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/of_platform.h>
>>>  #include <linux/platform_device.h>
>>> +#include <linux/pm_clock.h>
>>>  #include <linux/pm_runtime.h>
>>>
>>>
>>> @@ -22,17 +23,26 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
>>>
>>>       pm_runtime_enable(&pdev->dev);
>>>
>>> -     if (np)
>>> +     if (np) {
>>> +             of_pm_clk_add_clks(&pdev->dev);
>
> This should work out-of-the-box (that's the actual purpose of this driver),
> if the platform code that registers your PM Domain would take care
> of registering the clocks needed for PM management of the bus.

Yep, if the pm domain provider takes care of the bus clks, then it would 
work.

Am guessing that the clocks property in the DT node would be read by the 
PM domain provider and enable/disable during attach/detach callbacks.
If that is true, then any device tree nodes which are not children of 
"simple-pm-bus" and consumers of power-domain provider would enable all 
(including non-bus clks) clks twice. Once in the power-domain provider 
and once in the actual driver. Is this expected behavior from 
power-domains in general?

>
> Adding of_pm_clk_add_clks() here will start managing all clocks of the bus,
> which may not be wanted on all platforms.
>
That was the purpose.


Rajendra,
Looks like qcom gdsc pm domain provider driver does not handle bus clks 
along with power-domain, Is this something we should do? Or the bus 
driver take care of it?


Thanks,
srini
>>>               of_platform_populate(np, NULL, NULL, &pdev->dev);
>>> +     }
>>>
>>>       return 0;
>>>  }
>>>
>>> +static const struct dev_pm_ops simple_pm_bus_pm_ops = {
>>> +     SET_RUNTIME_PM_OPS(pm_clk_suspend,
>>> +                        pm_clk_resume, NULL)
>>> +};
>>> +
>>>  static int simple_pm_bus_remove(struct platform_device *pdev)
>>>  {
>>>       dev_dbg(&pdev->dev, "%s\n", __func__);
>>>
>>>       pm_runtime_disable(&pdev->dev);
>>> +     pm_clk_destroy(&pdev->dev);
>>> +
>>>       return 0;
>>>  }
>>>
>>> @@ -48,6 +58,7 @@ static struct platform_driver simple_pm_bus_driver = {
>>>       .driver = {
>>>               .name = "simple-pm-bus",
>>>               .of_match_table = simple_pm_bus_of_match,
>>> +             .pm = &simple_pm_bus_pm_ops,
>>>       },
>>>  };
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
