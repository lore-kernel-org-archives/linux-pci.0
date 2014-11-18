Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:64244 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbaKRSSg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 13:18:36 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so4566410iec.39
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2014 10:18:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4k57tdqbEYYcqEiviwoR0LCMUszECumpeL6w80xDeVfg@mail.gmail.com>
References: <20141118105542.457d7863@free-electrons.com>
	<20141118105843.3c1651d5@free-electrons.com>
	<20141118123402.7318ec94@free-electrons.com>
	<CAErSpo4k57tdqbEYYcqEiviwoR0LCMUszECumpeL6w80xDeVfg@mail.gmail.com>
Date: Tue, 18 Nov 2014 10:18:35 -0800
Message-ID: <CAE9FiQX0JO40EE=D88EYGwm2uRjnrX5+McTuofW6QLbS5nLMSw@mail.gmail.com>
Subject: Re: Regression caused by "PCI: Shrink decoding-disabled window while
 sizing BARs"
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>,
	Kevin Hilman <khilman@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	=?UTF-8?Q?Gregory_Cl=C3=A9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 18, 2014 at 6:27 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Yinghai]
>
> Yes, that change (3a02517d5e2a ("PCI: Support 64-bit bridge windows if
> we have 64-bit dma_addr_t")) is in my for-linus branch because it
> fixes a regression and I intend to merge it for v3.18 (after we figure
> out these issues, of course).
>
> I saw this warning yesterday, but haven't heard from Yinghai yet.

Will send updated version with u64 cast.

Thanks

Yinghai
