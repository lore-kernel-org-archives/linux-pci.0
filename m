Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091035;
	b=pOxmMH0mS6FAON1eu0mmcBiE3TogNMoOtmK6ZEs20cWJ+FzNrjPNLPb3wyU6/cTgGHf9
	 XoH/uj7mH7zQ7Fphriody02lNym/chOfMyMPN3IMzhpxjcSaY7fNjL370rvDVQ5xwuUyP
	 I02tATjMFUhhODwbgWcVrbk/xYamr9w6aOhZsSVt7xd5DFqiaKzzeb4MdLmNyzVFap9Cq
	 alNzqzDOhWT1QM57KQjC0Wne0pxiYbKq67E2UMAUY0hUhSjoEf26kjtC1tXKLlaa4WHip
	 5OI8yETq1ixCqU434AnPw1G7Z/n0VREotLZQCJlB+UutcgU4DxEzmPP9lrJIlvcB5bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=foFJ8LRhQ8EpHqWoQMHXD/oPaZiitqhRgcqM7WXi10I=;
	b=Mre3wgawKAFCrwn4W9bb3XVjgqyUDYM5a1cg2MHv2JKFRPui+FMMIAH9ePbCkra0+5XJ
	 yevSfOF3mS+GKJLQEoDY1LfLNZxFTopiqww4EJEjDmNY2QAfZAhfeioGYSsnqPEw+q23l
	 1yl3E4XjeDvfq6r+l/RHkS6Nkjh6o6+6xMwafqbTjgxGcy4XwxsWwA4kQisar8HgCZrzA
	 lQiwd0Qzmni88i4jgwecF471r0+K5TiJDsUbEZyb+BkmcwL4ssYRSebAIxTLe3yHENJGf
	 dDN4IaE1VkxprMGarnppKnxETXFN1H/ytTZ/aUYvyhN+Ko67jHW87D9leUAvgMpOZQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccqcrMEs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E44606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccqcrMEs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1721F000C4;
	Thu, 19 Nov 2026 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795091035;
	bh=foFJ8LRhQ8EpHqWoQMHXD/oPaZiitqhRgcqM7WXi10I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ccqcrMEsXaXZ+jg7sgBa1VlzTXa0E8TIuvVgowTgxwvvlgMHC5U/zlvPR1Gda9+hC
	 QwHU5YSfApeivnZ589QbhQlosH4G/VWLa2Wtmt9eQhjKG4sbei+BK0n4KIiTcSwtQO
	 RIWhE2qWndvSGqCU3cBfnR+z2l7Jgh7MDjHYe4VKBfFVt9ERV9x28d80QHlCQAIK0+
	 TnRCrp+s6q3ZXeksCNWz9C5Q+iWm12tOs3BXwpNj8hqwI+zkrH3Pjny2Zy9uLXfrIM
	 Iz3btVAlxPCBeKqg4gEoA5BicwbMG4+8Sb3GlVgUGTL/a7NFGQ6JmtoyeDdpx1ZogO
	 2yEyIde23USng==
Message-ID: <sashiko-outbox-223082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Correct PCIe port type field encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gokulkrishna Sekar" <gokulkrishnasr@gmail.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261119121947.204565-1-Gokulkrishna.Sekar@harman.com>
References: <20261119121947.204565-1-Gokulkrishna.Sekar@harman.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:23:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> set_pcie_port_type() validates PCIe port topology and corrects
> invalid upstream/downstream port type information in the cached
> pcie_flags_reg value.
>=20
> When performing these corrections, the code updates
> PCI_EXP_FLAGS_TYPE using PCI_EXP_TYPE_UPSTREAM or
> PCI_EXP_TYPE_DOWNSTREAM directly. The PCI_EXP_TYPE_* values are
> decoded port type numbers, not values encoded for the
> PCI_EXP_FLAGS_TYPE bitfield, so the corrected type is stored in the
> wrong bit position.
>=20
> As a result, a device whose type has been corrected may subsequently
> be reported as PCI_EXP_TYPE_ENDPOINT instead of the intended
> upstream or downstream port type.
>=20
> Use FIELD_MODIFY() to update PCI_EXP_FLAGS_TYPE so the corrected
> port type is encoded consistently with the format used in the PCI
> Express Capabilities Register.
>=20
> Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
> Link: https://lkml.org/lkml/2024/12/13/198
> Reported-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119121947.2045=
65-1-Gokulkrishna.Sekar@harman.com?part=3D1

