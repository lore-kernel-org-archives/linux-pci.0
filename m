Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 13 Mar 2014 00:11:09 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Liviu Dudau' <Liviu.Dudau@arm.com>,
	'linux-pci' <linux-pci@vger.kernel.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Catalin Marinas' <Catalin.Marinas@arm.com>,
	'Will Deacon' <Will.Deacon@arm.com>,
	'linaro-kernel' <linaro-kernel@lists.linaro.org>,
	'Benjamin Herrenschmidt' <benh@kernel.crashing.org>,
	'LKML' <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org,
	'LAKML' <linux-arm-kernel@lists.infradead.org>,
	'Tanmay Inamdar' <tinamdar@apm.com>,
	'Arnd Bergmann' <arnd@arndb.de>
Subject: Re: [PATCH v6 3/3] arm64: Add architecture support for PCI
Message-ID: <20140313001109.GA6915@bart.dudau.co.uk>
References: <1394020150-1875-1-git-send-email-Liviu.Dudau@arm.com>
 <1394020150-1875-4-git-send-email-Liviu.Dudau@arm.com>
 <000101cf3dce$df2c1840$9d8448c0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <000101cf3dce$df2c1840$9d8448c0$%han@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 12, 2014 at 05:41:33PM +0900, Jingoo Han wrote:
> On Wednesday, March 05, 2014 8:49 PM, Liviu Dudau wrote:
> > 
> > Use the generic host bridge functions to provide support for
> > PCI Express on arm64. There is no support for ISA memory.
> > 
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > Tested-by: Tanmay Inamdar <tinamdar@apm.com>
> > ---
> >  arch/arm64/Kconfig            |  19 +++-
> >  arch/arm64/include/asm/Kbuild |   1 +
> >  arch/arm64/include/asm/io.h   |   3 +-
> >  arch/arm64/include/asm/pci.h  |  49 +++++++++
> >  arch/arm64/kernel/Makefile    |   1 +
> >  arch/arm64/kernel/pci.c       | 173 ++++++++++++++++++++++++++++++++
> >  6 files changed, 244 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/pci.h
> >  create mode 100644 arch/arm64/kernel/pci.c
> 
> [.....]
> 
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/pci.h
> 
> [.....]
> 
> > +
> > +static inline int pci_domain_nr(struct pci_bus *bus)
> > +{
> > +	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
> > +
> > +	if (bridge)
> > +		return bridge->domain_nr;
> > +
> > +	return 0;
> > +}
> 
> Hi Liviu Dudau,
> 
> When CONFIG_PCI=n, the following build errors happen. :-(
> Would you confirm this?
> 
> In file included from include/linux/pci.h:1393:0,
>                  from drivers/scsi/scsi_lib.c:19:
> arch/arm64/include/asm/pci.h:31:19: error: redefinition of 'pci_domain_nr'
>  static inline int pci_domain_nr(struct pci_bus *bus)
>                    ^
> In file included from drivers/scsi/scsi_lib.c:19:0:
> include/linux/pci.h:1383:19: note: previous definition of 'pci_domain_nr' was here
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>                    ^
>              .....

Hi Jingoo,

I confirm the build error. Sorry for missing out on this test. I've now got out
of some more pressing tasks and I will post v7 tomorrow.

Best regards,
Liviu

> 
> Best regards,
> Jingoo Han
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...

