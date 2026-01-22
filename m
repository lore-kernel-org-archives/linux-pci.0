Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814C267B89;
	Thu, 22 Jan 2026 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088868; cv=none; b=Y0LRStoow668vjt859s2zAX1M9VH1uSkT6A+UVs+DaJnjnh6ID2WNtlsAU8WFA0I8XgpQHkys1Mtk6txvrPceL3qgEdOOQsZsQZeQ+ft8rG5X/4vUlyRUVv/TlsX3ZcvK1w7uuxEHk1vCBNYBa+pzEQgRVxg3axjIOvuujMD4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088868; c=relaxed/simple;
	bh=14O3Uhk8Km+FtypUEl+JSA0X/JK4g/H3efioqCzHUg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSVM1bmd9HHH9St9dvWxnMs+H69jL8wwYS6avld3V+u/y0APQ6sos+F7kOtLiyRdslnZLDHodLUX6uo1zY1PjcaeUk360zlxOZ7jEHyuv3tZMxZ0QrP6LumNOIZUMBp+7Idzr5FO8PWuu0rhvR6I44k+cSGiEyeUlrl7Esjfe48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D51892C01631;
	Thu, 22 Jan 2026 14:34:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A382E2D8C3; Thu, 22 Jan 2026 14:34:21 +0100 (CET)
Date: Thu, 22 Jan 2026 14:34:21 +0100
From: Lukas Wunner <lukas@wunner.de>
To: dan.j.williams@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
Message-ID: <aXInXZiTCSN06si8@wunner.de>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-11-terry.bowman@amd.com>
 <20260114190818.00004112@huawei.com>
 <6969513c2b1a4_34d2a1008a@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6969513c2b1a4_34d2a1008a@dwillia2-mobl4.notmuch>

On Thu, Jan 15, 2026 at 12:42:36PM -0800, dan.j.williams@intel.com wrote:
> I agree with the general sentiment, but not the conclusion, especially
> because this is a private detail. Linux has long ignored internal
> errors. The only reason to consider them now is because CXL decided to
> multiplex its error model on top of this oft-ignored feature of PCIe
> AER.
> 
> Specifically, portdrv.h is not in the global include namespace, this is
> a private detail of the only conumer of internal errors:
> drivers/pci/pcie/aer_cxl_{rch,vh}.c
> 
> At most we should have this as a comment to clarify:
> 
> /*
>  * Note, internal errors are only considered for the CXL error model,
>  * not for other implementations.
>  */
> 
> ...and the pci_aer_unmask_internal_errors() export should be:
> 
> EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core")
> 
> ...for the same reason. Steer folks away from thinking that it is open
> season for adding more internal error support.

It's not like Internal Errors are a bad thing per se.  They're a way
to signal "other" errors besides the spec-defined ones.

As an example, and I'm keeping this in general terms to avoid devulging
information about future products, a device possessing ECC RAM may raise
a Correctable Internal Error when ECC successfully recovers from flipped
bits because it allows alerting the user in advance that the device might
need to be replaced in the near future.  If ECC recovery fails, the device
might try to use a reserved spare portion of RAM in lieu of the failing one
and instruct the AER driver to recover through a bus reset.  Such errors
are not covered by the spec-defined types.  Using the Internal Error type
is the only possibility it seems.

My point is, there are valid (upcoming, not theoretical) use cases for
Internal Errors and creating infrastructure in the kernel to take advantage
of them is a good thing.  Hence my continued pushing back on hiding or
discouraging their use.

Thanks,

Lukas
