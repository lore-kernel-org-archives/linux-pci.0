Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272675;
	b=oyVDN1Jm5877l3GGlE0PhSB1npcdR4myuoGVWyTJTBxcYe2Y5PIHlswtWZsWEySQbGyA
	 hif3AZupRMxUU4aCY2kuIG5xXyb7jCYFfiwpopwkZ3O2Su1omn9xwZgleSEeWYCbCH8If
	 ZpTR9rL5tUkt6opGgZqIM1+lJSHnJaICdARqPaMoTak56ea8zAgS0E+oo4vWd4C1S5Neb
	 3TnhU8IxATTBHN/CEF1oCMG2qHripyHfvAgwg6gSZtkB7EX/nmAloAZDA1VSPvwSYXJ/i
	 hqOrNLKX5kNXgLgZZLeFHYgpAenK22QvIWjoFQdp71HuzIlkzfxCHu4Qj2RHtJZ8EcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272675;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To;
	bh=Bv0ooEsqQhG/+6pm98YOZvLWwFhBUu/sWcsdtUoLwy4=;
	b=L6gFi7ZHncAbVx6LhIKSpE6cUXYL69rpmIujODnU3L3r9WWLmScq2trj3tolMW+SXmMR
	 cc+wUbc0SMVgS0njzCMI3ExwtdZl/Vb4GsSdMNcYLT4wgrJCjbqQnsEUn3WwBmKgKEgHe
	 QBTz9V+6UVZicNJJfWauIaEYmc3kgNkQYE6x8ETQTh9Tee9V9W1GvfKj8hcMSFUXziWf1
	 vq3PTYixCVKBtgcW+7EBAciclKDUbNUQyo2kAf8Ou/QnH7cT1QGrWjmkP3Y+XuG/FOplj
	 vq/V2QjVwIGaR7uSV8vtMXHOs4VjeQmvucO/JxsopaOxbJNR/4m3a54Nv4UvEykM9BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/IdNdDl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3266606A31C;
	Tue, 10 Nov 2026 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/IdNdDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351B11F0089F;
	Tue, 10 Nov 2026 01:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272674;
	bh=Bv0ooEsqQhG/+6pm98YOZvLWwFhBUu/sWcsdtUoLwy4=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=Y/IdNdDllQ8txzmqlTq5n+jUNGUsT1AxrfTY2ikBxw33Ci2JnCEerTvPmnB/3QMAl
	 OjNGcxMFLFoWuhjU9RzXBnDylktnvyRr7vcG/VsWjAmjC3ARmbReleTmjFt1KWirol
	 utOgbEJ1hwQVm7nJ3+hkfywBaxif6Gd9FPgyDuJH+X4x56JZVehKpU2+hi4qtwbwin
	 jSQfm77qQHMo+h+nG9Vf6+/1Ffoekt6SHMkzEwJUypYrjKykbmUp3ukB6J7sduL2i5
	 wGnTT4nFjBjWBgxpiuYPx4ghgn2dIsiLQSdxNPvuZ29n5zLB/eObLqV1Cz2xMqSEf7
	 vf4f15+YNFK4A==
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
Date: Tue, 10 Nov 2026 02:04:25 +0100
Message-Id: <DMR4KREJHY3Q.4VWNF1EO3UE0@kernel.org>
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
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <boqun@kernel.org>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <jgg@ziepe.ca>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <peter@colberg.org>
To: "Simon Song" <xinmengs@nvidia.com>, <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 00/12] Rust VFIO PCI support and NVIDIA vGPU driver
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-1-xinmengs@nvidia.com>

On Fri Oct 23, 2026 at 5:39 PM CEST, Simon Song wrote:
>   rust: vfio: add PCI variant driver abstractions
>   rust: vfio: use the PCI adapter for variant drivers
>   rust: vfio: separate common device handling from PCI

Those three commits introduce quite some back and forth in terms of deletin=
g and
refactoring previously introduce code.

(I won't review them individually for this reason, but I can go over the en=
d
result and provide some feedback.)

For patch ordering, "rust: vfio: separate common device handling from PCI"
should be the first patch which establishes a shared representation of a ba=
se
VFIO device; the other two patches should be squashed into a single patch.

(I think a separate adapter type for vfio-pci could still have some advanta=
ges,
but this can be a subsequent consideration, for now I'd stick with the core=
 PCI
one.)

Thanks,
Danilo
