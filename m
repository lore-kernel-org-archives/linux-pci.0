Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 17 Feb 2016 15:37:52 +0000
From: Luis Henriques <luis.henriques@canonical.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] vfio: fix link failures when CONFIG_PCI_MSI is disabled
Message-ID: <20160217153752.GB28282@ares>
References: <20160203205108.GA9181@charon.olymp>
 <20160212111758.4b5cb926@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160212111758.4b5cb926@t450s.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 12, 2016 at 11:17:58AM -0700, Alex Williamson wrote:
> On Wed, 3 Feb 2016 20:51:08 +0000
> Luis Henriques <luis.henriques@canonical.com> wrote:
> 
> > The following link failure occurs when CONFIG_PCI_MSI is not set:
> > 
> > drivers/built-in.o: In function `vfio_msi_set_vector_signal':
> > :(.text+0x626640): undefined reference to `pci_write_msi_msg'
> > 
> > Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
> > ---
> >  drivers/vfio/pci/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > index 02912f180c6d..b9dbfc9aeee1 100644
> > --- a/drivers/vfio/pci/Kconfig
> > +++ b/drivers/vfio/pci/Kconfig
> > @@ -1,6 +1,6 @@
> >  config VFIO_PCI
> >  	tristate "VFIO support for PCI devices"
> > -	depends on VFIO && PCI && EVENTFD
> > +	depends on VFIO && PCI_MSI && EVENTFD
> >  	select VFIO_VIRQFD
> >  	select IRQ_BYPASS_MANAGER
> >  	help
> > 
> 
> 
> It seems like a better solution would be to have pci stub these out
> with static inlines when !CONFIG_PCI_MSI, we already do that for quite
> a lot of MSI and MSI-X callbacks.  MSI/X on the device clearly won't
> work if the host doesn't support MSI, and maybe there are improvements
> to be made there, but MSI is a subcomponent of vfio-pci, the module
> itself shouldn't depend on MSI.  Thanks,
> 
> Alex
> 

Thanks for reviewing.  I'll submit a new patch later today, stubbing
pci_write_msi_msg() to fix this failure.

Cheers,
--
Luís
