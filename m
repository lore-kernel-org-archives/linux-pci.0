Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F71490C1E
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399334; cv=none; b=tr1qjlfGMQ3fSFJaNpdkeS1/WzyGt+deidBvO3u2TTdbR8OylJTtjVKS7KzCtxz5evP6Zls6rzmvz8NQtz6C++WTVEeDpIlEchd+TxjVq+ag8U3stqNZ6jFN6XT9yh7yj19tFQGW//SZ2y7b8qEJSxP3hmIsqm7SBCtIZYU1kB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399334; c=relaxed/simple;
	bh=PLpRz4Ru/UBf8G56AqkBDQegnZ0Z+0E9rhKbzaRcA8E=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=TCuHd16SiHKgea7K8gYsb9yGH5PwZDfT/Ys7ABLCEiDBq0JeNuIQOkfTYDMsFUWzFEwH3ICM4yjzRsEIPF2md1xa5UmJTj3xUMpiqFg5zxHpfy0UV4PmdBaOSK+R1lCmw8Hyu+MvyVot7C5ffXzJgXa2rcxTntnQ8bGyfZslahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaRxuEhU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaRxuEhU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0D81F000C4;
	Mon, 19 Oct 2026 08:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399332;
	bh=PLpRz4Ru/UBf8G56AqkBDQegnZ0Z+0E9rhKbzaRcA8E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EaRxuEhUPAuCvwTyY6pV0KqRD1tJH3s+mzEXrzKE85NVLhGXHDcDmBZZGZgEig64N
	 pZg0LJwzuyZqieeenY8Co5WpXFWKciNmkWo5JyDYEWgLdNXAAYZCq4R5jbTnO2h/2C
	 sKNCjlht5Rbh0Fd3mUe140u0rr/u4jU8OBn8FWW6nMIMFcU7BNQMhvOj8QPfBpypsk
	 M6qqbfrdRB2fkyTbHvjWrkgqiADi5qoTQHgKjalfU7Bvd4bJHHVeUWejSEYjU1RjYH
	 vv4ZgvW9NaGTIJrWhnoRvkokb/YMjkiu9Ugn+9z/HLE80mNo7cDZXbW1QeVB4NeimC
	 9JqWjP69jD+Hg==
Message-ID: <sashiko-outbox-176825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/13] ice: Use pci_iov_get_virtfn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-12-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-12-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:42:12 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> ice_create_vf_entries() finds the VFs by walking PCI devices with the
> VF device ID and checking that they belong to the PF. Replace it with
> pci_iov_get_virtfn(), which looks up each VF directly by its VF ID.
>=20
> This also avoids leaking the reference held by pci_get_device() when VF
> entry allocation fails.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D11

