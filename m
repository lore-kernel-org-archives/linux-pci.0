Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C344772B1
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718337; cv=none; b=RWI7C7p9O1Ff3uxGEC1g9XOC5kSa4WTsRT4WuD0xawYgpC0HT0m4kfb/I6/oTojUp+mlitSugJPO1OZlY0SlIpNvUGdTqlAEsx1nqKqtsX0i9cN5ig+MSSs9ASzd0FSQzaNPOjcRuQ82PqwpvWxpugGgEM+0MbM0Ud20iA8Xqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718337; c=relaxed/simple;
	bh=47K+v3BaWhCN/ZlhK8r0rpxIBvN7CB+gAuQK/YkOujQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k5U0kwcIcNi5gR+0Tw9XHPZrADouB6L7uRqOhW7tI68CSBnkTRGpVZ36NBi/QHEKdUqeq0VB8aiMVAkY8wHoNIeo3wQp/4hQlY70wPX/k+QaiV7oRPXoJ5bMoaU/jKYDUfb6A53nUvG4y4J65omUTuPWkT9ZJHqn1D+/Nj04bqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EerpQ5PB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EerpQ5PB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159F51F00A3A;
	Fri, 14 Aug 2026 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786718326;
	bh=45MVhuihqHJglb6+1nSsDGPg6wt/esgZx5aPqjh6Jd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EerpQ5PB4Q9N/KggENfDQ+7CvsWmqHGoPlPhnFdkDCApgbOCd4+D4wZ5VYzQD4Tjg
	 rdujw004ro+dHTOaN0t3A9VauSO8K25q694DBVMxp5TxnoqDLYnY5k6WhMAQP4ICF4
	 B1pMmsBMzBV0VFBDAxr6AvUSpuga4YUgiHSN4vCyLoCgcpOuss/VmebIbZPVm7YF8i
	 egFBoK4e26GvN4VY2G3DU/N0wBl/ctAF8WEX8jd45+MwDm1AbokesujTdS/T3gZI0L
	 gHYw2S6cAovzjUStPw4PdOUY4nzjXY/ZaPjEjNWlr1yIXcG6BF1ZuSo1o20vPvyrhk
	 WSb32AOlo5DBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] nfs: introduce nfs_release_request_list helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>, linux-pci@vger.kernel.org
In-Reply-To: <20260814143255.861084-4-praan@google.com>
References: <20260814143255.861084-1-praan@google.com>
 <20260814143255.861084-4-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:38:45 +0000
Message-Id: <20260814143846.159F51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce a centralized helper, nfs_release_request_list, to handle
> the bulk release of nfs_page requests from a list.
>=20
> This serves as a preparatory step for two upcoming improvements:
>=20
>    1. Pin-Aware Cleanup: As we migrate to iov_iter_extract_* API,
>       requests will hold pins (GUP) instead of standard references. The
>       helper ensures that the correct unpinning logic gets applied
>       consistently across all requests in a list.
>=20
>    2. Folio Support: In subsequent patches where nfs_page structures
>       will cover multi-page folios, this helper provides a clean
>       infrastructure to unlock these larger units of I/O in bulk during
>       completion, similar to the pattern in bio_release_pages.
>=20
> Additionally, refactor nfs_read_sync_pgio_error() to utilize this new
> helper.
>=20
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814143255.8610=
84-1-praan@google.com?part=3D3

