Return-Path: <lv.zheng@intel.com>
Return-Path: <lv.zheng@intel.com>
From: "Zheng, Lv" <lv.zheng@intel.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki
	<tn@semihalf.com>
CC: "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"will.deacon@arm.com" <will.deacon@arm.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"shijie.huang@arm.com" <shijie.huang@arm.com>,
	"robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
	"mw@semihalf.com" <mw@semihalf.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org"
	<linaro-acpi@lists.linaro.org>, "andrea.gallo@linaro.org"
	<andrea.gallo@linaro.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "al.stone@linaro.org" <al.stone@linaro.org>,
	"graeme.gregory@linaro.org" <graeme.gregory@linaro.org>,
	"ddaney.cavm@gmail.com" <ddaney.cavm@gmail.com>, "okaya@codeaurora.org"
	<okaya@codeaurora.org>
Subject: RE: [PATCH V8 2/8] ACPI: Add new IORT functions to support MSI
 domain handling
Date: Tue, 16 Aug 2016 02:15:44 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC0E3F2@SHSMSX101.ccr.corp.intel.com>
References: <1470909998-16710-1-git-send-email-tn@semihalf.com>
 <1470909998-16710-3-git-send-email-tn@semihalf.com>
 <20160812164234.GB17734@red-moon>
In-Reply-To: <20160812164234.GB17734@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi,

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kern=
el.org] On Behalf Of Lorenzo
> Pieralisi
> Subject: Re: [PATCH V8 2/8] ACPI: Add new IORT functions to support MSI d=
omain handling
>=20
> On Thu, Aug 11, 2016 at 12:06:32PM +0200, Tomasz Nowicki wrote:
>=20
> [...]
>=20
> > +/**
> > + * iort_register_domain_token() - register domain token and related IT=
S ID
> > + * to the list from where we can get it back later on.
> > + * @trans_id: ITS ID.
> > + * @fw_node: Domain token.
> > + *
> > + * Returns: 0 on success, -ENOMEM if no memory when allocating list el=
ement
> > + */
> > +int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_=
node)
> > +{
> > +	struct iort_its_msi_chip *its_msi_chip;
> > +
> > +	its_msi_chip =3D kzalloc(sizeof(*its_msi_chip), GFP_KERNEL);
>=20
> I spotted this while reworking my ARM SMMU series, this may sleep
> and that's no good given that we call it within the acpi_probe_lock.
>=20
> Same goes for irq_domain_alloc_fwnode() (that we call in
> gic_v2_acpi_init()), we have got to fix this usage, I will see with
> Marc what's the best way to do it.

If we can ensure that all table device probe entries are created during lin=
k stage or early stage.
I think you can safely unlock probe lock before invoking acpi_table_parse()=
 in __acpi_probe_device_table().

Thanks
Lv

>=20
> Lorenzo
>=20
> > +	if (!its_msi_chip)
> > +		return -ENOMEM;
> > +
> > +	its_msi_chip->fw_node =3D fw_node;
> > +	its_msi_chip->translation_id =3D trans_id;
> > +
> > +	spin_lock(&iort_msi_chip_lock);
> > +	list_add(&its_msi_chip->list, &iort_msi_chip_list);
> > +	spin_unlock(&iort_msi_chip_lock);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * iort_deregister_domain_token() - Deregister domain token based on I=
TS ID
> > + * @trans_id: ITS ID.
> > + *
> > + * Returns: none.
> > + */
> > +void iort_deregister_domain_token(int trans_id)
> > +{
> > +	struct iort_its_msi_chip *its_msi_chip, *t;
> > +
> > +	spin_lock(&iort_msi_chip_lock);
> > +	list_for_each_entry_safe(its_msi_chip, t, &iort_msi_chip_list, list) =
{
> > +		if (its_msi_chip->translation_id =3D=3D trans_id) {
> > +			list_del(&its_msi_chip->list);
> > +			kfree(its_msi_chip);
> > +			break;
> > +		}
> > +	}
> > +	spin_unlock(&iort_msi_chip_lock);
> > +}
> > +
> > +/**
> > + * iort_find_domain_token() - Find domain token based on given ITS ID
> > + * @trans_id: ITS ID.
> > + *
> > + * Returns: domain token when find on the list, NULL otherwise
> > + */
> > +struct fwnode_handle *iort_find_domain_token(int trans_id)
> > +{
> > +	struct fwnode_handle *fw_node =3D NULL;
> > +	struct iort_its_msi_chip *its_msi_chip;
> > +
> > +	spin_lock(&iort_msi_chip_lock);
> > +	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
> > +		if (its_msi_chip->translation_id =3D=3D trans_id) {
> > +			fw_node =3D its_msi_chip->fw_node;
> > +			break;
> > +		}
> > +	}
> > +	spin_unlock(&iort_msi_chip_lock);
> > +
> > +	return fw_node;
> > +}
> > +
> >  static struct acpi_iort_node *
> >  iort_scan_node(enum acpi_iort_node_type type,
> >  	       iort_find_node_callback callback, void *context)
> > @@ -206,6 +285,96 @@ iort_find_dev_node(struct device *dev)
> >  			      iort_match_node_callback, &pbus->dev);
> >  }
> >
> > +/**
> > + * iort_msi_map_rid() - Map a MSI requester ID for a device
> > + * @dev: The device for which the mapping is to be done.
> > + * @req_id: The device requester ID.
> > + *
> > + * Returns: mapped MSI RID on success, input requester ID otherwise
> > + */
> > +u32 iort_msi_map_rid(struct device *dev, u32 req_id)
> > +{
> > +	struct acpi_iort_node *node;
> > +	u32 dev_id;
> > +
> > +	if (!iort_table)
> > +		return req_id;
> > +
> > +	node =3D iort_find_dev_node(dev);
> > +	if (!node) {
> > +		dev_err(dev, "can't find related IORT node\n");
> > +		return req_id;
> > +	}
> > +
> > +	iort_node_map_rid(node, req_id, &dev_id, ACPI_IORT_NODE_ITS_GROUP);
> > +	return dev_id;
> > +}
> > +
> > +/**
> > + * iort_dev_find_its_id() - Find the ITS identifier for a device
> > + * @dev: The device.
> > + * @idx: Index of the ITS identifier list.
> > + * @its_id: ITS identifier.
> > + *
> > + * Returns: 0 on success, appropriate error value otherwise
> > + */
> > +static int
> > +iort_dev_find_its_id(struct device *dev, u32 req_id, unsigned int idx,
> > +		     int *its_id)
> > +{
> > +	struct acpi_iort_its_group *its;
> > +	struct acpi_iort_node *node;
> > +
> > +	node =3D iort_find_dev_node(dev);
> > +	if (!node) {
> > +		dev_err(dev, "can't find related IORT node\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	node =3D iort_node_map_rid(node, req_id, NULL, ACPI_IORT_NODE_ITS_GRO=
UP);
> > +	if (!node) {
> > +		dev_err(dev, "can't find related ITS node\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	/* Move to ITS specific data */
> > +	its =3D (struct acpi_iort_its_group *)node->node_data;
> > +	if (idx > its->its_count) {
> > +		dev_err(dev, "requested ITS ID index [%d] is greater than available =
[%d]\n",
> > +			idx, its->its_count);
> > +		return -ENXIO;
> > +	}
> > +
> > +	*its_id =3D its->identifiers[idx];
> > +	return 0;
> > +}
> > +
> > +/**
> > + * iort_get_device_domain() - Find MSI domain related to a device
> > + * @dev: The device.
> > + * @req_id: Requester ID for the device.
> > + *
> > + * Returns: the MSI domain for this device, NULL otherwise
> > + */
> > +struct irq_domain *
> > +iort_get_device_domain(struct device *dev, u32 req_id)
> > +{
> > +	static struct fwnode_handle *handle;
> > +	int its_id;
> > +
> > +	if (!iort_table)
> > +		return NULL;
> > +
> > +	if (iort_dev_find_its_id(dev, req_id, 0, &its_id))
> > +		return NULL;
> > +
> > +	handle =3D iort_find_domain_token(its_id);
> > +	if (!handle)
> > +		return NULL;
> > +
> > +	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
> > +}
> > +
> >  void __init iort_table_detect(void)
> >  {
> >  	acpi_status status;
> > diff --git a/include/linux/iort.h b/include/linux/iort.h
> > index cde6809..d7daba1 100644
> > --- a/include/linux/iort.h
> > +++ b/include/linux/iort.h
> > @@ -20,11 +20,22 @@
> >  #define __IORT_H__
> >
> >  #include <linux/acpi.h>
> > +#include <linux/fwnode.h>
> > +#include <linux/irqdomain.h>
> >
> > +int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_=
node);
> > +void iort_deregister_domain_token(int trans_id);
> > +struct fwnode_handle *iort_find_domain_token(int trans_id);
> >  #ifdef CONFIG_IORT_TABLE
> >  void iort_table_detect(void);
> > +u32 iort_msi_map_rid(struct device *dev, u32 req_id);
> > +struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_=
id);
> >  #else
> >  static inline void iort_table_detect(void) { }
> > +static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
> > +{ return req_id; }
> > +static inline struct irq_domain *
> > +iort_get_device_domain(struct device *dev, u32 req_id) { return NULL; =
}
> >  #endif
> >
> >  #endif /* __IORT_H__ */
> > --
> > 1.9.1
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
