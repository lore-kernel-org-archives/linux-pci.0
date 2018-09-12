Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from office2.cesnet.cz ([195.113.144.244]:51358 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbeIMAGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Sep 2018 20:06:31 -0400
From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Baruch Siach <baruch@tkos.co.il>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since =?iso-8859-1?Q?"PCI:_mvebu:_Only_remap_I/O_space_if_configured"?=
Date: Wed, 12 Sep 2018 21:00:35 +0200
MIME-Version: 1.0
Message-ID: <7745d264-5d11-42a1-b491-95887a807894@cesnet.cz>
In-Reply-To: <20180912205052.19de01a0@windsurf>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il> <20180912205052.19de01a0@windsurf>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> You mean '4.19-rc3', right?

Right, sorry.

>>>> [    1.741458] Internal error: Oops - undefined instruction:=20
>>>> 0 [#1] SMP ARM
>>>> [    1.748182] CPU: 1 PID: 72 Comm: kworker/1:2 Tainted: G  =20
>>>>      W         4.19.0-rc3 #1 =20
>>=20
>> The 'W' taint means that there was a kernel warning before. Which
>> warning was that?

I have "spidev" listed in my DT, and the kernel complains about that;=20
that's a harmelss warning. (I sent a patch which adds my particular device=20=

into the spidev driver some time ago.)=20

With kind regards,
Jan
