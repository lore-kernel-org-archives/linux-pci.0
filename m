Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412A38C423;
	Mon, 12 Oct 2026 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843526; cv=none; b=B+G8+u9waSRARyOqDTKWyebuQm2cGQc0WLxLIDh/pUXbWJwzuKSeZ/7HhNblJrImrXBR968DwxTg79CWd5qT++1NWz/mMRuEeX2ml1v8w+rk9l6c3r6SyVmUQ10xwI/nUAkh/uJpcwk183e2LAcQXry71bOizHOkhH0qAhPYGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843526; c=relaxed/simple;
	bh=6q1dtZ4mFmGnR51E/lgbvW0mQS6LBiXKQ/GO0QIZaYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bX0l3WjkLUmKHrlhwxgBy7lFAeS/31SFV3Ub20F1jjmA2tcvZsWdR2m8DiGBq/2rMrN22gGXyfIrFsfaBnItjk2wy2xB/UhybKAiVyqojCCy5niZ12NKgha+VjT+99wcSFa7BglIhzxrpXpqzwKC41PVXKpSyFBxIKFeN/ktN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRzyh2Na; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRzyh2Na"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2381F0089B;
	Mon, 12 Oct 2026 22:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791843524;
	bh=SdztuT0CNnTRxqqFV8Jd29fRStGataYciuWQTe88Lno=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=WRzyh2NaOnyCk+x5vq84UE/CiaqgreCrQ8DcuAFs/hjqCahoZ4AxVCtVbPKnxbnEi
	 SBXeYwTir5rsEnH8CYXbue+kf8thLFgZNZt0VZqttar8BlzicVrBs5P6se/tdOuAmr
	 LDyvVM5UK63bLnT2Wd1+CybjUfwJD7CPWdD1SEf166OleHqPvLvMbwdM8rZWHa5Rj8
	 NI3uwFN0mtNGxrp417pLAUBZHKwn2nWh3Ndckz+eX+n+K97yTbdSnLG2nCHxWlrJTd
	 JVh6Y8xoPxJebFf0RufXiLajj9ZPnKdzV1HHVvqPjugiLuy2nFyfmUZ2KmzAt2+m+C
	 v4a8yj+vUCr5Q==
Date: Mon, 12 Oct 2026 17:18:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Richard Cheng <icheng@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, Lizhi Hou <lizhi.hou@amd.com>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable+noautosel@kernel.org
Subject: Re: [PATCH v13 10/10] PCI: of: Avoid np->data usage for the node
 changeset
Message-ID: <20261012221843.GA1409528@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012142826.159178-11-herve.codina@bootlin.com>

On Mon, Oct 12, 2026 at 04:28:24PM +0200, Herve Codina wrote:
> of_pci_remove_node() and of_pci_remove_host_bridge_node() check
> whether the node is dynamic but not whether it has valid private data.
> 
> During the node creation, an OF changeset is used and this changeset is
> stored in np->data to be available for removal functions.
> 
> If, for instance, a PCI host bridge is created using a device-tree
> overlay, the related node will have the dynamic flag set but np->data
> will be NULL. This leads to NULL pointer dereferences.
> 
> Checking for a non-NULL np->data pointer to determine if the node has
> been created by the PCI node creation process is not enough. Indeed,
> on some platforms like PowerPC, the OF_RECONFIG_ATTACH_NODE notifier
> (e.g., in the pci_dn_reconfig_notifier() function) intercepts node
> additions and populates np->data with its own structure, such as a
> struct pci_dn. In that case, np->data is not NULL but it is not related
> to our changeset stored during the PCI node process creation.
> 
> Avoid the usage of np->data to store the changeset used during the PCI
> node creation. Store our changeset in a more relevant structure: either
> struct pci_dev when the node is created for a PCI device or struct
> pci_host_bridge when the node is created for the PCI host bridge.
> 
> With that done, no ambiguity remains on removal. Indeed, this changeset,
> if non-NULL, is the one used during PCI node creation. Check and use
> this changeset on the removal process.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: <stable+noautosel@kernel.org> # Issue not triggered but could be a problem
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/of.c    | 32 ++++++++++++++++++++------------
>  include/linux/pci.h | 11 +++++++++++
>  2 files changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 0a5797652e18..fbed24a244d0 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -732,15 +732,20 @@ void of_pci_remove_node(struct pci_dev *pdev)
>  {
>  	struct device_node *np;
>  
> +	if (!pdev->cset)
> +		return;
> +
>  	np = pci_device_to_OF_node(pdev);
> -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> +	if (!np)
>  		return;
>  
>  	fw_devlink_set_device(&np->fwnode, NULL);
>  	device_remove_of_node(&pdev->dev);
> -	of_changeset_revert(np->data);
> -	of_changeset_destroy(np->data);
> +	of_changeset_revert(pdev->cset);
> +	of_changeset_destroy(pdev->cset);
>  	of_node_put(np);
> +	kfree(pdev->cset);
> +	pdev->cset = NULL;
>  }
>  
>  void of_pci_make_dev_node(struct pci_dev *pdev)
> @@ -800,18 +805,17 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  	if (ret)
>  		goto out_clear_devlink_dev;
>  
> -	np->data = cset;
> -
>  	ret = device_add_of_node(&pdev->dev, np);
>  	if (ret)
>  		goto out_revert_cset;
>  
> +	pdev->cset = cset;
> +
>  	kfree(name);
>  
>  	return;
>  
>  out_revert_cset:
> -	np->data = NULL;
>  	of_changeset_revert(cset);
>  out_clear_devlink_dev:
>  	fw_devlink_set_device(&np->fwnode, NULL);
> @@ -828,16 +832,21 @@ void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
>  {
>  	struct device_node *np;
>  
> +	if (!bridge->cset)
> +		return;
> +
>  	np = pci_bus_to_OF_node(bridge->bus);
> -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> +	if (!np)
>  		return;
>  
>  	fw_devlink_set_device(&np->fwnode, NULL);
>  	device_remove_of_node(&bridge->bus->dev);
>  	device_remove_of_node(&bridge->dev);
> -	of_changeset_revert(np->data);
> -	of_changeset_destroy(np->data);
> +	of_changeset_revert(bridge->cset);
> +	of_changeset_destroy(bridge->cset);
>  	of_node_put(np);
> +	kfree(bridge->cset);
> +	bridge->cset = NULL;
>  }
>  
>  void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
> @@ -899,8 +908,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
>  	if (ret)
>  		goto out_clear_devlink_dev;
>  
> -	np->data = cset;
> -
>  	/* Add the of_node to host bridge and the root bus */
>  	ret = device_add_of_node(&bridge->dev, np);
>  	if (ret)
> @@ -910,6 +917,8 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
>  	if (ret)
>  		goto out_remove_bridge_dev_of_node;
>  
> +	bridge->cset = cset;
> +
>  	kfree(name);
>  
>  	return;
> @@ -917,7 +926,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
>  out_remove_bridge_dev_of_node:
>  	device_remove_of_node(&bridge->dev);
>  out_revert_cset:
> -	np->data = NULL;
>  	of_changeset_revert(cset);
>  out_clear_devlink_dev:
>  	fw_devlink_set_device(&np->fwnode, NULL);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1e..7b0ba9ec7b5c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -339,6 +339,9 @@ struct pcie_link_state;
>  struct pci_sriov;
>  struct pci_p2pdma;
>  struct rcec_ea;
> +#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
> +struct of_changeset;
> +#endif
>  
>  /* struct pci_dev - describes a PCI device
>   *
> @@ -598,6 +601,10 @@ struct pci_dev {
>  	u8		tph_mode;	/* TPH mode */
>  	u8		tph_req_type;	/* TPH requester type */
>  #endif
> +
> +#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
> +	struct of_changeset *cset; /* Changeset used for OF node creation */
> +#endif
>  };
>  
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> @@ -670,6 +677,10 @@ struct pci_host_bridge {
>  	unsigned int	broken_l1ss_resume:1;	/* Resuming from L1SS during
>  						   system suspend is broken */
>  
> +#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
> +	struct of_changeset *cset; /* Changeset used for OF node creation */
> +#endif
> +
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>  			const struct resource *res,
> -- 
> 2.55.0
> 
