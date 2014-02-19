Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36006 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbaBSCyh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 21:54:37 -0500
Received: by mail-pa0-f47.google.com with SMTP id kp14so17430532pab.6
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2014 18:54:37 -0800 (PST)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <CAErSpo5uxJLoX9bouNh_+J70KErqs_Y=NWuXr4s_vefJuW71yQ@mail.gmail.com>
References: <20140203160724.949a0ee5.izumi.taku@jp.fujitsu.com>
	<20140212004927.GH21057@google.com>
	<E86EADE93E2D054CBCD4E708C38D364A53C32F56@G01JPEXMBYT01>
	<CAErSpo5ycKF4Xm26z80wNrms7G5onn1ASzcU2AHy7XN1YNAYuA@mail.gmail.com>
	<CAA93t1psHnnVSbaaaJ1LsqeNzRYmNiiO9RiTggVovDVJpk4cqw@mail.gmail.com>
	<E86EADE93E2D054CBCD4E708C38D364A53C37ABC@G01JPEXMBYT01>
	<11994c276661475080d900fa8b5942a5@DM2PR05MB671.namprd05.prod.outlook.com>
	<E86EADE93E2D054CBCD4E708C38D364A53C3D4C5@G01JPEXMBYT01>
	<CAErSpo6ku31cXTPNw-Ri6=DBSpCOk25yYs4peqkKA08eWxm5dQ@mail.gmail.com>
	<CAA93t1pApi2zDk81JKiW8WK+foOdKL=tDiCJSpc9WCwSO64NdA@mail.gmail.com>
	<CAErSpo5uxJLoX9bouNh_+J70KErqs_Y=NWuXr4s_vefJuW71yQ@mail.gmail.com>
Date: Tue, 18 Feb 2014 18:54:37 -0800
Message-ID: <CAA93t1onKeRKLgJK+8tx9Tr5h4YMWFT8QEqyf=CZja13TqBjAA@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix the problem that the present bit is not
 cleared though slot is empty
From: Rajat Jain <rajatxjain@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Izumi, Taku" <izumi.taku@jp.fujitsu.com>,
	Rajat Jain <rajatjain@juniper.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	Guenter Roeck <groeck@juniper.net>,
	Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 18, 2014 at 3:02 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Feb 14, 2014 at 12:39 PM, Rajat Jain <rajatxjain@gmail.com> wrote:
>> Hi Bjorn,
>>
>> On Fri, Feb 14, 2014 at 9:31 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Fri, Feb 14, 2014 at 12:21 AM, Izumi, Taku <izumi.taku@jp.fujitsu.com> wrote:
>>>>> Hmm... I see that the Slot has a power controller. Which means that the power to the slot shall not be turned on automatically
>>>>> (by HW) when the card is plugged in. Also meaning that the link will not come up automatically - so this does not seem
>>>>> like the Link state based hotplug kicking in.
>>>>>
>>>>> What I suspect is this one:
>>>>>
>>>>> f02d1843d83b "PCI: pciehp: Remove surprise bit checks"
>>>>
>>>>   You are right.
>>>>   In case of omitting comit-f02d1843, it worked as expected.
>>>>   Slot power doesn't become ON automatically when PCIe card is inserted.
>>>
>>> OK, I dropped f02d1843d83b ("PCI: pciehp: Remove surprise bit
>>> checks").
>>
>> I think part of this commit was still good (The part that drops the
>> surprise check when a card is yanked out). That is because when a card
>> is yanked out, it shouldn't matter whether the  surprise bit is set or
>> not - its gotta go.
>>
>> Functionally, that scenario is already covered by my patches (because
>> yanking out a card will make the link go down, hence kicking off link
>> state based unplug) - thus no functional change. But just thought I'll
>> mention since you were already at this cleanup phase. (If you agree, I
>> can send a separate clean patch or you can use Takashi's one).
>
> That sounds reasonable.  Send me a patch, if you don't mind, so it's
> clear what to do here.

Just sent.

Thanks,

Rajat
