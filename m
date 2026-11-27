Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780929;
	b=aXFPpd2Ko4aF8kxOzd1K/aAsOzFzp74R9ey5xmeF+z/Rk/CkeQ7aAdBPGh1ZnPu+IVFw
	 fe+n3DtPLMXauzcOucQC4tqaacjjKPRWzT0evYuRJxfHa4bHQxE/sQYXpHAkQxLYVFGZa
	 QPt8Iegm/I4L48nBR56fjLyLB8wyLru3d9OGRMWDIkqkL6RjbQfVDSm8MmpJnePtrxEU1
	 k8Msm0Ewlx3q3NC64iXKr0yr3s2nf7Oyxd/fXNt/mPntL+xGO589winKYXTGjCB/AUvXS
	 7nu+JM0nAAMIPugFD4Slkcay4g+VJTXMJfSOQTJcFjI+7Q37o6k74RygipUp9dLpetw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780929;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mfciCZ2p6eV+0uJxQz1WoLBNX8b+WC5/jSoUTKNbnfY=;
	b=tLAfI3GPMUfMhGEH8JInIvK4JehzZPysXupXYAJtV5zUM5GPdBDn4OHZaRIjKvEiw9Rk
	 kFmtLtzZaZLQkFDsNcUzFQWE/ZGgYjT2Y7PZNXL1QsdFG5tD/9Dic0pnQjHHIifu4iw4N
	 n6ZqCG98KzjGDf88eBP2UxCvYwYAfv52HEbAKhsqRGg7bctlMEeLMF1S73jzqdgFpExh0
	 YAI8b8MQIzlpo5PrfwDwrr3j9JzCd0c8IxCM3RMLu87OzZl+eLNiNzLB2SmegDzpz/M35
	 3pXxTKnQx4smGBh5df8FpM+gtik7RDAkvgV9xHddfEY9Kez1Roddc+qgO1nPCqIrBPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kreWVapZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B64A606A333
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kreWVapZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686221F02814;
	Fri, 27 Nov 2026 12:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795780928;
	bh=mfciCZ2p6eV+0uJxQz1WoLBNX8b+WC5/jSoUTKNbnfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kreWVapZmTVVUUt1LQ0G0W3Ix/KAZBm7ti0dXB4h+83VsLa55fMT2oiwXWqLGzx3w
	 FyyLX0AXmrAh20pJP2i6t3uTwgyx5NVvEOQ2N7PmhXr27W5GJktr9BsTZAtHKMbRz6
	 pwhj15IuYM8vepa3nZ0DAUWstmBG7ph2MhSthf+RtuNqd/HNNTPT0i2SJ+7ckVwGb6
	 Mo+RMhuE2wBArmXggQUpFS8j4k2zZvng1i/WRhH3NnkIcE8ZZ5PF2DdicL13I+SihP
	 E253Hgx8bccdrIJm/A4AOXGevdD7UUEKNUCc2/y4OSH6uhAK2aFry7W7oOg5P1+k0t
	 QV/bD49l+F/iQ==
Message-ID: <sashiko-outbox-237313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 0/2] PCI: of: Skip config reads for disabled
 bridges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261127-pci-of-disabled-bridges-v1-0-3bedcbe51cda@radxa.com>
References: <20261127-pci-of-disabled-bridges-v1-0-3bedcbe51cda@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 12:02:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-pci-of-dis=
abled-bridges-v1-0-3bedcbe51cda@radxa.com
