Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BD54BE454;
	Wed, 30 Sep 2026 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765927; cv=none; b=eZexBGX7ai1b+NI5OygZpqPG8pu7HduNq1u9JNN1Lq1Pou3nWV/mQ2QGTvu/cfFqxVvymihC9+cOlaq7E19dvFImhxWr2Fj2ykPdraWqEsBxy2YHW6ZM+b5lHMugwHQVdD1w9cBtN6tHla54xwu+zYpaObUNqg+YDAqcp5FLZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765927; c=relaxed/simple;
	bh=h4kAngNuV489YyMvHRZHJDmNdKZ0vVFXUoJpatROOVo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=KymduzgGS7godAeEqXiQNO2buEgVnNVUXHTiDRxuaSbG1wihZ4yx46dd1rfBn2q6kMgHF15krJJr+ahNIoyO1ISkUa+0+1SigFTfrHJEiQOc8G0PLWiSyzhqD8DuqTxYwRXawzHBPuuP+AHb23D8wcFDBtoRep9XIat27hkGegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnEvU5rv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnEvU5rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D041F00893;
	Wed, 30 Sep 2026 10:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790765915;
	bh=GuhjUXY9shlytgbX94l3GIOMRb872n+gaZa2VVP3Dmc=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=TnEvU5rvJGipyP2546Y+/ciTe1a7Rwv5eYcEyk9wNKT83TCVN496IDUUy4huCskau
	 j2iXKBY5wSA1KcPP7mKBtvFa6WDDVabtTwQa+OpmO8mlTV4Kd5U8XcYqLF0eq+4b7a
	 Cb6vrIzQQVGaurG1reNrabKBJxocfG+tEhQyVj1s5bbvif0oj3HExelzEDBhaMHqro
	 zgGlaN2pSHa/oISwo6mEC2u2VMXf/fpwbW/OgsoE0uLrFMO9i17RHLIOEPZAJXbc04
	 LUxaKpUGFsconfeJe1HkgL39bVovYr46PBmKnGCO+VqI6il+LXOImoLbKd8T24x3CB
	 48oyaDng2BoYw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 12:58:27 +0200
Message-Id: <DLSLJ8WO3LRO.3PBCCWG3GK6YH@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 01/10] rust: pci: add internal SR-IOV enable and
 disable helpers
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <jgg@nvidia.com>, <alex@shazbot.org>, "Peter Colberg" <peter@colberg.org>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <af34ce6151b5be98668d712fbe62b5d6af291770.1790759932.git.zhiw@nvidia.com>
In-Reply-To: <af34ce6151b5be98668d712fbe62b5d6af291770.1790759932.git.zhiw@nvidia.com>

On Wed Sep 30, 2026 at 12:18 PM CEST, Zhi Wang wrote:
> +impl Device<device::CoreInternal<'_>> {
> +    /// Enable the Single Root I/O Virtualization (SR-IOV) capability fo=
r this device,
> +    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
> +    #[expect(dead_code)]
> +    pub(crate) fn enable_sriov(&self, nr_virtfn: c_int) -> Result {

This can just be a u16; there are no implicit type conversions in Rust and =
the
PCIe SR-IOV spec defines this as 16bit register.

The conversion should be infallible, so you can just pass nr_virtfn.into().

> +        // SAFETY:
> +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +        //
> +        // `pci_enable_sriov()` checks that the enable operation is vali=
d:
> +        // - the device is a Physical Function (PF),
> +        // - SR-IOV is currently disabled, and
> +        // - `nr_virtfn` does not exceed the total number of supported V=
Fs.
> +        //
> +        // The CoreInternal device context inherits from the Bound devic=
e context,
> +        // which guarantees that the PF device is bound to a driver.

	// - `self.as_raw` returns a valid pointer to a `struct pci_dev`.
	//
	// - `pci_enable_sriov()` checks that the enable operation is valid:
	//   - the device is a Physical Function (PF),
	//   - SR-IOV is currently disabled, and
	//   - `nr_virtfn` does not exceed the total number of supported VFs.
	//
	// - The [`CoreInternal`] device context inherits from the [`Bound`] devic=
e context,
	//   which guarantees that the PF device is bound to a driver.

> +        to_result(unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_=
virtfn) })
> +    }
