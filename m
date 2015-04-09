Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Apr 2015 14:32:32 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: versatile: don't check resource with
 devm_ioremap_resource
Message-ID: <20150409193232.GK30967@google.com>
References: <1428067025-543-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428067025-543-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 03, 2015 at 09:17:05PM +0800, Jisheng Zhang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need
> to duplicate this in the driver. And we should check whether
> devm_ioremap_resource() succeeds or not.
> 
> This patch fixes all of these two trival issues.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

This looks correct to me, so I applied it to pci/host-versatile for v4.1
(unless Rob chimes in).

commit 873581698d391ff070fc1eb8fb298c85e873c07c
Author: Jisheng Zhang <jszhang@marvell.com>
Date:   Fri Apr 3 21:17:05 2015 +0800

    PCI: versatile: Check for devm_ioremap_resource() failures
    
    Check for failure of devm_ioremap_resource().
    
    devm_ioremap_resource() validates the resource it receives, so if we check
    for devm_ioremap_resource() failure, we need not check for failure of the
    preceding platform_get_resource().
    
    [bhelgaas: changelog]
    Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 1ec694a52379..b1caaea740fe 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -138,19 +138,19 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	LIST_HEAD(pci_res);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
 	versatile_pci_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(versatile_pci_base))
+		return PTR_ERR(versatile_pci_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
-		return -ENODEV;
 	versatile_cfg_base[0] = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(versatile_cfg_base[0]))
+		return PTR_ERR(versatile_cfg_base[0]);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	if (!res)
-		return -ENODEV;
 	versatile_cfg_base[1] = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(versatile_cfg_base[1]))
+		return PTR_ERR(versatile_cfg_base[1]);
 
 	ret = versatile_pci_parse_request_of_pci_ranges(&pdev->dev, &pci_res);
 	if (ret)
