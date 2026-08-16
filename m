Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C41A5BAE;
	Sun, 16 Aug 2026 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786879349; cv=none; b=sTF0iEGR6owptm+YKemaNy8qxA+JJf7NxwynJYgQuTFD3dy3zghug+eWiAjqaWaV5EfILk9kaJxhi9HsR3o77EGobM1PUKqltZFqk3ht3J+o+ioQ3FjMnf3Xm7ee/SdbfTWFP7h1gYbcJhJ4bd65m+Jn1l6a+gcRwTaFwZAaL80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786879349; c=relaxed/simple;
	bh=hVnbQ5XHxPe4aDCcEfAvoH33BjEq21Yw39tfdyVHGXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auKSKUXyP5I9A3XDx0jBJjn7bmP2IY0JkcWfzuj2cm9blWIxPxxbWP0agSTENRn6fjRZVDTdT7sVBdDbBD0u60XIDrY+e/bQHc7a0IkiBo6LEEXEwjSZ+9a0F8gwza9sPK92O0vesH9c1s6UyV4ebVmfklZW2BK0RuTKk89/ZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id C9D361062A;
	Sun, 16 Aug 2026 13:22:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AB0C1629CE25; Sun, 16 Aug 2026 13:22:25 +0200 (CEST)
Date: Sun, 16 Aug 2026 13:22:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: peng.guo@montage-tech.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, djbw@kernel.org, johnny.li@montage-tech.com,
	jingzhong.yang@montage-tech.com, engguopeng@buaa.edu.cn
Subject: Re: [PATCH 2/2] cxl/core: Skip non-CXL capabilities in MCAP
Message-ID: <aoGdcWjzmvQAhFEK@wunner.de>
References: <20260816084957.3316727-1-peng.guo@montage-tech.com>
 <20260816084957.3316727-3-peng.guo@montage-tech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816084957.3316727-3-peng.guo@montage-tech.com>

On Sun, Aug 16, 2026 at 04:49:57PM +0800, peng.guo@montage-tech.com wrote:
> +++ b/drivers/cxl/core/regs.c
> @@ -134,7 +134,13 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  	for (cap = 1; cap <= cap_count; cap++) {
>  		struct cxl_reg_map *rmap;
>  		u32 offset, length;
> -		u16 cap_id;
> +		u16 cap_id, vendor_id;
> +

Nit: Move the u16 line above the u32 line to maintain inverse Christmas
tree convention.

Thanks,

Lukas
