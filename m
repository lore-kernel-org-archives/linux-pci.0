Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC924756D4
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718424; cv=none; b=HclL8CBvAsCYP7EDMMuHVyKBz8IKlEhOKNhXtPSNDKbZ+ZBnqMlLLQwNEtMAQnmgxN2ja/wzXsCgrghosWevZLL5GElunKxO0BoukzcmOC8hWR4HUQZOqVzh2yY2Ls5IJbHs7dK/AMDERdCWXG2G0Ava9BIMG4vh9IC5YI6CUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718424; c=relaxed/simple;
	bh=q8f2Ugkq6UCF+Cll8MbeHKxdk2beKo+iNkJ9sjlWJ08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nfgijyuvXBL2z3gT4Dzu/Z7NimFx2wsYV1ApyomtZbyJOhnCBaT80mAguURyGzI8yAvLBJbdblajoeSajg8b8FzC6fZND6vLEjf+7s4GkCsq13uobtW3clmCdB0KVMG52GgkQyxiC6+XtM3VcC2gxVgHklrp46fMdQvNpxhDsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCNO+Ere; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCNO+Ere"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EB41F000E9;
	Fri, 14 Aug 2026 14:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786718417;
	bh=q8f2Ugkq6UCF+Cll8MbeHKxdk2beKo+iNkJ9sjlWJ08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WCNO+EregyKz3xN78pWBV1cqVUUBBhNt2Q3MmGKdmsHqx2DHKo0yMKa3z+LKnnp6z
	 t73ay0rWzyMlvGtC+6OMDSw+8e2getaosF7WQeQtxtlcHRTpGblqH2AVAvXEO7UC04
	 ZgRKw9A9hKUyVtuOnYrHuXxjkHYeZC6e2M+88Ezcv0gtCbo4duLOi7F/ykbthrCT2E
	 ot6L0V6WATeTfsOy32auNVaE/9RFMt0VjLXjL/kUjdvZNLvyStwdQuIiKBSIfda/Lj
	 Mj82c6MtcHax3A77BWfplQGlYwHk+m0Ts+x2SZTEJP97QIR1HEUXQgKK3+wZmSPt4p
	 BaBwWEzHPmicg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] nfs: introduce nfs_direct_extract_pages helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20260814143255.861084-6-praan@google.com>
References: <20260814143255.861084-1-praan@google.com>
 <20260814143255.861084-6-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:40:17 +0000
Message-Id: <20260814144017.89EB41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce nfs_direct_extract_pages() in direct.c to centralize page
> extraction and request creation for the Direct I/O path. The helper
> manages extraction from the iters and builds a list of nfs_page requests
>=20
> Refactor nfs_direct_read_schedule_iovec() and
> nfs_direct_write_schedule_iovec() to utilize the new helper, unifying
> the extraction logic on both paths.
>=20
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814143255.8610=
84-1-praan@google.com?part=3D5

