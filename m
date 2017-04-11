Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 11 Apr 2017 15:24:56 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 21/32] powerpc: include default ioremap_nopost()
 implementation
Message-ID: <20170411142456.GB6821@red-moon>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-22-lorenzo.pieralisi@arm.com>
 <1491917928.7236.8.camel@kernel.crashing.org>
MIME-Version: 1.0
In-Reply-To: <1491917928.7236.8.camel@kernel.crashing.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 11, 2017 at 11:38:48PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-04-11 at 13:29 +0100, Lorenzo Pieralisi wrote:
> > The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and Postin=
g")
> > mandate non-posted configuration transactions. As further highlighted in
> > the PCIe specifications (4.0 - Rev0.3, "Ordering Considerations for the
> > Enhanced Configuration Access Mechanism"), through ECAM and
> > ECAM-derivative configuration mechanism, the memory mapped transactions
> > from the host CPU into Configuration Requests on the PCI express fabric
> > may create ordering problems for software because writes to memory
> > address are typically posted transactions (unless the architecture can
> > enforce through virtual address mapping non-posted write transactions
> > behaviour) but writes to Configuration Space are not posted on the PCI
> > express fabric.
> > =

> > Include the asm-generic ioremap_nopost() implementation (currently
> > falling back to ioremap_nocache()) to provide a non-posted writes
> > ioremap interface to kernel subsystems.
> =

> NAK. As explained in my reply to patch 0.

Ok, point taken. BTW, may I ask you guys to have a look into this
please ?

https://lkml.org/lkml/2017/4/6/743

It is a side effect of this thread (v2), not sure why <asm/io.h>
on powerpc has to include <linux/io.h>.

Thanks,
Lorenzo

> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > ---
> > =A0arch/powerpc/include/asm/io.h | 1 +
> > =A01 file changed, 1 insertion(+)
> > =

> > diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/i=
o.h
> > index 5ed2924..6dcd0e2 100644
> > --- a/arch/powerpc/include/asm/io.h
> > +++ b/arch/powerpc/include/asm/io.h
> > @@ -757,6 +757,7 @@ extern void __iomem *ioremap_prot(phys_addr_t addre=
ss, unsigned long size,
> > =A0extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long s=
ize);
> > > =A0#define ioremap_nocache(addr, size)	ioremap((addr), (size))
> > > =A0#define ioremap_uc(addr, size)		ioremap((addr), (size))
> > +#include <asm-generic/ioremap-nopost.h>
> > =A0
> > =A0extern void iounmap(volatile void __iomem *addr);
> > =A0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
