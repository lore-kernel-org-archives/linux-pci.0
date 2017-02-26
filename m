Return-Path: <SRS0=KsSM=2H=linaro.org=linus.walleij@kernel.org>
Return-Path: <SRS0=KsSM=2H=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170131003751.GF20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170128204839.18330-2-linus.walleij@linaro.org> <20170131003751.GF20550@bhelgaas-glaptop.roam.corp.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 26 Feb 2017 20:42:51 +0100
Message-ID: <CACRpkdZ1ONM-sODoYi4isk65Eq5GUqPtfqnL9=is5s0=zObm_w@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: add driver for Cortina Gemini Host Bridge
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Janos Laube <janos.dev@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>, openwrt-devel@openwrt.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 31, 2017 at 1:37 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> Looks nice; a couple unused definitions below.

Just so I do things right:  what is your policy on unused defines?
I'm asking because the defines in this case is pretty much the
documentation... there is no datasheet for this IP core. I usually
like to keep the defines around so people can have them as a
hint if they want to tinker and hack the driver.

Would you be OK with keeping them if I comment them out?

I'll repost the driver soon, including all things asked to be
fixed up by you & Arnd.

Yours,
Linus Walleij
