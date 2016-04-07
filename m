Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:44833 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755623AbcDGLrM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 07:47:12 -0400
Date: Thu, 7 Apr 2016 19:42:59 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] PCI: designware: move remaining rc setup code to
 dw_pcie_setup_rc()
Message-ID: <20160407194259.5c13742c@xhacker>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ED44208@lhreml503-mbs>
References: <1458128433-3020-1-git-send-email-jszhang@marvell.com>
	<EE11001F9E5DDD47B7634E2F8A612F2E1ED40E52@lhreml503-mbs>
	<20160407103734.55e72da7@xhacker>
	<EE11001F9E5DDD47B7634E2F8A612F2E1ED43F95@lhreml503-mbs>
	<20160407163443.291fbd49@xhacker>
	<EE11001F9E5DDD47B7634E2F8A612F2E1ED44208@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 7 Apr 2016 10:06:45 +0000 Gabriele Paoloni wrote:

> Hi Jisheng
> 
..
> > >  
> > > >
> > > > Is it acceptable that pcie-hisi adds a call to dw_pcie_setup_rc()  
> > in  
> > > > hisi_add_pcie_port()?  
> > >
> > > I don't think so...that would try to overwrite what is already set by
> > > the bootloader; so it is wrong in principle and maybe it can lead to
> > > undefined behaviours...  
> > 
> > make sense! This commit is intend to re-setup the rc when waken from
> > s2ram (in
> > s2ram state, the host lost power)
> > 
> > I have no good solution but to introduce one function e.g
> > dw_pcie_setup_rc_after_linkup(), then move related code from
> > dw_pcie_host_init
> > to it, then let my host driver resume hook to call.
> > 
> > Hi Pratyush, Jingoo and Bjorn etc.
> > 
> > any suggestions are appreciated!  
> 
> What about:
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index a4cccd3..e461f5d 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -434,7 +434,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	struct platform_device *pdev = to_platform_device(pp->dev);
>  	struct pci_bus *bus, *child;
>  	struct resource *cfg_res;
> -	u32 val;
>  	int i, ret;
>  	LIST_HEAD(res);
>  	struct resource_entry *win;
> @@ -544,25 +543,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (pp->ops->host_init)
>  		pp->ops->host_init(pp);
>  
> -	/*
> -	 * If the platform provides ->rd_other_conf, it means the platform
> -	 * uses its own address translation component rather than ATU, so
> -	 * we should not program the ATU here.
> -	 */
> -	if (!pp->ops->rd_other_conf)
> -		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> -					  PCIE_ATU_TYPE_MEM, pp->mem_base,
> -					  pp->mem_bus_addr, pp->mem_size);
> -
> -	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> -
> -	/* program correct class for RC */
> -	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> -
> -	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
> -	val |= PORT_LOGIC_SPEED_CHANGE;
> -	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);

If we introduced one global function, is it better to keep the RC registers
program sequence not changed at all? And ask each pcie dw users to call this
new function in its resume hook if necessary. Either is fine, and can provide
what I want, let's wait maintainers' comments.

Something like:


diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index a4cccd3..53c6176 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -434,7 +434,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct platform_device *pdev = to_platform_device(pp->dev);
 	struct pci_bus *bus, *child;
 	struct resource *cfg_res;
-	u32 val;
 	int i, ret;
 	LIST_HEAD(res);
 	struct resource_entry *win;
@@ -544,24 +543,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->host_init)
 		pp->ops->host_init(pp);
 
-	/*
-	 * If the platform provides ->rd_other_conf, it means the platform
-	 * uses its own address translation component rather than ATU, so
-	 * we should not program the ATU here.
-	 */
-	if (!pp->ops->rd_other_conf)
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_MEM, pp->mem_base,
-					  pp->mem_bus_addr, pp->mem_size);
-
-	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
-
-	/* program correct class for RC */
-	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
-
-	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
-	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
+	dw_pcie_setup_rc_after_linkup(pp);
 
 	pp->root_bus_nr = pp->busn->start;
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
@@ -725,6 +707,30 @@ static struct pci_ops dw_pcie_ops = {
 	.write = dw_pcie_wr_conf,
 };
 
+void dw_pcie_setup_rc_after_linkup(struct pcie_port *pp)
+{
+	u32 val;
+
+	/*
+	 * If the platform provides ->rd_other_conf, it means the platform
+	 * uses its own address translation component rather than ATU, so
+	 * we should not program the ATU here.
+	 */
+	if (!pp->ops->rd_other_conf)
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+					  PCIE_ATU_TYPE_MEM, pp->mem_base,
+					  pp->mem_bus_addr, pp->mem_size);
+
+	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
+
+	/* program correct class for RC */
+	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
+
+	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
+	val |= PORT_LOGIC_SPEED_CHANGE;
+	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
+}
+
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val;
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index f437f9b..f7746bf 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -85,5 +85,6 @@ int dw_pcie_wait_for_link(struct pcie_port *pp);
 int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
+void dw_pcie_setup_rc_after_linkup(struct pcie_port *pp);
 
 #endif /* _PCIE_DESIGNWARE_H */

