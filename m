Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399C737F010
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336064; cv=none; b=bp8rzAFuqtUSHZBA7+EcjqZIc0ctdrpDxb7zov4VSleY7arnO7kemnGDLNg9+OwDhWENDs7vZ2rb9j9A1LfVPLJHmshwiZp2AtvqiDDH3vLX0vwwSiw/1z4LFoKn/MKrU5rAkD+G6rHSfGrpbbg78qvCZ3eEiv3PVqlU++pOw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336064; c=relaxed/simple;
	bh=A8hRXR12vyGhxawV1mVKIG4IUYxQwyFVFfSVpGPrt1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kBZQPvF9Q02eR0RGy6I7E79ovvmhH1hP+HWFtvf6E778S+pIfobbjI10gKRuGmXWlShMoPX/bH268pxsItYa6qd/+gDq/UsGqgf7Yf6c5HhOZZl+A0uU/Ll8HooqqJ1lSbRCdl5P1mOamLJ8FNFre5XS//arIdQBOwj7JMl3VqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCaYHTRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCaYHTRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C320D1F000FF;
	Fri, 25 Sep 2026 11:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336062;
	bh=A8hRXR12vyGhxawV1mVKIG4IUYxQwyFVFfSVpGPrt1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCaYHTRiwPL5JrFzX7tYfAFHbzGfcHaZB+MNYlff+m+eBt+xlOCMEqJygTgr2GIE9
	 UHJzO/JTau+St3GdExohrlPo03J7iLdrWBIn4Fcv80v++jI/L7kT357gBw3cll5z91
	 TgIS0cbcmFCai9jJADdCEyg7qSoxuDoAKY1smU+zBg7OFV35T2PgQxDosa2JIGl3Lv
	 a7FdOdh005E6ZYHpCQjbAKUY50T4rXoGx0LmVwHTEPAY6t9h6zcUzjHH/tZgdo8fkh
	 M/3PdfyEQtYvQF+Zslbq6sqK098oWyWYto7/s3Tavnh0k/CLuFJokYqxKB8jjyYgZ8
	 fJ3AxFBo/+ePw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] igc: Disable PCIe L1.2 substate on I225-LMvP and
 I226-LMvP devices
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGFuaWVsIFZpYcOxbw==?= <danividanivi@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260925112850.189302-1-danividanivi@gmail.com>
References: <20260925112850.189302-1-danividanivi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 11:34:22 +0000
Message-Id: <20260925113422.C320D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid
> performance issue") disabled the L1.2 substate on I226 controllers due
> to hardware exit latency limitations. However, IGC_DEV_ID_I226_LMVP
> (0x5503) was omitted from igc_is_device_id_i226(), and IGC_DEV_ID_I225_LM=
VP
> (0x5502) exhibits the same L1.2 exit latency constraints.
>=20
> On systems where I225-LMvP is connected behind Thunderbolt/USB4 bridges
> (such as the HP Thunderbolt Dock G4), negotiating L1.2 triggers severe
> BadDLLP packet framing errors, link timeouts, and system hangs during
> shutdown. An earlier attempt ("igc: Mask replay rollover/timeout errors
> in I225_LMVP") proposed masking AER reporting. However, as Bjorn
> Helgaas noted in review of that patch, simply masking errors is
> undesirable and fixing the root cause is preferable; disabling L1.2
> prevents the link from entering the unstable substate entirely.
>=20
> Include IGC_DEV_ID_I226_LMVP in igc_is_device_id_i226() and disable the
> L1.2 substate for I225-LMvP across probe, resume, and error recovery to
> ensure link stability without masking AER errors.
>=20
> Fixes: 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid perf=
ormance issue")
> Link: https://lore.kernel.org/lkml/eb5a9805-3e53-ec22-696e-21c6b8cf0bfc@m=
olgen.mpg.de/T/
> Signed-off-by: Daniel Via=C3=B1o <danividanivi@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925112850.1893=
02-1-danividanivi@gmail.com?part=3D1

