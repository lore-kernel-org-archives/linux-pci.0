Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271C24EFFDF;
	Mon, 28 Sep 2026 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614789; cv=none; b=GiX+m18W4LtEqAV9eVVHmVBXvS8PTd4dsaVTkFqgP5+IRuogftFDY0IUyF0olzwm+a2LRbcsf+NG5+bWLOr7UrX6B0YJ6a/CDkhCd9V1BdSuaUpefbZ+FANexwQcNvWjF8uwfvHSsnV+MmBJHKuVQNdTWfiyKqoVb9pzUDExjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614789; c=relaxed/simple;
	bh=PVGeImkWhGYA2ml8FLmYLV1MLWLKNd1OKBTLQ4cK4l0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sDkEV49PHJHQaqmYUaIcnQsSNF6rJ6txpuNYo62CtdNFdpXY5/IhNx5SZ3GpB5j668HJHNcFGk3D3F17Y9rYDlqiSkdHAYimotIqf/tbmtfM7BctPbRBE/XT/tG8Jv167Xu47mOyXHGuaxFN/vpTKOrEcQ9hSEuDz66ug+BJ7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF03PB3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF03PB3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811B01F000FF;
	Mon, 28 Sep 2026 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614787;
	bh=PVGeImkWhGYA2ml8FLmYLV1MLWLKNd1OKBTLQ4cK4l0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gF03PB3gxiVoqH+RKoOZzCa9wvTa5O4riKeo3+NvKD11J6LNS7P0IEdt/Xaw0NBgK
	 Ew2HU+UugAVgPRG/7PmUihhLLZ9DE2QxX+R3PSPxcJlVGHO/uQLUiDeXPHZ836VUKu
	 CLBjtBK/mOoBJQA4jLYz4eXSXvxOWihvpd7uqtQMdhdRXsTYUxtkX1Tx+ENuAkjoH8
	 Ru3C2SU9qN3L8PBdKhqSuLjQRT/8sFrJWxDWf+ZVyqSXFfpYhmNvcUq22QPXpPx49N
	 BCCe5KJhyIdTPiRkgoCe3fbZOoA9MAGrSGzQxKWB4fKhObw1xapFXx/L0L3iYMpLyp
	 Sc8d85tOPUOFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/15] PCI: rcar-gen4: Assert resets when Gen5 PHY
 initialization fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260928165230.3397664-7-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:59:47 +0000
Message-Id: <20260928165947.811B01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> common_init() enables the clocks and deasserts the power and
> Application/Local resets before phy_init(). If phy_init() fails, the
> error path only disables the clocks, leaving those resets deasserted.
>=20
> Assert both resets before disabling the clocks to unwind the completed
> common initialization.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D6

