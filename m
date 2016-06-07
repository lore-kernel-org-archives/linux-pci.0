Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, Wenrui Li <wenrui.li@rock-chips.com>, Doug Anderson <dianders@chromium.org>, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>, Hannes Reinecke <hare@suse.de>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/3] pci: introduce read_bridge/write_bridge pci ops
Date: Tue, 07 Jun 2016 10:13:01 +0200
Message-ID: <3754686.OCbiLBzILC@wuerfel>
In-Reply-To: <20160607002822.GA1391@localhost>
References: <1464784332-3775650-1-git-send-email-arnd@arndb.de> <3585926.N1C2xx3GaB@wuerfel> <20160607002822.GA1391@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Monday, June 6, 2016 7:28:22 PM CEST Bjorn Helgaas wrote:
> The caller is performing one abstract operation: reading or writing
> config space of a PCI device.  In the caller's context, it makes no
> difference whether it's a type0 or type1 access.
> 
> Moving the test from the host bridge driver to pci_read_config_byte()
> does move a little code from the callee to the caller, and there are
> more callees than callers, so in that sense it does remove code
> overall.  If you consider a single driver by itself, I'm not sure it
> makes much difference.
> 
> The pcie-designware.c patch is a net removal of 17 lines, but that's
> not all from moving the type0/type1 test: restructuring along the same
> lines but keeping the original type0/type1 test removes about 9 lines.
> 
> Anyway, I think I'd rather work first on your RFC patches to make
> pci_host_bridge the primary structure for probing PCI.  I think
> there will be a *lot* of benefit there.

Fair enough. This series started from the review of the Rockchip
driver, and the idea was to make that one simpler, but given that
we already have several dozen drivers doing the same thing, adding
one more isn't going to have a significant impact now.

	Arnd
