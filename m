Return-Path: <geert.uytterhoeven@gmail.com>
Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20161114221447.GH9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1479122155-13393-2-git-send-email-srinivas.kandagatla@linaro.org> <20161114221447.GH9868@bhelgaas-glaptop.roam.corp.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Nov 2016 09:23:13 +0100
Message-ID: <CAMuHMdUJ8Qn=dR_OMob4BO_4RmY5XemTf_UGM_oJ2VYtBa7Jiw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] bus: simple-pm: add support to pm clocks
To: Bjorn Helgaas <helgaas@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: svarbanov@mm-sol.com, linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Kevin Hilman <khilman@linaro.org>, Simon Horman <horms+renesas@verge.net.au>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

+cc linux-pm

On Mon, Nov 14, 2016 at 11:14 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Geert, Kevin, Simon]
>
> On Mon, Nov 14, 2016 at 11:15:53AM +0000, Srinivas Kandagatla wrote:
>> This patch adds support to pm clocks via device tree, so that the clocks
>> can be turned on and off during runtime pm. This patch is required for
>> Qualcomm msm8996 pcie controller which sits on a bus with its own
>> power-domain and clocks.
>>
>> Without this patch the clock associated with the bus are never turned on.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> I don't see a formal maintainer for drivers/bus/simple-pm-bus.c, but I'd
> like an ack or at least a review from Geert or Simon.

Thanks for letting me know!

>> ---
>>  drivers/bus/simple-pm-bus.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
>> index c5eb46c..63b7e8c 100644
>> --- a/drivers/bus/simple-pm-bus.c
>> +++ b/drivers/bus/simple-pm-bus.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/module.h>
>>  #include <linux/of_platform.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_clock.h>
>>  #include <linux/pm_runtime.h>
>>
>>
>> @@ -22,17 +23,26 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
>>
>>       pm_runtime_enable(&pdev->dev);
>>
>> -     if (np)
>> +     if (np) {
>> +             of_pm_clk_add_clks(&pdev->dev);

This should work out-of-the-box (that's the actual purpose of this driver),
if the platform code that registers your PM Domain would take care
of registering the clocks needed for PM management of the bus.

Adding of_pm_clk_add_clks() here will start managing all clocks of the bus,
which may not be wanted on all platforms.

>>               of_platform_populate(np, NULL, NULL, &pdev->dev);
>> +     }
>>
>>       return 0;
>>  }
>>
>> +static const struct dev_pm_ops simple_pm_bus_pm_ops = {
>> +     SET_RUNTIME_PM_OPS(pm_clk_suspend,
>> +                        pm_clk_resume, NULL)
>> +};
>> +
>>  static int simple_pm_bus_remove(struct platform_device *pdev)
>>  {
>>       dev_dbg(&pdev->dev, "%s\n", __func__);
>>
>>       pm_runtime_disable(&pdev->dev);
>> +     pm_clk_destroy(&pdev->dev);
>> +
>>       return 0;
>>  }
>>
>> @@ -48,6 +58,7 @@ static struct platform_driver simple_pm_bus_driver = {
>>       .driver = {
>>               .name = "simple-pm-bus",
>>               .of_match_table = simple_pm_bus_of_match,
>> +             .pm = &simple_pm_bus_pm_ops,
>>       },
>>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
