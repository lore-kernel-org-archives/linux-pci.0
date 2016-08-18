Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:40305 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752864AbcHRKu5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2016 06:50:57 -0400
Date: Thu, 18 Aug 2016 18:50:07 +0800
From: Dennis Chen <dennis.chen@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: <iommu@lists.linux-foundation.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Tomasz Nowicki <tn@semihalf.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Robin Murphy" <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Nate Watterson <nwatters@codeaurora.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <nd@arm.com>
Subject: Re: [PATCH v4 09/15] drivers: acpi: iort: add support for ARM SMMU
 platform devices creation
Message-ID: <20160818105005.GA20404@arm.com>
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1471274620-20754-10-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <1471274620-20754-10-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Mon, Aug 15, 2016 at 04:23:34PM +0100, Lorenzo Pieralisi wrote:
> In ARM ACPI systems, IOMMU components are specified through static
> IORT table entries. In order to create platform devices for the
> corresponding ARM SMMU components, IORT kernel code should be made
> able to parse IORT table entries and create platform devices
> dynamically.
>=20
> This patch adds the generic IORT infrastructure required to create
> platform devices for ARM SMMUs.
>=20
> ARM SMMU versions have different resources requirement therefore this
> patch also introduces an IORT specific structure (ie iort_iommu_config)
> that contains hooks (to be defined when the corresponding ARM SMMU
> driver support is added to the kernel) to be used to define the
> platform devices names, init the IOMMUs, count their resources and
> finally initialize them.
>=20
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/arm64/iort.c | 153 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 153 insertions(+)
>=20
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index f6db3d8..4043071 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -22,6 +22,7 @@
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/pci.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
> =20
>  struct iort_its_msi_chip {
> @@ -454,6 +455,157 @@ iort_get_device_domain(struct device *dev, u32 req_=
id)
>  =09return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
>  }
> =20
> +struct iort_iommu_config {
> +=09const char *name;
> +=09int (*iommu_init)(struct acpi_iort_node *node);
> +=09bool (*iommu_is_coherent)(struct acpi_iort_node *node);
> +=09int (*iommu_count_resources)(struct acpi_iort_node *node);
> +=09void (*iommu_init_resources)(struct resource *res,
> +=09=09=09=09     struct acpi_iort_node *node);
> +};
> +
> +static const struct iort_iommu_config * __init
> +iort_get_iommu_config(struct acpi_iort_node *node)
> +{
> +=09return NULL;
> +}
> +
> +/**
> + * iort_add_smmu_platform_device() - Allocate a platform device for SMMU
> + * @fwnode: IORT node associated fwnode handle
> + * @node: Pointer to SMMU ACPI IORT node
> + *
> + * Returns: 0 on success, <0 failure
> + */
> +static int __init
> +iort_add_smmu_platform_device(struct fwnode_handle *fwnode,
> +=09=09=09      struct acpi_iort_node *node)
> +{
> +=09struct platform_device *pdev;
> +=09struct resource *r;
> +=09enum dev_dma_attr attr;
> +=09int ret, count;
> +=09const struct iort_iommu_config *ops =3D
> +=09=09=09=09iort_get_iommu_config(node);
> +
> +=09if (!ops)
> +=09=09return -ENODEV;
> +
> +=09pdev =3D platform_device_alloc(ops->name, PLATFORM_DEVID_AUTO);
> +=09if (!pdev)
> +=09=09return PTR_ERR(pdev);
> +
> +=09count =3D ops->iommu_count_resources(node);
> +
> +=09r =3D kcalloc(count, sizeof(*r), GFP_KERNEL);
> +=09if (!r) {
> +=09=09ret =3D -ENOMEM;
> +=09=09goto dev_put;
> +=09}
> +
> +=09ops->iommu_init_resources(r, node);
> +
> +=09ret =3D platform_device_add_resources(pdev, r, count);
> +=09/*
> +=09 * Resources are duplicated in platform_device_add_resources,
> +=09 * free their allocated memory
> +=09 */
> +=09kfree(r);
> +
> +=09if (ret)
> +=09=09goto dev_put;
> +
> +=09/*
> +=09 * Add a copy of IORT node pointer to platform_data to
> +=09 * be used to retrieve IORT data information.
> +=09 */
> +=09ret =3D platform_device_add_data(pdev, &node, sizeof(node));
> +=09if (ret)
> +=09=09goto dev_put;
> +
> +=09pdev->dev.dma_mask =3D kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNE=
L);
> +=09if (!pdev->dev.dma_mask) {
> +=09=09ret =3D -ENOMEM;
> +=09=09goto dev_put;
> +=09}
> +
> +=09pdev->dev.fwnode =3D fwnode;
> +
> +=09/*
> +=09 * Set default dma mask value for the table walker,
> +=09 * to be overridden on probing with correct value.
> +=09 */
> +=09*pdev->dev.dma_mask =3D DMA_BIT_MASK(32);
> +=09pdev->dev.coherent_dma_mask =3D *pdev->dev.dma_mask;
> +
> +=09attr =3D ops->iommu_is_coherent(node) ?
> +=09=09=09     DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> +
> +=09/* Configure DMA for the page table walker */
> +=09acpi_dma_configure(&pdev->dev, attr);
> +
> +=09ret =3D platform_device_add(pdev);
> +=09if (ret)
> +=09=09goto dma_deconfigure;
> +
> +=09return 0;
> +
> +dma_deconfigure:
> +=09acpi_dma_deconfigure(&pdev->dev);
> +=09kfree(pdev->dev.dma_mask);
> +
> +dev_put:
> +=09platform_device_put(pdev);
> +
> +=09return ret;
> +}
> +
> +static void __init iort_smmu_init(void)
> +{
> +=09struct acpi_iort_node *iort_node, *iort_end;
> +=09struct acpi_table_iort *iort;
> +=09struct fwnode_handle *fwnode;
> +=09int i, ret;
> +
> +=09/*
> +=09 * table and iort will both point to the start of IORT table, but
> +=09 * have different struct types
> +=09 */
> +=09iort =3D (struct acpi_table_iort *)iort_table;
>
If the firmware of a platform happens to miss the IORT table, then iort_tab=
le here
will be a NULL pointer, in this case 'NULL pointer dereference' kernel pani=
c will occur,=20
if this is not an expected behavior then we can add a sanity check here to =
avoid this.=20
IORT missing is a fatal error? I don't think so.

Thanks,
Dennis
> +
> +=09/* Get the first IORT node */
> +=09iort_node =3D ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> +=09=09=09=09 iort->node_offset);
> +=09iort_end =3D ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> +=09=09=09=09iort_table->length);
> +
> +=09for (i =3D 0; i < iort->node_count; i++) {
> +
> +=09=09if (iort_node >=3D iort_end) {
> +=09=09=09pr_err("iort node pointer overflows, bad table\n");
> +=09=09=09return;
> +=09=09}
> +
> +=09=09if (iort_node->type =3D=3D ACPI_IORT_NODE_SMMU ||
> +=09=09    iort_node->type =3D=3D ACPI_IORT_NODE_SMMU_V3) {
> +=09=09=09fwnode =3D iort_get_fwnode(iort_node);
> +
> +=09=09=09if (!fwnode)
> +=09=09=09=09continue;
> +
> +=09=09=09ret =3D iort_add_smmu_platform_device(fwnode,
> +=09=09=09=09=09=09=09    iort_node);
> +=09=09=09if (ret) {
> +=09=09=09=09pr_err("Error in platform device creation\n");
> +=09=09=09=09return;
> +=09=09=09}
> +=09=09}
> +
> +=09=09iort_node =3D ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> +=09=09=09=09=09 iort_node->length);
> +=09}
> +}
> +
>  void __init iort_table_detect(void)
>  {
>  =09acpi_status status;
> @@ -465,4 +617,5 @@ void __init iort_table_detect(void)
>  =09}
> =20
>  =09acpi_probe_device_table(iort);
> +=09iort_smmu_init();
>  }
> --=20
> 2.6.4
>=20

