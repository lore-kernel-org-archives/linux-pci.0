Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59C366575;
	Wed, 20 May 2026 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267745; cv=none; b=SrqeMJbeRZI/LJb7kn6aOdO1woAwfkRYLLiSnFOi+QHIB4XdfpYuOwpadEq5FsY14FS8v8+c8jZTgJLSJ8KbSwU08NwIBWcn5qyoen1dsCwIjsL33sitV2jrdISOoqkuayaJg5fGGH9Iq68rlr7HUomIZvqcoo6jyA8B4j5Vujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267745; c=relaxed/simple;
	bh=8G0EY97BeoFd16cx4SZTifb8xsibU/ShVOKRDVJRar8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1Lu2nZndmmJxniF/jRhO0D0fPIfTYeWewlihC5RVLf7R8R1sHJ9vIYJOIeSkpStcO5/lK1ulkp84Ryyr+eQpkEQrGfIDm16x2+fuSZyYDt9uJBc978pT6bPinyHHlRjmBe1JJ0ecVFyqcb4T+Di/h/LsOZ6pw9Uyo6qZoJA7Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 26D90C85;
	Wed, 20 May 2026 11:02:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DAF866031598; Wed, 20 May 2026 11:02:12 +0200 (CEST)
Date: Wed, 20 May 2026 11:02:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Yury M." <yurypm@arista.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
Message-ID: <ag14lCLsYhyssY2v@wunner.de>
References: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>
 <agwzHzF3bpPM6jcC@wunner.de>
 <3633b587-5782-4cfa-b967-997de86866bb@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3633b587-5782-4cfa-b967-997de86866bb@arista.com>

On Tue, May 19, 2026 at 05:05:20PM +0100, Yury M. wrote:
> [ 476.224325] pci 0000:46:00.1: AER: can't recover (no error_detected callback)
> [ 476.224333] pci 0000:46:00.2: AER: can't recover (no error_detected callback)
> [ 476.224335] pci 0000:46:00.3: AER: can't recover (no error_detected callback)
> [ 476.224338] pci 0000:46:00.4: AER: can't recover (no error_detected callback)
> [ 476.224371] pcieport 0000:06:07.0: AER: device recovery failed

One more thing, recovery is failing here because those four devices
on bus 46 are unbound.  I've got two patches under development to
allow error recovery for unbound devices.  You may want to try those
and see if error recovery succeeds:

https://github.com/l1k/linux/commits/aer_unbound

Thanks,

Lukas
