Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393393;
	b=IQvQS+kmEhI8ffhDXHLC0TeMydOB4qPh/XauoHJAR2qHoOF06Q/tjiV0Fn9PiQYtkKm/
	 f/3aOa61g3CdBscqnLlbQ3m32ZtnuwZgMzPt53Vlygj8s040NklHkQGRVItAUKAB46Dj9
	 X8GRscbUK6AW1vjORUbNk0X/BkYI7DGifrZMQkmgmW0lhC+FI/wGx33pvqn4E83FeSi0O
	 TWrWipoyBGYIKxc7qkB76qngvJgQD55PJdSrIQwiyQ4EzfZmKagAA/+EPRcl/JEUUmDYN
	 K8pwPnbMf3q7zPM1NqMS/mIiXlH8/ol/qdm5SmwaiOxdhyPDNgYNfcMRlY7xZwecQHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393393;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:From:Subject:Cc:References:
	 In-Reply-To;
	bh=VVZplZGAUG0L1pPgjgjHgUC6lTFKsdTYAcESgif6QKU=;
	b=eoaiIKq6qmsr0H+iMNVUakzuVvRZVAjaw5CFpr04OmBgMh3pk00G5v+nYVJya9rwqcoZ
	 xB1eYNCPgNpg8jHDrmBCkFIHrQbEa7EByvoybrtYAIoxu/duN4g9XbnmTR7Gin9tLqXDo
	 c4ZWw/Wkkk/V36UbJaCdyBmqVcMssIEnmKzxMLk1hz11dcNVoJF64ySNjKe+njOpUMNDe
	 JtMvOe4oY2sRjAiX1T6T/K4uu93f9PhnQ0LLWBa0c96+0dua8bqKGlNxvbmzlM24TMx3e
	 C7dSMugpUQmkqNPHr4gc1tThcZPb5+0G7EUCqpaJaWRk19c8oBp6HbjgJDK7H8+uc7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAPh0ivP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364C606A31A;
	Fri, 30 Oct 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAPh0ivP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0A11F000C1;
	Fri, 30 Oct 2026 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793393393;
	bh=VVZplZGAUG0L1pPgjgjHgUC6lTFKsdTYAcESgif6QKU=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=CAPh0ivPF480Xp9fX9hVVZTwHlArFNJw5B1BVsXoNQ2XHYBsplj2QeZR9i8I8w/hF
	 H5WIxgXCZ9v3Fj1Bs6jI07/JP2X4VfQa/Ln/b1SMY5U7Vvvw7yAOVuPyj4+rEoUWGD
	 IJqafl5IFoUZhHv6tcgKMQIuHM6i33YSD8II4m802MgsvpoDHv6nATXINIzo54/BJm
	 aNhpDvTgk5aApZRdiS+Kc8yvKU55cmv58kERXISnRAoUUJyoOSOjRuWBszzVSa5FQ+
	 Sl38Zt0rZpAfT/bT0Z2BVq6cu3HsftqZhCVRd2ETIcq52TpTuu2ZfYyfTFii6sDNLf
	 jZX/mxV1+ynTw==
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
Date: Fri, 30 Oct 2026 21:49:43 +0100
Message-Id: <DMIGWAT6IRQ3.1071C3B8WDIU6@kernel.org>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 00/12] Rust VFIO PCI support and NVIDIA vGPU driver
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
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <fe4b26ba-9854-4375-8caa-9d1b77f9e745@nvidia.com>
In-Reply-To: <fe4b26ba-9854-4375-8caa-9d1b77f9e745@nvidia.com>

Hi Simon,

On Fri Oct 30, 2026 at 9:40 PM CET, Simon Song wrote:
> Could I get some feedback on the changes in this v2 series?

I have this series queued up to follow up with in the next few days.

Thanks,
Danilo
