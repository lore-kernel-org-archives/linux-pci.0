Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB34B66E2
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491445; cv=none; b=JzXveMl9zko3NZSowBZWrA9tpJGY7XFvk9ydbLTuG6pD+nUbnpPYYRJokuT80+vviap0LGMQ7q1ns6KNTpYHbLNXi50bXZ8CDqT7zvceD0E/2xKVWyBwXsRJTGGH3YNJWBK0fekGbjTNorInjm0CkNE4K3MQf6VDQUclpCn3ilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491445; c=relaxed/simple;
	bh=076wABR1HsdUZ/g7nYtFQIHNbV2UnmWrg/00kmjr2wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mqu/ytZlNWgr/xgzHjQb7NR34gelgcdr7UndHt/U5KzqbptYXhrfxOlxD9qysG/YpfBjcjoxvFBa1rvBAThzUMBbKpTbQVKgtIGgSZ38/MTgiKd24+jvJv0S1tCPkOjXO68m22aPAV8chAZu1uRjelEzXZ1gZWv46M204t48y4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chlK98RS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chlK98RS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0331F000FF;
	Tue, 15 Sep 2026 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491437;
	bh=076wABR1HsdUZ/g7nYtFQIHNbV2UnmWrg/00kmjr2wg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=chlK98RS4jFsSV1NsoWp/+UObUm6wESxGLmcewEG/briwDVaw9bSibMxR1h0KfaK9
	 zqTtKsrkuMzY5PiptYogONkyVlIMTcHK1g0aQfwYR77MfHhhwfTWzvHbVF8xmkD57s
	 HyYfkkX/WOOtLIATsD/GfI4JNVZgl/yLmZsFkIp8bH93wLpb1qnx/xQUbhL+8Lte84
	 V7OOL0DCq3+WYdc2Fz4QX9JL3lxHJRFQJ8g2PtZNaMHK6yMidAD+T7kG7jxOaj/tzo
	 NXdToklQ+OBbpaq2GNQwx/N8jKS8PQqzjPeK+GAD/ZvbhZfF7ZeELoTQhS52woZdy5
	 LnKqD3OpQU4mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/15] iommu/arm-smmu-v3: Discard partial PRI faults
 on PRIQ overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <be109e135724e8a436588489677a28c664407eff.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <be109e135724e8a436588489677a28c664407eff.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:57:17 +0000
Message-Id: <20260915165717.9A0331F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On PRIQ overflow, partial requests stored via report_partial_fault() whose
> LAST-page entry was lost stay in iopf_param->partial. Drop them by calling
> iopf_queue_discard_partial(), matching intel-iommu's handling.
>=20
> Do it only after the queue is fully drained, since the visible entries all
> precede the loss point: a group whose LAST-page entry is still in the que=
ue
> gets assembled before the discard, rather than losing its stored partials
> to it.
>=20
> Nothing can arrive in between, as an active overflow inhibits new entries
> from being written to the PRI queue until a final CONS write acknowledges
> it (IHI0070 8.1).
>=20
> Suggested-by: Harsha Vardhan V <harsha.v@oss.qualcomm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D11

