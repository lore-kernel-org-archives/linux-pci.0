Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836145D908;
	Sun, 11 Oct 2026 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791731694; cv=none; b=SYS3ykZ2HBdZEIfpJBmG7ko8E8tpBF2Yo5T7umIiDSiqT5+t/fuUgw58uJSnXv65GQXeKgGnIthpPkKzt0KxryTJ9fFaEdm88NCjZl1Cejp+XrAKUXXxM5PDzmyJheZ4eS6I1LBWbkvTveA2CljZiEETktBfkB6CeUCO4DBKmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791731694; c=relaxed/simple;
	bh=vDgatWtYnwE039GoIRVXyzRL17p8/QYPeLRw+0Ll0TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq8v2clOlp0Flbkmgg+HA23C9ew83d3GQIqZ/73f+DwT+mviSzaNMH6lwoqg6fxyCSj6ukAOdwB7bPXMn8tTxOaDC2623oyb+XgCAm28CSJ8zV/U3cfkF2Q5v66kg7pa77JmTb6CbzcX3d7SQGhxaUXda8DdYOGcdpcGlf7HUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 3EC7510F7A;
	Sun, 11 Oct 2026 17:14:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 136B76107905; Sun, 11 Oct 2026 17:14:49 +0200 (CEST)
Date: Sun, 11 Oct 2026 17:14:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alexander Gruhlke <gruhlke@mailbox.org>
Cc: bhelgaas@google.com, rafael@kernel.org, alex@shazbot.org,
	hui.wang@canonical.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: Don't treat ~0 as ready in pci_dev_wait() with
 RRS SV
Message-ID: <asun6Yq3cGBY3SXE@wunner.de>
References: <asqFthqcsDkUU6Sg@wunner.de>
 <20261011082408.17274-1-gruhlke@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011082408.17274-1-gruhlke@mailbox.org>

On Sun, Oct 11, 2026 at 10:24:08AM +0200, Alexander Gruhlke wrote:
> On Sat, Oct 10, 2026 at 08:36:38PM +0200, Lukas Wunner wrote:
> > I think it's sufficient if you just change the if-condition like this:
> >
> > -			if (!pci_bus_rrs_vendor_id(id))
> > +			if (!pci_bus_rrs_vendor_id(id) &&
> > +			    !PCI_POSSIBLE_ERROR(id)) {
> >
> > I don't see the need for the extra read of the Command register
> > you're performing.
> 
> The Vendor ID of a VF always reads ~0, so with that condition, an FLR
> of a VF below a Root Port with RRS SV would poll until the 60 s timeout
> and fail.  That's why the branch without RRS SV reads the Command
> register, too (see the comment above the loop).  I'll mention it in the
> commit message.

Ah okay, thanks for the clarification.  So how about:

-			if (!pci_bus_rrs_vendor_id(id))
+			if (!pci_bus_rrs_vendor_id(id) &&
+			    (!PCI_POSSIBLE_ERROR(id) || dev->is_virtfn))

Per PCIe r7.1 sec 9.4.3.3.1, VFs may respond with RRS Completions
under certain circumstance, so the Vendor ID does not *always* read
as 0xffff, despite sec 7.5.1.1.1 saying so.  The above should handle
that correctly (unless I've botched it again).

Thanks,

Lukas
