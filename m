Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208BC5476DE;
	Wed,  9 Sep 2026 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971850; cv=none; b=p9nVmMMJ6ZbXGEp8gnTM4gqamzFMFlhsmrtusKhV+sve3O1QGFqXuvwQCis5aKLlvlNzDtK3mMYEqneT0HeNiT+jHj13tcCpv4km1dMwQeEFxvXCIujiCHNGiyQ390dx5+AKB54/ZiGzXfOI9hpdJ0egTFpBDv/fvk5npP6mKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971850; c=relaxed/simple;
	bh=N/hD3iOvqRwNXu2nhLNrbx6yX4nWYBeXwpJfjKZWovE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sl1GMLh5m/78h9sdVvMHECgHm0MeM1Ik2wADiqLR74nPvDuF4P1JYKl3+Wzc9+sNDVsbsBU9zn9ubLis6/f763ZRvmV4vdiMQrxO24ExDdKA0P/YmLWHLvudHPJRfjXxLWflP1IJTPsN4kcJKpjN6OwGDyZnVULa2+WVplJ/N2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeLmg2ez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeLmg2ez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8570C1F000FF;
	Wed,  9 Sep 2026 16:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971848;
	bh=gnVa7gIkOilsSBkk9SQFHfHhrxiUZ2Bys5czQEdLfeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=JeLmg2ez+475CGd6yw266s23h9YJ/r7PbdpjdkEgxjQSW8gzAM6GatVpHGNoSmLjZ
	 kahmX7VjaTQEPtaI/B1laQVFwc/HRIIpzlLQSsjjLiKw+Po+UVIh8ymj6D7evvhwn7
	 UYl1ImDv4MyVv3pkDg4pKzNcfuY0+gUFlNgrnW6jS1tzg/0xYiP0bBmA6EjyxSOdQB
	 EawRY11FJeF3iugsxJZacS9Hji0gwZAOXygNVrJAE46b6HraeOtwMS4OjZRgHN36n8
	 TZd0cenwWRYqCq/0w+QR0nIIVpmV4C3D6XPlJTAX4mc7iAG+WREoS8TC9MnuqdcI6T
	 BJlIwlLncKF0Q==
Date: Wed, 9 Sep 2026 11:37:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: bhelgaas@google.com, robh@kernel.org, saravanak@kernel.org,
	herve.codina@bootlin.com, daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] PCI: of: introduce of_pci_verify_node()
Message-ID: <20260909163727.GA230382@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908213459.2519059-5-elder@riscstar.com>

On Tue, Sep 08, 2026 at 04:34:58PM -0500, Alex Elder wrote:
> Commit 407d1a51921e9 ("PCI: Create device tree node for bridge") linked
> the PCI enumeration process together with devicetree, creating a devicetree
> node for discovered PCI bridges.  Its successor commit ae9813db1dc5a ("PCI:
> Add quirks to generate device tree node for Xilinx Alveo U50") shows how
> to use a PCI final fixup quirk to also create a devicetree node for a
> non-bridge PCI device.  These changes allowed devicetree overlays to
> describe components downstream of a PCI device, by providing a place to
> attach the overlay.
> 
> Note that the dynamic devicetree node is only created if the device didn't
> already have an assigned node.
> 
> Later, commit aa7b4bbcb3a1d ("arm64: dts: qcom: qcs6490-rb3gen2: Add
> TC9563 PCIe switch node") *pre-defined* devicetree nodes to represent the
> PCI device nodes that would (also) be discovered via the PCI enumeration
> process.  The devicetree node in this case is created with the content
> from the DTS file.  So when a (host) bridge is done being initialized
> during PCI enumeration, no node is dynamically created (the commits
> mentioned above do not apply).
> 
> Ideally, any pre-defined PCI devicetree node would contain exactly the
> same information as whatever the dynamic creation process would produce
> (though it could include more).
> 
> However that is not the case for the pre-defined Qualcomm RB3gen2 nodes.
> And in particular, the endpoint (function) nodes include this property:
> 
>     device_type = "pci";
> 
> This is simply wrong; that property is meant only for bridge nodes.
> 
> Rob Herring requested that a runtime check to be added to spot this
> specific error, only for non-bridge PCI devices.  Herve Codina further
> suggested we ensure that bridge PCI devices *do* define the device_type
> property, with value "pci".  We also accept "pciex" as the value of the
> device_type property for bridges.

IIUC this patch basically adds a warning for ill-formed DTs but
doesn't otherwise change any behavior.  Obviously a developer could
fix the DT, but what would a user do in response to the warning?  

Is there something that doesn't work when this warning is emitted, and
fixing the DT would make it work?  If so, is there any hint that could
be included in the warning?  E.g., "DT device_type is missing; can't
support X"?

The commit log doesn't actually say directly what the patch does.  I
asked gemini to work on it, and it produced this, which is
straightforward but omits a lot of detail you might want:

  PCI: of: Verify "device_type" property for PCI device nodes

  According to the Open Firmware PCI Bus Supplement and Devicetree
  Specification, the `device_type` property is reserved strictly for
  PCI bridge nodes (with value "pci" or "pciex"). Non-bridge PCI
  endpoint nodes must not include a `device_type` property.

  Pre-defined Device Tree nodes representing PCI devices sometimes
  violate this requirement—such as endpoint nodes incorrectly
  specifying `device_type = "pci"`, or bridge nodes omitting
  `device_type` altogether.

  Introduce of_pci_verify_node() to sanity-check pre-defined Device
  Tree nodes assigned to PCI devices as they are registered in
  pci_bus_add_device():

    - Warn if a PCI bridge node lacks a "pci" or "pciex" `device_type`
      property.

    - Warn if a non-bridge PCI endpoint node contains a `device_type`
      property.

I'd like to get Rob's Reviewed-by since I'm not really a DT expert.

> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/pci/bus.c |  1 +
>  drivers/pci/of.c  | 32 ++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h |  3 +++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 655ed53436d3e..679afbc6d3109 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -351,6 +351,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	 * are not assigned yet for some devices.
>  	 */
>  	pcibios_bus_add_device(dev);
> +	of_pci_verify_node(dev);
>  	pci_fixup_device(pci_fixup_final, dev);
>  	if (pci_is_bridge(dev))
>  		of_pci_make_dev_node(dev);
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a51dff91b196d..5a040ed836744 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -1085,3 +1085,35 @@ int of_pci_get_equalization_presets(struct device *dev,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> +
> +/**
> + * of_pci_verify_node - Sanity check some PCI device node properties
> + * @pdev: The PCI device whose device node is checked
> + *
> + * PCI enumeration authoritatively discovers what we need to know about
> + * a PCI device.  A devicetree-based platform will represent a PCI root
> + * bridge with a node, but otherwise devicetree doesn't typically include
> + * many PCI nodes.  Where such nodes do exist, experience has shown that
> + * the "device_type" property is sometimes wrong, so warn about that.
> + */
> +void of_pci_verify_node(struct pci_dev *pdev)
> +{
> +	struct device_node *np = pci_device_to_OF_node(pdev);
> +	bool device_is_bridge;
> +	bool device_type_pci;
> +
> +	/* Nothing to check if there's no pre-existing devicetree node */
> +	if (!np)
> +		return;
> +
> +	device_is_bridge = pci_is_bridge(pdev);
> +	device_type_pci = of_node_is_type(np, "pci") ||
> +			  of_node_is_type(np, "pciex");
> +
> +	/* Bridges should have device type "pci"; endpoints should not */
> +	if (device_is_bridge == device_type_pci)
> +		return;
> +
> +	dev_err(&pdev->dev, "PCI %s have \"pci\" device_type property\n",
> +		device_is_bridge ? "bridge should" : "endpoint should not");
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc23..2e33d3bd4b0ba 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1253,6 +1253,7 @@ bool of_pci_supply_present(struct device_node *np);
>  int of_pci_get_equalization_presets(struct device *dev,
>  				    struct pci_eq_presets *presets,
>  				    int num_lanes);
> +void of_pci_verify_node(struct pci_dev *pdev);
>  #else
>  static inline int
>  of_get_pci_domain_nr(struct device_node *node)
> @@ -1308,6 +1309,8 @@ static inline int of_pci_get_equalization_presets(struct device *dev,
>  
>  	return 0;
>  }
> +
> +static inline void of_pci_verify_node(struct pci_dev *pdev) { }
>  #endif /* CONFIG_OF */
>  
>  struct of_changeset;
> -- 
> 2.53.0
> 
