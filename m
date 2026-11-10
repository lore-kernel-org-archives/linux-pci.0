Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296113;
	b=G+Rvta2yqOZoqADMu9ugymLhpA8EJuY8AswHiL95ioDrqTNAXvWJTKmRsSI/9TgY24VD
	 HuVvh132F5WWnnYuEuz/uVpZRKgAnAYOJKUkYQl51E5pB1PSRUg5UyQ7l3USLMWpGqcDQ
	 BDq81tsnzVWG6fQLcoXf9lIzQUioIPx+uVgzQ9jq7ET5wjm0W+2tRt9jD3FMjHKGG1Ed2
	 ytR2Hav1ORcslDv/hygyY82Fp1lu0bw1w4tL4YQlg0qqZHojm0OUgNV9zgtByxGczzURi
	 pkXBoge6H/xsfbIYEO7X4iHC8aR3IzjnmLkIFKjerqciDB1OyebFJSL5XnRUhmoS5lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296113;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sZJfyn0ha4u9I7komfCaaL0RzgMrCw/R9R4BaGkytU8=;
	b=PPUDO4A4PevG4Y/ftvZSXmz4/ivkdzuAKeE9JtcGJfr+sXMHM+3+773bojpkKB9hKSe9
	 QIIITgyyXP3zhTpz28F8PEaLp0IkVpp1Qg0IlkpvfAXNAUNzYiO6sH7YBMCvGQqhjvkP6
	 pLgk3TmQw0ORG9lcpVXaMYsMTkrwqxyXjyWbspx1lO1On9FoBDJGEzS/4Lc+Ng0P2pRL+
	 gkBbkaauxhimDlsYVx+D0bJFWIwSl8Fyk3uqqyUrh4GgolFM1D+fzi+P+Cb0tVHQxDrV/
	 QJ+WF6lFIwW7wjhH1bSTyy0XF94X6WHJgJ9QS26L2/v3IXW2K7gGk7SkUFq56P7AStw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lU8zdIdn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DF606A321;
	Tue, 10 Nov 2026 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lU8zdIdn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B531F008A1;
	Tue, 10 Nov 2026 07:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296112;
	bh=sZJfyn0ha4u9I7komfCaaL0RzgMrCw/R9R4BaGkytU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lU8zdIdnpOKOcBhAlT3qsxp1Xl860DsbbBoFgtmklK3T6tuGQwyeh8Rrkoi5gBoTH
	 VH3RTlpp54InoMd2MtXQIWqhzYlllTixFaOPwOeW3uiYIwYcm7XY85JJ/u/F6GCwuS
	 ++kLy4AQubadsMC5LOIfy4XlalN7xv4DiD5eaiB1nEFxmaDzdtuJLIC122fwuwG3df
	 mZrpjCYX1lhJ2Q7p0JVuL4N6isglyEptiAtwBsncvxRxltjv5PAFMRqC/9k3BjJVok
	 D/2XczwOSCgFxUr3YeoNWt0rt3q7rltov63N4hHgLA6iC1+yex5qIdiyc7vhbAulMu
	 8+ox5yPJUlifA==
Message-ID: <sashiko-outbox-206501@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/19] Input: gameport - attach manual drivers
 through the driver core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261109-device-trust-core-v2-1-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-1-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:12 +0000
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
> Manual gameport binding calls connect before publishing the binding, so
> driver-core admission cannot reject a device before functional setup.
>=20
> Use device_driver_attach() to run the existing bus probe and removal
> callbacks under the device lock. This gives manual attachment the same
> admission, setup and failure cleanup as automatic probing.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D1

