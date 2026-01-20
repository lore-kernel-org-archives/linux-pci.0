Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A644D033;
	Tue, 20 Jan 2026 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925360; cv=none; b=LlGKV7XnU0Xeucdt5q0Sjzb85krtRAd/Wtkn12bDyIeX1VfWNL7AnoAI4rLPLrWgWh9S0LyRpAhBwsykvEK4pIRpkbTvwVYwfzY8/0Vb48bj6e+NodxkqXzHASMZ1u3YkvfBaz3VmR/KCEgK0gUL5LViscaC+IXZivL7bZzrZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925360; c=relaxed/simple;
	bh=3h7U8OB8+wXTJLw06HOWz9QDzZOujMBQUm50YpEFJaw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DdMtWqVC8XRuXraP8IlU6jM4tPLlQ+NwZU6BFC0TlyhbPOuxBQBpQzzPMNiy/+zvOFLKg0uRmMZ68+Y5sZUHoTQlN6nO82DtSsDtJPVzQq65vDpj50NU0HJvyB7MknIkXJToUWJTYVbgvsgfg14XI+dG9Qxwg0RgQQddeFaozoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYRpQwvq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYRpQwvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280BAC19422;
	Tue, 20 Jan 2026 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768925360;
	bh=3h7U8OB8+wXTJLw06HOWz9QDzZOujMBQUm50YpEFJaw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=RYRpQwvqzJ9t4pyRKYwXWk9JDiVMKfQG6OA/n9BF9o+M4uka3uKKJJKuc8mxIq+0o
	 7PXmibTcnLpAw8WEI9UvOC5MhnD/aKR92o2mppDPo758yReopL/GEIJWGyN0aO8syx
	 Kob87V1RfhyfQvlOql34qqcB6QMl2c0TvOS8HE3yATefdE3nuQLVXMpZ85WayooJHP
	 Us7no1HFp5AnVHhxigUfZKOR+eEUIIg1TScXw+YGDdY8MHHruQMvnmZrDJrThbDnQl
	 Lu0bdj+sho5Z3CUZN5PwkzKFTC0K6sVn5yRU/maQUW4n6slmSMIjp3sJpn+ZPZXotv
	 8L2D36MXP2OmA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 17:09:13 +0100
Message-Id: <DFTJPCU9NQQ5.1J4RRDVZH3SX@kernel.org>
Subject: Re: [PATCH v10 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260119202250.870588-1-zhiw@nvidia.com>
 <20260119202250.870588-3-zhiw@nvidia.com> <aW83HV4lVR5MQlDd@google.com>
 <DFTC434Z6XRK.2RTE2DFC16TDA@kernel.org>
 <DFTJI4PTLDWM.1F7X1KN1Q264S@garyguo.net>
In-Reply-To: <DFTJI4PTLDWM.1F7X1KN1Q264S@garyguo.net>

On Tue Jan 20, 2026 at 4:59 PM CET, Gary Guo wrote:
> I think whether there's a runtime bound checking and whether a IO size is
> supported are two orthogonal things, I would rather we have a single seri=
es of
> `IoCapable<T>` to just indiate the latter and still keep the `IoKnownSize=
`.

I like this idea, it seems like a very reasonable compromise to me.
