Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 30 Apr 2015 11:26:47 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: mst@redhat.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com,
	airlied@linux.ie, daniel.vetter@intel.com,
	linux-fbdev@vger.kernel.org, luto@amacapital.net,
	cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	konrad.wilk@oracle.com, ville.syrjala@linux.intel.com,
	david.vrabel@citrix.com, jbeulich@suse.com,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	xen-devel@lists.xensource.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/5] lib: devres: add pcim_iomap_wc() variants
Message-ID: <20150430162647.GD7888@google.com>
References: <1430343372-687-1-git-send-email-mcgrof@do-not-panic.com>
 <1430343372-687-3-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430343372-687-3-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

Hi Luis,

On Wed, Apr 29, 2015 at 02:36:09PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> Now that we have pci_iomap_wc() add the respective devres helpers.

I guess I'm still confused about the relationship between pci_iomap_wc()
and arch_phys_wc_add().

Do you expect every caller of pcim_iomap_wc() to also call
arch_phys_wc_add()?

If so, I'm not sure how pcim_iomap_wc() fits into the picture.  A driver
can call both pcim_iomap_wc() and arch_phys_wc_add(), but the driver
doesn't explicitly do the unmap, so where would the arch_phys_wc_del()
happen?

If not, how does a driver know whether it should call arch_phys_wc_add()?

> ...
>  /**
> + * pcim_iomap_wc_regions - Request and iomap PCI BARs with write-combining
> + * @pdev: PCI device to map IO resources for
> + * @mask: Mask of BARs to request and iomap
> + * @name: Name used when requesting regions
> + *
> + * Request and iomap regions specified by @mask with a preference for
> + * write-combining.
> + */
> +int pcim_iomap_wc_regions(struct pci_dev *pdev, int mask, const char *name)
> +{
> +	void __iomem * const *iomap;
> +	int i, rc;
> +
> +	iomap = pcim_iomap_table(pdev);
> +	if (!iomap)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +		unsigned long len;
> +
> +		if (!(mask & (1 << i)))
> +			continue;
> +
> +		rc = -EINVAL;
> +		len = pci_resource_len(pdev, i);
> +		if (!len)
> +			goto err_inval;
> +
> +		rc = pci_request_region(pdev, i, name);
> +		if (rc)
> +			goto err_inval;
> +
> +		rc = -ENOMEM;
> +		if (!pcim_iomap_wc(pdev, i, 0))
> +			goto err_region;

Is there a user for this?  Are there really devices where *all* the BARs
can be mapped with WC?  Are there enough of them to make it worth adding
this?

I don't see users of either pcim_iomap_wc() or pcim_iomap_wc_regions() so
far.  Did I miss them, or do you just expect them in the near future?

Bjorn
