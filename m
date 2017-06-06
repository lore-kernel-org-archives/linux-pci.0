Return-Path: <SRS0=6U8f=5L=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=6U8f=5L=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 6 Jun 2017 11:02:28 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Graeme Gregory <graeme.gregory@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Leif Lindholm <leif.lindholm@linaro.org>,
	Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH 0/2] arm64: acpi/pci: allow the firmware BAR
 configuration to be preserved
Message-ID: <20170606100228.GA20126@red-moon>
References: <20170518140553.GA22106@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_cug6cVrWP-zkptvNn3LxYk7b4Gd=iTzHHe3us3KwL3Q@mail.gmail.com>
 <20170518154708.GA30182@red-moon>
 <CAKv+Gu-NDR1PYUfOs4z-T9WoeBrYvFTTBt3XMiMg+AU76MbYBg@mail.gmail.com>
 <20170518174612.GA31373@red-moon>
 <CAKv+Gu8hVhpNrXG+JUQu8XYZtQE86d0O66J8AORWDC6Ttcp3iA@mail.gmail.com>
 <20170601161511.GB19003@red-moon>
 <CAKv+Gu9FyLuQk3hkauoRzGME1FxHPgusWQe0v8eSJaKfaX7LMA@mail.gmail.com>
 <20170606085936.GB20085@red-moon>
 <CAKv+Gu-jVGvEJY7YBxSQHu+0jtnDHG7_6Gdpac8ca4PbPggw3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv+Gu-jVGvEJY7YBxSQHu+0jtnDHG7_6Gdpac8ca4PbPggw3Q@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 06, 2017 at 09:14:26AM +0000, Ard Biesheuvel wrote:

[...]

> > Do you want me to create a branch out of these patches (inclusive of
> > another patch to fix this bus reallocation policy discrepancy) for
> > ARM64 folks to test ? Let me know, thanks !
> >
> 
> Hi Lorenzo,
> 
> Bjorn has already picked up #1, which is now in -next. I will get back
> to this topic today or tomorrow, so let me respin (including the bus
> range fix) first, ok?

Of course, I just want to help you make progress on this, I think
we need help for testing them on ARM64 systems to see how to proceed.

Thanks !
Lorenzo
