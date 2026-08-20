Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006883822B5;
	Thu, 20 Aug 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239342; cv=none; b=FLaxcYHL/N8ugRbod4eM7+31gqn8D5tEG3w2BNEs2vCVWHsPFVUApLzVWarXzCxsWhBORad3wrMfduwB1b1mVkwFcMi2W6xXLIZGuUWDLLmPuGTa0dmS8/M9H+fmcsQ5NV/nggscrEAmwOnO4GYJWBeg2fJIPK7UC5YS3w030rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239342; c=relaxed/simple;
	bh=WvHhM6xHp7SFyvD79UIFzJ/eHBI0kokp9r1TCjmT8Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENc8C+wjXFt/EbXuL6np7NjW1W6ui6r9Qrlb9czg/JESrCDKaNSH1VSyjW10DwXIM4hTV01ThYHFY6czC8Q5A7UyLuXCd9OWFUlH1qwZmZM8GCXQUH+QW62V28hZZPgj8biUnsYsyE+lfnKVmf3F4l+JcE73WLGTKsz3Ex/CSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id E4884295A;
	Thu, 20 Aug 2026 17:22:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B18B761024E6; Thu, 20 Aug 2026 17:22:09 +0200 (CEST)
Date: Thu, 20 Aug 2026 17:22:09 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jan Beulich <JBeulich@novell.com>, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xen/pcifront: Fix PCI device reference leak in AER
 handling
Message-ID: <aocboedc16afKkcR@wunner.de>
References: <20260820135603.3901798-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820135603.3901798-1-ruoyuw560@gmail.com>

On Thu, Aug 20, 2026 at 09:56:03PM +0800, Ruoyu Wang wrote:
> pci_get_domain_bus_and_slot() increments the reference count of the
> returned PCI device. pcifront_common_process() drops that reference only
> when the device or its driver is missing. All paths for a bound device
> either return directly after invoking an error recovery callback or fall
> through without calling pci_dev_put(). Consequently, each AER request for
> a bound device leaks a reference and can keep the device allocated after
> removal.
> 
> Declare the looked-up device with __free(pci_dev_put), so every return
> path releases the reference after callback dispatch. This keeps the
> device alive while its callback runs and balances the lookup without
> restructuring the callback returns.
> 
> This issue was found by a static analysis checker and confirmed by manual
> source review.
> 
> Fixes: 956a9202cd12 ("xen-pcifront: Xen PCI frontend driver.")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
