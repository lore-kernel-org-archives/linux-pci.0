Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:33741 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932175AbaKRVAE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 16:00:04 -0500
Date: Tue, 18 Nov 2014 22:00:00 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>,
	Kevin Hilman <khilman@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: Regression caused by "PCI: Shrink decoding-disabled window
 while sizing BARs"
Message-ID: <20141118220000.3ab0d2d9@free-electrons.com>
In-Reply-To: <CAE9FiQX0JO40EE=D88EYGwm2uRjnrX5+McTuofW6QLbS5nLMSw@mail.gmail.com>
References: <20141118105542.457d7863@free-electrons.com>
	<20141118105843.3c1651d5@free-electrons.com>
	<20141118123402.7318ec94@free-electrons.com>
	<CAErSpo4k57tdqbEYYcqEiviwoR0LCMUszECumpeL6w80xDeVfg@mail.gmail.com>
	<CAE9FiQX0JO40EE=D88EYGwm2uRjnrX5+McTuofW6QLbS5nLMSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Yinghai Lu,

On Tue, 18 Nov 2014 10:18:35 -0800, Yinghai Lu wrote:
> On Tue, Nov 18, 2014 at 6:27 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > [+cc Yinghai]
> >
> > Yes, that change (3a02517d5e2a ("PCI: Support 64-bit bridge windows if
> > we have 64-bit dma_addr_t")) is in my for-linus branch because it
> > fixes a regression and I intend to merge it for v3.18 (after we figure
> > out these issues, of course).
> >
> > I saw this warning yesterday, but haven't heard from Yinghai yet.
> 
> Will send updated version with u64 cast.

Is a u64 cast really the appropriate solution here? Have you seen my
proposed fix "[PATCH] PCI: fix probe.c warning
on !CONFIG_ARCH_DMA_ADDR_T_64BIT platforms" ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
