Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF733A9C4;
	Thu,  5 Mar 2026 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753944; cv=none; b=B9lTmJuG0E6ik2TR1SaXnuZLuEDK0MV2yBK47nTQYGjdeC5cLPmllA7w760IdrxW5WEhcCpOvPMjYE+EM03Z0QRfIsUDH6ZDgxC27LMbGwK5t/rBu5mXk6L1uxM5e1Kl2Ej+L3ZlVaPu0wGGyCVsEUTlP0UwrA9Wzs+wF3g0NLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753944; c=relaxed/simple;
	bh=aT4WhbE8Nrb6sC1xx+3iJ7Azv5WPxuLbZVGaI//+MyE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qYa6cduga1AAqynePFJfhZNnexWMR+xcSjNJvNb9CSzwPFDjHKq5hwF1KZKNpvkWsMjdHMlRRo/FOiTO8JAJNLE4Q6ZkuTwKBFWoXDbkVj6UWYGtaDmX2VjjEXIFzFQO8MR1kuFV2N3avMHTBaY9PIkAxW8OhD4bLDERTzypvpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqonaUMm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqonaUMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8300C116C6;
	Thu,  5 Mar 2026 23:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753944;
	bh=aT4WhbE8Nrb6sC1xx+3iJ7Azv5WPxuLbZVGaI//+MyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mqonaUMm8yiy/hoVyQK0VWbgVgZD1rEPEkfkWO7HCKURlFQVjyx8BKYkP6qITunbN
	 Bo6RjKvlAyrQwak/spxeuKaslaSHJV1OY/746R7ngrJKJWJ/937xZ5Ul0/Sq5fOsvR
	 vAPnu/5n1Q5ksjOaIgMm/Ixm5Yiorqic9+XZcvlsA+7r3kK94XBLTmmDO4oYICpxGs
	 KY2oo85ixxQ5dybGO33Zx7C+KlEUKrBrFGQQI6YVVKW57muzmHbrAal81nieRiBUkA
	 ylbe2O3akk6+zpf4O9jNOkpwkbTZRU/EXOpumaUW8+Wwk0dCJHnhxwT2P6/AintuzV
	 wve+mzYqi/mSw==
Date: Thu, 5 Mar 2026 17:39:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Jinhui Guo <guojinhui.liam@bytedance.com>,
	Keith Busch <kbusch@kernel.org>,
	"Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: Consolidate
 pci_bus/slot_lock/unlock/trylock()
Message-ID: <20260305233902.GA80310@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304122139.1479-1-ilpo.jarvinen@linux.intel.com>

On Wed, Mar 04, 2026 at 02:21:38PM +0200, Ilpo Järvinen wrote:
> pci_bus/slot_lock/unlock/trylock() largely duplicate the bus iteration
> loop with variation only due to slot filter handling. The only
> differences in the loops is where the struct bus is found (directly in
> the argument vs in slot->bus) and whether slot filter is applied. Those
> difference are simple to handle using function parameters.
> 
> Consolidate the bus iteration loop to one place by creating
> __pci_bus_{lock,unlock,trylock}() and call them from the non-underscore
> locking functions.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/reset for v7.1, thanks, Ilpo.

> ---
> 
> v2:
> - Rebased
> - Fixed rollback path dereferencing slot->bus (changed to use the bus
>   parameter directly as slot can be NULL)
> 
>  drivers/pci/pci.c | 115 ++++++++++++++++++++--------------------------
>  1 file changed, 49 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8479c2e1f74f..c248224e0861 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5292,13 +5292,21 @@ static bool pci_bus_resettable(struct pci_bus *bus)
>  	return true;
>  }
>  
> +static void pci_bus_lock(struct pci_bus *bus);
> +static void pci_bus_unlock(struct pci_bus *bus);
> +static int pci_bus_trylock(struct pci_bus *bus);
> +
>  /* Lock devices from the top of the tree down */
> -static void pci_bus_lock(struct pci_bus *bus)
> +static void __pci_bus_lock(struct pci_bus *bus, struct pci_slot *slot)
>  {
> -	struct pci_dev *dev;
> +	struct pci_dev *dev, *bridge = bus->self;
> +
> +	if (bridge)
> +		pci_dev_lock(bridge);
>  
> -	pci_dev_lock(bus->self);
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		if (slot && (!dev->slot || dev->slot != slot))
> +			continue;
>  		if (dev->subordinate)
>  			pci_bus_lock(dev->subordinate);
>  		else
> @@ -5307,28 +5315,34 @@ static void pci_bus_lock(struct pci_bus *bus)
>  }
>  
>  /* Unlock devices from the bottom of the tree up */
> -static void pci_bus_unlock(struct pci_bus *bus)
> +static void __pci_bus_unlock(struct pci_bus *bus, struct pci_slot *slot)
>  {
> -	struct pci_dev *dev;
> +	struct pci_dev *dev, *bridge = bus->self;
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		if (slot && (!dev->slot || dev->slot != slot))
> +			continue;
>  		if (dev->subordinate)
>  			pci_bus_unlock(dev->subordinate);
>  		else
>  			pci_dev_unlock(dev);
>  	}
> -	pci_dev_unlock(bus->self);
> +
> +	if (bridge)
> +		pci_dev_unlock(bridge);
>  }
>  
>  /* Return 1 on successful lock, 0 on contention */
> -static int pci_bus_trylock(struct pci_bus *bus)
> +static int __pci_bus_trylock(struct pci_bus *bus, struct pci_slot *slot)
>  {
> -	struct pci_dev *dev;
> +	struct pci_dev *dev, *bridge = bus->self;
>  
> -	if (!pci_dev_trylock(bus->self))
> +	if (bridge && !pci_dev_trylock(bridge))
>  		return 0;
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		if (slot && (!dev->slot || dev->slot != slot))
> +			continue;
>  		if (dev->subordinate) {
>  			if (!pci_bus_trylock(dev->subordinate))
>  				goto unlock;
> @@ -5339,15 +5353,37 @@ static int pci_bus_trylock(struct pci_bus *bus)
>  
>  unlock:
>  	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
> +		if (slot && (!dev->slot || dev->slot != slot))
> +			continue;
>  		if (dev->subordinate)
>  			pci_bus_unlock(dev->subordinate);
>  		else
>  			pci_dev_unlock(dev);
>  	}
> -	pci_dev_unlock(bus->self);
> +
> +	if (bridge)
> +		pci_dev_unlock(bridge);
>  	return 0;
>  }
>  
> +/* Lock devices from the top of the tree down */
> +static void pci_bus_lock(struct pci_bus *bus)
> +{
> +	__pci_bus_lock(bus, NULL);
> +}
> +
> +/* Unlock devices from the bottom of the tree up */
> +static void pci_bus_unlock(struct pci_bus *bus)
> +{
> +	__pci_bus_unlock(bus, NULL);
> +}
> +
> +/* Return 1 on successful lock, 0 on contention */
> +static int pci_bus_trylock(struct pci_bus *bus)
> +{
> +	return __pci_bus_trylock(bus, NULL);
> +}
> +
>  /* Do any devices on or below this slot prevent a bus reset? */
>  static bool pci_slot_resettable(struct pci_slot *slot)
>  {
> @@ -5370,72 +5406,19 @@ static bool pci_slot_resettable(struct pci_slot *slot)
>  /* Lock devices from the top of the tree down */
>  static void pci_slot_lock(struct pci_slot *slot)
>  {
> -	struct pci_dev *dev, *bridge = slot->bus->self;
> -
> -	if (bridge)
> -		pci_dev_lock(bridge);
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate)
> -			pci_bus_lock(dev->subordinate);
> -		else
> -			pci_dev_lock(dev);
> -	}
> +	__pci_bus_lock(slot->bus, slot);
>  }
>  
>  /* Unlock devices from the bottom of the tree up */
>  static void pci_slot_unlock(struct pci_slot *slot)
>  {
> -	struct pci_dev *dev, *bridge = slot->bus->self;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate)
> -			pci_bus_unlock(dev->subordinate);
> -		else
> -			pci_dev_unlock(dev);
> -	}
> -
> -	if (bridge)
> -		pci_dev_unlock(bridge);
> +	__pci_bus_unlock(slot->bus, slot);
>  }
>  
>  /* Return 1 on successful lock, 0 on contention */
>  static int pci_slot_trylock(struct pci_slot *slot)
>  {
> -	struct pci_dev *dev, *bridge = slot->bus->self;
> -
> -	if (bridge && !pci_dev_trylock(bridge))
> -		return 0;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate) {
> -			if (!pci_bus_trylock(dev->subordinate))
> -				goto unlock;
> -		} else if (!pci_dev_trylock(dev))
> -			goto unlock;
> -	}
> -	return 1;
> -
> -unlock:
> -	list_for_each_entry_continue_reverse(dev,
> -					     &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate)
> -			pci_bus_unlock(dev->subordinate);
> -		else
> -			pci_dev_unlock(dev);
> -	}
> -
> -	if (bridge)
> -		pci_dev_unlock(bridge);
> -	return 0;
> +	return __pci_bus_trylock(slot->bus, slot);
>  }
>  
>  /*
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> -- 
> 2.39.5
> 
