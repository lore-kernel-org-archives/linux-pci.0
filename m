Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262643;
	b=yRrK9/6sTd+YdI1yn7efR6CJjpUTVqWH3sCuSb+DEmT36NfnnMIh03uQIyh2fQ+PE7cE
	 NI6IcqJWCLHcOnOiEY1Nfr9FkQ/E1tkalugqsn2lQqIghO6RJ7VDExc7GiHozLX1XjeWJ
	 8/R5le14evJOOJEgCvsj7M3YxowlM1fEOph3OdeRNwTWcSvR6eoOgFeip3R85z1dPUcWZ
	 eDX3o8GijaGHQF6SBYVHVv2XZGc7GTED72LugooRp86ssUms2ez+FWUMbsZXOhcTeGYSU
	 MP0N3A/RJsxL2J7ZfCe4cY4W75fy1zlAtnpX0qRDzn+fk4wkVmCDmadwcNr4LyU/ntw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262643;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=dXGOOAHztGwt4eSJUdZkgiCiQNoRMAkQZbNhRndviHY=;
	b=e5JfyQm+qB8G/H8MwvR3QMFcizerMrJ3NiqwlX9vOD0JLo2z8wkxftkt4TxFrdi/jkjD
	 sqPwjC5iSaPVWaTqJmGTDjubX/beGDH1WhtDcsjUgRYqmVlBlNF7Uk1YJ4IyY7G3zF+Is
	 uqitgEWadFyurTmS4mcjZif+kpeFBOr5pNdHeo6UsGYVFQqWhtYvOEu6sPc8rDcD7/44k
	 BtILvxnkstsK3OPRFZco3IFX/XipfkguZ75p1W8cXDHwlrymo+ryd36dXlObgo/MZKC8U
	 zpQLPCav/AsKXr8HYja90SsrtyqA069Qa577gYQJ13cD5NwjY9x0gDLkxcR5lbetzBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohqFsNKd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349E3606A321;
	Mon,  9 Nov 2026 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohqFsNKd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A711F0089F;
	Mon,  9 Nov 2026 22:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262642;
	bh=dXGOOAHztGwt4eSJUdZkgiCiQNoRMAkQZbNhRndviHY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=ohqFsNKdoEnp6uAorp9GyFfO/LSrzW7T6wuNK6X3pGhW+LY5eKvZ5OwrLxQMni9z/
	 93iUrtFyqZc5ZOC8LXG9teMFL6eqD5S236AwGAih4R6QAh2cEEdA1fqUERXSuT67fx
	 0hQAJXGs3XiK+a/H3tOQ1fsHT6tEfWZzBtNMSgJxjFaAdlSgP0lpWxh47jFlE5xxwV
	 YvZS35mcCU0BlopvqoDROEJqvWu/4yCY1pSjiBVi62ZpyJeBbN1MWiALcztPUMnc2B
	 UI39yGq3gJgRTT2sXcB2oOso4ct4AexQVrExrzQ0uP1twlet29zO2OTUbp3pqrenwZ
	 t4n7C5zXjG0bQ==
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 23:17:13 +0100
Message-Id: <DMR10QIH5MHE.2OCPKIF1LJMN9@kernel.org>
Subject: Re: [PATCH v2 02/12] rust: pci: expose the VF index within its PF
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
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <20261023154009.2246627-3-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-3-xinmengs@nvidia.com>

On Fri Oct 23, 2026 at 5:39 PM CEST, Simon Song wrote:
> +    pub fn vf_id(&self) -> Result<u32> {

As mentioned in the SR-IOV, this should return Result<u16>.
