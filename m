Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C63A7F60
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292291; cv=none; b=jX9nNAUHxsygH4mu8AwfCvjX4Q/ChaF3iDPHcj/8JkGRWE25TilmZZtZxRijOsRukAO1p8LtvespjzrPQGBHgBJCg6M3bqv64G9MScPDum/qCAKlxZOlROd1BhDIJjSKriViJXKgTEhPfba35xHh++nm7L3xtQotIeNIpQcj3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292291; c=relaxed/simple;
	bh=YUhhqapHpYHZgybLFx9nk5ieQ+nspWQvhvvE00yGu6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8m/Fj2cjW7GmPpZeO4RM2bXfXECPuNqZOJSCWXOC9noMIJ7mf66QUX4ad3sFvI6FJ8td56Qm4isu5RHb3cdFgCQoJYhxJijQjHx1koDiyGF+lf5OYxGtAHILG75Y4pNHQQzyYBKLmn9FOb6JITeAiJ1Uw58O9SDp1Cjf9yUzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bbkub3Yi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bbkub3Yi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 93FDF1A1058;
	Fri, 17 Jul 2026 12:44:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6041160361;
	Fri, 17 Jul 2026 12:44:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D187D11BD0007;
	Fri, 17 Jul 2026 14:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784292286; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=orntfb4ISJKu7Ltagz9jCqSpoh61GtFdaSyCjwLXfhI=;
	b=bbkub3YiYCNb/0uCckh0Dp3s88IanSu4PonyJka37XKL2VO99fjEx0GH/FAZMcsiaEoDdL
	e7iOiXWyh3R41YfGz6Q1Ye38i1PMYJgSTOG94OwEUOzRZqEMeiC0Fik9QZOiHtd4diUvLq
	mJLQBu5oTkHIy/bV8T7a6dH0VQMllqc+l4rBqahUD3mcdqa6Vip48yiQUO3Qijl1uo1r5a
	1XEKxzIZzvh7PiUujcqJBaOrjEO6DNpDSsgLa2vgBKtpffI6Btnl3cG0uh2EQejj8Srlkr
	LWCVX5djLAmx3X19qbzvKLF/1dZSsk9TIllz0wbIgsR88iIDAPAu/IOgoPtQuQ==
Date: Fri, 17 Jul 2026 14:44:44 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 6/9] PCI: of: Use fw_devlink_set_device()
Message-ID: <20260717144444.72c8e73f@bootlin.com>
In-Reply-To: <20260708102921.BDBD31F000E9@smtp.kernel.org>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
	<20260708100302.517792-7-herve.codina@bootlin.com>
	<20260708102921.BDBD31F000E9@smtp.kernel.org>
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

Hi,

On Wed, 08 Jul 2026 10:29:21 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Dangling pointer in `np->fwnode.dev` on error paths and during bridge removal, leading to a potential use-after-free.
> --
> 
> --- Patch [6]: [PATCH v9 6/9] PCI: of: Use fw_devlink_set_device() ---
> commit e05d94ee3b1f4fa9d5ff1b29db6b40e43eca7313
> Author: Herve Codina <herve.codina@bootlin.com>
> 
> PCI: of: Use fw_devlink_set_device()
> 
> The code directly set the fwnode.dev field. This commit updates the code
> to use the dedicated fw_devlink_set_device() helper to perform this
> operation.
> 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 8b18c4ba845cf..ee9eb384b377a 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -803,7 +803,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
> >  	 * bus. Avoid any new device creation.
> >  	 */
> >  	of_node_set_flag(np, OF_POPULATED);
> > -	np->fwnode.dev = &bridge->dev;
> > +	fw_devlink_set_device(&np->fwnode, &bridge->dev);  
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could this lead to a
> use-after-free on error paths?
> 
> In of_pci_make_host_bridge_node(), if an error occurs after setting up the
> fwnode (such as of_changeset_apply() or device_add_of_node() failing), the
> error path removes the node from the tree and releases its reference, but
> fails to clear the np->fwnode.dev pointer:
> 
> out_revert_cset:
> 	np->data = NULL;
> 	of_changeset_revert(cset);
> out_free_node:
> 	of_node_put(np);
> 
> Because device_remove_of_node() only clears the forward pointer
> (dev->fwnode) and not the backpointer, np->fwnode.dev remains dangling. If
> another thread holds a reference to np, the node outlives the function.
> When the bridge is later freed, any concurrent access via
> get_dev_from_fwnode(&np->fwnode) could dereference freed memory.
> 
> The same dangling pointer issue appears to exist in
> of_pci_remove_host_bridge_node() during teardown:
> 
> void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
> {
> ...
> 	device_remove_of_node(&bridge->bus->dev);
> 	device_remove_of_node(&bridge->dev);
> 	of_changeset_revert(np->data);
> 	of_changeset_destroy(np->data);
> 	of_node_put(np);
> }

This issue is relevant and clearing np->fwnode.dev in the error path will
be take into account in the next iteration.

Hervé
