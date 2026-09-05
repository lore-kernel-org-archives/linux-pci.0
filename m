Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F74483A9;
	Sat,  5 Sep 2026 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612407; cv=none; b=d3wMpV5Bz+Ww3i9lHX1gZg6ipdssmLfScHZDHCMI9//t6JQEfjYOuI0YdRFf2Hkvh3Yc9IYzU7ESUkxD6vs4MZwufAdMgoz6d0rybQHWY/KrItv+TsOTWSl2YYsWnyEiEId1a7BMmo4f1OgAS57fvGs/QD6hplaj05kdXPYRSfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612407; c=relaxed/simple;
	bh=dHvnM7Dg+IFwH6jSFhhYk2qXz7Ec1gvwQ/nxbAcOI7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BCJr8n+V1KCXgFdLg8s7VaBgMMkOTeB/aOB1MFK9psiBo4H6uZn66RjGRo1EixKuYiCHW0nx6BPYAYY0FkfnfAuZAZ8Uoghhsmf378AWWzzCmPOuWstn7hOlQWn03AUTHuuCoWSlYR48sQGTvzugs2mlRA6ujpLhMNiWZlHIBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps9Ah4Lv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps9Ah4Lv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F141F00A3D;
	Sat,  5 Sep 2026 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788612406;
	bh=dHvnM7Dg+IFwH6jSFhhYk2qXz7Ec1gvwQ/nxbAcOI7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ps9Ah4LvLHqefiOe+3elcP490n4Vf/zCUIVHuDw8JdbR63T7v1xFmBeU+k0XxP+0S
	 qiyAyVrSCscpaj2bcUwmaJBMkFSlbTUoS16/vWzsFq8Cgfc5l9uEnJ5LDmWps2CGNB
	 Ktbp0rG8mPXijLapYlvdGlUvK9+WLK0Sw6xU4mAHEb6aH12PU8CWDi9iBjun6mrL2g
	 8KKflkbdIbNLt1I++rUnVtxgZxEnzJ3s8VhW9QoDMK5f+dgXWaiDS6GrQ5R9Z1HasW
	 y8pK3bMRmgbrSv6fmxutdgW1M7DwuqndzkF2mUzHWsynOeOPGoM78e7N3kTX117k++
	 sCEC9o9EoIdlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] interconnect: mediatek: fix Makefile typo for
 mt8196
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: media-ci@linuxtv.org, linux-pci@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org
In-Reply-To: <20260905124434.6163-1-breno3011alves@gmail.com>
References: <20260905124434.6163-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 12:46:45 +0000
Message-Id: <20260905124645.E7F141F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Correct a copy-paste typo in the MediaTek interconnect Makefile that
> mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.
>=20
> Assisted-by: OpenCode AI
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905124434.6163=
-1-breno3011alves@gmail.com?part=3D1

