Return-Path: <rnayak@codeaurora.org>
Return-Path: <rnayak@codeaurora.org>
Subject: Re: [PATCH v4 1/3] bus: simple-pm: add support to pm clocks
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Bjorn Helgaas <helgaas@kernel.org>
References: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1479122155-13393-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20161114221447.GH9868@bhelgaas-glaptop.roam.corp.google.com>
 <CAMuHMdUJ8Qn=dR_OMob4BO_4RmY5XemTf_UGM_oJ2VYtBa7Jiw@mail.gmail.com>
 <d61f62d1-7a7e-6d91-d278-0fd922cd77b5@linaro.org>
Cc: svarbanov@mm-sol.com, linux-pci <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@linaro.org>, Simon Horman
 <horms+renesas@verge.net.au>, Linux PM list <linux-pm@vger.kernel.org>,
 "Nayak, Rajendra" <rjendra@qti.qualcomm.com>
From: "Nayak, Rajendra" <rnayak@codeaurora.org>
Message-ID: <d1bc3663-5824-32f8-a20f-1c5e28466a15@codeaurora.org>
Date: Wed, 16 Nov 2016 21:20:15 +0530
MIME-Version: 1.0
In-Reply-To: <d61f62d1-7a7e-6d91-d278-0fd922cd77b5@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hey Srini,

On 11/15/2016 4:55 PM, Srinivas Kandagatla wrote:
> + Rajendra (qcom,gdsc author)
[]..

>>
>>>> ---
>>>>  drivers/bus/simple-pm-bus.c | 13 ++++++++++++-
>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
>>>> index c5eb46c..63b7e8c 100644
>>>> --- a/drivers/bus/simple-pm-bus.c
>>>> +++ b/drivers/bus/simple-pm-bus.c
>>>> @@ -11,6 +11,7 @@
>>>>  #include <linux/module.h>
>>>>  #include <linux/of_platform.h>
>>>>  #include <linux/platform_device.h>
>>>> +#include <linux/pm_clock.h>
>>>>  #include <linux/pm_runtime.h>
>>>>
>>>>
>>>> @@ -22,17 +23,26 @@ static int simple_pm_bus_probe(struct
>>>> platform_device *pdev)
>>>>
>>>>       pm_runtime_enable(&pdev->dev);
>>>>
>>>> -     if (np)
>>>> +     if (np) {
>>>> +             of_pm_clk_add_clks(&pdev->dev);
>>
>> This should work out-of-the-box (that's the actual purpose of this
>> driver),
>> if the platform code that registers your PM Domain would take care
>> of registering the clocks needed for PM management of the bus.
>
> Yep, if the pm domain provider takes care of the bus clks, then it would
> work.
>
> Am guessing that the clocks property in the DT node would be read by the
> PM domain provider and enable/disable during attach/detach callbacks.
> If that is true, then any device tree nodes which are not children of
> "simple-pm-bus" and consumers of power-domain provider would enable all
> (including non-bus clks) clks twice. Once in the power-domain provider
> and once in the actual driver. Is this expected behavior from
> power-domains in general?
>
>>
>> Adding of_pm_clk_add_clks() here will start managing all clocks of the
>> bus,
>> which may not be wanted on all platforms.
>>
> That was the purpose.
>
>
> Rajendra,
> Looks like qcom gdsc pm domain provider driver does not handle bus clks
> along with power-domain, Is this something we should do? Or the bus
> driver take care of it?

I did post some patches to support handling of clocks associated with
gdscs [1], but it got dropped at that point since there wasn't a
real user, besides there were some open issues wrt the handling of
!CONFIG_PM cases etc.
I will revive and repost those patches again now based on the
discussions last time around.

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/362492.html

> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
