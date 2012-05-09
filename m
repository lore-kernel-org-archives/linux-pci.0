Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 May 2012 19:58:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Myron Stowe <myron.stowe@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jkosina@suse.cz>,
	Joe Perches <joe@perches.com>,
	"David Howells <dhowells@redhat.com> Jesper Juhl" <jj@chaosbits.net>
Subject: Re: [PATCH v2 2/2] arch/tile: tilegx PCI root complex support
Message-ID: <20120509165825.GB21461@redhat.com>
References: <201204072316.q37NGv8d019280@farm-0023.internal.tilera.com>
 <201204072319.q37NJgrI019382@farm-0023.internal.tilera.com>
 <alpine.LNX.2.00.1204080126300.4431@swampdragon.chaosbits.net>
 <CAErSpo6_gV1XKJ1jsDSvHo+BEORL_5wLC2YRyVG+OjVNDYbHgw@mail.gmail.com>
 <201204091359.13059.arnd@arndb.de>
 <4F8356C7.60706@tilera.com>
 <201204100914.06168.arnd@arndb.de>
 <201205091555.q49FttvG010396@farm-0027.internal.tilera.com>
 <201205091556.q49Fus3V010419@farm-0027.internal.tilera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201205091556.q49Fus3V010419@farm-0027.internal.tilera.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 08, 2012 at 05:10:17PM -0400, Chris Metcalf wrote:
> +extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);

Please don't put this here. asm-generic/pci_iomap.h already has
a declaration.

-- 
MST
