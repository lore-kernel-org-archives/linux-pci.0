Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
To: Thomas Gleixner <tglx@linutronix.de>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
 <e5c0bace-fcbe-de3f-b76f-0fb672562e84@arm.com>
 <310db9dd-7db6-2106-2e53-f0083b2d3758@free.fr>
 <9fffedd4-6292-b662-a588-a68fe7380af6@free.fr>
 <6e847686-43c6-11e9-6782-dec0fe81a58e@arm.com>
 <9c65e647-8395-4467-53ca-c20ed374131b@free.fr>
 <alpine.DEB.2.20.1703271644210.3616@nanos>
From: Mason <slash.tmp@free.fr>
Message-ID: <4f426de0-b24a-c8dc-76a0-d4ec607a86be@free.fr>
Date: Mon, 27 Mar 2017 17:18:23 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703271644210.3616@nanos>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Liviu Dudau <liviu.dudau@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 David Laight <david.laight@aculab.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 27/03/2017 16:46, Thomas Gleixner wrote:

> On Mon, 27 Mar 2017, Mason wrote:
>
>> On 24/03/2017 19:22, Marc Zyngier wrote:
>>
>>> You cannot directly use a pointer to a u32 in any of the bitmap
>>> operations. You need to copy the value to an unsigned long, and
>>> apply the bitmap op on that.
>>
>> On my platform, find_first_zero_bit() resolves to
>>
>>   int _find_first_zero_bit_le(const void * p, unsigned size);
>>
>> If the underlying implementation actually expects an unsigned long
>> pointer, should the function prototype be changed?
> 
> Errm? Why are you worrying about the underlying implementations?
> 
> find_first_zero_bit() is what you are supposed to use in your code. And
> that explicitely takes a unsigned long pointer.

I don't think so.

If the prototype for find_first_zero_bit() specified the first
argument as an unsigned long pointer, then the compiler would
have rejected my code like this:

  CC      drivers/pci/host/pcie-tango.o
In file included from ./include/linux/bitops.h:36:0,
                 from ./include/linux/kernel.h:10,
                 from ./include/linux/list.h:8,
                 from ./include/linux/smp.h:11,
                 from ./include/linux/irq.h:12,
                 from ./include/linux/irqchip/chained_irq.h:21,
                 from drivers/pci/host/pcie-tango.c:1:
drivers/pci/host/pcie-tango.c: In function 'tango_irq_domain_alloc':
drivers/pci/host/pcie-tango.c:122:28: error: passing argument 1 of '_find_first_zero_bit_le' from incompatible pointer type [-Werror=incompatible-pointer-types]
  pos = find_first_zero_bit(&mask, 32);
                            ^
./arch/arm/include/asm/bitops.h:199:59: note: in definition of macro 'find_first_zero_bit'
 #define find_first_zero_bit(p,sz) _find_first_zero_bit_le(p,sz)
                                                           ^
./arch/arm/include/asm/bitops.h:162:12: note: expected 'const long unsigned int *' but argument is of type 'u32 * {aka unsigned int *}'
 extern int _find_first_zero_bit_le(const unsigned long * p, unsigned size);
            ^
cc1: some warnings being treated as errors
make[1]: *** [drivers/pci/host/pcie-tango.o] Error 1
make: *** [drivers/pci/host/pcie-tango.o] Error 2


But, in fact, the compiler remained silent, specifically because
the situation on my platform is:

  #define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
  int _find_first_zero_bit_le(const void * p, unsigned size);


So I asked if the prototype could/should be changed, to have the
compiler catch the error as early as possible.

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
