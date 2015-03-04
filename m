Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1425510083.5200.312.camel@redhat.com>
Subject: Re: [PATCH 1/5] vfio-pci: Allow PCI IDs to be specified as module
 options
From: Alex Williamson <alex.williamson@redhat.com>
To: Bandan Das <bsd@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2015 16:01:23 -0700
In-Reply-To: <jpg8ufc75sk.fsf@redhat.com>
References: <20150304194711.26766.75450.stgit@gimli.home>
	 <20150304200243.26766.556.stgit@gimli.home> <jpgy4ncv681.fsf@redhat.com>
	 <1425507522.5200.311.camel@redhat.com> <jpg8ufc75sk.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-03-04 at 17:32 -0500, Bandan Das wrote:
> Alex Williamson <alex.williamson@redhat.com> writes:
> 
> > On Wed, 2015-03-04 at 15:49 -0500, Bandan Das wrote:
> >> Hi Alex,
> >> 
> >> Alex Williamson <alex.williamson@redhat.com> writes:
> >> ...
> >> > +		if (fields < 2) {
> >> > +			pr_warn("vfio-pci: invalid id string \"%s\"\n", id);
> >> > +			continue;
> >> > +		}
> >> > +
> >> > +		pr_info("vfio-pci: add %04X:%04X sub=%04X:%04X cls=%08X/%08X\n",
> >> > +			vendor, device, subvendor, subdevice,
> >> > +			class, class_mask);
> >> > +
> >> > +		rc = pci_add_dynid(&vfio_pci_driver, vendor, device,
> >> > +				   subvendor, subdevice, class, class_mask, 0);
> >> > +		if (rc)
> >> > +			pr_warn("vfio-pci: failed to add dynamic id (%d)\n",
> >> > +				rc);
> >> Just a minor observation - maybe we should print out the
> >> vendor/device/subvendor/subdevice as part of the failure message too. The info
> >> message could potentially get lost in a system with high syslog traffic.
> >
> > Thanks for the comment.  I don't think we want to duplicate the pr_info
> > above it, so are you thinking something like this?
> >
> >                 if (fields < 2) {
> >                         pr_warn("vfio-pci: invalid id string \"%s\"\n", id);
> >                         continue;
> >                 }
> >
> >                 rc = pci_add_dynid(&vfio_pci_driver, vendor, device,
> >                                    subvendor, subdevice, class, class_mask, 0);
> >                 if (rc)
> >                         pr_warn("vfio-pci: failed to add dynamic id: %04X:%04X sub=%04X:%04X cls=%08X/%08X (%d)\n",
> >                                 vendor, device, subvendor, subdevice,
> >                                 class, class_mask, rc);
> >                 else
> >                         pr_info("vfio-pci: add %04X:%04X sub=%04X:%04X cls=%08X/%08X\n",
> >                                 vendor, device, subvendor, subdevice,
> >                                 class, class_mask);
> >         }
> 
> Yep, this is good. (BTW, we can define pr_fmt at the top of the file and avoid
> the "vfio-pci" prefix)

Cool, I'll remove the "vfio-pci: " prefixes and define the standard:

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Thanks!

> >> > +	}
> >> > +}
> >> > +
> >> >  static int __init vfio_pci_init(void)
> >> >  {
> >> >  	int ret;
> >> > @@ -1053,6 +1097,8 @@ static int __init vfio_pci_init(void)
> >> >  	if (ret)
> >> >  		goto out_driver;
> >> >  
> >> > +	vfio_pci_fill_ids();
> >> > +
> >> >  	return 0;
> >> >  
> >> >  out_driver:
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



