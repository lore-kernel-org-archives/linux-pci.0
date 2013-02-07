Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	Greg KH <gregkh@linuxfoundation.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-tegra@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/14] ARM: pci: Keep pci_common_init() around after init
Date: Thu, 07 Feb 2013 02:20:05 +0100
Message-ID: <2957343.pp7RNnqk54@wuerfel>
In-Reply-To: <CACRpkdYGgdMTi0ZeMeCk5UmrndD451Pyz8L_XE=y9SPXfGGdew@mail.gmail.com>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de> <9348609.HjKCmL9u9S@wuerfel> <CACRpkdYGgdMTi0ZeMeCk5UmrndD451Pyz8L_XE=y9SPXfGGdew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 06 February 2013 18:07:53 Linus Walleij wrote:
> However it leaves the question of how much __init, __initdata
> and __initconst we have littering around. Oh, well, we'll see
> I guess.

Actually, kbuild is pretty good at warning around the
bugs there.

	Arnd
