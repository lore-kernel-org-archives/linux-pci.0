Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:32992 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934584AbdCaBNc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2017 21:13:32 -0400
Received: by mail-pg0-f42.google.com with SMTP id x125so54960441pgb.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2017 18:13:31 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh@kernel.org>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI: don't allow unbinding host controllers that aren't prepared
Date: Thu, 30 Mar 2017 18:12:03 -0700
Message-Id: <20170331011203.41505-1-briannorris@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Many PCI host controller drivers aren't prepared to have their devices
unbound from them forcefully (e.g., through /sys/.../<driver>/unbind),
as they don't provide any driver .remove callback, where they'd detach
the root bus, release resources, etc. Keeping the driver built in (i.e.,
not a loadable module) is not enough; and providing no .remove callback
just means we don't do any teardown.

To rule out the possibility of unbinding a device via sysfs, we need to
set the ".suppress_bind_attrs" field.

I found the suspect drivers via the following search:

  git grep -l platform_driver $(git grep -L -e '\.remove' -e suppress_bind_attrs drivers/pci/)

Then I inspected them to ensure that
(a) they set up a PCI bus in their probe() and
(b) they don't have a remove() callback for undoing the setup

I excluded drivers/pci/host/pcie-rockchip.c, because I've implemented
remove() support elsewhere [1].

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1349576.html
    [PATCH v2 3/5] PCI: rockchip: add remove() support

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Not tested, other than to compile a few of these.

 drivers/pci/dwc/pci-imx6.c             | 1 +
 drivers/pci/dwc/pci-layerscape.c       | 1 +
 drivers/pci/dwc/pcie-armada8k.c        | 1 +
 drivers/pci/dwc/pcie-artpec6.c         | 1 +
 drivers/pci/dwc/pcie-designware-plat.c | 1 +
 drivers/pci/dwc/pcie-hisi.c            | 2 ++
 drivers/pci/dwc/pcie-spear13xx.c       | 1 +
 drivers/pci/host/pci-ftpci100.c        | 1 +
 drivers/pci/host/pci-host-generic.c    | 1 +
 drivers/pci/host/pci-thunder-ecam.c    | 1 +
 drivers/pci/host/pci-thunder-pem.c     | 1 +
 drivers/pci/host/pci-versatile.c       | 1 +
 drivers/pci/host/pci-xgene.c           | 1 +
 13 files changed, 14 insertions(+)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index 801e46cd266d..f85a063e9964 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -725,6 +725,7 @@ static struct platform_driver imx6_pcie_driver = {
 	.driver = {
 		.name	= "imx6q-pcie",
 		.of_match_table = imx6_pcie_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.shutdown = imx6_pcie_shutdown,
 };
diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index c32e392a0ae6..880f345bff43 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -305,6 +305,7 @@ static struct platform_driver ls_pcie_driver = {
 	.driver = {
 		.name = "layerscape-pcie",
 		.of_match_table = ls_pcie_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 builtin_platform_driver_probe(ls_pcie_driver, ls_pcie_probe);
diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index f110e3b24a26..9d8f7e4db5df 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -262,6 +262,7 @@ static struct platform_driver armada8k_pcie_driver = {
 	.driver = {
 		.name	= "armada8k-pcie",
 		.of_match_table = of_match_ptr(armada8k_pcie_of_match),
+		.suppress_bind_attrs = true,
 	},
 };
 builtin_platform_driver(armada8k_pcie_driver);
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index fcd3ef845883..7a86d4b4dcc1 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -290,6 +290,7 @@ static struct platform_driver artpec6_pcie_driver = {
 	.driver = {
 		.name	= "artpec6-pcie",
 		.of_match_table = artpec6_pcie_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 builtin_platform_driver(artpec6_pcie_driver);
diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index b6c832ba39dd..bdb75a5758ae 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -129,6 +129,7 @@ static struct platform_driver dw_plat_pcie_driver = {
 	.driver = {
 		.name	= "dw-pcie",
 		.of_match_table = dw_plat_pcie_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = dw_plat_pcie_probe,
 };
diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
index fd66a3199db7..088ed5e4e46b 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/dwc/pcie-hisi.c
@@ -334,6 +334,7 @@ static struct platform_driver hisi_pcie_driver = {
 	.driver = {
 		   .name = "hisi-pcie",
 		   .of_match_table = hisi_pcie_of_match,
+		   .suppress_bind_attrs = true,
 	},
 };
 builtin_platform_driver(hisi_pcie_driver);
@@ -391,6 +392,7 @@ static struct platform_driver hisi_pcie_almost_ecam_driver = {
 	.driver = {
 		   .name = "hisi-pcie-almost-ecam",
 		   .of_match_table = hisi_pcie_almost_ecam_of_match,
+		   .suppress_bind_attrs = true,
 	},
 };
 builtin_platform_driver(hisi_pcie_almost_ecam_driver);
diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
index eaa4ea8e2ea4..0d117499da0d 100644
--- a/drivers/pci/dwc/pcie-spear13xx.c
+++ b/drivers/pci/dwc/pcie-spear13xx.c
@@ -308,6 +308,7 @@ static struct platform_driver spear13xx_pcie_driver = {
 	.driver = {
 		.name	= "spear-pcie",
 		.of_match_table = of_match_ptr(spear13xx_pcie_of_match),
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 4ae5418a1aad..9d2713707a91 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -556,6 +556,7 @@ static struct platform_driver faraday_pci_driver = {
 	.driver = {
 		.name = "ftpci100",
 		.of_match_table = of_match_ptr(faraday_pci_of_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe  = faraday_pci_probe,
 };
diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index c05ea9d72f69..7d709a7e0aa8 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -60,6 +60,7 @@ static struct platform_driver gen_pci_driver = {
 	.driver = {
 		.name = "pci-host-generic",
 		.of_match_table = gen_pci_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = gen_pci_probe,
 };
diff --git a/drivers/pci/host/pci-thunder-ecam.c b/drivers/pci/host/pci-thunder-ecam.c
index 3f54a43bbbea..fc0ca03f280e 100644
--- a/drivers/pci/host/pci-thunder-ecam.c
+++ b/drivers/pci/host/pci-thunder-ecam.c
@@ -373,6 +373,7 @@ static struct platform_driver thunder_ecam_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = thunder_ecam_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = thunder_ecam_probe,
 };
diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index 52b5bdccf5f0..4260b0765949 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -416,6 +416,7 @@ static struct platform_driver thunder_pem_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = thunder_pem_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = thunder_pem_probe,
 };
diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 5ebee7d37ff5..5a5b84227eb6 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -221,6 +221,7 @@ static struct platform_driver versatile_pci_driver = {
 	.driver = {
 		.name = "versatile-pci",
 		.of_match_table = versatile_pci_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = versatile_pci_probe,
 };
diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 1a6108788f6f..517bea33809f 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -697,6 +697,7 @@ static struct platform_driver xgene_pcie_driver = {
 	.driver = {
 		   .name = "xgene-pcie",
 		   .of_match_table = of_match_ptr(xgene_pcie_match_table),
+		   .suppress_bind_attrs = true,
 	},
 	.probe = xgene_pcie_probe_bridge,
 };
-- 
2.12.2.564.g063fe858b8-goog
