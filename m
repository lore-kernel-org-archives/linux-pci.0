Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33476 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbcADO4x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2016 09:56:53 -0500
MIME-Version: 1.0
In-Reply-To: <HK2PR0601MB1393CE3EA6A72D0F74498251F5F20@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
	<1450358557-28376-3-git-send-email-phil.edworthy@renesas.com>
	<20151217133058.GA20372@katana>
	<PS1PR06MB1180304088ECF5384C497E40F5E10@PS1PR06MB1180.apcprd06.prod.outlook.com>
	<20151218140412.GA4595@katana>
	<KL1PR06MB1174165C6112327548CD29DDF5E40@KL1PR06MB1174.apcprd06.prod.outlook.com>
	<CAMuHMdUKHO50n_OAhx-OcZX9FwN+dUbZCHnjP4HaPqgt3j=MzQ@mail.gmail.com>
	<HK2PR0601MB1393CE3EA6A72D0F74498251F5F20@HK2PR0601MB1393.apcprd06.prod.outlook.com>
Date: Mon, 4 Jan 2016 15:56:52 +0100
Message-ID: <CAMuHMdVthWRkwQua0bFOSkYrsiaEVWeOWEnQJBOD=8sxL-YJMQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: rcar: Support runtime PM link state L1 handling
 in pcie-rcar
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Phil,

On Mon, Jan 4, 2016 at 3:18 PM, Phil Edworthy <phil.edworthy@renesas.com> wrote:
> On 21 December 2015 13:17, Geert Uytterhoeven wrote:
>> On Mon, Dec 21, 2015 at 11:52 AM, Phil Edworthy
>> <phil.edworthy@renesas.com> wrote:
>> > On 18 December 2015 14:04, Wolfram Sang wrote:
>> >> > Since the hardware doesn't support hot plug, I believe this loop will
>> >> > always exit very quickly. Unless someone has taken a hammer to the HW
>> >> > of course.
>> >>
>> >> I know what you mean. But since readl_poll_timeout() makes it easy, we
>> >> should better be safe than sorry.
>> > Hmm, I changed the code, but now it doesn't come out of suspend unless
>> > sleep_us passed to readl_poll_timeout is 0. Any reason you can think of?
>>
>> Timers or interrupts disabled?
>>
>> Does the might_sleep_if() scream if CONFIG_DEBUG_ATOMIC_SLEEP=y?
> Yes, it does indeed scream. Would you recommend to still use readl_poll_timeout
> with sleep_us set to 0?

Seems like people hit this before: use readl_poll_timeout_atomic().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
