Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 28 Oct 2015 10:49:15 +0000
From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	Tomasz Nowicki <tn@semihalf.com>, <bhelgaas@google.com>,
	<arnd@arndb.de>, <will.deacon@arm.com>, <catalin.marinas@arm.com>,
	<rjw@rjwysocki.net>, <hanjun.guo@linaro.org>,
	<Lorenzo.Pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
	<linaro-acpi@lists.linaro.org>, <linux-pci@vger.kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<Liviu.Dudau@arm.com>, <ddaney@caviumnetworks.com>,
	<Narinder.Dhillon@caviumnetworks.com>,
	<linux-acpi@vger.kernel.org>, <robert.richter@caviumnetworks.com>,
	<wangyijing@huawei.com>, <tglx@linutronix.de>,
	<jiang.liu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<Stefano.Stabellini@eu.citrix.com>
Subject: Re: [Linaro-acpi] [PATCH V1 07/11] XEN / PCI: Remove the dependence
 on arch x86 when PCI_MMCONFIG=y
In-Reply-To: <562FB3A5.3050500@oracle.com>
Message-ID: <alpine.DEB.2.02.1510281047460.15801@kaball.uk.xensource.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-8-git-send-email-tn@semihalf.com>
 <562FAA88.3020609@linaro.org> <562FB3A5.3050500@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="1342847746-1160060852-1446029363=:15801"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--1342847746-1160060852-1446029363=:15801
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT

On Tue, 27 Oct 2015, Boris Ostrovsky wrote:
> On 10/27/2015 12:47 PM, Tomasz Nowicki wrote:
> > + Stefano
> > 
> > On 27.10.2015 17:38, Tomasz Nowicki wrote:
> > > From: Hanjun Guo <hanjun.guo@linaro.org>
> > > 
> > > In drivers/xen/pci.c, there are arch x86 dependent codes when
> > > CONFIG_PCI_MMCONFIG is enabled, since CONFIG_PCI_MMCONFIG
> > > depends on ACPI, so this will prevent XEN PCI running on other
> > > architectures using ACPI with PCI_MMCONFIG enabled (such as ARM64).
> > > 
> > > Fortunatly, it can be sloved in a simple way. In drivers/xen/pci.c,
> > > the only x86 dependent code is if ((pci_probe & PCI_PROBE_MMCONF) == 0),
> > > and it's defined in asm/pci_x86.h, the code means that
> > > if the PCI resource is not probed in PCI_PROBE_MMCONF way, just
> > > ingnore the xen mcfg init. Actually this is duplicate, because
> > > if PCI resource is not probed in PCI_PROBE_MMCONF way, the
> > > pci_mmconfig_list will be empty, and the if (list_empty())
> > > after it will do the same job.
> > > 
> > > So just remove the arch related code and the head file, this
> > > will be no functional change for x86, and also makes xen/pci.c
> > > usable for other architectures.
> > > 
> > > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > ---
> > >   drivers/xen/pci.c | 6 ------
> > >   1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
> > > index 6785ebb..9a8dbe3 100644
> > > --- a/drivers/xen/pci.c
> > > +++ b/drivers/xen/pci.c
> > > @@ -28,9 +28,6 @@
> > >   #include <asm/xen/hypervisor.h>
> > >   #include <asm/xen/hypercall.h>
> > >   #include "../pci/pci.h"
> > > -#ifdef CONFIG_PCI_MMCONFIG
> > > -#include <asm/pci_x86.h>
> > > -#endif
> 
> Assuming this still compiles on x86 now that this include file is removed
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

I think it does not:

drivers/xen/pci.c: In function ‘xen_mcfg_late’:
drivers/xen/pci.c:221:18: error: ‘pci_mmcfg_list’ undeclared (first use in this function)
drivers/xen/pci.c:221:18: note: each undeclared identifier is reported only once for each f


> > > 
> > >   static bool __read_mostly pci_seg_supported = true;
> > > 
> > > @@ -222,9 +219,6 @@ static int __init xen_mcfg_late(void)
> > >       if (!xen_initial_domain())
> > >           return 0;
> > > 
> > > -    if ((pci_probe & PCI_PROBE_MMCONF) == 0)
> > > -        return 0;
> > > -
> > >       if (list_empty(&pci_mmcfg_list))
> > >           return 0;
> > > 
> > > 
> 
--1342847746-1160060852-1446029363=:15801--
