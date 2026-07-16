Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CC4432BE9;
	Thu, 16 Jul 2026 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222222; cv=none; b=ro78iUixkmAvD9Ytcz9q7QnXJ7BijtiiZ9YGkPCFXEBnD4m/PIMdGpY8MeqTKQEh8px3d9jpo/cuAfYa1eCsq9xDjnohG5w1bfIdbSfomioujo6Eb9S/tGLTJZ1mszPiE9tA7Z3N8h1DAdC6KlVnrii5BMWftFD7tl2X1P1yJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222222; c=relaxed/simple;
	bh=lv+c+sT0a7zcSQiN+d/CxCnsfGPzB0eDrdW4imUk/rw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fznNZt8qhrK2P91Sn0/7PnzLfM004Sh7UQPxU75bCKFdgjlsSSLI7xuKrH+xyXsZNKwTXwFJs/G03fU51s7QPsQkVUl8wtoJpE07MWmXw26l78eOlW1Ez5n+uuq9giUnfYPm6dYOl0eUFqsSPH0YNUCNqeeFOkD3oEpCWK/GbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kzvmxi0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kzvmxi0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF63A1F000E9;
	Thu, 16 Jul 2026 17:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784222221;
	bh=lv+c+sT0a7zcSQiN+d/CxCnsfGPzB0eDrdW4imUk/rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kzvmxi0NhFcK/MhUY/YhNxDKg1hI/Q5jL9rFc5JOfr18B1CKQkrt9nLEKtLS12pB3
	 u8MvBFgY6+LaZX+PRCFqI7H6ibyn+3Jvg9PctRnqVlPjubFFRH19S+Q9Bzh+sADlfT
	 DmwW+wOMXVywLo4A772MmWrrxyGjDvp4TuuBcgZ0HOWJdTAZIzF21Pu9czeLUI4d/i
	 IEmTRMDdWegIsauB8w4zBe1MLucD6kEhPzN4LCfNhuU8KD1C/hVz86UqryzGe0KTHc
	 SsRE24xw4v6hWrAxEeiaFpPbzA7IyP29mLI465LZSS1hFeGBErmXZ95aW+aqcKZh6l
	 6Le9E+MQz/SaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/6] arm64: tegra: Add PCIe root ports on Tegra264
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260716-tegra264-pcie-v8-6-23e51589229b@nvidia.com>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
 <20260716-tegra264-pcie-v8-6-23e51589229b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 17:17:00 +0000
Message-Id: <20260716171700.AF63A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> The bindings have been updated to use the PCIe root port bindings, so
> the nodes for the root ports must be added.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-tegra264-p=
cie-v8-0-23e51589229b@nvidia.com?part=3D6

