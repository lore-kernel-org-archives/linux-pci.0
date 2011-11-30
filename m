Return-Path: <linux-arch-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH-RFC 1/2] tile: don't panic on iomap
Date: Wed, 30 Nov 2011 15:49:57 +0000
Cc: Chris Metcalf <cmetcalf@tilera.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Paul Mundt <lethal@linux-sh.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
References: <cover.1322592494.git.mst@redhat.com> <201111301404.41544.arnd@arndb.de> <20111130143122.GC21413@redhat.com>
In-Reply-To: <20111130143122.GC21413@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201111301549.57430.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 30 November 2011, Michael S. Tsirkin wrote:
> On Wed, Nov 30, 2011 at 02:04:41PM +0000, Arnd Bergmann wrote:
>
> > Ah, right. I didn't realize that the generic pci_iomap still attempts
> > to call ioport_map(). It would probably make sense to enclose
> > the ioport_map() call in pci_iomap() inside of #ifdef CONFIG_HAS_IOPORT.
> > It's not exactly beautiful, but probably the most correct solution
> > so that we can make any call to ioport_map() a build-time error on
> > architectures that set CONFIG_NO_IOPORT.
> 
> I'm not sure why do you want to do that.
> 

The problem is that any definition of ioport_map on architectures
that can't do it is potentially harmful. Calling panic() is
bad style as you pointed out, but simply returning NULL can
also be harmful because it's likely that some drivers are written
under the (false) assumption that ioport_map can never fail.

Getting a build-time error would be more helpful here IMHO.

	Arnd
