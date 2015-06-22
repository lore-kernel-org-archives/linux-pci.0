Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33108 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbFVNag (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2015 09:30:36 -0400
Received: by lbbvz5 with SMTP id vz5so60667496lbb.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2015 06:30:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434616021.3061.2.camel@pengutronix.de>
References: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
	<1434616021.3061.2.camel@pengutronix.de>
Date: Mon, 22 Jun 2015 10:30:34 -0300
Message-ID: <CAOMZO5BLQXKwVjykQVVmD1kHHm=M31RJPmgGa1Tznz8gpYwvyw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx6: Fix "BUG: scheduling while atomic" if PCIe
 switch is attached
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: =?UTF-8?Q?David_M=C3=BCller?= <dave.mueller@gmx.ch>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 5:27 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

>> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
>> index fdb9536..c63691c 100644
>> --- a/drivers/pci/host/pci-imx6.c
>> +++ b/drivers/pci/host/pci-imx6.c
>> @@ -489,7 +489,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>>                * Wait a little bit, then re-check if the link finished
>>                * the training.
>>                */
>> -             usleep_range(1000, 2000);
>> +             mdelay(20);
>
> While switching to mdelay might be the right thing to do here, you are
> also changing the timeout. This is a change in behavior and so not okay.

msleep(2) is not recommended according to Documentation/timers/timers-howto.txt.

What would be the proper fix then?

Regards,

Fabio Estevam
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
