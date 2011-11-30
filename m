Return-Path: <linux-arch-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH-RFC 1/2] tile: don't panic on iomap
Date: Wed, 30 Nov 2011 14:04:41 +0000
Cc: Chris Metcalf <cmetcalf@tilera.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Paul Mundt <lethal@linux-sh.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
References: <cover.1322592494.git.mst@redhat.com> <201111300909.18431.arnd@arndb.de> <20111130115956.GA21413@redhat.com>
In-Reply-To: <20111130115956.GA21413@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201111301404.41544.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 30 November 2011, Michael S. Tsirkin wrote:
> > > Presumably whoever wrote that architecture considered and discarded setting GENERIC_IOMAP.
> > 
> > The tile PCI controller is apparently special in that it does not map the
> > PIO region into MMIO space, or make it available in any other way, so generic
> > iomap with IOCOND is pointless. Setting NO_IPORT will still mean that drivers
> > using ioport_map will not be built. This mostly impacts the legacy (non-AHCI)
> > ATA controllers, which I assume are not used on tile anyway.
> 
> I don't object to setting NO_IPORT at all, but this won't help address
> the problem this patch is fixing, which is to use a generic pci_iomap
> on tile.

Ah, right. I didn't realize that the generic pci_iomap still attempts
to call ioport_map(). It would probably make sense to enclose
the ioport_map() call in pci_iomap() inside of #ifdef CONFIG_HAS_IOPORT.
It's not exactly beautiful, but probably the most correct solution
so that we can make any call to ioport_map() a build-time error on
architectures that set CONFIG_NO_IOPORT.

	Arnd
