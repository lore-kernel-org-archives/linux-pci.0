Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8453446C845;
	Wed,  5 Aug 2026 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931788; cv=none; b=Xb+mWK/kHjxDS3UW8RBY1Xi/BuNzjgycdFgFIAK/g/1q0Tx2chVr+PKSTBnFkSA/ABU6P1pDrQCXa0U7iAVYSUBS0Q9nylou8v5iXpO/jOzTQsGixaeBkuD6DzeQQOHr5GH3+x16J5ibupp0nSRqvh1QXKqXlbBfTODX6qBAF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931788; c=relaxed/simple;
	bh=mj6C51uJ1qwk0HtHW4bXFUDW8q9EWnoEZMOSNuJkVzw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r0oAdF/wKJHp1pn/O81wQ1JQZtzqSpRFujtD4MXzV5kEPWDhRIBBBMYLXwCRLCZqZOjiWILtJCEpWKVFvHQ7xQkq459q6JVbNgRoWzc8Pj2LQuF5asqDeKRghponcH6uPwqRn1go5ckDM2ABDdA78iTYLr+9Rmf7RK+npNd8hYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ky1uZUJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ky1uZUJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500C11F00AC4;
	Wed,  5 Aug 2026 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931773;
	bh=mj6C51uJ1qwk0HtHW4bXFUDW8q9EWnoEZMOSNuJkVzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ky1uZUJcT/0aczaJYXpo2BiObqlab/LjTbG0xrjFOKwbxkYUg3g/MSYlOThb6J2Zw
	 ItE70DNm8bTTztAVslO4BeTcRWNfK8lq6rdMlbjbXL6XKW/IT7XA4/Y3SQGCiBRnTA
	 hBnXkW1anfFBx/AxBnoBnIZsJ/HweDPuLrgcwjNj4OfRaFm+LHnZMQYYqnt5fEe8pE
	 B/VR/6iBUlYiiM7/TZEeqsxCCca0ozMtNBwwWkNUjP0WS/ocbiY0OgaD9YRNVVJIwW
	 nDz223vW4+DzoNkoQ5O7Rr3H8U1bssT+LiBSdmM66f2IVizbz3MhO6yJKSL/B2xyQO
	 CSCxpdINWjStg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/5] dt-bindings: pci: tegra264: Switch to PCIe root
 port bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260805-tegra264-pcie-v9-2-fa2ed7350ae1@nvidia.com>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
 <20260805-tegra264-pcie-v9-2-fa2ed7350ae1@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:09:32 +0000
Message-Id: <20260805120933.500C11F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> Switch to using the PCIe root port bindings in preparation for using the
> standard WAKE# handling.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-tegra264-p=
cie-v9-0-fa2ed7350ae1@nvidia.com?part=3D2

