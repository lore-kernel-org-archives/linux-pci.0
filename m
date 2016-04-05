Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:33303 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbcDETK5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2016 15:10:57 -0400
MIME-Version: 1.0
In-Reply-To: <1459344542.2565.44.camel@pengutronix.de>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com>
	<1459344542.2565.44.camel@pengutronix.de>
Date: Tue, 5 Apr 2016 16:10:55 -0300
Message-ID: <CAOMZO5A+v01c3KAaNMM7KN_Jo7cZfouA8QhywX=MGTv_Gt3i2g@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset GPIO"
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <Richard.Zhu@freescale.com>,
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	=?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wed, Mar 30, 2016 at 10:29 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Montag, den 28.03.2016, 18:45 -0300 schrieb Fabio Estevam:
>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> Commit 5c5fb40de8f14 ("PCI: imx6: Add support for active-low reset GPIO")
>> cause regressions on some boards like MX6 Gateworks Ventana, for example.
>>
>> The reason for the breakage is that this commit sets the gpio polarity
>> in the wrong logic level.
>>
>> Also, the commit log is wrong because active-low reset GPIO is what the
>> driver used to support since the beginning.
>>
>> So keep the old behavior that ignores the gpio polarity specified in
>> the device tree and treat the PCI reset GPIO as active-low.
>>
>> Cc: <stable@vger.kernel.org> # 4.5
>> Reported-by: Krzysztof Hałasa <khalasa@piap.pl>
>> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
>
> We need to keep compatibility to existing DTs that are setting the GPIO
> active polarity in the wrong way, so this revert is correct:
>
> Acked-by: Lucas Stach <l.stach@pengutronix.de>

Any chance to get this into 4.6-rc3 to fix the regression?
