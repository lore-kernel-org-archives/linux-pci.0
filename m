Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] pci: host: Add Broadcom STB PCIE RC controller
Date: Wed, 11 May 2016 14:47:45 +0000
Message-ID: <8520D5D51A55D047800579B094147198258955D9@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
 <1462475700-1654-3-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1462475700-1654-3-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jim2101024@gmail.com" <jim2101024@gmail.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> +
> +static struct pci_ops brcm_pcie_ops = {
> +	.read = brcm_pcie_read_config,
> +	.write = brcm_pcie_write_config,
> +};
> +
> +static int brcm_pcie_probe(struct platform_device *pdev) {
> +	struct device_node *dn = pdev->dev.of_node;
> +	const u32 *log2_scb_sizes, *dma_ranges;
> +	const struct brcm_pcie_cfg_data *data;
> +	const struct of_device_id *of_id;
> +	struct brcm_pcie *pcie;
> +	void __iomem *base;
> +	struct resource *r;
> +	int i, rlen, ret;
> +	u32 tmp;
> +
> +	pcie = devm_kzalloc(&pdev->dev, sizeof(struct brcm_pcie),
> GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	of_id = of_match_node(brcm_pcie_match, dn);
> +	if (!of_id)
> +		return -EINVAL;
> +
> +	data = of_id->data;
> +	pcie->type = data->type;
> +	pcie->ops = &data->ops;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	INIT_LIST_HEAD(&pcie->resource);
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	ret = of_alias_get_id(dn, "pcie");
> +	if (ret >= 0)
> +		pcie->num = ret;
> +
> +	pcie->clk = devm_clk_get(&pdev->dev, "pcie");
> +	if (IS_ERR(pcie->clk)) {
> +		dev_err(&pdev->dev, "could not get clock\n");
> +		pcie->clk = NULL;
> +	}
> +
> +	ret = clk_prepare_enable(pcie->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not enable clock\n");
> +		return ret;
> +	}
> +
> +	pcie->dn = dn;
> +	pcie->base = base;
> +	pcie->dev = &pdev->dev;
> +	pcie->dev->of_node = dn;
> +	pcie->gen = 0;
> +
> +	ret = of_property_read_u32(dn, "brcm,gen", &tmp);
> +	if (ret == 0) {
> +		if (tmp > 0 && tmp < 3)
> +			pcie->gen = (int)tmp;
> +		else
> +			dev_warn(pcie->dev, "bad DT value for prop
> 'brcm,gen");
> +	} else if (ret != -EINVAL) {
> +		dev_warn(pcie->dev, "error reading DT prop 'brcm,gen");
> +	}
> +
> +	pcie->ssc = of_property_read_bool(dn, "brcm,ssc");
> +
> +	/* Get the value for the log2 of the scb sizes. Subtract 15 from
> +	 * each because the target register field has 0==disabled and 1==6KB.
> +	 */
> +	log2_scb_sizes = of_get_property(dn, "brcm,log2-scb-sizes", &rlen);
> +	if (log2_scb_sizes) {
> +		for (i = 0; i < rlen / sizeof(u32); i++) {
> +			pcie->scb_size_vals[i]
> +				= (int)of_read_number(log2_scb_sizes + i, 1)
> +					- 15;
> +			pcie->num_memc++;
> +		}
> +	}
In your device tree documentation this is required property, what if this property 
is missing ?
> +
> +	/* Look for the dma-ranges property.  If it exists, issue a warning
> +	 * as PCIe drivers may not work.  This is because the identity
> +	 * mapping between system memory and PCIe space is not
> preserved,
> +	 * and we need Linux to massage the dma_addr_t values it gets
> +	 * from dma memory allocation.  This functionality will be added
> +	 * in the near future.
> +	 */
> +	dma_ranges = of_get_property(dn, "dma-ranges", &rlen);
> +	if (dma_ranges != NULL)
> +		dev_warn(pcie->dev, "no identity map; PCI drivers may fail");
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		ret = irq_of_parse_and_map(pdev->dev.of_node, 1);
> +		if (ret == 0)
> +			dev_warn(pcie->dev, "cannot get msi intr; MSI
> disabled\n");
> +		else
> +			pcie->msi_irq = ret;
> +	}
> +
> +	ret = of_pci_get_host_bridge_resources(dn, 0, 0xff,
> +					       &pcie->resource, NULL);
> +	if (ret) {
> +		dev_err(pcie->dev, "ranges parsing failed\n");
> +		return ret;
> +	}
> +
> +	ret = brcm_pcie_setup_early(pcie);
> +	if (ret)
> +		goto out_err_clk;
> +
> +	/* If setup bridge fails, it cleans up behind itself */
> +	ret = brcm_setup_pcie_bridge(pcie);
> +	if (ret)
> +		goto out_err;
> +
> +	pcie->bus = pci_scan_root_bus(pcie->dev, pcie->num,
> &brcm_pcie_ops,
> +				      pcie, &pcie->resource);
> +	if (!pcie->bus) {
> +		ret = -ENOMEM;
> +		goto out_err_bus;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		brcm_pcie_msi_chip_set(pcie);
> +
> +	pci_bus_size_bridges(pcie->bus);
> +	pci_bus_assign_resources(pcie->bus);
> +
> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +	pci_bus_add_devices(pcie->bus);
> +
> +	return 0;
> +
> +out_err_bus:
> +	brcm_pcie_enter_l23(pcie);
> +	brcm_pcie_turn_off(pcie);
> +out_err_clk:
> +	clk_disable_unprepare(pcie->clk);
> +out_err:
> +	return ret;
> +}
> +
> +static int brcm_pcie_remove(struct platform_device *pdev) {
> +	return brcm_pcie_suspend(&pdev->dev);
> +}
> +
> +static struct platform_driver brcm_pcie_driver = {
> +	.probe = brcm_pcie_probe,
> +	.remove = brcm_pcie_remove,
> +	.driver = {
> +		.name = "brcm-pcie",
> +		.owner = THIS_MODULE,
> +		.of_match_table = brcm_pcie_match,
> +		.pm = &brcm_pcie_pm_ops,
> +	},
> +};
> +module_platform_driver(brcm_pcie_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Broadcom STB PCIE RC driver");
> +MODULE_AUTHOR("Broadcom");
> diff --git a/drivers/pci/host/pcie-brcmstb.h b/drivers/pci/host/pcie-
> brcmstb.h new file mode 100644 index 000000000000..b4a507423bb0
> --- /dev/null
> +++ b/drivers/pci/host/pcie-brcmstb.h
> @@ -0,0 +1,160 @@
> +#ifndef __PCIE_BRCMSTB_H
> +#define __PCIE_BRCMSTB_H
> +
> +#include <linux/io.h>
> +
> +/* Broadcom PCIE Offsets */
> +#define PCIE_RC_CFG_PCIE_LINK_CAPABILITY		0x00b8
> +#define PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL
> 	0x00bc
> +#define PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL		0x00c8
> +#define PCIE_RC_CFG_PCIE_LINK_STATUS_CONTROL_2
> 	0x00dc
> +#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1
> 	0x0188
> +#define PCIE_RC_CFG_PRIV1_ID_VAL3			0x043c
> +#define PCIE_RC_DL_MDIO_ADDR				0x1100
> +#define PCIE_RC_DL_MDIO_WR_DATA
> 	0x1104
> +#define PCIE_RC_DL_MDIO_RD_DATA
> 	0x1108
> +#define PCIE_MISC_MISC_CTRL				0x4008
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI		0x4010
> +#define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
> +#define PCIE_MISC_RC_BAR1_CONFIG_HI			0x4030
> +#define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
> +#define PCIE_MISC_RC_BAR2_CONFIG_HI			0x4038
> +#define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
> +#define PCIE_MISC_RC_BAR3_CONFIG_HI			0x4040
> +#define PCIE_MISC_MSI_BAR_CONFIG_LO			0x4044
> +#define PCIE_MISC_MSI_BAR_CONFIG_HI			0x4048
> +#define PCIE_MISC_MSI_DATA_CONFIG			0x404c
> +#define PCIE_MISC_PCIE_CTRL				0x4064
> +#define PCIE_MISC_PCIE_STATUS				0x4068
> +#define PCIE_MISC_REVISION				0x406c
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT	0x4070
> +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG
> 	0x4204
> +#define PCIE_INTR2_CPU_BASE				0x4300
> +#define PCIE_MSI_INTR2_BASE				0x4500
> +
> +#define PCIE_RGR1_SW_INIT_1				0x9210
> +#define PCIE_EXT_CFG_INDEX				0x9000
> +#define PCIE_EXT_CFG_DATA				0x9004
> +
> +/* BCM7425 specific register offsets */
> +#define BCM7425_PCIE_RGR1_SW_INIT_1			0x8010
> +#define BCM7425_PCIE_EXT_CFG_INDEX			0x8300
> +#define BCM7425_PCIE_EXT_CFG_DATA			0x8304
> +
> +#define PCI_BUSNUM_SHIFT		20
> +#define PCI_SLOT_SHIFT			15
> +#define PCI_FUNC_SHIFT			12
> +
> +#define BRCM_NUM_PCI_OUT_WINS		4
> +#define BRCM_MAX_SCB			4
> +
> +/* Offsets from PCIE_INTR2_CPU_BASE and PCIE_MSI_INTR2_BASE */
> +#define STATUS				0x0
> +#define SET				0x4
> +#define CLR				0x8
> +#define MASK_STATUS			0xc
> +#define MASK_SET			0x10
> +#define MASK_CLR			0x14
> +
> +enum brcm_pcie_type {
> +	BCM7425,
> +	BCM7435,
> +	GENERIC,
> +};
> +
> +struct brcm_pcie;
> +
> +/* Chip-specific PCIe operations (read/write config and reset) */
> +struct brcm_pcie_ll_ops {
> +	u32 (*read_config)(struct brcm_pcie *pcie, int cfg_idx);
> +	void (*write_config)(struct brcm_pcie *pcie, int cfg_idx, u32 val);
> +	void (*rgr1_sw_init)(struct brcm_pcie *pcie, u32 mask,
> +			     int shift, u32 val);
> +};
> +
> +struct brcm_pcie_cfg_data {
> +	const enum brcm_pcie_type type;
> +	const struct brcm_pcie_ll_ops ops;
> +};
> +
> +struct brcm_msi;
> +
> +/* Internal Bus Controller Information.*/ struct brcm_pcie {
> +	void __iomem		*base;
> +	bool			suspended;
> +	struct clk		*clk;
> +	struct device_node	*dn;
> +	bool			ssc;
> +	int			gen;
> +	int			scb_size_vals[BRCM_MAX_SCB];
> +	struct pci_bus		*bus;
> +	struct device		*dev;
> +	struct list_head	resource;
> +	int			msi_irq;
> +	struct brcm_msi		*msi;
> +	unsigned int		rev;
> +	unsigned int		num;
> +	bool			bridge_setup_done;
> +	enum brcm_pcie_type	type;
> +	const struct brcm_pcie_ll_ops *ops;
> +	unsigned int		num_memc;
> +};
> +
> +/* Helper functions to access read/write config space and software init
> +which
> + * are chip-specific
> + */
> +static inline u32 brcm_pcie_ll_read_config(struct brcm_pcie *pcie, int
> +cfg_idx) {
> +	return pcie->ops->read_config(pcie, cfg_idx); }
> +
> +static inline void brcm_pcie_ll_write_config(struct brcm_pcie *pcie,
> +					     int cfg_idx, u32 val)
> +{
> +	pcie->ops->write_config(pcie, cfg_idx, val); }
> +
> +static inline void brcm_pcie_rgr1_sw_init(struct brcm_pcie *pcie, u32 mask,
> +					  int shift, u32 val)
> +{
> +	pcie->ops->rgr1_sw_init(pcie, mask, shift, val); }
> +
> +/*
> + * MIPS endianness is configured by boot strap, which also reverses all
> + * bus endianness (i.e., big-endian CPU + big endian bus ==> native
> + * endian I/O).
> + *
> + * Other architectures (e.g., ARM) either do not support big endian, or
> + * else leave I/O in little endian mode.
> + */
> +static inline u32 bpcie_readl(void __iomem *base) {
> +	if (IS_ENABLED(CONFIG_MIPS))
> +		return __raw_readl(base);
> +	else
> +		return readl(base);
> +}
> +
> +static inline void bpcie_writel(u32 val, void __iomem *base) {
> +	if (IS_ENABLED(CONFIG_MIPS))
> +		__raw_writel(val, base);
> +	else
> +		writel(val, base);
> +}
> +
> +#ifdef CONFIG_PCIE_BRCMSTB_MSI
> +int brcm_pcie_enable_msi(struct brcm_pcie *pcie, int nr); void
> +brcm_pcie_msi_chip_set(struct brcm_pcie *pcie); #else static inline int
> +brcm_pcie_enable_msi(struct brcm_pcie *pcie, int nr) {
> +	return 0;
> +}
> +static inline void brcm_pcie_msi_chip_set(struct brcm_pcie *pcie) { }
> +#endif
> +
> +#endif /* __PCIE_BRCMSTB_H */
> --
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
