Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073AD36E483
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783245401; cv=none; b=dXHvqMm55oqiPUL2lFxeodAMABjFT0ArVp7+VngRVz2bge9Dg8urPbjBnHFSrUEy544g7HB9aZfHJYpVsBKhcXv/AKRDXNK35Vrz5j+6kQFjKzUTfw17YrRnYpP2YZAYH0W2W/3nipjF8eW0Skl4PHd3UN29F6mn4KqWOeoStXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783245401; c=relaxed/simple;
	bh=9NOY51Ii0IuAPd8uuvfIiV5fSOvyKfVTX7KccJbyrMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uBU+ctXjkZPeyQiPo40305B7eiV99GmVzDGus4AGS9Hp8X7gVSJ6hUr8RDNIRurhxuQ950+hxxXb0+aMqpzt7TaMrfoALKcJlZMCHQKALOD+9BPfTdOXelPost0VrWlcxXJNvayDkXX41xqYXJ4r+knRoRVinuylUyTMWqVUG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQI6Z5CN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQI6Z5CN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680D11F000E9;
	Sun,  5 Jul 2026 09:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783245399;
	bh=9NOY51Ii0IuAPd8uuvfIiV5fSOvyKfVTX7KccJbyrMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dQI6Z5CN65yx1DqvTkyiEUlM950BlsUEdMK7ImHrvz7+FNMxvV/jxhEtHQJ5aqhnV
	 tbcSJ0fC4/6IQqMh0b5oiA1MCAbDGJjyXRTbq5DprOCotf+Y9VyD2jfS92FJ0GOiXM
	 XX9rOuYJl8CbH0AsKiVhfgz5/1aNq3LAanz+fFBgLTznvhdI5d3RERj1bUVpCtTfvl
	 7esnilT1XfRM5V+DJRAji8MGVZdzXkfnZZmTc+kAxleFMXq937XMOlLaxEc1ecUz29
	 C/iByfBPU3WhQyc85TlJf7FIt9nEfocq9ISidAW9tO0GOBZWQtIZtY1y4rZ8eCIS3t
	 JDBrLdjh7uh7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add Nvidia Vera Rubin device to P2P
 whitelist
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705-p2p-vr-v1-1-3cd45cab3fb4@nvidia.com>
References: <20260705-p2p-vr-v1-1-3cd45cab3fb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 09:56:38 +0000
Message-Id: <20260705095639.680D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Nvidia Vera Rubin platforms support PCI peer=E2=80=91to=E2=80=91peer tran=
sactions.
> Add them to the P2P whitelist to enable this functionality.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-p2p-vr-v1-=
1-3cd45cab3fb4@nvidia.com?part=3D1

