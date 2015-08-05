Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32964 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbbHEJZg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Aug 2015 05:25:36 -0400
Date: Wed, 5 Aug 2015 10:25:34 +0100
From: Will Deacon <will.deacon@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jayachandran C <jchandra@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v4 1/3] PCI: generic: remove dependency on hw_pci
Message-ID: <20150805092533.GC6092@arm.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
 <20150804234956.GF17327@google.com>
 <20150805092318.GB6092@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150805092318.GB6092@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 05, 2015 at 10:23:18AM +0100, Will Deacon wrote:
> That said, I just tried to build this and it fails to compile the x-gene
> PCI host driver. Fixup below.

Wait, there's more!

Will

--->8

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 514f41b86c49..8ab3bd098424 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -506,7 +506,7 @@ static int xgene_pcie_msi_enable(struct xgene_pcie_port *port)
 {
 	struct device_node *msi_node;
 
-	msi_node = of_parse_phandle(port->dev.of_node, "msi-parent", 0);
+	msi_node = of_parse_phandle(port->dev->of_node, "msi-parent", 0);
 	if (!msi_node)
 		return -ENODEV;
 
@@ -515,7 +515,7 @@ static int xgene_pcie_msi_enable(struct xgene_pcie_port *port)
 		return -ENODEV;
 
 	of_node_put(msi_node);
-	port->msi->dev = &port->dev;
+	port->msi->dev = port->dev;
 	return 0;
 }
 

