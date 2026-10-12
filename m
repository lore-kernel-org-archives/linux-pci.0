Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E7249B1E9;
	Mon, 12 Oct 2026 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818298; cv=none; b=E6q7Ymq8LNLN+TennyItrg2Rl2wc3z57tFuTR+7HhqIMf2CA+vIviquFnTLaKoTW+BKOKZL5Dm9DXptHSr5erHizOUs+Uruz8JgLO7Wi4x8/19Gf7tlvhSWPXsywi6cl2wlMlcmR9chps8UEPyxQqhtBFiAXwUEZwcd55Rao7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818298; c=relaxed/simple;
	bh=XfWNez3TZElIw3B+tobB5BSrfbaynnFmNqa9anO7WiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWrwsatgSFgriEDRsvDbNuGPhjuAxAudG1cQ7/cG4QpM2Zm+fEA4HtNnOfzfKat6PQ5uGSDpIC6BOfx6a8CyWozNK65MGNOP/b4kcsq1cJ5mIlRim469gk6xN8lKdkqfR5QeNW4UTRkfiBz4C+BcBU4ff+87fb2srvSgcS44k4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NaT5xHHm; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NaT5xHHm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5E6524E411FD;
	Mon, 12 Oct 2026 15:18:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2AAB8601A6;
	Mon, 12 Oct 2026 15:18:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18BF511D70160;
	Mon, 12 Oct 2026 17:18:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791818293; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eAuhjWIHoJ+lPcsgkZ9ZICB7wFWD1mA0dcHUmJgisnU=;
	b=NaT5xHHmP2CFGmBmICiFg9ybAxPj/PSjEf+8dyYCGN/bt+MFaZpNChQ0CboqttpSI/6CPT
	ZqUZOBnQEuTJY29iWGNzquJkKva5xNVZ2r3twYEj+vBDMqkbPGv32Y8Rca4UdwdqE17vLP
	fAV5uwSFul/8+hsakgDL0nYEwN0L17Rq34e2d8QZ9ZG7+ABclARY2zwmoKaXwcMvsXy+5C
	mBv0nemTTMII4PqUYlpGhf8x519W6BCLP+u6w5C6jkz6VcnnhK8ujuz6f/KninMGIln++q
	/ZSzAPXBh8rFFPKhIwWH0g3We/uQIY9+sXWKW5VTElHIZWKOVvpIi2gUkD9iLg==
Date: Mon, 12 Oct 2026 17:18:11 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-gpio@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 08/10] PCI: of: Set fwnode device of newly created
 PCI device nodes
Message-ID: <20261012171811.50f6cb9f@bootlin.com>
In-Reply-To: <sashiko-outbox-168281@kernel.org>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
	<20261012142826.159178-9-herve.codina@bootlin.com>
	<sashiko-outbox-168281@kernel.org>
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

On Mon, 12 Oct 2026 14:44:48 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] base: TOCTOU data race and UAF on fwnode->dev access
> --
> 
> commit dc94be607770b564614555ac56ea83f070fa3dd4
> Author: Herve Codina <herve.codina@bootlin.com>
> 
> PCI: of: Set fwnode device of newly created PCI device nodes
> 
> Device-tree node can be created when CONFIG_PCI_DYNAMIC_OF_NODES. Those
> nodes are created and filled based on PCI core information but the
> fwnode device field is not set.
> 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 29b63a9090ae3..8914bfa25dc11 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -736,6 +736,7 @@ void of_pci_remove_node(struct pci_dev *pdev)
> >  	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> >  		return;
> >  
> > +	fw_devlink_set_device(&np->fwnode, NULL);  
> 
> [Severity: High]
> Does this locklessly clear the fwnode device while another traversal might be
> reading it?
> 
> If a PCI device is concurrently removed while a driver is being bound to
> another device on the same system, of_pci_remove_node() clears fwnode->dev
> locklessly here.
> 
> Concurrently, __fw_devlink_pickup_dangling_consumers() in drivers/base/core.c
> can traverse the fwnode tree and read it locklessly:
> 
> 	if (fwnode->dev && fwnode->dev->bus)
> 		return;

I don't think so.

__fw_devlink_pickup_dangling_consumers() can look at fwnode->dev but those
fwnode->dev are not in the same branch in the tree as the one where the fwnode
being modified is located.

I don't see any cases where __fw_devlink_pickup_dangling_consumers() can
reach our fwnode.

In other word I don't see any race condition on my side and so I will not try
to fix that point except if this "potential" issue is confirmed by other people.
Indeed, I could be wrong in my analysis but without further details, I don't
think the issue reported here can happen.

Best regards,
Hervé
