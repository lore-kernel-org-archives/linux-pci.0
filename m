Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753171;
	b=lhps3zmRAIxY+kXyBnoFT8CI+zjtc5RFXbjVi88JusG9LZ3G9d7p2xeZSWCWHdbSz3WZ
	 sNBVECsZ/WRd8/3uqurKvvAVdhzXJRCuaBk3P4uvkQ75cLs6Us2Q2p9z9NJEfrIqiwRhM
	 cUj1HzWpFJJg3Fa6LjNzcFfbSubC3E7yXPExQwg0QJUcWdG31FrjvEMvjBti6FXvv8Gzs
	 dm2Hs6eEHKKy6r0NaW2vJj2qONWrxxtecl4ZFtLsRPJBWqXr3csn7/WSvHKCr3BuPuGHT
	 zYN3IZe0Sxo68WgovAnlSOEfELXEWhad5Ab8OA48KEVqqC/493jEH9waGlXUgmsR3VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753171;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=qotwDIV+dwawUH4U9PtLZflu8IFLEqef+DT+z1ntPP4=;
	b=teDG7kJj1lGrs6Yu+/PavSYrPN9la8uusc4PZHSwoSe9YSZON8yirlwvzY1MMzDJ2eG8
	 7oN70/qJhwxSqndCDD3T5fd1d5mS4FYySkBDLpuj7GkifbdziclC2zXXvml3jQ167vNCL
	 ezlsOqMXCvam8NwXu7mLs4IjetKUxXhb03JYtJHx+7mkrdT0z7qmaynYIX7Dbe7yW93rr
	 AVc5MHGtI9JV2dlwKDCdzWrBIykyIqbuAYHCRITs6vUyce4giu5moeS9VpfBYvscykHwm
	 T/VrQx1POSNfUYjBME4FKaYDFUy3arSxSP2kmRLpQRTIzdilieixz0ZMxqnaFtx8qtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW2ZyrP2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537CB606A324
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW2ZyrP2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C1B1F000C1;
	Wed,  4 Nov 2026 00:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793753170;
	bh=qotwDIV+dwawUH4U9PtLZflu8IFLEqef+DT+z1ntPP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=YW2ZyrP2jAETL09SS7CObYbWB2IReAHHxNvB4BBaEfkJHs5+00wllPtJkfcta+9DS
	 ngTWktlv/14hH+cm10zxyvcjyZ6Anj04x2yXZ88/pefNyaqP3ExFKIpwr5YJl5zQcH
	 oZNTC25/eZkOcQFV1NjrnSsKBvlVV/aJXjfdHs3tpSTeDHgpS09jibEBqiU86/kYjd
	 oGIRzICBOX8bPQQTILKGonEQkgtYg2L+DaoirtqCLTBOmGQnAWWodIqsjqVKkzp/GC
	 aPq0ZLuPdxwbNoZj+d0roZcXy7+RjptQtm9j8i/LGlv84rRAfepM2XLPjWsvWmabiD
	 K19WyAoYkJ4wg==
Date: Tue, 3 Nov 2026 18:46:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: Re: [PATCH 2/2] PCI/AER: Check validity of Error Source ID register
Message-ID: <20261104004609.GA1167435@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97e38070-1ad1-74d3-3b60-7fd2ead00c42@linux.intel.com>

On Tue, Nov 03, 2026 at 02:57:58PM +0200, Ilpo Järvinen wrote:
> On Tue, 3 Nov 2026, Lukas Wunner wrote:
> 
> > Certain Intel and AMD Root Ports are known to populate the Error Source ID
> > register with an invalid value.  The AER driver seeks to recognize such
> > buggy silicon by assuming invalidity if the bus number is zero.  It then
> > searches for the error-signaling device in the hierarchy below the Root
> > Port.  This was introduced by commit 28eb27cf0839 ("PCI AER: support
> > invalid error source IDs").
> > 
> > Alex has provided dmesg output which shows an invalid Error Source ID with
> > a non-zero bus number.  The AER driver's heuristic fails to recognize its
> > invalidity:
> > 
> >   pcieport 0000:00:07.1: AER: Correctable Error message received from 0000:01:00.0 (no details found)
> > 
> > The Root Port at 0000:00:07.1 has subordinate bus 04, so an error source

I always think "subordinate" is just slightly ambiguous because it's
used for both "anything below this bridge" and the more specific
"Subordinate Bus Number" (the highest numbered bus below the bridge).

It's perfectly accurate as-is especially because in this case it looks
like Secondary Bus Number and Subordinate Bus Number are *both* 04 for
00:07.1.  But "secondary bus 04" seems less ambiguous to me.

> > on bus 01 is obviously invalid.  The range of subordinate buses is cached
> > and checking against it is cheap.
> ...

> > +	return root->subordinate->busn_res.start <= PCI_BUS_NUM(id) &&
> > +	       root->subordinate->busn_res.end   >= PCI_BUS_NUM(id);
> 
> I kind of hate the order of this logic. I understand you're probably 
> doing it for the alignment which has some value but...
> 
> ...For me, the more logical order would be to keep these in increasing 
> order even if doing it results in losing the alignment:
> 
>    start <= val &&
>    val <= end
> 
> Maybe that's just me and it's not an end of the world either way.

I agree, I think "start <= val && val <= end" is more readable, though
not quite as pretty.
