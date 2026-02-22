Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28F19D074;
	Sun, 22 Feb 2026 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771765328; cv=none; b=mSQlADRtrFimkGTYzW1qxFIk8rLihaIGPF8jIqyWqJQmftmWGpPZ+NMP4WTeyEPKhmXpsH0leJA+CjzzoLlZ/bnc7dKBe/jd1XBrZbCfX90X4BM/v2PBhk6mOPz81gzZHczV+HXlLlep+5PZJLW0VDSR+mFNRnjV/PFRjWdXzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771765328; c=relaxed/simple;
	bh=GbPNGTAhpwVYQVHSGvUf/gJS8cG/rQNp+lHJ48YbW1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ7SY5IoH6IXjtP1xH0UKm4fvOfXBLNUxrSzjAyX1V6nco/30yPZolgN+v7Xl0O82CTE0lfJdK6B21beM7pv3vgU37ZOc7CEgJnmb5rumtB9xbaVPfmS2gnoAIMWR56WVCM50oBKomk0aDSjZr44bIjwweW+EqeUHVWd4YiyVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C54652020A39;
	Sun, 22 Feb 2026 14:01:56 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B04F92CF0A; Sun, 22 Feb 2026 14:01:56 +0100 (CET)
Date: Sun, 22 Feb 2026 14:01:56 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	bhelgaas@google.com, corbet@lwn.net, cassel@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	s-vadapalli@ti.com, danishanwar@ti.com, srk@ti.com
Subject: Re: [RFC PATCH 2/4] PCI/DOE: Move common definitions to the header
 file
Message-ID: <aZr-RMZlgO0eEM8n@wunner.de>
References: <20260213123603.420941-1-a-garg7@ti.com>
 <20260213123603.420941-3-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213123603.420941-3-a-garg7@ti.com>

On Fri, Feb 13, 2026 at 06:06:01PM +0530, Aksh Garg wrote:
> Move common macros and structures from drivers/pci/doe.c to
> include/linux/pci-doe.h to allow reuse across root complex and
> endpoint DOE implementations.

Please use drivers/pci/pci.h for declarations that need not be visible
outside the PCI core.

There are users of pci_doe() & pci_find_doe_mailbox() outside the
PCI core, that's the (only) reason the declarations are in
include/linux/pci-doe.h.

> Also add CONFIG_PCI_DOE guards around the root complex DOE APIs to
> maintain proper conditional compilation.

It's not clear to me why these empty inlines are needed, please drop
them or provide an explanation in the commit message.

Thanks,

Lukas
