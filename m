Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36480 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbaIWM2t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 08:28:49 -0400
Received: by mail-ie0-f181.google.com with SMTP id tr6so8940148ieb.26
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2014 05:28:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1411466190.3256.7.camel@pengutronix.de>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	<1411445498-20250-3-git-send-email-r65037@freescale.com>
	<1411466190.3256.7.camel@pengutronix.de>
Date: Tue, 23 Sep 2014 05:28:49 -0700
Message-ID: <CAJ+vNU30=+YXkBHjzs_4n49TSJU0CuuSx54X3M7AVg8JRSLTfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] PCI: imx6: wait the clocks to stabilize after ref_en
From: Tim Harvey <tharvey@gateworks.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 23, 2014 at 2:56 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Dienstag, den 23.09.2014, 12:11 +0800 schrieb Richard Zhu:
>> - a while delay is mandatory required after pcie_ref_clk_en
>> is set. Otherwise, the system would be hang on imx6qdl ard
>> boards, because that imx6qdl boards don't have the reset_gpio.
>> - the clocks should be stable already after the
>> "clk_prepare_enable" is return. So I think it's ok to move the
>> usleep delay after the pcie_ref_en is set.
>>
>
> You are describing a lot of the conditions around the issue, but not the
> issue itself, which makes it hard to follow your commit message. After
> looking at the code I think the problem is this (and should be described
> accordingly):
>
> For boards without a reset gpio we skip the delay between enabling the
> pcie_ref_clk and touching the RC registers for configuration. Apparently
> this hangs when the clocks are not yet settled in the DW PCIe core. So
> we need to make sure that there is always an appropriate delay between
> those two actions.
>
> I have not found this constraint anywhere in the i.MX6 Reference Manual,
> nor in the DW PCIe documents I have access to, which makes me a bit feel
> a bit unhappy about this. Richard, do you have better info on why this
> delay is needed and how long it needs to be? Or is this just empirical?
>
> In general I'm ok with this patch, but still want a confirmation from
> Tim that this doesn't break anything.

I agree with Lucas' comments and also agree that this can use some
testing. Based on my previous findings PCI link is very fragile. It
will take me a few days to get a proper test setup in a thermal
chamber with a host of boards but I will report back when I have
findings.

Tim

>
>> Signed-off-by: Richard Zhu <r65037@freescale.com>
>> ---
>>  drivers/pci/host/pci-imx6.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
>> index 233fe8a..bc4222b 100644
>> --- a/drivers/pci/host/pci-imx6.c
>> +++ b/drivers/pci/host/pci-imx6.c
>> @@ -275,15 +275,15 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>>               goto err_pcie;
>>       }
>>
>> -     /* allow the clocks to stabilize */
>> -     usleep_range(200, 500);
>> -
>>       /* power up core phy and enable ref clock */
>>       regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>>                       IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
>>       regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>>                       IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
>>
>> +     /* allow the clocks to stabilize */
>> +     usleep_range(200, 500);
>> +
>>       /* Some boards don't have PCIe reset GPIO. */
>>       if (gpio_is_valid(imx6_pcie->reset_gpio)) {
>>               gpio_set_value(imx6_pcie->reset_gpio, 0);
>
> --
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
