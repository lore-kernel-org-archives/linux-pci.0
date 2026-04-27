Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1023DCD99;
	Mon, 27 Apr 2026 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311470; cv=none; b=Lp+M8q8OTZE0sspDvaiw4EVTEuqlYABFmeMaXxh6YqfUv5IINMKHtfTL3w954KWAjwlsiIo1BiAChFSqCgwCrNKTLLTXpzJFAy3/0NtgDlG70sXfe+37GgJY7Lvqso9LydpeRTL2ZQsQu6KJTTyj2+7sAXodyEnePe+xt/z3ldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311470; c=relaxed/simple;
	bh=kM4HoBJaBuhfIaWRXlcVZyIJAMkolQXdqWkRiXRmmzo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VOm/6BSTKp3q7yABBDNnIVRRyLJwkfgjuSAy9h3SAqJbjoDQeVfObTFj/qZG4olaGhMDVafv/e9US19nOBXEid4r1NfL9JmWUUgH1J61cSIhqu3vuuiW9E6iX9UKUwmqei0gDJuJ3zm7CiDBfgM5Rvd6v+cvHmlIbAc5OT0i/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UggPRKs8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UggPRKs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37A7C19425;
	Mon, 27 Apr 2026 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777311469;
	bh=kM4HoBJaBuhfIaWRXlcVZyIJAMkolQXdqWkRiXRmmzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UggPRKs8Avns3Vj/OFucdtUGUQtO09le6EtuW1tAdot1KntAo0nKrIy51Jwcxmz9v
	 +0mayeU/xB1h96vtS5zAeIDJ6WgOpl7jgeXr00AlxqfLQxHFI/EByviJtRgB6faTST
	 u/cnstMz2cCHFKDg3apAMz3Q7k/IavnR/2rQP3WeiUh/Tme/YAPwQxl6kzh+owNqeu
	 Oak+KG4FrqA6YNpDrZ1JzBnHfSzaATsluZNtmw9u0TGsxnzPC4pnqVX8oyMKc9nWAg
	 rsCD3XtIBu5Y1I/iAryK5crlXKBBWUtb8QlC/FZbZSG8+69EefNpIPoP/4RdopyZHC
	 A26h+SCPTdwrQ==
Date: Mon, 27 Apr 2026 12:37:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: brgl@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH] PCI/pwrctrl: Do not try to power on/off devices that
 don't need pwrctrl
Message-ID: <20260427173748.GA164968@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421104102.12322-1-manivannan.sadhasivam@oss.qualcomm.com>

On Tue, Apr 21, 2026 at 04:11:01PM +0530, Manivannan Sadhasivam wrote:
> pci_pwrctrl_is_required() is used to detect whether a device really
> needs the PCI pwrctrl support or not. It is currently used in
> pci_pwrctrl_create_device(), but not in pci_pwrctrl_power_{on/off}_device()
> APIs. This leads to pwrctrl core trying to power on/off the incompatible
> devices like USB hub downstream ports defined in DT.
> 
> Hence, add this check to prevent pwrctrl core from poking at wrong
> devices. For this purpose, move the pci_pwrctrl_is_required() helper
> definition to the top.
> 
> Fixes: b35cf3b6aa1e ("PCI/pwrctrl: Add APIs to power on/off pwrctrl devices")
> Reported-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/core.c | 90 ++++++++++++++++++++------------------
>  1 file changed, 48 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 97cff5b8ca88..b5a0a14d316e 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -139,6 +139,48 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
>  
> +/*
> + * Check whether the pwrctrl device really needs to be created or not. The
> + * pwrctrl device will only be created if the node satisfies below requirements:
> + *
> + * 1. Presence of compatible property with "pci" prefix to match against the
> + *    pwrctrl driver (AND)
> + * 2. At least one of the power supplies defined in the devicetree node of the
> + *    device (OR) in the remote endpoint parent node to indicate pwrctrl
> + *    requirement.
> + */
> +static bool pci_pwrctrl_is_required(struct device_node *np)
> +{
> +	struct device_node *endpoint;
> +	const char *compat;
> +	int ret;
> +
> +	ret = of_property_read_string(np, "compatible", &compat);
> +	if (ret < 0)
> +		return false;
> +
> +	if (!strstarts(compat, "pci"))
> +		return false;
> +
> +	if (of_pci_supply_present(np))
> +		return true;
> +
> +	if (of_graph_is_present(np)) {
> +		for_each_endpoint_of_node(np, endpoint) {
> +			struct device_node *remote __free(device_node) =
> +				of_graph_get_remote_port_parent(endpoint);
> +			if (remote) {
> +				if (of_pci_supply_present(remote)) {
> +					of_node_put(endpoint);
> +					return true;
> +				}
> +			}
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static int __pci_pwrctrl_power_off_device(struct device *dev)
>  {
>  	struct pci_pwrctrl *pwrctrl = dev_get_drvdata(dev);
> @@ -157,6 +199,9 @@ static void pci_pwrctrl_power_off_device(struct device_node *np)
>  	for_each_available_child_of_node_scoped(np, child)
>  		pci_pwrctrl_power_off_device(child);
>  
> +	if (!pci_pwrctrl_is_required(np))
> +		return;

Sashiko asked:

  Should we also add this same check to pci_pwrctrl_destroy_device()?
  Since pci_pwrctrl_destroy_device() iterates over all children and
  blindly calls of_device_unregister(), could it erroneously
  unregister incompatible devices (like USB hubs) created by another
  subsystem if this check is missing?

which seems like a reasonable question.  pci_pwrctrl_create_device()
only calls of_platform_device_create() if pci_pwrctrl_is_required().

I'm also curious about the fact that of_platform_device_create() and
of_platform_device_destroy() look like they should be a symmetric
pair, but we don't use of_platform_device_destroy() in pwrctrl:

  pci_pwrctrl_create_device
    if (pci_pwrctrl_is_required(np))
      pdev = of_platform_device_create(np)

  pci_pwrctrl_destroy_device
    pdev = of_find_device_by_node(np)
    of_device_unregister(pdev)
    platform_device_put(pdev)
    of_node_clear_flag(np, OF_POPULATED)

Another Sashiko question (although I don't think it's directly related
to *this* patch):

  Also, looking at the rest of this function, it calls device_is_bound()
  before executing the power off callback:

    drivers/pci/pwrctrl/core.c:pci_pwrctrl_power_off_device() {
      ...
      if (device_is_bound(&pdev->dev)) {
        ret = __pci_pwrctrl_power_off_device(&pdev->dev);
      ...
    }

  Could this result in a use-after-free?

  If a concurrent driver unbind event occurs between the device_is_bound()
  check and the callback execution inside __pci_pwrctrl_power_off_device(),
  the pwrctrl structure might be freed since the device lock is not held.
  This same pattern appears in pci_pwrctrl_power_on_device().

And another (again unrelated to this patch):

  Is there a resource leak if powering on a child device fails in the loop
  just above this check?

    drivers/pci/pwrctrl/core.c:pci_pwrctrl_power_on_device() {
      for_each_available_child_of_node_scoped(np, child) {
        ret = pci_pwrctrl_power_on_device(child);
        if (ret)
          return ret;
      }
      ...
    }

  If an error or -EPROBE_DEFER occurs, the function returns immediately.
  Does it need to iterate backwards and power off the children it
  successfully powered on during the current loop?

  While the top-level caller pci_pwrctrl_power_on_devices() rolls back
  siblings, the successfully powered-on sub-children here appear to be left
  stranded. On -EPROBE_DEFER, the host controller might retry probing later,
  repeatedly incrementing clock and regulator enable counts without
  disabling them.

If you do anything about these, note that I split the code move of
pci_pwrctrl_is_required() to its own patch to make the addition of the
calls more obvious.

>  	pdev = of_find_device_by_node(np);
>  	if (!pdev)
>  		return;
> @@ -213,6 +258,9 @@ static int pci_pwrctrl_power_on_device(struct device_node *np)
>  			return ret;
>  	}
>  
> +	if (!pci_pwrctrl_is_required(np))
> +		return 0;
> +
>  	pdev = of_find_device_by_node(np);
>  	if (!pdev)
>  		return 0;
> @@ -268,48 +316,6 @@ int pci_pwrctrl_power_on_devices(struct device *parent)
>  }
>  EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
>  
> -/*
> - * Check whether the pwrctrl device really needs to be created or not. The
> - * pwrctrl device will only be created if the node satisfies below requirements:
> - *
> - * 1. Presence of compatible property with "pci" prefix to match against the
> - *    pwrctrl driver (AND)
> - * 2. At least one of the power supplies defined in the devicetree node of the
> - *    device (OR) in the remote endpoint parent node to indicate pwrctrl
> - *    requirement.
> - */
> -static bool pci_pwrctrl_is_required(struct device_node *np)
> -{
> -	struct device_node *endpoint;
> -	const char *compat;
> -	int ret;
> -
> -	ret = of_property_read_string(np, "compatible", &compat);
> -	if (ret < 0)
> -		return false;
> -
> -	if (!strstarts(compat, "pci"))
> -		return false;
> -
> -	if (of_pci_supply_present(np))
> -		return true;
> -
> -	if (of_graph_is_present(np)) {
> -		for_each_endpoint_of_node(np, endpoint) {
> -			struct device_node *remote __free(device_node) =
> -				of_graph_get_remote_port_parent(endpoint);
> -			if (remote) {
> -				if (of_pci_supply_present(remote)) {
> -					of_node_put(endpoint);
> -					return true;
> -				}
> -			}
> -		}
> -	}
> -
> -	return false;
> -}
> -
>  static int pci_pwrctrl_create_device(struct device_node *np,
>  				     struct device *parent)
>  {
> -- 
> 2.51.0
> 
