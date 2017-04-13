Return-Path: <linux-arch-owner@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3 21/32] powerpc: include default ioremap_nopost() implementation
In-Reply-To: <1491952528.7236.26.camel@kernel.crashing.org>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com> <20170411122923.6285-22-lorenzo.pieralisi@arm.com> <1491917928.7236.8.camel@kernel.crashing.org> <20170411142456.GB6821@red-moon> <1491952528.7236.26.camel@kernel.crashing.org>
Date: Thu, 13 Apr 2017 13:35:47 +1000
Message-ID: <87shld9dyk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2017-04-11 at 15:24 +0100, Lorenzo Pieralisi wrote:
>> Ok, point taken. BTW, may I ask you guys to have a look into this
>> please ?
>> 
>> https://lkml.org/lkml/2017/4/6/743
>> 
>> It is a side effect of this thread (v2), not sure why <asm/io.h>
>> on powerpc has to include <linux/io.h>.
>
> Not sure how we ended up with that... it's odd indeed.
>
> Michael ? Any reason we can't just remove it ?

No ... idea.

Looks like it was added in:

commit b41e5fffe8b81fc939067d8c1c195cc79115d5a3
Author:     Emil Medve <Emilian.Medve@Freescale.com>
AuthorDate: Sat May 3 06:34:04 2008 +1000
Commit:     Paul Mackerras <paulus@samba.org>
CommitDate: Mon May 5 16:47:14 2008 +1000

    [POWERPC] devres: Add devm_ioremap_prot()
    
    We provide an ioremap_flags, so this provides a corresponding
    devm_ioremap_prot.  The slight name difference is at Ben
    Herrenschmidt's request as he plans on changing ioremap_flags to
    ioremap_prot in the future.
    
    Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
    Acked-by: Tejun Heo <htejun@gmail.com>
    Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index afae0697e8ce..e0062d73db1c 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -18,6 +18,9 @@ extern int check_legacy_ioport(unsigned long base_port);
 #define _PNPWRP		0xa79
 #define PNPBIOS_BASE	0xf000
 
+#include <linux/device.h>
+#include <linux/io.h>
+
 #include <linux/compiler.h>
 #include <asm/page.h>
 #include <asm/byteorder.h>
@@ -744,6 +747,9 @@ static inline void * bus_to_virt(unsigned long address)
 
 #define clrsetbits_8(addr, clear, set) clrsetbits(8, addr, clear, set)
 
+void __iomem *devm_ioremap_prot(struct device *dev, resource_size_t offset,
+				size_t size, unsigned long flags);
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_POWERPC_IO_H */


I'll try removing it and see what breaks.

cheers
