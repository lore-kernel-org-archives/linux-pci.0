Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884C32C92A;
	Tue,  8 Sep 2026 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877056; cv=none; b=n03LCQ/CBiP+0YUHJuzKiFOtStqTZmic51VkW2kyUN3VXclYMxB37L9+kL50GBED9l28LHXVVFE+MeATx4rRY+N1Vq7aV5iajKkm47CIMH7sQsxmS9yCLT0sZqdfo9BuLcBb4YYN/R8oI57wo7DjIdV/sYoJ3z0dlKst1iijjdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877056; c=relaxed/simple;
	bh=SiB0/otJcbr22idHruLGyow7r9++5RkIb4QheHUDPDI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bfgYnTT05cl4jtgNhmP7EC8zmfVuV2JMfXlVVhhrs2qTmsmvOTLkj25MpRZtXUskHq/5jjIqb3QPw0uPXbYn1BzHvAyrzzdGtZX6C05F/+f+Ip1fTn5ULVJAHv68Oa1vwkBbN1E4xgwpeGw0B056GyS5BJyG5HTK4Ua36zo7RQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvCKtl+9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvCKtl+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551981F00A3A;
	Tue,  8 Sep 2026 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788877046;
	bh=SiB0/otJcbr22idHruLGyow7r9++5RkIb4QheHUDPDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvCKtl+9urgoZOvn08VyCnlmGyz+LYqz4xB4r5AibITQARkfk1HW5/StGboDmb3y3
	 guTalBovH399DWwmwoWpjMQhYuSBGE6d5ZXNYCVrejBr/RqkElaBzfV6uGAle2q1vZ
	 yBDMiysddfk1mLoJY+Z/jCISkhbGIofi3HYiJqQkU0KwXG7/DtEF68iYsD4QNh6xU6
	 5FQCq7V2YLXQ1lvDOgAvlebRbYZYgWZUTveQB8y/XsmCQ4gwWn6uVlevqn//mqAIRM
	 I51cFlhTEOoQlVud0zfx0Xgsfni+LWPfqfKtv+92Ey1nC7eVUb6kAaB0nnj6ExU+Iy
	 kHsl535IGnsjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/8] perf hisi-ptt: Add field-level parsing for
 header DW0/DW1/DW2/DW3
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260908140509.2485649-7-liusizhe5@huawei.com>
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
 <20260908140509.2485649-7-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:17:25 +0000
Message-Id: <20260908141726.551981F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add field-level parsing of Header DW0, DW1, DW2 and DW3 of the TLP,
> separating the layout for different requests. The message type parsed in
> the previous patch is used to select the corresponding field layout.
>=20
> HiSilicon PCIe trace device hardware is responsible for packet collection,
> parsing, extraction and fills the corresponding fields with the required
> positions. The packet decoder software will perform the parsing and
> printing of fields filled by hardware.
>=20
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908140509.2485=
649-1-liusizhe5@huawei.com?part=3D6

