Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <4ED69DD4.3060403@tilera.com>
Date: Wed, 30 Nov 2011 16:19:16 -0500
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Paul Mundt <lethal@linux-sh.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"David S. Miller" <davem@davemloft.net>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arch@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH-RFC 2/2] tile: switch to GENERIC_PCI_IOMAP
References: <cover.1322592494.git.mst@redhat.com> <c5893cb30ae99a7e3c48b3fd209c770cd55c87ef.1322592495.git.mst@redhat.com>
In-Reply-To: <c5893cb30ae99a7e3c48b3fd209c770cd55c87ef.1322592495.git.mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/29/2011 1:54 PM, Michael S. Tsirkin wrote:
> tile now has working stubs for ioport_map and ioremap
> such that the generic pci_iomap will DTRT: cast to
> pointer on memory and return NULL and log message on IO map.
>
> Switch it over to GENERIC_PCI_IOMAP.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/tile/Kconfig           |    1 +
>  arch/tile/include/asm/pci.h |    2 +-
>  arch/tile/kernel/pci.c      |   21 ---------------------
>  3 files changed, 2 insertions(+), 22 deletions(-)

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

