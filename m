Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49819 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754437AbaDRVcG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Apr 2014 17:32:06 -0400
Message-ID: <1397856690.32730.110.camel@pasglop>
Subject: Re: [Resend] pcibios_add_platform_entries usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <monstr@monstr.eu>,
	Paul Mackerras <paulus@samba.org>
Date: Sat, 19 Apr 2014 07:31:30 +1000
In-Reply-To: <alpine.LFD.2.11.1404181154450.1609@denkbrett>
References: <alpine.LFD.2.11.1403281931410.1516@denkbrett>
	 <alpine.LFD.2.11.1404141101500.1529@denkbrett>
	 <20140414173541.GA4417@google.com>
	 <alpine.LFD.2.11.1404141958120.1561@denkbrett>
	 <alpine.LFD.2.11.1404171938190.1588@denkbrett>
	 <1397768575.32730.70.camel@pasglop>
	 <alpine.LFD.2.11.1404181154450.1609@denkbrett>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2014-04-18 at 12:10 +0200, Sebastian Ott wrote:
> On Fri, 18 Apr 2014, Benjamin Herrenschmidt wrote:
> > On Thu, 2014-04-17 at 19:46 +0200, Sebastian Ott wrote:
> > 
> > > pci: move open fabric devspec attribute to pci common code
> > > 
> > > Move the devspec OF attribute to pci common code's set of device
> > > attributes since it's not architecture dependent.
> > > As a side effect microblaze and powerpc no longer need to use
> > > pcibios_add_platform_entries.
> > > 
> > > Link: https://lkml.kernel.org/r/alpine.LFD.2.11.1404141101500.1529@denkbrett
> > > Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> > 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > (Pending you've compile tested it on powerpc, I'm on vacation and
> > haven't done it :)
> 
> I did:
> make ARCH=powerpc CROSS_COMPILE=powerpc64-4.3.2- g5_defconfig
> make ARCH=powerpc CROSS_COMPILE=powerpc64-4.3.2-
> 
> and failed with:
>   CC      arch/powerpc/lib/xor_vmx.o
> In file included from include/linux/list.h:4,
>                  from include/linux/preempt.h:10,
>                  from arch/powerpc/lib/xor_vmx.c:22:
> include/linux/types.h:29: error: both ‘unsigned’ and ‘_Bool’ in declaration specifiers
> cc1: warnings being treated as errors
> include/linux/types.h:29: error: useless type name in empty declaration

Not sure what's up here, did you try with a more recent compiler ? 4.3
is pretty ancient by kernel standards.

You can find cross compilers there:

https://www.kernel.org/pub/tools/crosstool/

They aren't the newest either but they should work.

Ben.

> 
> make ARCH=powerpc CROSS_COMPILE=powerpc64-4.3.2- arch/powerpc/kernel/ drivers/pci/
> 
> worked just fine.
> 
> Regards,
> Sebastian
> 
> > 
> > > ---
> > >  arch/microblaze/pci/pci-common.c |   20 --------------------
> > >  arch/powerpc/kernel/pci-common.c |   20 --------------------
> > >  drivers/pci/pci-sysfs.c          |   17 +++++++++++++++++
> > >  3 files changed, 17 insertions(+), 40 deletions(-)
> > > 
> > > --- a/arch/microblaze/pci/pci-common.c
> > > +++ b/arch/microblaze/pci/pci-common.c
> > > @@ -168,26 +168,6 @@ struct pci_controller *pci_find_hose_for
> > >  	return NULL;
> > >  }
> > >  
> > > -static ssize_t pci_show_devspec(struct device *dev,
> > > -		struct device_attribute *attr, char *buf)
> > > -{
> > > -	struct pci_dev *pdev;
> > > -	struct device_node *np;
> > > -
> > > -	pdev = to_pci_dev(dev);
> > > -	np = pci_device_to_OF_node(pdev);
> > > -	if (np == NULL || np->full_name == NULL)
> > > -		return 0;
> > > -	return sprintf(buf, "%s", np->full_name);
> > > -}
> > > -static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
> > > -
> > > -/* Add sysfs properties */
> > > -int pcibios_add_platform_entries(struct pci_dev *pdev)
> > > -{
> > > -	return device_create_file(&pdev->dev, &dev_attr_devspec);
> > > -}
> > > -
> > >  void pcibios_set_master(struct pci_dev *dev)
> > >  {
> > >  	/* No special bus mastering setup handling */
> > > --- a/arch/powerpc/kernel/pci-common.c
> > > +++ b/arch/powerpc/kernel/pci-common.c
> > > @@ -201,26 +201,6 @@ struct pci_controller* pci_find_hose_for
> > >  	return NULL;
> > >  }
> > >  
> > > -static ssize_t pci_show_devspec(struct device *dev,
> > > -		struct device_attribute *attr, char *buf)
> > > -{
> > > -	struct pci_dev *pdev;
> > > -	struct device_node *np;
> > > -
> > > -	pdev = to_pci_dev (dev);
> > > -	np = pci_device_to_OF_node(pdev);
> > > -	if (np == NULL || np->full_name == NULL)
> > > -		return 0;
> > > -	return sprintf(buf, "%s", np->full_name);
> > > -}
> > > -static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
> > > -
> > > -/* Add sysfs properties */
> > > -int pcibios_add_platform_entries(struct pci_dev *pdev)
> > > -{
> > > -	return device_create_file(&pdev->dev, &dev_attr_devspec);
> > > -}
> > > -
> > >  /*
> > >   * Reads the interrupt pin to determine if interrupt is use by card.
> > >   * If the interrupt is used, then gets the interrupt line from the
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -416,6 +416,20 @@ static ssize_t d3cold_allowed_show(struc
> > >  static DEVICE_ATTR_RW(d3cold_allowed);
> > >  #endif
> > >  
> > > +#ifdef CONFIG_OF
> > > +static ssize_t devspec_show(struct device *dev,
> > > +			    struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	struct device_node *np = pci_device_to_OF_node(pdev);
> > > +
> > > +	if (np == NULL || np->full_name == NULL)
> > > +		return 0;
> > > +	return sprintf(buf, "%s", np->full_name);
> > > +}
> > > +static DEVICE_ATTR_RO(devspec);
> > > +#endif
> > > +
> > >  #ifdef CONFIG_PCI_IOV
> > >  static ssize_t sriov_totalvfs_show(struct device *dev,
> > >  				   struct device_attribute *attr,
> > > @@ -521,6 +535,9 @@ static struct attribute *pci_dev_attrs[]
> > >  #if defined(CONFIG_PM_RUNTIME) && defined(CONFIG_ACPI)
> > >  	&dev_attr_d3cold_allowed.attr,
> > >  #endif
> > > +#ifdef CONFIG_OF
> > > +	&dev_attr_devspec.attr,
> > > +#endif
> > >  	NULL,
> > >  };
> > >  
> > 
> > 
> > 


