Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380650;
	b=xrQoeuab7pEMjzKdG9TqtBfQzxOfpBUzYLcBdIRcinRqdIVNw+VaMpuDgZXOHtBXRlRX
	 yh9jRM8os4dSUp0rN/JUfZ1fyjW73TlDIZ+lI0x/TaRssxWmmwPR0Sb5EwKVbwXBCsS+B
	 fNxr0sZ29VbIGvU12CTM97EK1PgrViPi0VJviOan2n06zAe6AJCoLc9WmKEiJNZ0OTYQR
	 1iERnjU9gxZLUag69cWWtqCgPWQwv+NrOI1ksWfkPgu6hNjxTUe556L9Gfd8LiW4U0pGf
	 LGBVUX5dmtIOtdXk9nSJQG3qkkp+xLJbLVj74FMnSxs8VJve2T01jwzTrPa7qKtX/dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380650;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pGLzC+yKVAreitAW6NBN9PeKhZ/ftzn2rZqwhxDfyS8=;
	b=crlxJ7DBD6UrD6BIiUn9Tdc56gzEUI7UN3WTfEWrOS6tj1bKgGdc4HwOW/62NyRVW31Q
	 WqS/d8KnWXmJYwphbtxD9olqdJNU5DnSVRlCM0Bw1MBuOOqMarrBKYRrpi3AYChbfDXox
	 61WDtjbmHEKA55GkT2hxyfRMiUd3yXZW3GQnPEUgIuryNumrybog1iIdibnC8iMi8cBWU
	 xkG7ESiQDit6ITR9QlX6KBYPrB6c1krBdvUjS2NC5fzVxfb/uLIpTuoi+afTJGT1vMSh0
	 aU8EDHWKCEKEugmRKbxw0GYPAuetfBJ/vcq2IO1psEalPalR0VdEobMu8YFVNs2bO4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F+Jt0VI/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC91606A31A
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+Jt0VI/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938FC1F000C1;
	Fri, 30 Oct 2026 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380649;
	bh=pGLzC+yKVAreitAW6NBN9PeKhZ/ftzn2rZqwhxDfyS8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=F+Jt0VI/qDvD7faym0nQarseTSXcD7lOXDPhRUNwNtiaNUCbUh8a6rAfgNGPXVWR8
	 T805vdc37vx5k6ZCA1gjQtmaG1qB7IR/6oxiQTjZx79mx5OVpAEC1A/UzD2aNf3uQA
	 jGzpfR4s/VNRsq6e6y0bISmsxJFmYFhoo05uXmfNIRiywdBuDIz0XPYq8ek5Hg9Jg2
	 /3jRxi3BTizACD3aJNeFVWXqDde1al+OxItmAdafNA/l6MKN/1YyU9GRu2XVYddlRR
	 G1O1HCpQwI6KNuMJgIQCk1bIFzOjOw0bd2N12h/VdYmzCMHZF4ObnNXZDy6fVWZwaN
	 gmOzfZLhJLAfA==
Message-ID: <sashiko-outbox-191318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] rust: pci: add internal SR-IOV enable and
 disable helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261030171230.196717-2-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-2-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:17:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Peter Colberg <peter@colberg.org>
>=20
> Wrap pci_enable_sriov() and pci_disable_sriov() on Device<CoreInternal>
> for use by the SR-IOV callback tokens and their rollback guard.
> Keep these operations internal so drivers can only enable or disable
> VFs through the callback-scoped API introduced later in this series.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030171230.1967=
17-1-xinmengs@nvidia.com?part=3D1

