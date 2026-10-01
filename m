Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0D3BFE2B;
	Thu,  1 Oct 2026 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883450; cv=none; b=mZH4I3gERdUOfQdpEe2JxFsTnyHIvWPOIKBLoKB/Va8D7zWrtUEf4i/YTDD/iK32n6GtDY4nLVxPutLMvu20Z6Fk1aocozuv/qZ0oO88FNOyqwzV6ts7Ff2+tSHK30XqBCmYhGW0PyRmcTcqxzzXRRR8wa6awIgne8eDGxse+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883450; c=relaxed/simple;
	bh=IwlDC8wn5b8kCP6Z/TFT1NMXwzbGOW7GKSvw2JJYln4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6qgytD/VzHvEeeApgnweU0KnIA54xWJB/f7WYHl07v47bZp06yeBf0v2o/ByQEYjgeEoDgR3qwEVE9lQXQGKQe5Bb9vWql7RCozZvt/pbnejjdqSRFTOk1LIdb/NGkrFcSnWXVsdHO0GlOr94AYVA7in2wr9SX2SfnVJXydlh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsyRrOev; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsyRrOev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790883449; x=1822419449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IwlDC8wn5b8kCP6Z/TFT1NMXwzbGOW7GKSvw2JJYln4=;
  b=YsyRrOev2ZbWt2pk1rzhKRGabeFOwhlmeXCSz7sSM476fNOGUKyFfabD
   VpTC1WN7sL5GVtkBjwEm83JB6OVgU+6wL//hKSLa4mcSjk40qrz8/KOGt
   InRTxbMRBwTx4lsyjAtkHo7EUCr0VvHh6o8URIm4wt7bE58jM94Eq9PQl
   pQ0fucYB11d/OhZIJC4g8PZoCCO/N8i3yrPo/eJSE1mcaHz3jyyAE/MhS
   QaBwPVmdSGtEtI1yBNk/1NtdmoZisatruvP5pbgcphVSkLP4KUs6sLKHu
   dirOdZ9kKb/aEgWYnDZV+njFrflf1CHP+tK2BGkPqDCdn4V5RV7sJT3Px
   A==;
X-CSE-ConnectionGUID: zv0dbStlQzyoYTD/wfMG9g==
X-CSE-MsgGUID: 1Szc+1izSCKygmcVz/FIdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="113439128"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="113439128"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 12:37:28 -0700
X-CSE-ConnectionGUID: 5saRle/kR5GVopSKB8UEhQ==
X-CSE-MsgGUID: drHUxuAESCitOMFVcMcoBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="279837423"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 12:37:18 -0700
Date: Thu, 1 Oct 2026 22:37:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH v12 10/10] PCI: of: Avoid np->data usage for the node
 changeset
Message-ID: <ar62bJzBEAhGL2iu@ashevche-desk.local>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
 <20261001142815.277550-11-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001142815.277550-11-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 04:28:10PM +0200, Herve Codina wrote:
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

...

>  void of_pci_remove_node(struct pci_dev *pdev)

>  	struct device_node *np;
>  
>  	np = pci_device_to_OF_node(pdev);
> -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> +	if (!pdev->cset || !np)
>  		return;

Wouldn't be better to split this conditional to two?

	if (!pdev->cset)
		return;

	np = pci_device_to_OF_node(pdev);
	if (!np)
		return;

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

-- 
With Best Regards,
Andy Shevchenko


