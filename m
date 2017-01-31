Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750891AbdAaPTz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jan 2017 10:19:55 -0500
Date: Tue, 31 Jan 2017 09:09:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shailendra Verma <shailendra.v@samsung.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.shailesh@samsung.com,
        ashish.kalra@samsung.com,
        Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: Re: [PATCH] Pci: host - Fix possible NULL derefrence.
Message-ID: <20170131150900.GB9942@bhelgaas-glaptop.roam.corp.google.com>
References: <CGME20170130044942epcas2p4c3e879675c189ff46c27b5f35bbc350f@epcas2p4.samsung.com>
 <1485751775-29126-1-git-send-email-shailendra.v@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485751775-29126-1-git-send-email-shailendra.v@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shailendra,

On Mon, Jan 30, 2017 at 10:19:35AM +0530, Shailendra Verma wrote:
> of_match_device could return NULL, and so can cause a NULL
> pointer dereference later.
> 
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> ---
>  drivers/pci/host/pcie-hisi.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> index 56154c2..3256f8f 100644
> --- a/drivers/pci/host/pcie-hisi.c
> +++ b/drivers/pci/host/pcie-hisi.c
> @@ -174,6 +174,10 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>  	driver = dev->driver;
>  
>  	match = of_match_device(driver->of_match_table, dev);
> +	if (!match) {
> +		dev_err(dev, "Error: No device match found\n");
> +		return -ENODEV;
> +	}
>  	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
>  
>  	hisi_pcie->subctrl =

I like this patch and I think it's correct.  I'd like an ack from Zhou
and/or Gabriele, and I'd propose the following tweak, which just moves the
check earlier, before we start allocating this:


commit 0bd4137b946cab412d612ae155f3b268f2f0a856
Author: Shailendra Verma <shailendra.v@samsung.com>
Date:   Mon Jan 30 10:19:35 2017 +0530

    PCI: hisi: Check of_match_device() return value
    
    of_match_device() could return NULL, and so can cause a NULL pointer
    dereference later.  Check the result first, before we start setting up
    things that need to be undone if it fails.
    
    [bhelgaas: check earlier, changelog]
    Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index a301a7187b30..0f0521169a3c 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -264,6 +264,10 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	struct device_driver *driver;
 	int ret;
 
+	match = of_match_device(driver->of_match_table, dev);
+	if (!match)
+		return -ENODEV;
+
 	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
 	if (!hisi_pcie)
 		return -ENOMEM;
@@ -272,7 +276,6 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	pp->dev = dev;
 	driver = dev->driver;
 
-	match = of_match_device(driver->of_match_table, dev);
 	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
 
 	hisi_pcie->subctrl =
