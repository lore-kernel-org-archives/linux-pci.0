Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493933;
	b=16HFRe5Xl2yAqU0fDtokzBTstNINXzwkbI4mmR9cGo8aNi+VLBotFzgvECvJh0o9oHEN
	 dYUdS/L5wF0uso19oPfEwEsk/95w/sXisItILWiQxQKLCqqbHe+afmvPE36phoHF9wVz4
	 KZbe+E49EIWmGJOjeOPnNwMLTYoZ0hiXZ/xTdR2DK110VOdM9J/jhD41iLs4kSJFrEXiX
	 oKkCP6u7DsSGkFtmlzYY2Zii+oXixr1opsFkYp2ElUD27uYVGtDIYuxKteWnK/fjXltBH
	 X4exAAxPCu7Wd2RQWAzU4mfOPqCHBMO+N9293Uf6oFqnCb2mX22WJ0iZSTVQeAncpeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493933;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=foXDGGGEZNGKYZdnr9DiRWy6+/PHkP1LxkXC97iLxU8=;
	b=ZTElc0MlrXBmAvBmoNoNDRlR8OREWorAcpBKTe6G7/mYllkTojXqxVzuBxmJ6EukQq5X
	 FSYHvk7BBftbfKtw6Rkp1g0EsPRvSHF9d722qMq4CblWtm0fyRopOXLX2Bc5wze3d5bNn
	 4jmYIaf7zTuoRwX+STzIoE0E86hgI4emWueUqmkMc+2yavrBHMl9O/c4xvU9D9pQmA1So
	 CKb6UznGx2tutTTTQZDnC1Eoe+lfWaIEvqj/DTddpYx/qll2GZfrnPbsar6QznTy9JQJX
	 66XUTqa8HwGjtx3No+rEWvTWj3sYMWV3LtupEQCS5VJixQqebNARIZdeWYerCaEPmDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mimj3geE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE0606A8B1
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mimj3geE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C889E1F00A05;
	Thu, 12 Nov 2026 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493933;
	bh=foXDGGGEZNGKYZdnr9DiRWy6+/PHkP1LxkXC97iLxU8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Mimj3geEs3BRszX0LyoV/vIJD8tdnIajNEunetVsffhoddo0C+axEn82HLQT7IAT+
	 O+O7uUJ+lk6dk2GfoUX7wCFL6M2FL9rVRJXw+tgvpqTl2JZJlczyD+4x7xCkFKXdVT
	 HNIuLp4fXgAAUwVMw0yYHX7zQk0F6NTZYdupBc1PkowhoTcMIOpfyXHqyyYwieD9lo
	 c7wWpzJhyozhwhZevctVUdHXSrDaYb7+La5TI143UBDPP5m9GoiRGPVYQ6LZg8KRmU
	 z0KUVhQc58AouGTWvoRY3tiH2Swcp7EwYrtJwBz9ZI2Ft/dS199JZL4Emgwwn/Cwn8
	 P2tp1a9Z9EO8g==
Message-ID: <sashiko-outbox-211339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 09/20] vfio/pci: Use access ops for function
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-10-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-10-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:32:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Userspace function reset and its D0 preparation must finish before host
> recovery changes device state.
>=20
> Run both through the SRCU-protected access ops. Reject blocked requests
> and let recovery drain admitted operations. The D0 helper returns
> -EAGAIN on bus-lock contention.
>=20
> Hold memory_lock across preparation and reset so concurrent PM writes
> cannot put the device back into D3. Keep the existing DMA-BUF mapping
> removal and restoration around reset.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D9

