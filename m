Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62195 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751428AbaBMAaK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 19:30:10 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Remove unnecessary list_empty(&pci_pme_list) check
Date: Thu, 13 Feb 2014 01:44:50 +0100
Message-ID: <1584702.QFexHcKXLf@vostro.rjw.lan>
In-Reply-To: <20140212191053.5459.95323.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140212190949.5459.46330.stgit@bhelgaas-glaptop.roam.corp.google.com> <20140212191053.5459.95323.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, February 12, 2014 12:10:53 PM Bjorn Helgaas wrote:
> list_for_each_entry() handles empty lists just fine, so there's no need to
> check whether the list is empty first.
> 
> No functional change.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c |   40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1febe90831b4..52e10e1181d0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1611,29 +1611,27 @@ static void pci_pme_list_scan(struct work_struct *work)
>  	struct pci_pme_device *pme_dev, *n;
>  
>  	mutex_lock(&pci_pme_list_mutex);
> -	if (!list_empty(&pci_pme_list)) {
> -		list_for_each_entry_safe(pme_dev, n, &pci_pme_list, list) {
> -			if (pme_dev->dev->pme_poll) {
> -				struct pci_dev *bridge;
> -
> -				bridge = pme_dev->dev->bus->self;
> -				/*
> -				 * If bridge is in low power state, the
> -				 * configuration space of subordinate devices
> -				 * may be not accessible
> -				 */
> -				if (bridge && bridge->current_state != PCI_D0)
> -					continue;
> -				pci_pme_wakeup(pme_dev->dev, NULL);
> -			} else {
> -				list_del(&pme_dev->list);
> -				kfree(pme_dev);
> -			}
> +	list_for_each_entry_safe(pme_dev, n, &pci_pme_list, list) {
> +		if (pme_dev->dev->pme_poll) {
> +			struct pci_dev *bridge;
> +
> +			bridge = pme_dev->dev->bus->self;
> +			/*
> +			 * If bridge is in low power state, the
> +			 * configuration space of subordinate devices
> +			 * may be not accessible
> +			 */
> +			if (bridge && bridge->current_state != PCI_D0)
> +				continue;
> +			pci_pme_wakeup(pme_dev->dev, NULL);
> +		} else {
> +			list_del(&pme_dev->list);
> +			kfree(pme_dev);
>  		}
> -		if (!list_empty(&pci_pme_list))
> -			schedule_delayed_work(&pci_pme_work,
> -					      msecs_to_jiffies(PME_TIMEOUT));
>  	}
> +	if (!list_empty(&pci_pme_list))
> +		schedule_delayed_work(&pci_pme_work,
> +				      msecs_to_jiffies(PME_TIMEOUT));
>  	mutex_unlock(&pci_pme_list_mutex);
>  }
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
