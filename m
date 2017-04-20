Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170420105153.GA9741@red-moon>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
 <20170419164913.19674-3-lorenzo.pieralisi@arm.com>
 <20170420105153.GA9741@red-moon>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Apr 2017 08:12:37 -0500
Message-ID: <CAErSpo4wEACDex+9LC_gmdNWO+HAi7mJM7d-3s_GjRgEhezKQw@mail.gmail.com>
Subject: Re: [PATCH v4 02/21] linux/io.h: add PCI config space remap interface
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Murali Karicheri <m-karicheri2@ti.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 5:51 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> [+ Michael]
>
> On Wed, Apr 19, 2017 at 05:48:51PM +0100, Lorenzo Pieralisi wrote:
>> The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
>> Posting") mandate non-posted configuration transactions. As further
>> highlighted in the PCIe specifications (4.0 - Rev0.3, "Ordering
>> Considerations for the Enhanced Configuration Access Mechanism"),
>> through ECAM and ECAM-derivative configuration mechanism, the memory
>> mapped transactions from the host CPU into Configuration Requests on the
>> PCI express fabric may create ordering problems for software because
>> writes to memory address are typically posted transactions (unless the
>> architecture can enforce through virtual address mapping non-posted
>> write transactions behaviour) but writes to Configuration Space are not
>> posted on the PCI express fabric.
>>
>> Current DT and ACPI host bridge controllers map PCI configuration space
>> (ECAM and ECAM-derivative) into the virtual address space through
>> ioremap() calls, that are non-cacheable device accesses on most
>> architectures, but may provide "bufferable" or "posted" write semantics
>> in architecture like eg ARM/ARM64 that allow ioremap'ed regions writes
>> to be buffered in the bus connecting the host CPU to the PCI fabric;
>> this behaviour, as underlined in the PCIe specifications, may trigger
>> transactions ordering rules and must be prevented.
>>
>> Introduce a new generic and explicit API to create a memory
>> mapping for ECAM and ECAM-derivative config space area that
>> defaults to ioremap_nocache() (which should provide a sane default
>> behaviour) but still allowing architectures on which ioremap_nocache()
>> results in posted write transactions to override the function
>> call with an arch specific implementation that complies with
>> the PCI specifications for configuration transactions.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>>  include/linux/io.h | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/include/linux/io.h b/include/linux/io.h
>> index 82ef36e..3934aba 100644
>> --- a/include/linux/io.h
>> +++ b/include/linux/io.h
>> @@ -91,6 +91,25 @@ void devm_memunmap(struct device *dev, void *addr);
>>  void *__devm_memremap_pages(struct device *dev, struct resource *res);
>>
>>  /*
>> + * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
>> + * Posting") mandate non-posted configuration transactions. There is
>> + * no ioremap API in the kernel that can guarantee non-posted write
>> + * semantics across arches so provide a default implementation for
>> + * mapping PCI config space that defaults to ioremap_nocache(); arches
>> + * should override it if they have memory mapping implementations that
>> + * guarantee non-posted writes semantics to make the memory mapping
>> + * compliant with the PCI specification.
>> + */
>> +#ifndef pci_remap_cfgspace
>> +#define pci_remap_cfgspace pci_remap_cfgspace
>> +static inline void __iomem *pci_remap_cfgspace(phys_addr_t offset,
>> +                                            size_t size)
>> +{
>> +     return ioremap_nocache(offset, size);
>> +}
>> +#endif
>> +
>> +/*
>
> As an heads-up, this patch strictly depends on:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/powerpc/include/asm/io.h?id=590c369e7ecc00be736be39ae0c62d1b5d563a51
>
> to go upstream first, otherwise we would break powerpc compilation
> (owing to powerpc including linux/io.h before ioremap_nocache() is
> defined in arch/powerpc/include/asm/io.h).
>
> If we want to decouple them I must drop the static inline and make
> it a #define, it is not ideal but we must be aware of this, I really
> want to prevent breakage if we go ahead with this set (and -next can
> hide the issue).

It looks like Stephen merges powerpc/next into linux-next before
pci/next, so this will probably be OK there.  I'll try to remember to
wait for the powerpc stuff to make it to Linus' tree during the merge
window before I send my pull request.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
