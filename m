Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116578;
	b=LaCpJKeD8cu4hleD4GYpnAObVAMu5oO+hU0PpxuJuUXMIMtdxLKxvZkC66ps3FQ8Z9SA
	 wXVClrbzRVm7I2cHDUgu3Nl7NJ3vMIcQIVP/lBjg1pO9nCVASVzdrTI02l+tZ2qaigWw2
	 JaLfctUmoI53nOAk0fwVAlOFUt69/tLXNBLP3QHIShgKG5Ky+8G0OByw/PFHKjfnJeFDo
	 HGOZwr5+YWhlavHElEGRwd9pEGSwM462eJt2iUZZQYq13lVPyU/03AW2oep6tw2oECEOo
	 fqMvS/xm5bI8bZCgecKYeYlm/sdrdD80LaMKb8E/NLTi5aro71GZXS6fHvpMh8+YzUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116578;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KHqlicreNc1yHYH6N/SnpHn6sVGJJ+btK0Fp8SA6OwY=;
	b=crptzhlMbfYUyn/SDYE2kRxkPLc16z2yZRWQJ4IKyx5rFBU43psuewqWHkhjerwkkrnR
	 IRG/07RlIAsRgSUwwVMM7z08L9BAh9SnntsChQPU9pXmzTgLNPNxGIOdwmVl40kW/gXUS
	 yWHfoTfrXHHgAgXouxdI0nCFSpzmg0Gu6nJqJrMCQRF6xXcMSP97wVybIB8T1LHu33+uc
	 sAX7+2QBPoR3jst5P99Y5W6mMOmzMetmMZGXczJ3pMVbm+N0KDpkUrso4Q6BW8PuS+WCY
	 3lIw6Q4ERYzTLhT2uCQmnLidOnoyOHbS+SN7voT5GGGVeyE+rCXN/k3Wx3MikKDRZ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLl8Ac6q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03560A383C;
	Thu, 19 Nov 2026 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLl8Ac6q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20D11F000C5;
	Thu, 19 Nov 2026 19:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116578;
	bh=KHqlicreNc1yHYH6N/SnpHn6sVGJJ+btK0Fp8SA6OwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nLl8Ac6qOxQhHOPTnvmYlhuU+pXwf9jAEbpIbDWjXnw4GWs+2q9FoKQLET5dmOxSM
	 9241cPcPeZCxUL/uWdutt4SQvXyGFMJi7wXf05xtT8yBu5CjqVeEnOr8NxKS+dzOuR
	 yiAMq5mBUIwJ6hT0FytKETu5mW1jDLgMtay560Wwvmc3JkoWn+ylNx8Tqt+2jGXBXb
	 C23/BlzDNZxWRxc+NC3CiKiKrlPZ3rofIn2ic/+TsXhY4GJSwyTPw7Zr5s9DYGCNZz
	 xK7q7Bj4c+abDYqymoiCpz7kfQN5GQYA+y5qq6rRhvDuXKnqPDItTYBvCAmIIt7yWX
	 KeIfHbOF1JTlw==
Message-ID: <sashiko-outbox-223905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/31] driver core: Introduce a generic device trust
 level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-19-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-19-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:37 +0000
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
> Attestation needs to hold devices before driver probing and DMA setup.
> Authorization on individual buses does not provide a common policy that
> drivers and infrastructure can use.
>=20
> Introduce a shared admission policy and operating trust level. Keep the
> accepted level fixed for the device's lifetime because unbind or failed
> setup does not necessarily undo hardware configuration. Retain active tru=
st
> through teardown so cleanup uses the same assumptions as setup. Preserve
> existing behavior when no trust boot options are supplied.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D19

