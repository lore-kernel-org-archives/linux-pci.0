Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBF15505D0
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090033; cv=none; b=qBTUXm5NmolFlLyBZR9irDKJZeg5q86XdMqeJkxKp0I6//au8hkm37wQiufSy86gj6/d3R3FZc/xXrhGV7gLcMysITJWWPu6TbtScw0GLBGU1380R6suavrZ9uoufAsZrhHYS7GNxj1ixDLPjGc4wl0b7dnUtNkeqCL7t/jotII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090033; c=relaxed/simple;
	bh=nW44D2zTYoe16qQdM/VBs/18QcQHgOuCWbfSrN899bc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ObOug64stPO8WiuB33HY+7uOoPuCGZwoVa+0Q+kjJfR5WhObRbrBM6rCzo+J4MNFRAa5Xh9azfWdIwuJoMbVjVnG9AIfNOEv//VTvFOvozpM3XwUjoYUYxOjxJeI5HV6hgV4JahWi13u30bHu4V1iuxljBIFO/RPi6oB454r7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2UXZnju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2UXZnju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047C01F00899;
	Tue, 22 Sep 2026 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090032;
	bh=Ksxvb2fs/+Arxj/qzEdIelKD0QKHpDUdqFCA3jYyUh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2UXZnjuVBCpQpMrAzMBrkFqTv82AS21MOYtfsaVSOJfhwf7M2VR9bNXdOOlb5b45
	 9qzXIAPIK902dwpoi702DOqhDHu4mxVS/Sxyzf4bBvAm7JowJ9bwM+g7+eh2bny+rB
	 fwXMAwb50zqRdpY+Oq6XFNdDkj83ODhwTXjdEuBt9+PnBIyp1vKs+m5cjqWErbzZ5b
	 +1JRCFnMljT/pOpLd20dfEfX2mBGo9Pjbv0wdj7tbQFOLHX+8nXFL28Vlf/uwe9TWE
	 xQe3DIQq42ZYn8HtldQReFB56VbWansngrrU9lmHOfk2Bv+pOnxPoWuqAmfjiI2JKe
	 jZpGjunK+OZqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/6] PCI: Refactor disable_acs_redir and config_acs
 param handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB43935F96407D9E8C8ED028A8DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB43935F96407D9E8C8ED028A8DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:13:51 +0000
Message-Id: <20260922151352.047C01F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The current implementation mixes disable_acs_redir and config_acs param
> processing inside __pci_config_acs(), using acs_mask=3D=3D0 as an implicit
> signal to switch into config_acs_param mode. The intertwined logic is
> hard to follow and easy to break:
>=20
>   - The acs_mask=3D=3D0 special case is non-obvious and obscures which co=
de
>     paths apply to which parameter.
>   - The interleaved logic is fragile; changes intended for one parameter
>     can unintentionally affect the other. For example,
>     pci_dev_specific_disable_acs_redir() is invoked on the common path
>     even though it should apply only to disable_acs_redir.
>=20
> Split the two behaviors into dedicated functions,
> pci_param_disable_acs_redir() and pci_param_config_acs(), making the
> control flow explicit and easier to maintain.
> [ ... ]
>=20
> This refactor separates concerns, improves robustness, and makes future
> extensions to ACS parameter handling safer and easier to review.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB43935D2C01=
946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D4

