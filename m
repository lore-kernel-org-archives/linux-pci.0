Return-Path: <SRS0=S6c9=LA=kalray.eu=mrybczyn@kernel.org>
Return-Path: <SRS0=S6c9=LA=kalray.eu=mrybczyn@kernel.org>
Date: Fri, 17 Aug 2018 10:09:50 +0200 (CEST)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
	Srinath Mannam <srinath.mannam@broadcom.com>,
	Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
	Lukas Wunner <lukas@wunner.de>,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
	linux-kernel@vger.kernel.org
Message-ID: <66577784.13494160.1534493390262.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20180817044902.31420-6-benh@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org> <20180817044902.31420-6-benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 5/6] pci: Protect the enable/disable state of
 pci_dev using the state mutex
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>



----- On 17 Aug, 2018, at 06:49, Benjamin Herrenschmidt benh@kernel.crashing.org wrote:

> This protects enable/disable operations using the state mutex to
> avoid races with, for example, concurrent enables on a bridge.
> 
> The bus hierarchy is walked first before taking the lock to
> avoid lock nesting (though it would be ok if we ensured that
> we always nest them bottom-up, it is better to just avoid the
> issue alltogether, especially as we might find cases where
> we want to take it top-down later).
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


> 
> static void pci_enable_bridge(struct pci_dev *dev)
> {
> 	struct pci_dev *bridge;
> -	int retval;
> +	int retval, enabled;
> 
> 	bridge = pci_upstream_bridge(dev);
> 	if (bridge)
> 		pci_enable_bridge(bridge);
> 
> -	if (pci_is_enabled(dev)) {
> -		if (!dev->is_busmaster)
> -			pci_set_master(dev);
> +	/* Already enabled ? */
> +	pci_dev_state_lock(dev);
> +	enabled = pci_is_enabled(dev);
> +	if (enabled && !dev->is_busmaster)
> +		pci_set_master(dev);
> +	pci_dev_state_unlock(dev);
> +	if (enabled)
> 		return;
> -	}
> 

This looks complicated too me especially with the double locking. What do you
think about a function doing that check that used an unlocked version of
pcie_set_master?

Like:

        dev_state_lock(dev);
        enabled = pci_is_enabled(dev);
        if (enabled &&  !dev->is_busmaster)
                pci_set_master_unlocked();
        pci_dev_state_unlock(dev);

BTW If I remember correctly the code today can set bus mastering multiple
times without checking if already done.

Marta
