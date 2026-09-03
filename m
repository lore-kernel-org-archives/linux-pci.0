Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720153A7F7C;
	Thu,  3 Sep 2026 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422628; cv=none; b=kFrFGPEGLHdg7T1ZkyPBub1qrJvl4CerQP8HmL6soc70RDfxtKP5h5QyUOsk7jC9dFOHI2wbypyP3CFQW1+ScmKJHDu1FvvEYfopIKni0pe111gMcMCzqKuQhDStJEMIW6e6jQZelipQtvurggEgVdI89R0bIa989g/gInHrozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422628; c=relaxed/simple;
	bh=9i5t/xvQraqqpMFkPyT4pJMg+enEByLpy3zyUq32LYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hyif9NouRgW2dk9WmyaVNOSikiSCSIyTcfKoEsIGToKzRyPAz6jRYwxMUOynE3q+bCmGCSxclB+bAn4NUB7eOwHpdgSdVpGZEpsFQ8pvMaEXfkFLeLHLTVtHkwWfz+1HKHx7SMQTrexAW+CEmhnd1bitwbzkAcXqhsP8Gz8YewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzDtOuSl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzDtOuSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269BF1F000E9;
	Thu,  3 Sep 2026 08:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422627;
	bh=9i5t/xvQraqqpMFkPyT4pJMg+enEByLpy3zyUq32LYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CzDtOuSlPJA6r0Ua7GGcF1sROIzBRACfQ+XERsCXz8KS39DoR/E2PwMEVPFN3V2MG
	 UPqQYc0pAMNSdg8GgV5yXF/rgBRTaWcAwBoLG1NAEN8pNIFNqcXhA6+O/VWE0jRsjv
	 ZAjO5tcJpsDdeQHMZIMVQtVRMBjSqGA1oC+GSBJIy4Mk52WIA0t3uQuCHDyJkhIEsF
	 xhCey4aoRVr/8b4ZDYQvfiXHB4sU6eFpo2CBEmuRpFp2QXFURO3S0JVZPDAlngrtIZ
	 6IgOXTO3TbMorcI7cXDkcpHXxmVH5ycem2w3brl1zvkirZInV5jXHzqUYmjdCVw3A6
	 yFBmebKa+VlcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] perf hisi-ptt: Merge 4DW and 8DW HEAD0 printing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260903075241.1445338-5-liusizhe5@huawei.com>
References: <20260903075241.1445338-1-liusizhe5@huawei.com>
 <20260903075241.1445338-5-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:03:46 +0000
Message-Id: <20260903080347.269BF1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903075241.1445=
338-1-liusizhe5@huawei.com?part=3D4

