Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:52758 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbAISXf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jan 2015 13:23:35 -0500
Received: by mail-oi0-f46.google.com with SMTP id a3so13047261oib.5
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2015 10:23:34 -0800 (PST)
Date: Fri, 9 Jan 2015 11:23:31 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Chris J Arges <chris.j.arges@canonical.com>
Cc: linux-pci@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: use standard parsing functions for sysfs
 setters
Message-ID: <20150109182331.GF6575@google.com>
References: <1417820598-8021-1-git-send-email-chris.j.arges@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417820598-8021-1-git-send-email-chris.j.arges@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 05, 2014 at 05:02:42PM -0600, Chris J Arges wrote:
> The functions link_state_store, clk_ctl_store had just subtracted ASCII '0' from
> input which could lead to undesired results. Instead, use linux string functions
> to safely parse input.
> 
> Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>

Applied to pci/misc for v3.20, thanks.

> ---
>  drivers/pci/pcie/aspm.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index e1e7026..48e1714 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -859,7 +859,10 @@ static ssize_t link_state_store(struct device *dev,
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct pcie_link_state *link, *root = pdev->link_state->root;
> -	u32 val = buf[0] - '0', state = 0;
> +	u32 state = 0;
> +	u32 val;
> +
> +	kstrtouint(buf, 10, &val);
>  
>  	if (aspm_disabled)
>  		return -EPERM;
> @@ -900,15 +903,14 @@ static ssize_t clk_ctl_store(struct device *dev,
>  		size_t n)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	int state;
> +	bool state;
>  
> -	if (n < 1)
> +	if (strtobool(buf, &state))
>  		return -EINVAL;
> -	state = buf[0]-'0';
>  
>  	down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
> -	pcie_set_clkpm_nocheck(pdev->link_state, !!state);
> +	pcie_set_clkpm_nocheck(pdev->link_state, state);
>  	mutex_unlock(&aspm_lock);
>  	up_read(&pci_bus_sem);
>  
> -- 
> 1.9.1
> 
