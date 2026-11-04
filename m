Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824615;
	b=AOVCBuBd37VnNA+E4bYFwAjGLu5a/jY2hvXBtnh4n/6rRTk/szqh6qni4X7yJLEVUZ3v
	 56hCOim5Vuxp5KtHy2EePvXSLrG74uKgNO+l/+px5sK1i5vyogzVfnsEMbqPBipFDJfdG
	 UEkPJ4w30KiPKQIj+oDIAJDlP26qUOtXzjowp7GLpJe4c4tY8Ep9Yt+7zpvVZehHF+7VI
	 oOwRF8Lk6/yiz6Z4LhhKdiOhPraMs2o4hfZcDQXL0vvRUBR86baXWdLqiY5fmGMZtfTuH
	 o1+tjDQwn4t8Zkcp6PvmrQbD+INqPZVGu1j55gf/mYfahrPcAWt5RIalQwAdGw8e/pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824615;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=molaxxSlyqGgz4uBias4mBVkzNOljDY00RtNc7qBpVk=;
	b=YMUlhsvDuk48qYZnCbN0Ze93aw5b0En5Kum0LckeY6EAD3my/Fj3gv6vjZcUJQpy1AC5
	 DaoHFbF0k5MNd9b0/5YgIOJj4cXcx+TVpuRKnUM3r1MEaCry6qdH84VReBuTYK3qFH/e5
	 gxEY/h+CDWfyEsDWue0qMq884xL7+8G9BnnLsd7UgAgNtxV57MXfKWYE2bbDrUoaBf7FX
	 wqW3Ztlhi72MCRw+Wazp6C+N8HUFkt0hvsM+TLA73hoURbAXymgRuahOFArjdgOjl45/z
	 2f3792JMIMQ8jEnHtVf29WcjI9T6B51O3f4ph/COG6QJYiprXeOTrKqXTc39KfGYk6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQyj2k3l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6FC6075DC8;
	Wed,  4 Nov 2026 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQyj2k3l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA74D1F000C1;
	Wed,  4 Nov 2026 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793824614;
	bh=molaxxSlyqGgz4uBias4mBVkzNOljDY00RtNc7qBpVk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=aQyj2k3lWyOeTjKWdAFZjRq5vb3hLRfSE69ir1W/UiZbad3Lm5N65cOzeV0cxMNmK
	 BTLHvVNru3HldjTMSU+QGhGlhAF2X31rweGCKtM7kZ24IJTU3DQ9DqZi6tbb0LO2az
	 ICKpcNvV4Rp1yplZxS9/lXtxTJ+7F5b3VRSo5jxyW1mSPJlTueXJl1ZLOt3mnzVVIW
	 AttOaVSIc+mVCKd4pzpmBdS9IctQ9Xfsi0i3ZQh7PNV5rnLcv/pfKO4B0pTgOLhgSM
	 RzHfP5x5EYlcEscSgIrODegWAbqoZwppbtACjtxAdE86nJJoBp3keruU1koHjgCtXM
	 vOFNQlfMOJbGA==
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
Date: Wed, 04 Nov 2026 21:36:44 +0100
Message-Id: <DMMPR2NCVOPR.36BPE8I92CIXB@kernel.org>
Subject: Re: [PATCH v5 6/9] rust: pci: add typed SR-IOV PF registration data
Cc: "Simon Song" <xinmengs@nvidia.com>, <acourbot@nvidia.com>,
 <kvm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <linux-pci@vger.kernel.org>,
 <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
 <apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
To: "Bjorn Helgaas" <helgaas@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261030171230.196717-7-xinmengs@nvidia.com>
 <20261104202810.GA1422371@bhelgaas>
In-Reply-To: <20261104202810.GA1422371@bhelgaas>

On Wed Nov 4, 2026 at 9:28 PM CET, Bjorn Helgaas wrote:
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# include/linux/pci.h

Thanks!

> I assume use of vf_registration_data_rust is meant to stay
> encapsulated in rust/kernel/pci.rc and rust/kernel/pci/.

Yes, this is private to the Rust PCI core code.

(I may generalize this via generic private data pointer for bus abstraction=
s in
the future in struct device_private; there are a few more cases that will n=
eed
something similar.)
