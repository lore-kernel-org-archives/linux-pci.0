Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B694819ADA4;
	Fri, 17 Jul 2026 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293058; cv=none; b=FC5MvlzO7nt7uOTykrn7N/GyRJaWcrdpEi+I1FI2wJ8p+bvrCNuw0JDqUU74KbFOzGu5U9nNu1QZR/ATVJhzBb0uY6x9LCC1uoOS7R4TEsEJiio26X3TctJa+SON2KsdA20vZ644bHkdsfOm+tpBOBOfENTxkpHohV6VD6Cj9w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293058; c=relaxed/simple;
	bh=GhxDQXA/DWqtyNQUezuLE9ghbfUV2/5HJLZzxOmPtBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3P5Po/LCWotNcf8+A8Lf/swnC8Uncjm5zlwe+e01owfUeTMF51oSF5Wef3Xgy1rzfQVfdQtGlSh6yvf7vHXFc/Vq4BB4Y6Dg4sYYrNqPLsYXOC7542Vqy+uO85r4ObITsCKmKcqLGrhd2cpviL+CdJUD9bCC3Uv5OOMtlMYX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hlmpmPnd; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hlmpmPnd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A8A63C2B9F9;
	Fri, 17 Jul 2026 12:57:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E06B460361;
	Fri, 17 Jul 2026 12:57:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1DE5B11BD16F5;
	Fri, 17 Jul 2026 14:57:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784293053; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5bizaNWFoc+PmBpwnYFuVL842Hs5RjnxZvnhEheX4EU=;
	b=hlmpmPnd5WY30jeSCJPYUTq2GsuXafRybmBxcrHK6XFrw3P/SNx9BNGxLjn5UNJSSf6L6x
	+Yy0hsPu5f2ssvUjqXXYqnLBbg+CJG4LqPHYTphCEgnvkG3S6oGySEinYalxT9l2LK6pjX
	eWFidKWwLuBh5hvyuAdWE11S+ThgEsSslAzVRH7knPEr44R29vGlsjYkoGxGDbLthYJzgc
	4U4qzFCYaeoCVwLmAji/HxaLh0xtQbKSJ8suRk+mSrf8igZblI83VDrLQ7cRA4xUTCv19E
	/bPJ3MbwgWt5/GKzKCIHIrDe2rozUU0HcHT8YaeEXSMMAwrn6X3es1kckGpgpQ==
Date: Fri, 17 Jul 2026 14:57:31 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 7/9] PCI: of: Clear fwnode->dev during root bridge
 node removal
Message-ID: <20260717145731.0b878b27@bootlin.com>
In-Reply-To: <20260708103435.2E2421F000E9@smtp.kernel.org>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
	<20260708100302.517792-8-herve.codina@bootlin.com>
	<20260708103435.2E2421F000E9@smtp.kernel.org>
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

On Wed, 08 Jul 2026 10:34:34 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing fw_devlink cleanup in the error path of of_pci_make_host_bridge_node(), leaving a dangling fwnode->dev pointer.
> - [High] Kernel panic on removal of overlay-provided PCI host bridge nodes due to unsafe changeset revert.
> --
> 
> --- Patch [7]: [PATCH v9 7/9] PCI: of: Clear fwnode->dev during root bridge node removal ---
> commit 9e6873c21d6442ce4222fe6e9ac417348c8b3fbd
> Author: Herve Codina <herve.codina@bootlin.com>
> 
> PCI: of: Clear fwnode->dev during root bridge node removal
> 
> This commit clears fwnode->dev during of_pci_remove_host_bridge_node() to
> prevent a dangling pointer. It ensures fw_devlink_set_device() is called
> with a NULL device before the fwnode is cleared.
> 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index ee9eb384b377a..8dd558a490bbd 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -743,6 +743,7 @@ void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
> >  	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> >  		return;
> >  
> > +	fw_devlink_set_device(&np->fwnode, NULL);  
> 
> [Severity: High]
> This is a pre-existing issue, but does of_pci_make_host_bridge_node()
> also need to clear the fwnode->dev pointer on its error path?
> 
> If device_add_of_node() fails in of_pci_make_host_bridge_node(), it jumps
> to the error paths but leaves np->fwnode.dev pointing to the bridge device:
> 
> drivers/pci/of.c:of_pci_make_host_bridge_node() {
> 	...
> 	fw_devlink_set_device(&np->fwnode, &bridge->dev);
> 	...
> 	/* Add the of_node to host bridge and the root bus */
> 	ret = device_add_of_node(&bridge->dev, np);
> 	if (ret)
> 		goto out_revert_cset;
> 
> 	ret = device_add_of_node(&bridge->bus->dev, np);
> 	if (ret)
> 		goto out_remove_bridge_dev_of_node;
> 	...
> out_remove_bridge_dev_of_node:
> 	device_remove_of_node(&bridge->dev);
> out_revert_cset:
> 	np->data = NULL;
> 	of_changeset_revert(cset);
> out_free_node:
> 	of_node_put(np);
> 	...
> }
> 
> If a concurrent thread acquired a reference to np, could the node outlive
> the error path and result in a use-after-free where fwnode->dev points to
> freed memory?

This issue is relevant and clearing np->fwnode.dev in the error path will
be take into account in the next iteration.

> 
> >  	device_remove_of_node(&bridge->bus->dev);
> >  	device_remove_of_node(&bridge->dev);
> >  	of_changeset_revert(np->data);  
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does calling
> of_changeset_revert(np->data) unconditionally cause a crash when removing
> an overlay-provided PCI host bridge node?
> 
> When an overlay provides the device tree node for a PCI host bridge, the
> node inherently has the OF_DYNAMIC flag set. If the bridge is removed,
> of_pci_remove_host_bridge_node() assumes the node was created by
> of_pci_make_host_bridge_node() and executes of_changeset_revert(np->data).
> 
> Since np->data is NULL for standard overlay nodes, does this result in a
> NULL pointer dereference in __of_changeset_revert_entries() when it tries
> to evaluate &ocs->entries?
> 

This scenario should not exist but anyway, I will add a new patch in the
series in order to have a more robust code checking for a NULL np->data in
both of_pci_remove_host_bridge_node() and of_pci_remove_node().

Hervé
