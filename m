Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611631;
	b=4dT37Vy15bMoBxq5LYYTvj4m1kGhKlqEHcGjOD6pfG01az1B+RBdsokKMnFfTubEoKYh
	 3LLjbO/pleivnsPcbKg1jOc+ONWomoqg5KSH7ThuOn43r+yxdDGQqd74xKNRpElG0hcTC
	 V5sMxbMuiszAARt2169LgLCPve1zjfjyS6sAP61XNlfCesXnL1fnnv3OoGBjdTZK3mhkD
	 1wboqhFlRfjb/vNPr9Su83vM1DIWZvXsa8HwTFtYVtdJj9UocKWOO6XICc9cbO6XdQdgS
	 tJLorSo1wmLB0DvooCeutCEsT8AsIqlX027U3EOTRMzm8nGfCQlMf/acnHSYrd8n9Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611631;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gpDx4lma7n17kPQYuQO2Iji2/ozlaW5XneDnwq0Xxq0=;
	b=imhh9Dp95reAxVmxMT7gcaIpueRMosCbM+6SFQHuiV0IOv5VUjBaDxcYZ+W6wpO1Sn6y
	 u8eK4Abfb/sAuwKq76LKuXmQUFS4+MdOl1hgh7DCA/fAJjwceQOC4ukYgoZumBKx79wZS
	 /YUZp4weAQI40YB+393oE/5ePObLHvq3SJlzEQw81KkobwoI3CvGSpbAe4o7q/Z7TCyqM
	 eRc0ZqZT70Xe3sv/lPf/GBgpHWr0QVknQ5IVo98Eq/Wc2olo1le7I471UPQvM0mGLfsq2
	 I0F/Eu8w3tM67utKWo7/SSXSMbBIVfvo5Lubn431R+tLWgt5t5Jfj3HiLKuMPtih5CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GYN/koX/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3A606A326
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYN/koX/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF70C1F000C1;
	Mon,  2 Nov 2026 09:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611631;
	bh=gpDx4lma7n17kPQYuQO2Iji2/ozlaW5XneDnwq0Xxq0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GYN/koX/u31+BbwtyaPKLRfOYpfdlS1o1N7fNBGs9OSdfBBclsnjvHh4xP3Y+jPu3
	 LtYMz8GQc2JPhTS3Xt/v7vepI/0jyY9Px1q7+so0xcydPE9RWLiC1YCH30yUWbeLHu
	 lcc3u8CuC667/NAz3Jq9iRHBpHGRN5rTxA0F+JzqilZl095TDIXz/J0aD4X3yrgwDc
	 6cYraZXhueB55hJ9UBnHKv4PoT5CpZn5kKt+OkrY7413jOt2luYCwz2YwafGZl9rCa
	 w68aeuhxvfWlIjz1tZJee/TLdm8f3bfEjtNsJf3Kj7mkveyjQcX2hfHMzbxJPr3w9O
	 z7VU8JtoYB7MA==
Message-ID: <sashiko-outbox-193173@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: tegra194: Use FIELD_*() for register fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261102092238.3917883-2-mmaddireddy@nvidia.com>
References: <20261102092238.3917883-1-mmaddireddy@nvidia.com>
 <20261102092238.3917883-2-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 09:27:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Several Tegra194 APPL and DesignWare register fields are programmed
> with open-coded shifts, which makes the register programming more
> verbose than necessary.
>=20
> Use FIELD_PREP(), FIELD_MODIFY() and FIELD_GET() at the Tegra call
> sites where values are shifted into fields. The LTSSM state constants
> are converted from pre-shifted register values to unshifted field
> values for FIELD_GET().
>=20
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20260515070753.3852840-2-mmaddireddy@nvid=
ia.com
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102092238.3917=
883-1-mmaddireddy@nvidia.com?part=3D1

