Return-Path: <linux-arch-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH-RFC 1/2] tile: don't panic on iomap
Date: Tue, 29 Nov 2011 22:05:11 +0000
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Paul Mundt <lethal@linux-sh.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
References: <cover.1322592494.git.mst@redhat.com> <a3bc9cb56040258dabc7b466ea217f4515b68b7d.1322592495.git.mst@redhat.com>
In-Reply-To: <a3bc9cb56040258dabc7b466ea217f4515b68b7d.1322592495.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201111292205.11544.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 29 November 2011, Michael S. Tsirkin wrote:
> diff --git a/arch/tile/include/asm/io.h b/arch/tile/include/asm/io.h
> index c9ea165..be6090d 100644
> --- a/arch/tile/include/asm/io.h
> +++ b/arch/tile/include/asm/io.h
> @@ -204,7 +204,8 @@ static inline long ioport_panic(void)
>  
>  static inline void __iomem *ioport_map(unsigned long port, unsigned int len)
>  {
> -       return (void __iomem *) ioport_panic();
> +       pr_info("Trying to map an IO resource - it does not exit on tile.\n");
> +       return NULL;
>  }

Why not just set CONFIG_NO_IOPORT and make this unavailable at compile time?

	Arnd
