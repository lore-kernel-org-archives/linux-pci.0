Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4749AA5A;
	Tue,  8 Sep 2026 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903650; cv=none; b=f+V6GABuUO3j3xw/RC2xaeP+bI9XJu409x+gYX/rKhmBWWj+GH8/cEQoQHhy7lA/oVR7/SS3aEnGYXK9X+ssel/f3MoGqlFapBhihMnbzln/xwJRCQr6DY8ALCdofiTTkuDpHTPE8Y7pKRnWIyL9FtEXNRmfbWDIXdhDPUp0D8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903650; c=relaxed/simple;
	bh=qhZR2fbr8yD1EuU1wQUTTWjOWsRSD/QOEfA8yGlGtaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bex/v6ha/q56tkGfCPuuGCjd7geamVRa7GOwIzp1yjfqiyQEbNCR1qEnMrwH7NdfQm/qluGdLkaR6jqENjHLZXwsDPrvP2Buwv0jiW0k8M4wNz/b8MBBHqqOAwmsE30VEabtFymmYps/ExMP5q2BKOge6xY4v9FfuFkO6ohCzPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRWYFNqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRWYFNqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB251F00A3A;
	Tue,  8 Sep 2026 21:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788903647;
	bh=qhZR2fbr8yD1EuU1wQUTTWjOWsRSD/QOEfA8yGlGtaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oRWYFNqDj6ctSFCfmjit4geUIdgW5Yee9RdwbgPwzKr5qhCTwcbidLxcBGiAxWarg
	 Wfh1KLMj0LlXnBqNgcyzUrO0zYEhB5JfAKQiq2YpnRrsNskIgNrASanAYikvdsYRkT
	 4ItLIJWesUOz6vAwTgwAau9XGzPwiOVDIye/ungwpbFbhl6bjQuCaYTa/zUXSqsvkx
	 T1toaNQwYLqhfkuITNIFf5ChUmrZAijMbWw6moFa7Nkqye3CXbHW6o/fUohNzmKa/e
	 hMUWP48zUONvSTMtuAN9BzqnwkIKOFJP29YisCyxw9SEgaco9DLOQ1Mlwj813MvE/l
	 0f0SAq1PyExyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] PCI: of: avoid allocations in
 of_pci_prop_compatible()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260908213459.2519059-2-elder@riscstar.com>
References: <20260908213459.2519059-1-elder@riscstar.com>
 <20260908213459.2519059-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 21:40:46 +0000
Message-Id: <20260908214047.0CB251F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Three compatible strings are formatted in of_pci_prop_compatible().
> Their sizes are known in advance, and the largest is 16 bytes.
>=20
> Rather than dynamically allocating the space for those strings, just
> set aside a buffer on the stack large enough to hold all three.
>=20
> This avoids a problem that Sashiko pointed out, where an allocation
> failure would cause subsequent crash because strlen() is called
> unconditionally in of_changeset_add_prop_string_array().
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/sashiko-reviews/a647bd56-7dc8-4fec-9d96-834=
622054cdf@riscstar.com
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908213459.2519=
059-1-elder@riscstar.com?part=3D1

