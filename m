Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716263DB31E;
	Tue, 19 May 2026 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211675; cv=none; b=RG2vaT72jYFclMZmVy/jlF8IJOo/gXCG3FtBKumW4WVnZbmvQfePmXxH7vCpcvwBMATc3wnj5ur9ip1jaWKiXWBnhJps7Y1MdIbgW9d1l+kDJjGhGQtcmk5y83s2p2PIyOnmn3S628TZ5LjcVvi8CmzWEE/m8FzlCJi5cNBORlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211675; c=relaxed/simple;
	bh=KBC3Nc4aH72MDDN7wEUpqS9TMs92M6VFHpdyi/AgL2I=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=jONZACKjtBewcnn7jP48D+6OsBz4MNhgV/wWMhs6S/k1EBxz6MdQbij6LwT9gpJhTqpqngnSyIFI4DjOP26pLfJSxkAeYU8RWrA+bMXQhKCO+NUMX+FJVM28bmnV3XNVoZyY8ul+NEG95+woBDnUczXg3Nqm6OQfWQ+2nwk6Bfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwVfu29S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwVfu29S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC5BC2BCB3;
	Tue, 19 May 2026 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779211675;
	bh=KBC3Nc4aH72MDDN7wEUpqS9TMs92M6VFHpdyi/AgL2I=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=jwVfu29SblsG+4P+aBXxO13QJS40NiLgL8mIXyl4UEhXpizahXky04JFQtE1jdXm1
	 KcmoWZXj/8EQx2z5HvWz2Y31jSxHGvxx2LT8p1pd1kkkoZq62V47RYGYHYyOEjo2LE
	 Vv+Sw7MdeySOwJlJCye/ombzPr6lwUTRFVSFxGKyQchG7gtZJnK3mbvsnx0lRgALQq
	 JEiPS+ZG7Z+PVFQGEdrd4cO1b6Lb5O6rgTnM9rGi3SFjL9GrNPyEkH8TEJuOAeFTpN
	 QpXh+mizIZH72OjwMIjOqaaOv7nrO39VjZvFKptfuiQUD9buI0kHXKn3r7lCAIl+jy
	 C+7fSOwjTK/NA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 19:27:45 +0200
Message-Id: <DIMTWBHV9E5I.1X2L8UNUWLVT3@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 19/27] rust: pci: make Bar lifetime-parameterized
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-20-dakr@kernel.org>
 <DIMSJVKTYX6D.AEN6OPPC2898@garyguo.net>
In-Reply-To: <DIMSJVKTYX6D.AEN6OPPC2898@garyguo.net>

On Tue May 19, 2026 at 6:24 PM CEST, Gary Guo wrote:
> Either way, I think we probably want to limit `'bound` to cases where it'=
s
> actually `'bound` and not some possibly shortened lifetime.

Agreed; [1] for reference.

[1] https://lore.kernel.org/driver-core/DIMTSQS1HZM9.326ZOXFP6PV5J@kernel.o=
rg/
