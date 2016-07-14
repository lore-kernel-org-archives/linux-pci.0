Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37674 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbcGNLNu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2016 07:13:50 -0400
Received: by mail-it0-f46.google.com with SMTP id f6so67794520ith.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2016 04:13:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160707224403.3279d807@free-electrons.com>
References: <1467279152-5717-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160707224403.3279d807@free-electrons.com>
From: Marcin Wojtas <mw@semihalf.com>
Date: Thu, 14 Jul 2016 13:13:48 +0200
Message-ID: <CAPv3WKcY3wWsbqkwjH7e51jDpgSxFtru=f=Sv3AXabaHEEr0XA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] pci: Aardvark PCIe controller driver for Marvell
 Armada 3700
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Victor Gu <xigu@marvell.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

I tested MSI's, Legacy IRQ's and stability problems with configuration
space access - everything works fine, so
Tested-by: Marcin Wojtas <mw@semihalf.com>

Best regards,
Marcin

2016-07-07 22:44 GMT+02:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> Hello Bjorn,
>
> On Thu, 30 Jun 2016 11:32:29 +0200, Thomas Petazzoni wrote:
>
>> This is the third iteration of the patch series that adds a PCIe
>> controller driver for the Aardvark PCI controller, which is used on
>> Marvell Armada 3700.
>
> Have you had the chance to look into this third iteration, which
> hopefully integrates the feedback you made during your review of the
> second version?
>
> I was hoping to get this in time for 4.8, so if you have any comments,
> do not hesitate to let me know so that I can address them.
>
> Thanks!
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
