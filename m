Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348016;
	b=aRFpaSghtbpNYRtBUi6eT332I88VMKCM/AB87fCGn7bD75XlH1efvwpmV0J3QJ6gQczR
	 uAA1z52e0d0SkMvXxWbKND7n/5bYPHRJn+hNLPaCCAp9jmiZTrnzl3rlSiLCgOWHJwRx/
	 NCbvlmJuLfQVUo2Sni1rNnTytKPfvLwmTqf7xjlhXGCQ1N9N/cBFm3hmXylra4sGqwvNU
	 mYVQe9B6ulNye6EMp120HfFcVZOrEsTWha5oMGh+M2tLIyMJQNmXjTvlMjc4i+ZzTwn/R
	 jXj5UAmCrP4Zf3myAkY6Ztz5xsbT34PMXeKqT/T7P1hxnzIvchysb+vUaAE/gUulC1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348016;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wyxzkMGnAn2d3gBhwWGMqC66n5EIc9WpDSCV6kgZH0s=;
	b=bsqBaD3hBfW0KMT5BWjl61ncCjJgSRHItnD02XtwmUGTOpy2yDSCz+6mRqtO/lF+5z8O
	 3i6zJzC5CJLnb+OfrfGpUm63QW9pmb2OG+oZ3FemHsOhQqIvd6AmNc4pNGeYODc29c0/Q
	 BdIpeVInFrrySY4NSkCKOo27XUxehJ/mU6wO7rPJf0a+viXIRY0CA6tlHbaWc+HQb73gv
	 AyBVj+lZNt+t+lkhDpbb1OUuipc8gmGN7Jw+zaUARVGbI6xANkyVAGPfHhfSMr38rudBa
	 XwvpbSAeSznES8Q07O/UDV2LiakfTdpUqDc8HbO40q3EtYohQ2vYXNduIyvTZFdZHrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Artj0AW3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85227606A325
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Artj0AW3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E821F0089F;
	Tue, 10 Nov 2026 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348016;
	bh=wyxzkMGnAn2d3gBhwWGMqC66n5EIc9WpDSCV6kgZH0s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Artj0AW3DXJGxLAqlO9VLg8Vdr5Ki5nfEYM/qrTzNSTM55hzadoxT17euJa2Hj6YR
	 m8wHwPMxzTVVPba10Pe7Yw1URHykVWPwHvuVlyPsYtlWjqUWVhYlHci7zOkFOtSiyX
	 kTZFcJ3YaU+GVQ8A46Lt6e85UcXSy8mppFdM2A73s3hBoWhS34N/u0sujVtZaCye3L
	 xpndPFyW8S3mntHhQxha9DeSgJ/6IJMcn0Smvi4IVMXZ9JarwcMZ1vG/nLOzvceGhd
	 eR86ciozeNM4kO+8PIBLzFO0cMlg3jSfT1Z1J3JIH52tEd20yJK37KBTe4SUPM4IQ2
	 8Qax4YMyRXaFQ==
Message-ID: <sashiko-outbox-207798@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] PCI/AER: Report the ratelimit interval in
 milliseconds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261110215614.3931232-4-yazen.ghannam@amd.com>
References: <20261110215614.3931232-1-yazen.ghannam@amd.com>
 <20261110215614.3931232-4-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:00:15 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The "*_ratelimit_interval_ms" attributes convert milliseconds to jiffies
> when storing. But they don't convert jiffies to milliseconds when
> showing. So the user is presented with the raw jiffies value.
>=20
> Do the jiffies to milliseconds conversion when showing the value.
>=20
> Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110215614.3931=
232-1-yazen.ghannam@amd.com?part=3D3

