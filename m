Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FA2FFF90
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143869; cv=none; b=l8qGa+h2P82eGXmCcNwiiIpDKS1vhOWO2LTOS6yttmamnQrcjUMZ7O8MjRD4+umqrxnT/qZc6s2AqPATWXy8p3MVj5GDalLdjHQ5ZFqUkOJe4Bmjo/dnxp9xJyXeNw+4MX6w+qDFWPsQFdfZxP8HmTM5gYYDyjjWsY0n05PI1CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143869; c=relaxed/simple;
	bh=V07Dmu0XIAcZKJHLIht0M9ebzp+sZC5dIj+pYoduQ4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kChVykfi4J3ReNaKJx5w732IARWsUkndSmfmUzFZNCITTR8O4tMifKu5A9R1e5BUVFbPhsDJu3MJUStC9gW8h7vK/lY06csVN/x64+S5mO3D30kzxk5ByKNqKOoZDEz4+1GCA8WYwgTApkDya29OGkqg+GIkaCD/yznBcdMtlwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMntb7Lq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMntb7Lq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1036B1F000E9;
	Wed, 19 Aug 2026 12:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787143868;
	bh=oXQSei8azSfDCIwnq3MAeReVjjYRmVbLCDbedjSDaSE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JMntb7Lq0JPqtyIPOFx/oNNkxWkHyavE2eMFeOwn+uEfL572ATeSzXazHOn110kdf
	 np9NJw9fqWuYfqyRrVAPaC+znIXhfL/YHBVLY1wMvQWx0gpEYA5Hr4zq7wha97wgWs
	 cE05LRaS038HL7Qnq/zWFSZUZQOMlmGzdBgU732GFp1yjv1GSAqURtS+csigbKbmUI
	 IvvpPUYGdn73haZxjvAsT1gv0pFQQ4iuZiGW94orCSw9H2ykMskkd3fY9eY1B0v3ji
	 YgcMUkhXqfTmTD9YNWuUD65ernYFYX/04dKyevFfr535x4nDXmDqF9V1vq611DUUKK
	 Bd1pAqO7K0DNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/7] PCI/MSI: re-enable conditional parent
 mask/unmask with sw moderation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luigi Rizzo" <lrizzo@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260819124341.4185621-8-lrizzo@google.com>
References: <20260819124341.4185621-1-lrizzo@google.com>
 <20260819124341.4185621-8-lrizzo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 12:51:07 +0000
Message-Id: <20260819125108.1036B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Recent commits removed masking of interrupts at the PCIe level when
> the masking is also done at the parent (e.g. on ARM with GIC).  This
> optimization saves the PCIe write, and especially the expensive readback,
> but causes the device to still send MSI interrupts that are ignored.
>=20
> As a result, it very harmful on platforms (many, for multiple
> architectures) that are unable to deal with too many MSI interrupts, and
> defeats GSIM (CONFIG_IRQ_SW_MODERATION), which is esplicitely designed to
> address this problem, but depends on masking interrupts at the PCIe level.
>=20
> Revert to the old behavior when GSIM (CONFIG_IRQ_SW_MODERATION)
> is compiled in.
>=20
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819124341.4185=
621-1-lrizzo@google.com?part=3D7

