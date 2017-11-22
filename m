Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44847 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdKVPHx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 10:07:53 -0500
Date: Wed, 22 Nov 2017 07:07:51 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        "open list:CORETEMP HARDWARE MONITORING DRIVER"
        <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [11/30] hwmon: (coretemp) deprecate pci_get_bus_and_slot()
Message-ID: <20171122150751.GA25158@roeck-us.net>
References: <1511328675-21981-12-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511328675-21981-12-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 22, 2017 at 12:30:56AM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/coretemp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index c13a4fd..4bdbf77 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -246,7 +246,8 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
>  	int err;
>  	u32 eax, edx;
>  	int i;
> -	struct pci_dev *host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> +	u16 devfn = PCI_DEVFN(0, 0);
> +	struct pci_dev *host_bridge = pci_get_domain_bus_and_slot(0, 0, devfn);
>  
>  	/*
>  	 * Explicit tjmax table entries override heuristics.
