Return-Path: <SRS0=0Srs=ZO=linaro.org=linus.walleij@kernel.org>
Return-Path: <SRS0=0Srs=ZO=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170131003137.GE20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20170128204839.18330-1-linus.walleij@linaro.org> <20170131003137.GE20550@bhelgaas-glaptop.roam.corp.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Feb 2017 21:00:14 +0100
Message-ID: <CACRpkdZFHBufh1ZunKnY018_TN-s80drQ_f-KTtPoR6O5OGHrg@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: add DT bindings for Cortina Gemini PCI Host Bridge
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Janos Laube <janos.dev@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>, openwrt-devel@openwrt.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 31, 2017 at 1:31 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:

>> +- bus-range: set to <0x00 0x00> (only root bus)
>
> Why is this limited to bus 0?  Is everything completely soldered down
> with no possibility of adding or replacing PCI devices? The interrupt-map
> below suggests slots, though.  If there's a slot, we could plug in a card
> with a bridge, which would mean more than just bus 0.

I thought so because it's a NAS box (the typical usecase) but when I
dismantled it and turned it over, wow, there is indeed a MiniPCI
slot!

OK I will augment this to 0x00 0xff.

Yours,
Linus Walleij
