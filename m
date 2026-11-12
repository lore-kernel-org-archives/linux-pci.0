Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443237;
	b=nwBN1lvra2+3ImSPSweP+ZTFIQ2XJfjhIhz4q9qvN8fvXeR43QTVQIwkkb1hoxbbxJN0
	 95aKQDqA/NbTTvLJ3lyYN5iJYbtplYbALHePzyay8U3XlQ+T5JanH8N2pzcOWxUgephwL
	 SdakNErzW2SUdMwK0KzdIiZM3SSLaUrKA0xA6PsEviqbfzBzeX1q6EVOCQe2CIfLj/qIy
	 ttPkHxc4X0IQ8tKmIhACwqzN94yLEqoVo9GHA6yf6vBATu3KaAMwFXNTGrkkVLuHs1Eua
	 y6ZXO55SjYCjOqvI1g7eoEvAkuWvOy8vuHT7lwf6Z5Hof9k9gd0bZyZBNAOd/BDSPsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443237;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M7V6JlcrCzyTZudqacuDhkPuMB/9JCAHjE7QjRizzLM=;
	b=O7h/g2VqZW0zMd6QDq3IMov8cPeK3tLQfiBZLPOF3KUTK8L+WsZkbBnzE9kiBo29Cj9b
	 LCNktlvqnDs6n/i7UfyIvH0o7ytw7W8q9gFKlOOqtFhTivgBB6g64h40uvBLsrLJ5Ftg0
	 00BeGw+bNJTy3ZgKNp8HR1vi4pGu6q1yoXjmYIuzZddW4SZeknuhvoi1ygPmyu9+pMtRH
	 MV6zUg9EFmUUxA8TsAq71rUi5JywW5v/eBkHf1fJ61ZPxmjFNA9qQTO02lKJYF6WHgopb
	 WmkTrvgmfiPAdinnfmSQCkR9M2sLKFEDuJcI2zO+97jpo8cUgGk7xGCexAhFcBrYB4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hr4zu9XL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBEA606A326
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hr4zu9XL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C511F00A05;
	Thu, 12 Nov 2026 00:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443237;
	bh=M7V6JlcrCzyTZudqacuDhkPuMB/9JCAHjE7QjRizzLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hr4zu9XLp9aS5eWNCEefMJVX2GJ+NEx8AKrFfzxt31IKkYyrW7kg15E0sUN99N7QN
	 k6fb0KQIsKGZ6yrDznLxeNbViJcs3TZxn4n/6A897hFfCL+pJYCvkj+nUkJp7195Ro
	 a5Fnkvs1rpKe7284/gIJfgvv2oSzAO5ZdVzY+3ZiIbPJOBAoT4D/GLfR8JYK1r6/yo
	 DvTSMMI6Py5uk5gi74H+FELfaqVqyKBE1gL1smDMJhg4kh/WSg8ifEEjROwFNeDMcO
	 Eefhb3NKTtlXEKxrEt7qBzoGCpHa+To7PN//Wg7JAIrxqx5g9O18uUHolChu5zttHO
	 iu4r77/r6bWsw==
Message-ID: <sashiko-outbox-209916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] platform/x86: Include <asm/cpu_device_id.h>
 unconditionally in soc.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111234821.4814-6-pavel.e.popov@intel.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-6-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:27:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed. The include of
> <linux/device-id/x86_cpu.h>, which is generic, moves out of the
> #ifdef as well.
>=20
> The soc_intel_is_*() helpers still need CONFIG_X86 for the INTEL_*
> model defines.
>=20
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111234821.4814=
-1-pavel.e.popov@intel.com?part=3D5

