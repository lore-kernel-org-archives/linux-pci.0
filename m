Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
Date: Wed, 08 Jun 2016 17:34:08 +0200
Message-ID: <21977687.7hvSV5l0N0@wuerfel>
In-Reply-To: <20160608162750.712916ce@free-electrons.com>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <33469694.MLbpCUJe2G@wuerfel> <20160608162750.712916ce@free-electrons.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
 Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>,
 linux-pci@vger.kernel.org, Hanna Hawa <hannah@marvell.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Marcin Wojtas <mw@semihalf.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, June 8, 2016 4:27:50 PM CEST Thomas Petazzoni wrote:
> Hello,
> 
> Thanks for your review!
> 
> On Thu, 02 Jun 2016 11:35:38 +0200, Arnd Bergmann wrote:
> > On Thursday, June 2, 2016 11:09:43 AM CEST Thomas Petazzoni wrote:
> > > +               ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
> > > +                         0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
> > >   
> > 
> > Any reason for not having a 64-bit MEM prefetchable area in the example?
> > Does the host not support that?
> 
> I'll have to admit I am not sure how to find this out from the
> datasheet. My datasheet says about the PCIe controller:
> 
> """
> 64-bit PCIe address and system address space for outbound transactions
> """
> 
> So I guess this would indicate that a 64-bit MEM area is possible.
> However, since anyway the area used above is at 0xe8000000 for a length
> of 0x1000000, what would be the benefit of declaring this range as a
> 64-bit one ?
> 
> Regarding the prefetchable aspect, I couldn't find any reference in the
> datasheet. However, the original driver code explicitly errors out if
> there is no non-prefetchable memory area, so I guess prefetchable
> areas is not supported.
> 
> In of_bus_pci_get_flags(), both the 32-bit and 64-bit cases are handled
> in the same way, so is this distinction actually being used by the
> kernel?

Each device needs to have at least one non-prefetcheable range, which
is why some drivers check for that. Non-prefetchable BARs always use
32-bit addressing, so 64-bit BARs are by definition prefetchable,
but you can also have prefetchable registers in the first 4GB in some
cases.

Some devices require large prefetchable BARs (hundreds of MB, or more),
so if you have the option, you should enable that in the host, as the
16MB you have available for non-prefetchable devices is not going to be
sufficient.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
