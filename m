Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985932;
	b=aKIBG/ggyGz6D4BdWVUxD08MX0Q9zf3Slw30/8mBkP4gTAUJeO4KYFc0DywQJTTSU+og
	 4icyUsdW3mBQXtdjodnazOSEywWlF73Kj6R5Mc0ZOnikY1/Yljhtt9j3/1zOqRx2HYbzl
	 GkJ54Z/7lrtuGmlzFf7BM01xzdYf9tJen79BD0GIEKoEealzrjdpVtSzi9na19yoZCn5h
	 61nnXr981YJI8pKa0BtjNG8PRFmcHqIqwSfPTqRhJwDFuZAxRZGxe8/XBaD8zXjPbaNFN
	 pacmC32Xnbrh97p3Yx9O/5/itzDQLI/NoW3KobQrZ1F2MOrcREXFcfe7uVxN5tZNaMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985932;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ru2oCJ/d6ebjZsZ30nMQl1i6eairnkPjpZ6freW069o=;
	b=Y68wDAOi5CwHeg41tv7L9dSmZDWcHc3anskpSJs0KEkmZYsU1fIQjcIxFQ+UT+LMf+yL
	 EFyiI/aPsK1S+5UrvSmTDjEphvt/l9GZBBt55Y/x6/HaNLxXzoP8m4HXQfiA1zPy0clgZ
	 zYdA62MXXCv0BURnPUhFcFfBzqXeNyFZv8uYzzMzAh6oJoWTATBp60klE1N/H/MZJ2Cs+
	 SDt2uh3dJqqSG5PgWk9lwFbGHOyeWx6zDZN4F8Mz8piijnj9ErMqYh+LtVRDaGNll4Lqw
	 5BeyZRoZmOwufA6f+5NKur3Ew/NX9q8xvy7z6ivabGBRAxllgmO1I9Kh5vtstlbvwJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC5B606A33C
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 17:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC5B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 3715C49C5;
	Fri, 06 Nov 2026 18:25:29 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E16E560290FC; Fri,  6 Nov 2026 18:25:28 +0100 (CET)
Date: Fri, 6 Nov 2026 18:25:28 +0100
From: Lukas Wunner <lukas@wunner.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI/AER: Check validity of Error Source ID
 register
Message-ID: <au4NiO-rglobvYxo@wunner.de>
References: <cover.1793982724.git.lukas@wunner.de>
 <357275f9c2554a61bfa6fcbe9a25416cafe9ce00.1793982724.git.lukas@wunner.de>
 <sashiko-outbox-201907@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-201907@kernel.org>

On Fri, Nov 06, 2026 at 05:15:07PM +0000, sashiko-bot@kernel.org wrote:
> > +++ b/drivers/pci/pcie/aer.c
> > -	/*
> > -	 * When bus ID is equal to 0, it might be a bad ID
> > -	 * reported by Root Port.
> > -	 */
> > -	if ((PCI_BUS_NUM(e_info->id) != 0) &&
> > +	/* Some Root Ports report an invalid Error Source ID */
> > +	if (e_info->id_valid &&
> >  	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
> >  		/* Device ID match? */
> >  		if (e_info->id == pci_dev_id(dev))
> 
> [Severity: Medium]
> As reported by Ilpo Järvinen on v1 [1]

Hallucination, this was reported by sashiko itself and Ilpo merely confirmed
sashiko's finding.

> can treating pci_dev_id(root) == id
> as unconditionally valid cause a false-positive match on the Root Port and
> skip searching the subordinate hierarchy when a Root Port at 00:00.0 (such
> as on DesignWare, Cadence, or Aardvark SoC host bridges) reports 0x0000 for
> a downstream device error, or when a Root Port at 00:xx.y loses the bus
> number of a downstream error source at bus:xx.y?

The commit message addresses this concern, it seems sashiko overlooked that
paragraph.

Thanks,

Lukas
