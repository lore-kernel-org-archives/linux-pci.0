Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38504 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbFLUUM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jun 2015 16:20:12 -0400
Received: by igblz2 with SMTP id lz2so17728684igb.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2015 13:20:11 -0700 (PDT)
Date: Fri, 12 Jun 2015 15:20:08 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: festevam@gmail.com, marex@denx.de, linux-pci@vger.kernel.org,
	r65037@freescale.com, l.stach@pengutronix.de, tharvey@gateworks.com
Subject: Re: [PATCH 1/1] pci-imx6: add speed change timeout message
Message-ID: <20150612202008.GI23119@google.com>
References: <1433543864-7252-1-git-send-email-troy.kisky@boundarydevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433543864-7252-1-git-send-email-troy.kisky@boundarydevices.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Troy,

On Fri, Jun 05, 2015 at 03:37:44PM -0700, Troy Kisky wrote:
> Currently, the timeout is never detected as count
> has a value of -1 if a timeout happens, but the code is checking
> for 0. Also, this patch removes the unneeded final wait
> if a timeout occurs.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  drivers/pci/host/pci-imx6.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index fdb9536..51be92c 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -398,20 +398,22 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
>  	writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
>  
>  	count = 200;
> -	while (count--) {
> +	while (1) {
>  		tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
>  		/* Test if the speed change finished. */
> -		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
> +		if (!(tmp & PORT_LOGIC_SPEED_CHANGE)) {
> +			/* Make sure link training is finished as well! */
> +			ret = imx6_pcie_wait_for_link(pp);
> +			break;
> +		}
> +		if (count-- == 0) {
> +			dev_err(pp->dev, "Speed change timeout\n");
> +			ret = -EINVAL;
>  			break;
> +		}
>  		usleep_range(100, 1000);
>  	}
>  
> -	/* Make sure link training is finished as well! */
> -	if (count)
> -		ret = imx6_pcie_wait_for_link(pp);
> -	else
> -		ret = -EINVAL;
> -
>  	if (ret) {
>  		dev_err(pp->dev, "Failed to bring link up!\n");
>  	} else {

This looks fine functionally, but I propose the following slight
rearrangement because I have another patch that makes all the
"wait_for_link" timeout loops look similar, and this loop might as
well be similar, too.

Unrelated to your patch, but noticed while doing this: what's the magic
constant 0x80 here?

+	tmp = readl(pp->dbi_base + 0x80);

Is that correct?  Can we add a symbolic name for it?

Bjorn


commit 24533d23e8fa
Author: Troy Kisky <troy.kisky@boundarydevices.com>
Date:   Fri Jun 12 14:30:16 2015 -0500

    PCI: imx6: Add speed change timeout message
    
    Currently, the timeout is never detected as count has a value of -1 if a
    timeout happens, but the code is checking for 0.  Also, this patch removes
    the unneeded final wait if a timeout occurs.
    
    [bhelgaas: reworked starting from http://lkml.kernel.org/r/1433543864-7252-1-git-send-email-troy.kisky@boundarydevices.com]
    Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index fdb9536..2bbd38d 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -352,6 +352,23 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 	return 0;
 }
 
+static int imx6_pcie_wait_for_speed_change(struct pcie_port *pp)
+{
+	uint32_t tmp;
+	unsigned int retries;
+
+	for (retries = 0; retries < 200; retries++)
+		tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+		/* Test if the speed change finished. */
+		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
+			return 0;
+		usleep_range(100, 1000);
+	}
+
+	dev_err(pp->dev, "Speed change timeout\n");
+	return -EINVAL;
+}
+
 static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
 {
 	struct pcie_port *pp = arg;
@@ -363,7 +380,7 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 	uint32_t tmp;
-	int ret, count;
+	int ret;
 
 	/*
 	 * Force Gen1 operation when starting the link.  In case the link is
@@ -397,29 +414,22 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
 	tmp |= PORT_LOGIC_SPEED_CHANGE;
 	writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
 
-	count = 200;
-	while (count--) {
-		tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
-		/* Test if the speed change finished. */
-		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
-			break;
-		usleep_range(100, 1000);
+	ret = imx6_pcie_wait_for_speed_change(pp);
+	if (ret) {
+		dev_err(pp->dev, "Failed to bring link up!\n");
+		return ret;
 	}
 
 	/* Make sure link training is finished as well! */
-	if (count)
-		ret = imx6_pcie_wait_for_link(pp);
-	else
-		ret = -EINVAL;
-
+	ret = imx6_pcie_wait_for_link(pp);
 	if (ret) {
 		dev_err(pp->dev, "Failed to bring link up!\n");
-	} else {
-		tmp = readl(pp->dbi_base + 0x80);
-		dev_dbg(pp->dev, "Link up, Gen=%i\n", (tmp >> 16) & 0xf);
+		return ret;
 	}
 
-	return ret;
+	tmp = readl(pp->dbi_base + 0x80);
+	dev_dbg(pp->dev, "Link up, Gen=%i\n", (tmp >> 16) & 0xf);
+	return 0;
 }
 
 static void imx6_pcie_host_init(struct pcie_port *pp)
