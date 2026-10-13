Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B051356C
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897979; cv=none; b=V2XOgiutnIKj3u7gbDMf/8m8BwW8apKhw36+RwhXVcPv9MMNP4H2lClEsBYs4l8y4E4FkiyKLmOZt1C5AN2CL4GpKGMws88idwXAf9rfyDBKaPIIw+Px6Apf3n+VZMC//yBWNhMNsGTa0+KG1dd/Pr6TpOu4fE8yHySL7MZfJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897979; c=relaxed/simple;
	bh=qIs0luSujBRZbSyQfEL/k1QJCQqLjlNzOQQ3vn6AWFc=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=lX0AxggqhRCG9zfLRe8rB0wRtbem5iw3ecz7rgYIZHrjL0EgD6N1/fdObBe4ZMgq1GaF7ocXMbzZBYjM9UhUdmcMhRwroAYEFE8bCQC/j0RlHwoPiphVvgXx8QFTvhjyXzN64OkemOx7Zgqrre//6iqmebb0nX5fDTYIOk/B0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWWSAGI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWWSAGI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CD81F00893;
	Tue, 13 Oct 2026 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897978;
	bh=bc8X2CcAw1B6xhoCPTnYIZE360HR6D5IK1G73uEIYTo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GWWSAGI6Db72aQ4UxQlepnp7AgqNRAYdlxuZ2vTouznesOgpfFb+Yz9KDJqZFLtXR
	 OdmQ8f7YjrTDLGD5tL/H5GX00PENBEo6lq42dOGhvrXnPd9yqgd8QX9lbwEuj942e4
	 aF5fdKzfPZn3QB1pnTOMDKbi5wmGylnCyyYpgzwWMMNLA9nczphPXgBNM9cmhIimCu
	 iqYbWOU4HBz/JVSPPMdQ+cxDjoiYOtqTqYKjiUsCfqFzfYWzbBPYuXoWt3iG8SJe3C
	 fBXEVDaSjPS/U8J1V9vh1bsvkuf1xu5TrvILnM5ECqeE2Co+7a0/nM97d36kBkruhL
	 h4PoPOg0niyYA==
Message-ID: <sashiko-outbox-169807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] PCI: Fix composite resource sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261013130948.6231-8-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
 <20261013130948.6231-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:26:18 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The bridge window sizing algorithm aims to pack child resources back to
> back. With multiple composite child resources whose sizes do not align
> to the calculated minimal alignment for the bridge window, back-to-back
> placement may not be possible. The non-aligning remainder placement is
> limited because it must be adjacent to the rest of the composite
> resource.
>=20
> Effectively, two remainder parts may be placed into the same align
> sized block, but sum of their size might not match align. In such case,
> a gap is required to meet the alignment requirement of both resources.
>=20
> Add bridge window gap size calculator. Basic rules:
>=20
> 1) Gaps are only necessary if there is more than one non-aligning
>    composite resource within a single bridge window.
> [ ... ]
> Reported-by: Nikolas Joshua Britton <nbritton@exabit.io>
> Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>
> Link: https://lore.kernel.org/linux-pci/20260903063124.9316-1-nbritton@ex=
abit.io/
> Reported-by: Maciej Grochowski <Maciej.Grochowski@sony.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013130948.6231=
-1-ilpo.jarvinen@linux.intel.com?part=3D7

