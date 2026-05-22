Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145C72617;
	Fri, 22 May 2026 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434412; cv=none; b=Ioiv2/C6MrGupx43mgTXqKuzxfhiB5FsL6F6zwf39OQF9FkoOj5/+00MEHe9OWDpvflGxnzDUUm4sU96HXK8CaiE/hdAj4pV3ABp9LRWdfRS+5w7lZu0Pgy1EF6tRf4bWHpwC/WrYbdzktObowasxDGOMOC1FZtf/eS3B7TeY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434412; c=relaxed/simple;
	bh=SZgvl9TKyKGo0bsjmgm6buOlxJTmz3k4rgI2g3VVZwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwPrBCNnMvz8O3OpPVd18GhxS4jOb9O3AxSvdOLFV7hpSCn4wcae2RLL9y469ZjlzTuqr5T4qx+zdcSHm7S9h2O1yzdTSTEAH6jtyzsEaxovhRM94ioupI4JcMDMvi4HlJtERe61+BTC4D/nQ4MdfBo6v9JYJbL2iGsv+VyKc0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 38498C22;
	Fri, 22 May 2026 09:20:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 02A5D60E6420; Fri, 22 May 2026 09:20:01 +0200 (CEST)
Date: Fri, 22 May 2026 09:20:01 +0200
From: Lukas Wunner <lukas@wunner.de>
To: javen <javen_xu@realsil.com.cn>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch] pci: add power management for rtl8116af
Message-ID: <ahADoUizmRYB03D2@wunner.de>
References: <20260521033827.502-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521033827.502-1-javen_xu@realsil.com.cn>

On Thu, May 21, 2026 at 11:38:27AM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RTL8116af is a multi function card. But due to the hardware design, only
> function 0 and function 1(nic) are exposed to pci system. If the system
> want to enter s0idle or cpu need to enter c10 when suspend, function 2
> to 7 must be set to d3 and enable aspm. Function 5 and 6 are reserved,
> so we skip them.
[...]
> Just as the comments above, function 2 to 7 are hidden to pci system. So
> we have to set d3 and aspm through our private register, which is CSI. I
> have a discussion with netdev maintainer, and he thought this might be a
> question to pci system.
> I wonder whether this patch can be accepted here. Any feedback would be
> highly appreciated!

This is quite large for a quirk.  Have you considered writing a small
driver instead to configure power state for the invisible/unused functions?
Or integrating the functionality into an existing driver?

Usually a quirk only makes sense if the system becomes unusable
or if a device falls off the bus without the quirk.  It's not
suitable if the point is just to avoid unnecessarily high power
consumption.

Thanks,

Lukas
