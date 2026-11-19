Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116565;
	b=WaD4aRhHmRne9rvTJYZ5zwxT+hdfvikd0kj0mdjYQWhZPBugxqnQAIWO3/65HsTBnc4H
	 BGeE06jk80wsx0i0qdzEBqJf1RJdMwknRPAt7SH8uYBOsyFYXnnzIN+PaVvwFUGkYvWiB
	 26BaCn4LF4PT4MKL2HpM0rkrLtcYodJuOWgQdwWunYAk0J5yl9CK5zQFrqfA1DTiX4176
	 Ko5ZCcpDMm6AMMyn9zHHEyZr+zzHkVJHYT9ILV4jzGrjJWQKQwMHdlwrOYPRfItrQ3MY7
	 FgV/9FFYkKnoUUnmgmqaAYrf5esaOWdsXqfOfGFLJLVB1fAwXIcRIW9MznJ99dzstdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116565;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ce+QtVqJe7Xw12EEhFE2MVhtEhpRXlhTYVtak42GP9I=;
	b=Rqgjo2bo8PdSpBgHW/eYLSb0qDE0NaP/R37lnj2bXqcSYlQhhgufFXSBADHQshsdx5E/
	 ZppHmYgLQat583tJqXHosllYZVMThZ4HN9JQgpC1cr5Ki7CKGQElbd8Z8ZDYhpfbIqVGD
	 Gt+JSEJl7MSkOPFOfsGSEzJwc+5lbNDb/cX9xZCI40+fHRF86vyEa8ERGl36Hequn9ZMU
	 YXXxv0e/3eTk8pZqlnBqQmgvx3Ck7NfZZkjn5zpMubxa2nv1x8zQo2fvAXPwmGfaJ5Wbo
	 C7PRdC57BNZEomF0LfpiS7mfnDI38pfAQYDEuObLzZJ4JtlUK5dF6Cu083tRCv8fHCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5Tab1cr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555E60A260C;
	Thu, 19 Nov 2026 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5Tab1cr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B991F000C5;
	Thu, 19 Nov 2026 19:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116564;
	bh=ce+QtVqJe7Xw12EEhFE2MVhtEhpRXlhTYVtak42GP9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5Tab1cr3rUZZnfB7W0PkXrbPb1mC314ofVvK6ODGA2Cbmr/gItj2qf28BU/4dO1Y
	 kCJ9q7nkF8EcUwBQeXWkJcuxnADXD2ndv+RdAVpfpr62rxzWFZPz6KNz78tc2RKLFS
	 aUiWenNV9nsw5jQOm6QoA3qKdEvoiBb5F/qXGFgr+x9EdrxJIOcKkSUqHjQMj6SDUo
	 vnuWWWdKpJCDoaTS3Amkqr7mhINTOn2xPRLqLS5Ew5eEW9arYJCrXhs0RCUAXbDWrt
	 U28vK1YzxvOCdJlBnwqY1fHiFnlWILvlJQ9X+Ty3BUuR2ex8LgaF8uSUfxTBZP/p4U
	 QYjO5CEMIeqcQ==
Message-ID: <sashiko-outbox-223891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/31] USB: Reject claims of DT-disabled interfaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-5-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-5-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> USB core skips registration of DT-disabled interfaces but keeps their
> objects available to sibling drivers. A CDC-ACM control interface can
> therefore claim a disabled data interface: manual claims check USB
> authorization without checking Device Tree availability.
>=20
> Fixes: 01fdf179f4b0 ("usb: core: skip interfaces disabled in devicetree")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D5

