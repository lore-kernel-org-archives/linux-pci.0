Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger.kernel.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/9] PCI: rockchip: Cleanups against v10
Date: Thu, 01 Sep 2016 22:52:49 +0200
Message-ID: <6064818.1vCMXWIdYQ@wuerfel>
In-Reply-To: <20160901163758.14195.15725.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160901163758.14195.15725.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 1, 2016 11:43:52 AM CEST Bjorn Helgaas wrote:
> These are cleanups against 2098142ae87d, the current pci/host-rockchip
> head in my tree.  This is basically the v10 driver posting (it's not
> identical because I had already tweaked a few things and squashed in
> Brian's bug fix).

I looked over the series and everything looks good, I particularly
like the way that 	patches 7 and 8 make the code so much more readable.

	Arnd
