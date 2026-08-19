Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86E37DAA9;
	Wed, 19 Aug 2026 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134830; cv=none; b=l+DmIqfJXgtVtDmbS6FOuvUZxiy4lD03Fznwy/L/ZLHd5iezjtz55Ox82D7L5wPjULSvKzqmcnEv81VrBVQVrZyDMB7wF2RKVsbPWVmiM0HbkaLuyCcroak25GQIeUKjMJEFtLcyPFIyVELswREOJ4558sSE02e+42P5RkQXe1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134830; c=relaxed/simple;
	bh=awAToS9HGTXs2KozuAt+YtiCKwWo0nxiLwo/mrpxxcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPr0pHYigaqHelCDjPD0Xd+mstEmsmo4lbruMTIAShTUP9LJSAbv5jP96Oo9l7yLk1S15m8LnQUHFn8NVp2JXOkdmgVKKuFhHYXVe/q1uSGTi0e+lINx+EthJ0DY5sR23IhN0ozna6zvFy4VL3XiGWRNF/MvhF9acnlwXxEhA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pPvMG6EO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pPvMG6EO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4A9351A1737;
	Wed, 19 Aug 2026 10:20:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0BE3A5FF42;
	Wed, 19 Aug 2026 10:20:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4859111C755E7;
	Wed, 19 Aug 2026 12:20:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787134820; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Di5o/870QOvjubcyqWFfxdNWPGnFvk4UYOcojc7xAAM=;
	b=pPvMG6EOasRjfb5qQ4aT7g7fafsy5J/uVmNUvzDHhZ84CsR3dpTvPFUsgY/1MqLNv8ruGd
	VS6wfkEkkSDNXdyfGMXFyCkXyKX2lPBPGJj9ZSD7XT8R2NxGY+EF3+/L+8Zk2EkQHzJAvU
	JVHP8QXoZn7DoTBmWK9VxNM4mPvQpMUhebr9Vvt6AIX4DhcKfAj2S6yUX/cbXG2AsQlzyZ
	153uuNISqOja2oVRk4jO+fGFMdSqdWaUyjynCK9Ruq9YVQqmxTQRR1scwGtHzNzGB4oqQ1
	fyw0i6gBI27p4xN9uxCi0x/8Tenx0Jx3esPVACWBUZcC5JGkmXJorMFlNeZDCw==
Date: Wed, 19 Aug 2026 12:20:15 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Alex Elder <elder@riscstar.com>
Cc: bhelgaas@google.com, robh@kernel.org, daniel@riscstar.com,
 mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: of: introduce of_pci_verify_node()
Message-ID: <20260819122015.7e05e4dd@bootlin.com>
In-Reply-To: <20260812172247.276554-5-elder@riscstar.com>
References: <20260812172247.276554-1-elder@riscstar.com>
	<20260812172247.276554-5-elder@riscstar.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Alex,

On Wed, 12 Aug 2026 12:22:47 -0500
Alex Elder <elder@riscstar.com> wrote:

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
> specific error, only for non-bridge PCI devices.
> 
> (There are many things that could be verified for statically-defined
> devicetree nodes, but this is all we'll do for now.)
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: Verify even if PCI_DYNAMIC_OF_NODES is not defined (Sashiko)
> 
>  drivers/pci/bus.c |  1 +
>  drivers/pci/of.c  | 26 ++++++++++++++++++++++++++
>  drivers/pci/pci.h |  3 +++
>  3 files changed, 30 insertions(+)
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
> index 8b18c4ba845cf..0bbf1a915b7d2 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -1006,3 +1006,29 @@ int of_pci_get_equalization_presets(struct device *dev,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> +
> +/*
> + * Check a pre-existing devicetree node for errors.  The PCI enumeration
> + * process gathered a lot of information about the device, and ideally it
> + * matches what the devicetree node says.
> + */

Can you switch the kernel doc format [0] or move the comment into the function itself ?

[0] https://elixir.bootlin.com/linux/v7.2/source/Documentation/doc-guide/kernel-doc.rst#L67

> +void of_pci_verify_node(struct pci_dev *pdev)
> +{
> +	struct device_node *np = pci_device_to_OF_node(pdev);
> +
> +	/* If there's no pre-existing node, there's nothing to check */
> +	if (!np)
> +		return;
> +
> +	if (pci_is_bridge(pdev))
> +		return;

The property 'device_type = "pci"' is needed for bridges.

You could check that it is well present in case of bridges.

> +
> +	/*
> +	 * Currently we just verify that non-bridges don't contain a
> +	 * device_type = "pci" property.
> +	 */
> +	if (!of_node_is_type(np, "pci"))
> +		return;
> +
> +	dev_err(&pdev->dev, "\"pci\" device_type NOT VALID for PCI endpoint\n");
> +}

Best regards,
Hervé
