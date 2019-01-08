Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8433FC43444
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 10:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1A42173C
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 10:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfAHKsb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:48:31 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33498 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfAHKsb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jan 2019 05:48:31 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EE54A209D7; Tue,  8 Jan 2019 11:48:27 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr [90.88.149.148])
        by mail.bootlin.com (Postfix) with ESMTPSA id BEECD20432;
        Tue,  8 Jan 2019 11:48:17 +0100 (CET)
Date:   Tue, 8 Jan 2019 11:48:17 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Regression with commit PCI: mvebu: Convert to PCI emulated
 bridge config space
Message-ID: <20190108114817.2bb15d5e@windsurf>
In-Reply-To: <CAEzXK1qKXikS4qd1q_kw7r-_ykBgYnKQzGFhV4TT_HXhq2v6Tw@mail.gmail.com>
References: <CAEzXK1o9L-bVRGBpAo+a_wYqXZh6_zuebF221Bd8=b-DTL1Q9g@mail.gmail.com>
        <20181218144702.752d97cd@windsurf>
        <20181218153404.45b038cf@windsurf>
        <CAEzXK1ryTQ5sbUSuZoq36ss=Z7ewLegaxsXtvsNOGqHyTQibmg@mail.gmail.com>
        <20181218213716.70d27f1f@windsurf>
        <CAEzXK1qKXikS4qd1q_kw7r-_ykBgYnKQzGFhV4TT_HXhq2v6Tw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/TxW1cQ+a1jh1mQUOvGQreYe"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--MP_/TxW1cQ+a1jh1mQUOvGQreYe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Luis,

Sorry for the long delay, the Christmas/New Year vacation and some
personal issues got in the way.

On Tue, 18 Dec 2018 23:13:59 +0000, Lu=C3=ADs Mendes wrote:

> The complete lspci outputs follow in attachments.
>=20
> In the working case, region 5, is at e0200000 with size 256k and is
> immediately followed by the expansion rom at  e0240000 [disabled]
> [size=3D128K], however in the non-working case,
> region 5 has a completely different address, and regions are not contiguo=
us.
> Another difference is at:
> Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>         Address: 00000000f1020a04  Data: 0f12
>=20
> vs
>=20
>     Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>=20
> So it looks like MSI is not being enabled with the new PCI management
> code and looks like the PCI rom maybe mapped to an invalid memory
> address, causing the ioremap to fail.

Could you apply the patches attached (one is meant to be used with 4.20
as-is, and the other meant to be used with 4.20 +
1f08673eef1236f7d02d93fcf596bb8531ef0d12 reverted), and post the
complete boot logs ?

You will most likely have to increase CONFIG_LOG_BUF_SHIFT to avoid
having dropped messages, as my additional debug messages are quite
verbose. I'm using CONFIG_LOG_BUF_SHIFT=3D16.

Having these boot lots will help me investigate the issue.

Best regards,

Thomas
--=20
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--MP_/TxW1cQ+a1jh1mQUOvGQreYe
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=0001-PCI-mvebu-add-debug.patch

From 2bd51f2891150b524f73e58c55da5fe68a7d1457 Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 8 Jan 2019 10:59:19 +0100
Subject: [PATCH] PCI: mvebu: add debug

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index fa0fc46edb0c..9715ba070263 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -624,9 +624,13 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Access the emulated PCI-to-PCI bridge */
-	if (bus->number == 0)
+	if (bus->number == 0) {
+		dev_info(&pcie->pdev->dev,
+			 "%s: devfn=0x%x, where=0x%x, size=%d, val=0x%x\n",
+			 __func__, devfn, where, size, val);
 		return pci_bridge_emul_conf_write(&port->bridge, where,
 						  size, val);
+	}
 
 	if (!mvebu_pcie_link_up(port))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -653,9 +657,14 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 	}
 
 	/* Access the emulated PCI-to-PCI bridge */
-	if (bus->number == 0)
-		return pci_bridge_emul_conf_read(&port->bridge, where,
-						 size, val);
+	if (bus->number == 0) {
+		ret = pci_bridge_emul_conf_read(&port->bridge, where,
+						size, val);
+		dev_info(&pcie->pdev->dev,
+			 "%s: devfn=0x%x, where=0x%x, size=%d, val=0x%x\n",
+			 __func__, devfn, where, size, *val);
+		return ret;
+	}
 
 	if (!mvebu_pcie_link_up(port)) {
 		*val = 0xffffffff;
@@ -986,6 +995,8 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 	/* Get the PCIe IO aperture */
 	mvebu_mbus_get_pcie_io_aperture(&pcie->io);
 
+	dev_info(dev, "MEM: %pR, IO: %pR\n", &pcie->mem, &pcie->io);
+
 	if (resource_size(&pcie->io) != 0) {
 		pcie->realio.flags = pcie->io.flags;
 		pcie->realio.start = PCIBIOS_MIN_IO;
-- 
2.20.1


--MP_/TxW1cQ+a1jh1mQUOvGQreYe
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-PCI-mvebu-add-debug-after-revert.patch

From ac0aa231c23390150dddfdf923400af2a4a4e86b Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 8 Jan 2019 10:59:19 +0100
Subject: [PATCH] PCI: mvebu: add debug

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index dacad51f19e7..94aa7e42c5e2 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -796,8 +796,12 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Access the emulated PCI-to-PCI bridge */
-	if (bus->number == 0)
+	if (bus->number == 0) {
+		dev_info(&pcie->pdev->dev,
+			 "%s: devfn=0x%x, where=0x%x, size=%d, val=0x%x\n",
+			 __func__, devfn, where, size, val);
 		return mvebu_sw_pci_bridge_write(port, where, size, val);
+	}
 
 	if (!mvebu_pcie_link_up(port))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -824,8 +828,13 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 	}
 
 	/* Access the emulated PCI-to-PCI bridge */
-	if (bus->number == 0)
-		return mvebu_sw_pci_bridge_read(port, where, size, val);
+	if (bus->number == 0) {
+		ret = mvebu_sw_pci_bridge_read(port, where, size, val);
+		dev_info(&pcie->pdev->dev,
+			 "%s: devfn=0x%x, where=0x%x, size=%d, val=0x%x\n",
+			 __func__, devfn, where, size, *val);
+		return ret;
+	}
 
 	if (!mvebu_pcie_link_up(port)) {
 		*val = 0xffffffff;
@@ -1156,6 +1165,8 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 	/* Get the PCIe IO aperture */
 	mvebu_mbus_get_pcie_io_aperture(&pcie->io);
 
+	dev_info(dev, "MEM: %pR, IO: %pR\n", &pcie->mem, &pcie->io);
+
 	if (resource_size(&pcie->io) != 0) {
 		pcie->realio.flags = pcie->io.flags;
 		pcie->realio.start = PCIBIOS_MIN_IO;
-- 
2.20.1


--MP_/TxW1cQ+a1jh1mQUOvGQreYe--
