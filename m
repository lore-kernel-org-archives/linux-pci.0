Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2961372EC3
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771868; cv=none; b=ZE1v6APeEUZVRlJeigQ5XfnNa1roZ52Evpayi2BnpNM2lHA6fuaW1mumQADH2Uq0+QqybFXKU6ArgaMkAOkUGPH2ah6/37dsAIFAbO3t542rj1wploQ3fQmsWF4JePJSWwIVKer4CblSCJPq2XeXqn/gXnfnR77DoQqlbTLiVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771868; c=relaxed/simple;
	bh=omaH4Qox1rXB88th3GtNkVZxzq959lM1t95ZPWhUZ0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPDEdRtkJO3Y/gCYy1nhwiUsyJv9WgmXaFtVObWXCXupx37hw2z8hPKFxgtxnjLBPaX3qT1N8xul7uTnBEKVE03VixoD/D2D9e/XR1MMHyBfn2FYUKKMqL9Lmm+lwcAjdMEbHAwlMgWDNK/mFc5G5hyACCYcfz71XTvKdAljtVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 0185321CD;
	Tue, 17 Mar 2026 19:24:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EC8356029AFD; Tue, 17 Mar 2026 19:24:24 +0100 (CET)
Date: Tue, 17 Mar 2026 19:24:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	jgg@nvidia.com, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Message-ID: <abmcWIgaAyw66h5J@wunner.de>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303000207.1836586-9-dan.j.williams@intel.com>

On Mon, Mar 02, 2026 at 04:01:56PM -0800, Dan Williams wrote:
> +    type: const
> +    name: max-nonce-size
> +    value: 256
[...]
> +#define PCI_TSM_MAX_OBJECT_SIZE	16777216
> +#define PCI_TSM_MAX_NONCE_SIZE	256
> +#define PCI_TSM_MAX_OBJ_TYPE	4

Where is the maximum nonce size of 256 bytes coming from?

Such definitions should always be accompanied by a spec reference,
not pulled out of thin air.

SPDM nonces are 32 bytes, I assume that's what we're dealing with here?

This patch:
https://github.com/l1k/linux/commit/bca645e08ee9

... contains the following definition:
#define SPDM_NONCE_SZ 32 /* SPDM 1.0.0 table 20 */

Though it's defined in a private header in lib/spdm/spdm.h.  If there's
a need outside of the SPDM library, its visibility can be broadened
of course.

Thanks,

Lukas
