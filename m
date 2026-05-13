Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2932FE04E
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684170; cv=none; b=RH4AJxd2MUjpSFhgKALPZ7Vj7gI6pU/OarcIJCycK2HBUgvHqVIn9frODlRv9dSfqTuhLAHcJfpbLGmtanWS7b9l/JaKul3euwi0x2zQ+TyAprLiIgEEiXwcvjqRbnlyBDxgCcXH8jeZ/t+4QBaJ3Kzj+DZDmJB1Rv9a48q3ZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684170; c=relaxed/simple;
	bh=iF3iRtD1HVFwFmcdd0Iw6QCsk0QJZkQ/96WzLxkxZwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ji9PjKivXwH/QjQdAX9q9Zt2b7KOivGKmhxtWb/aQ+jV1Tq0ckDLGgwvQurQsPp63ZFvvD4ku877Yn/lIZsLg3xMNJswoziDIeAaDq3ATKrBfVBFjxOa/PUiYLgIutd2wRQroDqylfyt5kUvqEgfVUKuMYmpvGSVupubYh/KzgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wnHIlYwK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wnHIlYwK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 069634E42C3A;
	Wed, 13 May 2026 14:56:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C81EC5FE21;
	Wed, 13 May 2026 14:56:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1F2011AF9024;
	Wed, 13 May 2026 16:56:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778684164; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=InIEjbkx41SElg007gk0ZVS0qwsnlkKzxM5ylSKQ/Qs=;
	b=wnHIlYwKkJshEX+7RkItIQb7WCOi2VLN6EJm7WNvL65mWr8+xY8Mv1gsURg6953cUMyIwW
	AO3LoqsVOI8HcxjdS68hCtZ8PpsaR/Jrn/eh+gNm/0zadDL5Er9kHyp+EyQ5X3s9xTweG7
	13HehkHCn/pFlQCBGqMMa/4eHvZcKWx2IoXwz/td7uLUOniIDNzvA98YJdZfeN/bhEYk1s
	UcOZoYv5HPHN3vGfMnoZEVf+sZkEAClwdsB5dOoVMCeqyQAywCHcQB4aRYmFXpP2tYpLnX
	Nxo9uToP4ebI9QzJef+7D9ba8dpjkuxPpY9M/efghLbyxuo0wXJSHi+UHqbeRA==
Date: Wed, 13 May 2026 16:56:02 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: sashiko-bot@kernel.org
Cc: sashiko@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 7/8] PCI: of: Set fwnode device of newly created PCI
 device nodes
Message-ID: <20260513165602.7d6f0f29@bootlin.com>
In-Reply-To: <20260512224622.973D1C2BCB8@smtp.kernel.org>
References: <20260511155930.34604-8-herve.codina@bootlin.com>
	<20260512224622.973D1C2BCB8@smtp.kernel.org>
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

Hi All,

On Tue, 12 May 2026 22:46:21 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The patch fails to achieve its stated goal because `of_changeset_apply()` unconditionally sets the `FWNODE_FLAG_NOT_DEVICE` flag, causing `fw_devlink` to ignore the explicitly set fwnode device.
> - [High] Dangling `fwnode->dev` pointer leads to a Use-After-Free when the PCI device is removed.
> --
> 
> commit 3981405050778ad9837921511772531243255e6a
> Author: Herve Codina <herve.codina@bootlin.com>
> 
> PCI: of: Set fwnode device of newly created PCI device nodes
> 
> This commit sets the fwnode device field of dynamically created PCI device
> nodes to the corresponding PCI device. This aims to allow fw_devlink to
> properly use the PCI device as a supplier, instead of falling back to the
> PCI root bridge.
> 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 7506208815a47..25fb02c3dc720 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -709,6 +709,13 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
> >  	if (ret)
> >  		goto out_free_node;
> >  
> > +	/*
> > +	 * Set the fwnode device in order to have fw_devlink creating links
> > +	 * pointing to this PCI device instead of walking up to the PCI host
> > +	 * bridge.
> > +	 */
> > +	fw_devlink_set_device(&np->fwnode, &pdev->dev);  
> 
> Can this lead to a use-after-free regression when the PCI device is removed?
> 
> During PCI device removal, of_pci_remove_node() calls
> device_remove_of_node(&pdev->dev) which explicitly sets pdev->dev.fwnode
> to NULL.
> 
> Later, when device_del(&pdev->dev) is executed, its built-in fwnode cleanup
> mechanism is completely bypassed because pdev->dev.fwnode was already cleared:
> 
>     if (dev->fwnode && dev->fwnode->dev == dev)
>         fw_devlink_set_device(dev->fwnode, NULL);
> 
> This leaves np->fwnode.dev as a dangling pointer to &pdev->dev.
> 
> If the OF node outlives the PCI device, any subsequent operation that accesses
> the node through fw_devlink will dereference the freed pdev->dev memory.

It will not. In device_remove_of_node(), the OF node is destroyed when the
of_changeset_revert() and of_changeset_destroy() are called.

> 
> > +
> >  	ret = of_changeset_apply(cset);  
> 
> Does this code actually prevent fw_devlink from walking up to the PCI host
> bridge?
> 
> of_changeset_apply() invokes __of_attach_node(), which unconditionally
> executes fwnode_set_flag(&np->fwnode, FWNODE_FLAG_NOT_DEVICE).
> 
> When fw_devlink attempts to resolve a supplier, it checks for this flag:
> 
>     if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NOT_DEVICE))
>         sup_dev = fwnode_get_next_parent_dev(sup_handle);
> 
> Because FWNODE_FLAG_NOT_DEVICE is set, fw_devlink bypasses the explicitly
> mapped np->fwnode.dev and walks up the tree to the parent device anyway.
> 
> >  	if (ret)
> >  		goto out_free_node;  
> 

Well, an other series fixes this FWNODE_FLAG_NOT_DEVICE issue [1].

In this one, with or without the fw_devlink_set_device() call the issue is
present.


[1] patches 1 and 2 in https://lore.kernel.org/all/20260511155755.34428-1-herve.codina@bootlin.com/

Best regards,
Hervé
