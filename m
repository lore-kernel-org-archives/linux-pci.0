Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907303;
	b=E+sfsCC139NBshU/sxO++oXCJpPsbUFZXdP+UaNllo+YnPSyRvWXI9FjoABKVmI4mQL8
	 lF5ApiAEejlJzy5S9NTytPuDPazqrupi/HKqhKL0BiBK1pYAO9GvE3Li/GD+01MXTV6zv
	 w/j7zNyE5L59Zy30Aqrzx+16h51FYBGKkJhwFXWYePHJuNCbSDmq75zpRWc2QSe8nxOo4
	 iBq0Rd970bMJdgO5bZfsyKjuNpELhOFjvqu6s5hfwKmpX+E+NyW1aOg5ZYOnt/mIgWHnk
	 h6ZL1ZmkHks+BIIrbb8YeraTW+S3O/kHzBA0HjTIa2bLlbd7sKfEtEczmjixf7cHmPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907303;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r2u3FuTaMSganup+OansOJGDXA0Y0adq+ALvKMF49uw=;
	b=26L9Z/x7pya1yogTTFxia05XUjdOcIIPdpfxT4ocuQm2Q/ibzLMvPV7E5SgVWt0659cH
	 U9i7pS3zALEd/kAN86jR1RuZw5UVtceeM+YNt5LgmoqR7ejMT3+nfx0itGmhdLnhu1ukI
	 lyePoFk250oJbIvLkanpicTtD1oJk/a/wolMJaaMoPgs0IkXGUJyKsxOqpmTwaBbMUGBG
	 iaI+faeN+WSmdKGRd0Pg238HKejfNuTnm2SLzwR6d4JLBl3badrUatWDLtcXtzjVSz7BY
	 rDBhGQ2rdPQ/ywcgtkxWiKMuhL45OgVPzU82SFTKI6Hb+5n3mWvOUr0H5xWCpKyjuQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ncuef/j5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063C606D51D
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ncuef/j5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784321F0089E;
	Thu,  5 Nov 2026 19:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907302;
	bh=r2u3FuTaMSganup+OansOJGDXA0Y0adq+ALvKMF49uw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ncuef/j5Vv2u58TThJGDqmYEsWmUSMV56W7jvFmf8qqf5mcBiV1OR3djDzxpUQqWE
	 x3qhQsMqplGuSaFifD69ZsFDuUxfu8+l8qz9gs7BH/5jINNIvGynwXNbseaxERfmXK
	 Mr1s+5ZwGE7vRNN0/7lzVwojNKidBr+dV9wo62Bnx7o0TKXiL5MZW6pzf34S8RVUkX
	 mvLbbVQmH8kZgHhjbU/A2aqnTnuEi8izC59NIa7q6IxMn5GQxkOX7++qZEc5jY6/+X
	 ZtE7nL2Njc3loNDBL2gtUrzEDMjAaxYQSMCDVSxk8E3CFkVrCJT+pDl2V07hBrNTMp
	 9nG/HAXmlItEA==
Message-ID: <sashiko-outbox-199930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 16/19] PCI/CXL: Expose CXL Reset as a PCI reset
 method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-17-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-17-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Register cxl_reset with the PCI reset-method interface and place it before
> FLR, which does not reset CXL.cache or CXL.mem protocol state.
>=20
> Return -ENOTTY when device capabilities, function scope, cached HDM state,
> or required cache synchronization do not permit a safe reset.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D16

