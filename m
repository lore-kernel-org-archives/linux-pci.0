Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1830D3F8;
	Tue,  8 Sep 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876723; cv=none; b=RulaP0Z9tFx5FEXXmNPn4GPOoyD9V1GwgoXNhCAaiDmam6F9hKDn56cax3yFgV3Qv54YFc+EOqTyzGov6ZBD+elMnwqKfBngrsV06Cx9UMSywz4PpWmibE3mmN16pnBpuFVVktH+SbQ0MTdnVe8LKjXnA15IcwB0RfNKlo7VNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876723; c=relaxed/simple;
	bh=zxebgplSknB3OOptK+rMScPfctX3sR0/b2b6TMU7MvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i2uukUQ88O5vSlyLv88RTA3imgAEopyfDLH/OoX11/M6vpfB2MWwvPL+5NO7vcCZZdxeUqVe6E63wk6rxTeJQFxRR4c0psNw81Pvg+AhR3bNmTMzMchu0o4XUww05r7V6vAgKgP5qCK1oUetdZt6ZaxFRCdKMQneGApf6m1smZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al+lpTyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al+lpTyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BD11F00A3A;
	Tue,  8 Sep 2026 14:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876708;
	bh=zxebgplSknB3OOptK+rMScPfctX3sR0/b2b6TMU7MvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Al+lpTyRI4Z6DKvapaE5B1mDUkSdN5Z9IHAZIDpRkkSG1WId6xQH4gXrp/ICuND1A
	 Z7Mc7I/xuMf2o/q3y1oBAOGw0MbHdDV3VHUITPrDwhNtR2EJSudpQVhiptf6QBrfhH
	 M1wEmYFyLy9VAwQzoP81klapDe0FBXleomMlTXHz42G9W9VpBrpQAOihuz90rhr1Ds
	 msF44XGWoqmWX+QqJJQkw/kq8VMSbL7SLUp0gx24ia0InSZMjbmvHeFWJmGj8m0e+1
	 XOT/TjhLbJBvcgM4AdC1Sxy0dKkkSGbTbAzTJwjYSsAiBj9UZeUwcYs+Aky8LcIRZ1
	 TK85pHmHMfkLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/8] perf hisi-ptt: Merge 4DW and 8DW HEAD0 printing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260908140509.2485649-5-liusizhe5@huawei.com>
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
 <20260908140509.2485649-5-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:11:47 +0000
Message-Id: <20260908141147.D8BD11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Merge the printing of HEAD0 for both 4DW and 8DW TLP headers into
> hisi_ptt_print_head0(). This unifies the entry point and makes it
> easier to add HEAD1/HEAD2/HEAD3 field parsing in subsequent patches.
>=20
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908140509.2485=
649-1-liusizhe5@huawei.com?part=3D4

