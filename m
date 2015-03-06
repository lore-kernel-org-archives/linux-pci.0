Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35518 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbbCFWL0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 17:11:26 -0500
Received: by obbgq1 with SMTP id gq1so23502541obb.2
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2015 14:11:26 -0800 (PST)
Date: Fri, 6 Mar 2015 16:11:21 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] vfio-pci: Allow PCI IDs to be specified as module
 options
Message-ID: <20150306221121.GA14814@google.com>
References: <20150304194711.26766.75450.stgit@gimli.home>
 <20150304200243.26766.556.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150304200243.26766.556.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 04, 2015 at 01:02:43PM -0700, Alex Williamson wrote:
> This copies the same support from pci-stub for exactly the same
> purpose, enabling a set of PCI IDs to be automatically added to the
> driver's dynamic ID table at module load time.  The code here is
> pretty simple and both vfio-pci and pci-stub are fairly unique in
> being meta drivers, capable of attaching to any device, so there's no
> attempt made to generalize the code into pci-core.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci.c |   46 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index f8a1863..b3bae4c 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -32,6 +32,10 @@
>  #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
>  #define DRIVER_DESC     "VFIO PCI - User Level meta-driver"
>  
> +static char ids[1024] __initdata;
> +module_param_string(ids, ids, sizeof(ids), 0);
> +MODULE_PARM_DESC(ids, "Initial PCI IDs to add to the vfio driver, format is \"vendor:device[:subvendor[:subdevice[:class[:class_mask]]]]\" and multiple comma separated entries can be specified");
> +
>  static bool nointxmask;
>  module_param_named(nointxmask, nointxmask, bool, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(nointxmask,
> @@ -1034,6 +1038,46 @@ static void __exit vfio_pci_cleanup(void)
>  	vfio_pci_uninit_perm_bits();
>  }
>  
> +static void __init vfio_pci_fill_ids(void)
> +{
> +	char *p, *id;
> +	int rc;
> +
> +	/* no ids passed actually */
> +	if (ids[0] == '\0')
> +		return;
> +
> +	/* add ids specified in the module parameter */
> +	p = ids;
> +	while ((id = strsep(&p, ","))) {
> +		unsigned int vendor, device, subvendor = PCI_ANY_ID,
> +			subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
> +		int fields;
> +
> +		if (!strlen(id))
> +			continue;
> +
> +		fields = sscanf(id, "%x:%x:%x:%x:%x:%x",
> +				&vendor, &device, &subvendor, &subdevice,
> +				&class, &class_mask);
> +
> +		if (fields < 2) {
> +			pr_warn("vfio-pci: invalid id string \"%s\"\n", id);
> +			continue;
> +		}
> +
> +		pr_info("vfio-pci: add %04X:%04X sub=%04X:%04X cls=%08X/%08X\n",

pci_setup_device() uses "[%04x:%04x] ... class %#08x".  Maybe they should
be the same, at least as far as using upper/lower case, spelling out
"class", and "0x" prefix.  Maybe there's other precedent that you're
following and pci_setup_device() is not?

> +			vendor, device, subvendor, subdevice,
> +			class, class_mask);
> +
> +		rc = pci_add_dynid(&vfio_pci_driver, vendor, device,
> +				   subvendor, subdevice, class, class_mask, 0);
> +		if (rc)
> +			pr_warn("vfio-pci: failed to add dynamic id (%d)\n",
> +				rc);
> +	}
> +}
> +
>  static int __init vfio_pci_init(void)
>  {
>  	int ret;
> @@ -1053,6 +1097,8 @@ static int __init vfio_pci_init(void)
>  	if (ret)
>  		goto out_driver;
>  
> +	vfio_pci_fill_ids();
> +
>  	return 0;
>  
>  out_driver:
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
