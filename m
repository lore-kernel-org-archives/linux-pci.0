Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0824E4AF
	for <linux-pci@vger.kernel.org>; Sat, 14 Mar 2026 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773513441; cv=none; b=MB/Ms9QssD2h9A8hPlwuA8Q6aosqeYl7K/BMv9Ed8Y2beQFkkOgwvDbwSuPbPEr9qObuBLSAJn/FwweyMrRWD8kqiH6lJApjH6j8GZ0If92WCfgIn6jc4JRvVveEpQafH3sJ4akY+Oo9yAyybes327WH33/wz4Q8unU3KVIDerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773513441; c=relaxed/simple;
	bh=zorgPiFi2fNS/ZFJPNkYvwT/2KEm5Git4UaiyVWOxTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geG/OXsqQv1rfmTkq5l/POc6y8B0iGUjNdsNfzOzZZgIFljfitPicHj8yPn9uoyfi0VbllaMHh+OAZXUtNsuIGdOrOLUgu76VTiiev33SEfZAhP34UxwaML4PcWaKqzi7Sp5HNAAAymocYqUyrMUgeZnKaXudBACAf185QRyLzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 432CE2020222;
	Sat, 14 Mar 2026 19:37:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 23D1F1BCF2; Sat, 14 Mar 2026 19:37:10 +0100 (CET)
Date: Sat, 14 Mar 2026 19:37:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	jgg@nvidia.com, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Message-ID: <abWq1oiE-YkksxNu@wunner.de>
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
> +definitions:
> +  -
> +    type: const
> +    name: max-object-size
> +    value: 0x01000000
[...]
> +      -
> +        name: val
> +        type: binary
> +        checks:
> +          max-len: max-obj-size

The length of a netlink attribute is a 16-bit value, so a 16 MByte value
(0x01000000) won't fit.

Moreover you're referencing max-obj-size but are defining max-object-size.

This doesn't look like it's ever been tested, so at the very least
it should be marked RFC in the subject to convey that it's not yet
in a cut-and-dried state.

The two top-most commits on my development branch have solved the
size problem and may serve as a template:

https://github.com/l1k/linux/commits/doe

Thanks,

Lukas
