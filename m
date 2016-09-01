Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 1 Sep 2016 12:33:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [v10,2/2] PCI: Rockchip: Add Rockchip PCIe controller support
Message-ID: <20160901173348.GB9471@localhost>
References: <1471570498-3284-1-git-send-email-shawn.lin@rock-chips.com>
 <20160831181754.GA7460@roeck-us.net>
 <9075a2c1-c787-986f-31b4-4d5b7c92b771@rock-chips.com>
 <20160901163455.GA9471@localhost>
 <20160901165757.GA3253@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160901165757.GA3253@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 01, 2016 at 09:57:58AM -0700, Brian Norris wrote:
> On Thu, Sep 01, 2016 at 11:34:55AM -0500, Bjorn Helgaas wrote:
> > I can't conveniently build it, so I'm sure I've broken things.  I
> 
> Indeed, you have :)
> 
> > pushed the current work-in-progress branch to pci/host-rockchip-wip.
> > After we fix build errors and other thinkos, I'll rename it and put it
> > in -next.
> 
> I'll append a patch that gets things building and working for me. With
> that:
> 
> Tested-by: Brian Norris <briannorris@chromium.org>

Thanks, I added your fixes.
