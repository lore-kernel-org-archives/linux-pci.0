Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299884;
	b=Pctk4CyuqMJjeU/va+6ds6jnN59M2zykUfyRJOBGaaslQWuDTvC9eRTbJ1BGVPoi4f/6
	 A6YfWRSv0oVZB9eOjS2WYkgqimZ+L5SkfuUnJWM5tak6oTLNxTOWZd9ZtKEPSl3mTtabR
	 hv+kZvfpouhBmCPcTCGOaraj96O7jrSgtzJ0iWfKqQ746MC2OxIJCKzWZedEaiHeevbo0
	 MeczAdUBLaOBQT1BKydz1H7ROgbqnKN3sHmKvOQlAlZUgh6+fU25vnNRFZ5Tk9uJO6XTS
	 ude3XaEcnWp3jhpSa6OWMAJRikkHcUywSUAaLZ29aZkkKu6dyDi/Uo6339wd2nW1NNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299884;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ldkMrcZFbHQCqY1WwpSCpAfvXf+j3cRXvwQKoWn+Fkk=;
	b=bf0+OcRto9o2pRhea+MboClQqK63F0EEHdb1O5prfv6p/af2XQ/wxphyrVEz9I66McM9
	 8Z/27fnJe8a/MbxEbIsaJ5Rl72aAdlQCWixfjFpJxUyI+NpfDMAdR5zGfj0Tcx+/8sQgd
	 tPmCOpKKmNS+YL4NtmoekAuJOsWNf4+gA89hLaSGcPn6Od6Bg3najJ2dYrzb8VSk+z3kW
	 iFUbCBXEK36OtaCAPHXQuE5FUmSlIu7r0NwK0ZkZr4nthx0i+7e8jsJUV9mcrD9F7Cs+C
	 YpTC8g2RXIjKKalZcQMXkjZrbgc0a5yLAlFNapT9xsrseJxKkZmVIhedj4el1bFc9Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQYiGpFk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039B606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQYiGpFk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB9E1F0089F;
	Tue, 10 Nov 2026 08:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794299883;
	bh=ldkMrcZFbHQCqY1WwpSCpAfvXf+j3cRXvwQKoWn+Fkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SQYiGpFkLi2v8PIwDdPH0HDfmAix+qo3hNYJg+hPA+Bl54rtomLnexwoZXbHk5rwF
	 ll3R15Wbkxnx2LVkHqSKTpj6H6xzdzE8tZD+0esNFfJ770LRjFPl4xDmepEfP0IOvN
	 UGwaARZMu0TXyqPRGD6H+5iyWwkEVdMFSAaUj1mmLLvcqVMtlAwlZkcb8OxYhbPdEe
	 Q47QyaOAdqm4224nV0fGEAVcJAV0+NOjv9jrdhsqpr4bz17qSov/LOiQAO78h7ZtHM
	 jl3/1MVXHuV3nKPAviv1nqUIXqs4RDgRg3AM7BJl3I9kNhjGGcbqtFTBpc7qmj5ZZ1
	 QU3Q/Ls2YQUDw==
Message-ID: <sashiko-outbox-206640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/10] NTB: ntb_hw_epf: Use the shared NTB control
 layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110082459.1798763-9-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:38:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Currently, ntb_hw_epf.c duplicates the endpoint control layout with
> hard-coded register offsets.
>=20
> Use the shared struct and macros in pci-epf-ntb.h and derive offsets
> with offsetof().
>=20
> No functional changes.
>=20
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110082459.1798=
763-1-den@valinux.co.jp?part=3D8

