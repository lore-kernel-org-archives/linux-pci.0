Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752296AbdHBJBO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 05:01:14 -0400
Date: Wed, 2 Aug 2017 10:03:07 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
Cc: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar-pcie: Fix memory leak when no PCIe card is
 inserted
Message-ID: <20170802090307.GA24167@red-moon>
References: <20170802071320.28674-1-harunobu.kurokawa.dn@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170802071320.28674-1-harunobu.kurokawa.dn@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 02, 2017 at 04:13:20PM +0900, Harunobu Kurokawa wrote:
> When no PCIe card is inserted, there is a memory leak as
> pci_free_resource_list is not called before returning.
> 
> Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> ---
>  drivers/pci/host/pcie-rcar.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index ac80fbb..9b06de6 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1190,14 +1190,15 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -err_free_bridge:
> -	pci_free_host_bridge(bridge);
> -
>  err_pm_put:
>  	pm_runtime_put(dev);
>  
>  err_pm_disable:
>  	pm_runtime_disable(dev);
> +
> +err_free_bridge:
> +	pci_free_host_bridge(bridge);
> +	pci_free_resource_list(&pcie->resources);
>  	return err;
>  }

The error code path needs fixing but not like this (with a single
patch lumping all fixes - well, actually it does not - together).

Step one, patch below. Step two free the &pci->resources list
(which IIUC was not freed even before commit 90634e854079) in
a separate patch.

Am I missing something ?

Please apply, check and repost the patch if it is ok, thanks.

-- >8 --
Subject: [PATCH] PCI: rcar: Fix error exit path

Commit 90634e854079 ("PCI: rcar: Convert PCI scan API to
pci_scan_root_bus_bridge()") converted PCI root bus scan API
to the new pci_scan_root_bus_bridge() API; in the process
some error paths were not updated correctly which may
cause memory leaks.

Fix the driver error exit path reinstating the previous
correct error exit behaviour.

Fixes: 90634e854079 ("PCI: rcar: Convert PCI scan API to pci_scan_root_bus_bridge()")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/host/pcie-rcar.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 246d485..007523e 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -471,10 +471,8 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 		bridge->msi = &pcie->msi.chip;
 
 	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret < 0) {
-		kfree(bridge);
+	if (ret < 0)
 		return ret;
-	}
 
 	bus = bridge->bus;
 
@@ -1190,14 +1188,15 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_free_bridge:
-	pci_free_host_bridge(bridge);
-
 err_pm_put:
 	pm_runtime_put(dev);
 
 err_pm_disable:
 	pm_runtime_disable(dev);
+
+err_free_bridge:
+	pci_free_host_bridge(bridge);
+
 	return err;
 }
 
-- 
2.10.0
