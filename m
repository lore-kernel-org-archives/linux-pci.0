Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1F4915A7
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944790; cv=none; b=gCDyUrdNkXQa+H4eQj3bQ4DpT5+PWAly98vXkucEWZ8c07hrBdR1zNLV7rbACm++yBHIRBnN//T1uyB9xhlmy73b3IqsoSBlyIWauL0/FW/EjgxaTF03MdS9Nq7DqsNs5j4fs+2G/SgGXFKOkckxEgrX0qanPEqcwv8AIDtRfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944790; c=relaxed/simple;
	bh=RsOWaow4xyNlxb9t6QDZxsEQgmNVortCcZlQT/kSFj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWIRkwCC1WJkgLVqh09xzQHStgqhErIcjNqlrAEZ24RNfBrO6aVPXK0vmmYLAXH5mtEy7u4djh/CxpbHWwopmzyv8z9knbBsvF5qiFt4UNVMhYVICLewLKSvpoJXr2gGJn3owpu5MIVWosws8W1OGf9AUsL2ED4GK8nIQXnGQvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wqRBnZ4m; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wqRBnZ4m"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E3A891A1A78;
	Wed,  9 Sep 2026 09:06:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B086360448;
	Wed,  9 Sep 2026 09:06:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC93811C7AF78;
	Wed,  9 Sep 2026 11:06:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788944786; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IgFCdDS5B2dqwxNnNpEegsmxei6KgD7xlNl1LOYi9Vw=;
	b=wqRBnZ4mXP4WxLqyY5K+wOz4VrHlag6Kovw2eHJVqR13eAdMwvCWcxjErWWIptY9w5Nqhg
	ifCwW8m/jWTmEvWMndQjLyyqQHkmeG6A/YJ/gVk9NTxyjF4RZWRTKAwFnRLU2fpDlSjK7+
	Wk6V51Q9pME60PvF76BO4J9DjPrF9U50mCRt5iKBXEyeFkYlBaPNN7tFYE+6ys5jSeSCAq
	hfawKVtMdqRHtAW3z0UclDDah+olc3m4M8fVqcnqRSRr8fx+dIdp4b6IvT/gT8qhcm4G3E
	Biyn0xQ7aKf62wCfv8FrZT5sRf0qPTRRkuBeVkSSApvmuKEeuWlrybm5e8ZjMA==
Date: Wed, 9 Sep 2026 11:06:23 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 10/10] PCI: of: Avoid np->data usage for the node
 changeset
Message-ID: <20260909110623.2e6bbc89@bootlin.com>
In-Reply-To: <20260909081755.444E91F00A3A@smtp.kernel.org>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
	<20260909080114.591938-11-herve.codina@bootlin.com>
	<20260909081755.444E91F00A3A@smtp.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 09 Sep 2026 08:17:54 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Missing NULL check on `np` in `of_pci_remove_node` and `of_pci_remove_host_bridge_node` leading to kernel panic.
> - [High] Dangling pointer in `pdev->cset` and `bridge->cset` after freeing, leading to potential use-after-free or double-free.
> --
> 
> commit 506858ef76ab83f59a005bd51f3fde0f4d73a6a2
> Author: Herve Codina <herve.codina@bootlin.com>
> 
> PCI: of: Avoid np->data usage for the node changeset
> 
> This patch modifies how OF changeset references are stored during PCI node
> creation. Instead of using np->data, which can be altered by platform code,
> it stores the changeset in pdev->cset or bridge->cset. This ensures the
> correct changeset is reverted and destroyed during node removal.
> 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 0a5797652e183..cd87128c71ddc 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -732,15 +732,16 @@ void of_pci_remove_node(struct pci_dev *pdev)
> >  {
> >  	struct device_node *np;
> >  
> > -	np = pci_device_to_OF_node(pdev);
> > -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> > +	if (!pdev->cset)
> >  		return;
> >  
> > +	np = pci_device_to_OF_node(pdev);
> >  	fw_devlink_set_device(&np->fwnode, NULL);  
> 
> [Severity: High]
> Will this result in an invalid pointer dereference if np is NULL?
> 
> The previous implementation had a NULL check for np, but the new code computes
> &np->fwnode unconditionally. If pdev->dev.of_node is cleared prior to removal,
> pci_device_to_OF_node() will return NULL, causing fw_devlink_set_device() to
> dereference an offset address.

How np could be NULL with pdev->cset non-NULL ?

I don't think this can happen.

> 
> >  	device_remove_of_node(&pdev->dev);
> > -	of_changeset_revert(np->data);
> > -	of_changeset_destroy(np->data);
> > +	of_changeset_revert(pdev->cset);
> > +	of_changeset_destroy(pdev->cset);
> >  	of_node_put(np);
> > +	kfree(pdev->cset);  
> 
> [Severity: High]
> Is it possible for of_pci_remove_node() to be called twice for the same device?
> 
> If so, leaving pdev->cset as a dangling pointer could lead to a double-free.
> Should pdev->cset be set to NULL after kfree() so that the earlier
> if (!pdev->cset) check can prevent a second execution?

I don't think that of_pci_remove_node() can be called twice.

> 
> [ ... ]
> 
> > @@ -828,16 +828,17 @@ void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
> >  {
> >  	struct device_node *np;
> >  
> > -	np = pci_bus_to_OF_node(bridge->bus);
> > -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> > +	if (!bridge->cset)
> >  		return;
> >  
> > +	np = pci_bus_to_OF_node(bridge->bus);
> >  	fw_devlink_set_device(&np->fwnode, NULL);  
> 
> [Severity: High]
> Can np evaluate to NULL here?
> 
> Similar to the issue in of_pci_remove_node(), if pci_bus_to_OF_node() returns
> NULL, the missing NULL check will cause a crash during the &np->fwnode pointer
> arithmetic.

bridge->cset protects agains a NULL np.

> 
> >  	device_remove_of_node(&bridge->bus->dev);
> >  	device_remove_of_node(&bridge->dev);
> > -	of_changeset_revert(np->data);
> > -	of_changeset_destroy(np->data);
> > +	of_changeset_revert(bridge->cset);
> > +	of_changeset_destroy(bridge->cset);
> >  	of_node_put(np);
> > +	kfree(bridge->cset);  
> 
> [Severity: High]
> Could this lead to a use-after-free or double-free on bridge->cset?
> 
> If a removal API like pci_stop_root_bus() is invoked multiple times, the
> dangling pointer bypasses the if (!bridge->cset) check at the start of the
> function, resulting in a double-free on the changeset.
> 

I don't think that pci_stop_root_bus() can be called twice.

