Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 17 Sep 2018 16:19:17 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] asm-generic: io: Fix ioport_map() for
 !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO
Message-ID: <20180917151917.GB5390@e119886-lin.cambridge.arm.com>
References: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
 <464e07ab-797e-971a-0839-5fd55e3e2ad3@huawei.com>
MIME-Version: 1.0
In-Reply-To: <464e07ab-797e-971a-0839-5fd55e3e2ad3@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, suzuki.poulose@arm.com,
 jean-philippe.brucker@arm.com, dann.frazier@canonical.com,
 Will Deacon <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
 linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
 linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 17, 2018 at 03:42:32PM +0100, John Garry wrote:
> - dead e-mail addresses (Zhichang, Gabriele)
> 
> On 13/09/2018 13:48, Andrew Murray wrote:
> 
> Hi Andrew,
> 
> > The !CONFIG_GENERIC_IOMAP version of ioport_map uses MMIO_UPPER_LIMIT to
> > prevent users from making I/O accesses outside the expected I/O range -
> > however it erroneously treats MMIO_UPPER_LIMIT as a mask which is
> > contradictory to its other users.
> > 
> > The introduction of CONFIG_INDIRECT_PIO, which subtracts an arbitrary
> > amount from IO_SPACE_LIMIT to form MMIO_UPPER_LIMIT, results in ioport_map
> > mangling the given port rather than capping it.
> > 
> > We address this by aligning more closely with the CONFIG_GENERIC_IOMAP
> > implementation of ioport_map by using the comparison operator and
> > returning NULL where the port exceeds MMIO_UPPER_LIMIT. Though note that
> > we preserve the existing behavior of masking with IO_SPACE_LIMIT such that
> > we don't break existing buggy drivers that somehow rely on this masking.
> 
> I wouldn't say any drivers rely on this - for the only device driver which
> uses the "Indirect" IO space region above MMIO_UPPER_LIMIT (HiSilicon LPC),
> no child device driver for that host uses ioport_map() [those being ipmi si
> and 8250 generic+of drivers].

I was really referring to the existing !CONFIG_GENERIC_IOMAP && 
!CONFIG_INDIRECT_PIO use cases where there may be drivers (however unlikely)
that provide ioport_map an incorrect address which, due to the masking, gets
converted into a valid address. Returning NULL for these would result in new
run-time errors therefore it seemed safer to change this to support the new
"indirect IO" whilst not breaking existing bad drivers.

A more correct implementation would always return NULL if
port > IO_SPACE_LIMIT - it would fully align it with the CONFIG_GENERIC_IOMAP
implementation - in my view these two implementations should behave the same
with respect to error handling - at the moment they don't.


> 
> Regardless of that, it seems better to return NULL when the port is
> out-of-range, rather than masking it.
> 
> Cheers
> 
> > 
> > Fixes: 5745392e0c2b ("PCI: Apply the new generic I/O management on PCI IO hosts")
> > Reported-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks for the review.

Andrew Murray

> 
> > ---
> >  include/asm-generic/io.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index 66d1d45..d356f80 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -1026,7 +1026,8 @@ static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
> >  #define ioport_map ioport_map
> >  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
> >  {
> > -	return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
> > +	port &= IO_SPACE_LIMIT;
> > +	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
> >  }
> >  #endif
> > 
> > 
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
