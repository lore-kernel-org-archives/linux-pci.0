Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD583749FA;
	Wed, 30 Sep 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783303; cv=none; b=Cwe2+I4b+jOoxvULIOqeNPSrD1bjJMW5I4YeEdDFaOzIb7hFT30OcAJeVHqg+l2ZXGUUSTJBpv/Epd+JoowyIcqbKqdcNrsY/lTAdr0nZ1LJ+HUM8f2BH9Vkt6SydNdSJUu5dM9MHgTBtUX7lmO4SkHfwaq3O6Q5jmsOLYBC8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783303; c=relaxed/simple;
	bh=MJOgAvAcfwjCPLRrSS8M66NTXmnn994l12opYVC7Kjc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gfaM7lpdhlmIxpPZqRVJPGhBX5rpU4RRQuKewbUtHvSrkEZbaq2xO6rYf10aO9krfiitrNq0G1LJlvOalU54EOiVhOcHr2JqMLMiPoLA2vqK98B6OkTJFdeCmpD/dbsCRtIdCNsoTsCE/CPbS0Fj6kIJ4UlH1UEl0hhEOm2MPQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE6fwnUA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE6fwnUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4B11F00899;
	Wed, 30 Sep 2026 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790783299;
	bh=Q3dyweEFIw9MMaAQ3qtHiJGRvzjhtsRVs97Lrtaxxi0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=XE6fwnUAwglbhcdAUGpYMPdG6pAocT+0GJ5tREtciyKq9M/ayirFD3z5tatqi/m2y
	 XdnU+DEV3c5XAPWOkwrLafhvFCPr+WvbtIWvwMFLr8oJJpojVgbaRASMJn5fVHsRN6
	 TslBl21/rtXKG4Bvps/fJmnjganr3OjcNR2VXt9jURpgGNhl0y2wLQf/JRbdHHPo7C
	 Ra8AJpFvppqxFtYgVPFoyzk+GNHG8yTfdcMxAY2+zGOzicmp7EiQkAxuzvZk03oRdO
	 8D3na2MB1l0tLPvqflMEvx3Pm41YQ605NginVf9qZWEzym/LrxgeI6AZ/rmr/nZrn3
	 DGtyGapgXY0kA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 17:48:08 +0200
Message-Id: <DLSRP1M7HK6V.PJ3SDXZ991JU@kernel.org>
Subject: Re: [PATCH 2/7] rust: pci: expose the VF index within its PF
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir
 Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>, "Peter
 Colberg" <peter@colberg.org>, "Simon Song" <xinmengs@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1790764573.git.zhiw@nvidia.com>
 <5828df56a42b784ce9da005b338e8580ea63294c.1790764573.git.zhiw@nvidia.com>
In-Reply-To: <5828df56a42b784ce9da005b338e8580ea63294c.1790764573.git.zhiw@nvidia.com>

On Wed Sep 30, 2026 at 12:57 PM CEST, Zhi Wang wrote:
> @@ -40,6 +40,14 @@ pub fn is_virtfn(&self) -> bool {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          unsafe { (*self.as_raw()).is_virtfn() !=3D 0 }
>      }
> +
> +    /// Return the zero-based VF index within its PF, or an error for a =
non-VF device.
> +    pub fn vf_id(&self) -> Result<u32> {
> +        // SAFETY: `self.as_raw()` points to a live PCI device; the help=
er checks VF membership.
> +        let id =3D unsafe { bindings::pci_iov_vf_id(self.as_raw()) };
> +        to_result(id)?;
> +        Ok(id as u32)
> +    }

In my PoC I had this implemented for Device<Bound>, but here it is implemen=
ted
for just Device I think? It's not visible from the context, but IIRC you mo=
ved
is_virtfn() in an impl Device block (which is correct).

So, if this is correct, please move it under Device<Bound>, as offset and s=
tride
are not guaranteed to not be concurrently modified otherwise.
