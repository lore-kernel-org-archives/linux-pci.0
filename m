Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34622 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965254AbcCPVdf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2016 17:33:35 -0400
Received: by mail-ob0-f177.google.com with SMTP id ts10so64908031obc.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2016 14:33:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOMZO5C0rvszTg0bPoSnT5zzL8EC2Vk1PVDJgB1m1FREy9ncaQ@mail.gmail.com>
References: <56D5E3DF.9030906@tekno-soft.it>
	<56D71F27.7070708@tekno-soft.it>
	<20160302195634.GA19223@localhost>
	<DBXPR04MB2706C7C2FD2348D205331998CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
	<56D80435.90408@tekno-soft.it>
	<DBXPR04MB2702F4BC78FA28DC82DCA218CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
	<56D8180A.1050708@tekno-soft.it>
	<56D84B6D.1050800@tekno-soft.it>
	<56D883AD.5060601@tekno-soft.it>
	<56DEE426.8030902@tekno-soft.it>
	<1457448829.3207.22.camel@pengutronix.de>
	<56E1B04A.9010206@tekno-soft.it>
	<56E679FE.20409@tekno-soft.it>
	<56E7ED1E.3070506@tekno-soft.it>
	<CAOMZO5C9H92mMqTPiOwMYhywBCyQuXQen3Vw==ELE-ppTtogqg@mail.gmail.com>
	<56E81C56.8060404@tekno-soft.it>
	<CAOMZO5C0rvszTg0bPoSnT5zzL8EC2Vk1PVDJgB1m1FREy9ncaQ@mail.gmail.com>
Date: Wed, 16 Mar 2016 14:33:34 -0700
Message-ID: <CAJ+vNU1TxqEfjH6jPLnStDuYTjHvt6TxFbe+QN2O5aVqwr1-Tg@mail.gmail.com>
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>,
	Roberto Fichera <kernel@tekno-soft.it>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 16, 2016 at 7:19 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Tim,
>
> On Tue, Mar 15, 2016 at 11:29 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>> On 03/15/2016 03:10 PM, Fabio Estevam wrote:
>>> On Tue, Mar 15, 2016 at 8:08 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>>>
>>>> Just to say that I've fixed the problem by asserting PERST before to drop PCIe refclk and enable
>>>> power down. PERST is finally released at the usual place.
>>> Excellent! Do you plan to submit a patch to fix this issue?
>>
>> I don't know, in my case the problem was related to the XIO2001 that require PERST to be
>> asserted before to drop PCIe refclk as reported by its datasheet:
>
> Does your board detect XIO2001 bridge with kernel 4.4.x or do you also
> need something like Roberto's changes below?
>

Fabio,

The board combination I have where an XIO2001 is connected directly to
an IMX6 is a bit different from Roberto's setup. In our configuration
the XIO2001 is on an 'expansion' board that its own local PCI clock
generation. So, in my case the XIO2001 always has a valid clock
before/during/after its reset. This is different from Roberto's
scenario. I do recall running into an issue with the XIO2001 on
another product with a different host controller that had to do with
noise on the clk prior to its reset being asserted so I am not too
surprised at what Roberto has found.

I don't specifically see an issue with a change that asserts PCI_RST#
before the CLK gets enabled then de-asserts it after at least 100ms
has expired from clock enable - I think that actually follows the
specs wording closer than what we currently do (turning o the clock
prior to assert/de-assert reset). However I get very nervous at any
change to the IMX6 PCIe init. We have found it to be very finicky
because of the lack of a proper reset.

Roberto,

Did you require the changes regarding Gen2 negotiation? My
IMX6+XIO2001 links reliably at Gen1 which makes sense for that chip.

Regards,

Tim
