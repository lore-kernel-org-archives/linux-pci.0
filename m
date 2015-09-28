Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:59457 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbbI1Tip (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2015 15:38:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Herring <robh@kernel.org>
Cc: Ley Foon Tan <lftan@altera.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 5/6] Documentation: dt-bindings: pci: altera pcie device tree binding
Date: Mon, 28 Sep 2015 21:38:33 +0200
Message-ID: <1803658.W77SUJGE4K@wuerfel>
In-Reply-To: <CAL_JsqL9eoTRa2-eeNJgVoO=0LyuaaJ87E4_BS0KocRKBXGdGA@mail.gmail.com>
References: <1442801587-3812-1-git-send-email-lftan@altera.com> <CAFiDJ59PuhRj3F288A_451pLiKnqPUKin9C2t5uuH2iNPnJfAg@mail.gmail.com> <CAL_JsqL9eoTRa2-eeNJgVoO=0LyuaaJ87E4_BS0KocRKBXGdGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 28 September 2015 12:31:36 Rob Herring wrote:
> >> > +
> >> > +Required properties:
> >> > +- compatible :       should contain "altr,pcie-root-port-1.0"
> >> > +- reg:               a list of physical base address and length for TXS and CRA.
> >> > +- reg-names: must include the following entries:
> >> > +             "Txs" or "txs": TX slave port region
> >> > +             "Cra" or "cra": Control register access region
> >>
> >> Why both cases? Can we please just have one (or none is better IMO).
> > The PCIe IP on different device families use different register names.
> > And our device tree generator will auto generate the register names
> > based on the hardware description name. Too bad we can't change the
> > hardware description names now.
> 
> Okay, your problem to maintain. Hopefully the driver just goes by index then.
> 
> Strictly speaking, if you have undocumented bindings downstream that
> is your problem and we don't have to accept them as-is upstream. I'm
> not going to worry about that here.

Are they always in the same order? If you don't mandate any names for the
registers in the binding but just use them by index, we can keep that
bit of ugliness out of the binding and the driver and still be compatible
with all the devices.

	Arnd
