Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <4ED7CBEA.6060005@tilera.com>
Date: Thu, 1 Dec 2011 13:48:10 -0500
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arch@vger.kernel.org>,
	Rolf Eike Beer <eike-kernel@sf-tec.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Maxin B. John" <maxin.john@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Paul Mundt <lethal@linux-sh.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] lib/devres.c: allow specifying NO_IOPORT while using
 PCI
References: <cover.1322592494.git.mst@redhat.com> <201111301404.41544.arnd@arndb.de> <20111130143122.GC21413@redhat.com> <201111301549.57430.arnd@arndb.de> <201112011815.pB1IFGZe004948@farm-0002.internal.tilera.com> <20111201184442.GA13173@google.com>
In-Reply-To: <20111201184442.GA13173@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/1/2011 1:44 PM, Tejun Heo wrote:
> Hello,
>
> On Thu, Dec 01, 2011 at 12:59:19PM -0500, Chris Metcalf wrote:
>> The tile architecture does not support IOPORT, but it does support
>> PCI and IOMEM.  We were not specifying NO_IOPORT, though, because it
>> was causing a couple of functions (pcim_iomap_regions and pcim_iomap_table)
>> that are needed to not get provided.  Moving the #ifdef fixes this
>> so that those functions and some related ones are now always provided
>> if CONFIG_PCI is true.
>>
>> Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
>   Acked-by: Tejun Heo <tj@kernel.org>
>
> Please feel free to route the change through tile.  If not, Andrew,
> can you please pick this up?

Thanks.  I'll plan to push this to Linus through the tile tree with your
Acked-by.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

