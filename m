Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28DF2FFDD5;
	Mon, 16 Feb 2026 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247364; cv=none; b=ZtDJFppFDZi5QS3Ws0MnWygcSqodQZavBLRgnEtAnKKUHFkdovmyLoZa39xnGL9kr3Sk+GsqiFY28oYbVeFVkPvYvl1knhJzrC5iYsW4JoFF9ReLbOU8IjMMlRYC7DTvad7Ln0yI0n7pPCqTr0A1KVwprI3SBubrUnWxPx7/4eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247364; c=relaxed/simple;
	bh=Pyp/aGzfvgpJebSqQXxiQZfB8XfCNmGx8unMy6uuxDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHOIjDlfhnZ9n5Kirt8farSl/IxIxumUoxCkoJiYSIS/P9oOpOSmky1FNoobTUGpF1mSml4jdvkmbdtOMRmQP/nInz1YfjWo7Pggc5TuXGHcsnF3+c6IfJqmRJ3PYD5GcsC/E5MLb0lsq5sDTm9NNAUAV7WV6dobPxvEq3bgPdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8BF5A2C06C9C;
	Mon, 16 Feb 2026 14:09:18 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8291E1D2F8; Mon, 16 Feb 2026 14:09:18 +0100 (CET)
Date: Mon, 16 Feb 2026 14:09:18 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, maz@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, cassel@kernel.org,
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH] PCI: Add PCI_RID_MASK macro
Message-ID: <aZMW_giP0KjM5kpv@wunner.de>
References: <20260216120600.479738-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216120600.479738-1-a-garg7@ti.com>

On Mon, Feb 16, 2026 at 05:36:00PM +0530, Aksh Garg wrote:
> +++ b/include/linux/pci.h
> @@ -71,6 +71,7 @@
>  #define PCI_DEVID(bus, devfn)	((((u16)(bus)) << 8) | (devfn))
>  /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
>  #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
> +#define PCI_RID_MASK	0xffff

Why not instead introduce

#define PCI_RID(x) ((x) & 0xffff)

to go alongside PCI_SLOT() & friends?

Thanks,

Lukas
