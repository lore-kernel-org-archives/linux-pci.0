Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A511B808;
	Thu,  3 Sep 2026 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422278; cv=none; b=fgNQWteqI4iuwllPmQr3Ry/2toyushzkOSn3LqqNFPH9b72wHDIdpBrJbrkFoQIeDyF+kxHICKtCHmW9WJO+vL3HBh3jQr7mVE9WayVpA39Ga/JjQfPxk5CRe3zlqSQlV2LkTV2ZRx8KvBpmeDDn7WQc2/cASN4Sa03c9H8YVx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422278; c=relaxed/simple;
	bh=V+k9q2Y0OkH8N8Y6Hy5wu5Hv91NHUTaaouwku4e93z8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c3V4TB2dj+X8REkLURTDkP/1/5wlVarMJcyKqsuNh2Js6om4FWL317/QEZZTK3cQFFCdhrmZOyPsxPGpwlsTZPt/mgBUNUdfcOU9V5ug2j279/+JVRpMIEjVy3+uOJGeQttdhEcWBIo/Cilw8/Hwjs887v60sWcO0RToMOBDHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV6FhNKW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV6FhNKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF791F000E9;
	Thu,  3 Sep 2026 07:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422276;
	bh=V+k9q2Y0OkH8N8Y6Hy5wu5Hv91NHUTaaouwku4e93z8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cV6FhNKWuKrB8Iyi6tTUufhqMEXuaJyWpJvX6k4wgfgLDsZrM6fWoYhEYzNh/EqE4
	 MRLugHmsqWFQFC4WQUp0PdWtLq5kniqEEHsbKk1taDX+YoyEh69y6JeaQuJ7KCBzEk
	 x6ga8WR4BJ4alVDfabckiYIOncMqUv3LOxZXXnegek4l6h4QuDCnw/bUYd2isM1hgh
	 T7tUF76WSojVE1kdl4IFKBnux9/mlh/NrR69OnI1aGKyQlEH1lQS9AFzrU4liv0jlO
	 fqD4qPxhSA34dSmBfifjKlB7m8Nap9mHgD5ctjqkB9LIKZ69NrBBHFR1sLE/2DP955
	 rOInI173dMj7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] perf hisi-ptt: Complete the field names for 4DW
 and 8DW packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260903075241.1445338-3-liusizhe5@huawei.com>
References: <20260903075241.1445338-1-liusizhe5@huawei.com>
 <20260903075241.1445338-3-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:57:56 +0000
Message-Id: <20260903075756.7BF791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the missing HISI_PTT_4DW_HEAD0 entry to the 4DW field name table
> and add the HISI_PTT_8DW_CHK_AND_RSV0/HISI_PTT_8DW_RSV1 entries to
> the 8DW field name table so that all DW indices have corresponding
> names.
>=20
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903075241.1445=
338-1-liusizhe5@huawei.com?part=3D2

