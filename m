Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F42F8EBC;
	Tue, 25 Aug 2026 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625721; cv=none; b=UV6ETbqHWoE8sBpPee2klTpZsVtvvFPkKL3uXmpn1XsyjZGYFKiQJchIZW8gNLacBbD+IBesojnuDZoWox6Lxu4Ynq6L7CHGT+wytsuZfDMZmXw9kHr3L8Odo6uuDNtEjJ317ERHyfbyaYwCcygzRfd6X585qCo3mgDMcBzZWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625721; c=relaxed/simple;
	bh=EiyqEwQW5BOokyxx4jlmzLFv8WNIRhFajztjWnBIJNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uCFr5bg5yW6+y4I+ASWJC+H76y4ztlBhE2W5uOnD2XNUtOiWP93pZnKXO7Xs/8B6qjZjj29uBlLDnZANhH8qzWJ3lBmXXOxflvpWL7GkDAZ+nDKTqksS27YpbT5aK9DsQ6ycmrKX2UPCvx3ngJaXM8G1btWmRGW8VsIO3LmeMlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPWMyPS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPWMyPS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4B81F000E9;
	Tue, 25 Aug 2026 02:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787625720;
	bh=U3RzAo9ZVS3j/Oul4Lnn5sG27MTDOahZ96tRX/IT8Lc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LPWMyPS6u0/h9XJwoZdmzcwIy9chaGecQ3WQaWszyAqIDavZzo9ZeX9X5YvOWCm74
	 SQV+8x7cl4/ceWSz1LFdkhVIaH75Bt/p5TcKa3cYZ8GNVClRpD4SnZLRGsddied9ai
	 8pSpF1HQ4LXvCNVqT8niW9TB914FujlGgYtoTBrj8IzqcrReP/K5Q3PX+EQg3WNsSW
	 oxx3/nwZyZsOQXgzXtWXKempr2GwQe3zNlWVRolnz5GYnFUAA+34pQolmENYFGR3Bf
	 FJjyp21Sq/Msv6d1gbLcAWffioYaz0vxLwMY1VHW6jxfyf70oRX0iwvFaivePBbwsU
	 h2vhsErx3/R1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/13] cxl/hdm: Add function to restore one HDM
 decoder
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260825022628.3651434-3-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:41:59 +0000
Message-Id: <20260825024159.CA4B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `cxl_decoder_recommit()` falsely reports success if the hardware i=
s disconnected and the MMIO read returns `~0`.
--

--- Patch [2]: [PATCH v2 02/13] cxl/hdm: Add function to restore one HDM de=
coder ---
commit 15afab37836901527b4313972b91d202d46a3f32
Author: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

cxl/hdm: Add function to restore one HDM decoder

This commit adds cxl_decoder_recommit() to restore a single HDM decoder's
settings if hardware no longer reports it as committed after a reset. The
function reprograms the registers and commits the changes, which is a step
toward restoring decoders below a reset port.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..d55d764895f88 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
[ ... ]
> @@ -849,6 +849,77 @@ static int cxl_decoder_commit(struct cxl_decoder *cx=
ld)
>  	return 0;
>  }
> =20
> +/**
> + * cxl_decoder_recommit - reprogram @cxld's HDM decoder registers and co=
mmit
[ ... ]
> +int cxl_decoder_recommit(struct cxl_decoder *cxld, u32 ctrl)
> +{
> +	struct cxl_port *port =3D to_cxl_port(cxld->dev.parent);
> +	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
> +	void __iomem *hdm =3D cxlhdm->regs.hdm_decoder;
> +	u32 hw_ctrl;
> +	int rc;
> +
> +	if ((cxld->flags & CXL_DECODER_F_ENABLE) =3D=3D 0)
> +		return 0;
> +
> +	if (!cxld->commit)
> +		return 0;
> +
> +	hw_ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, hw_ctrl)) {

[Severity: High]
If the hardware is disconnected or failed to recover from reset, readl() co=
uld
return ~0 (all 1s). In that case, FIELD_GET() will evaluate the COMMITTED b=
it
as true, causing the function to immediately return 0 (success) without
reprogramming the decoder or checking for COMMIT_ERROR.

Could this lead to falsely reporting successful decoder restoration during a
hardware failure, potentially routing traffic to a dead path?

> +		dev_dbg(&cxld->dev, "%s: still committed, no reprogram needed\n",
> +			__func__);
> +		return 0;
> +	}
> +
> +	writel(ctrl & ~(CXL_HDM_DECODER0_CTRL_COMMIT |
> +			CXL_HDM_DECODER0_CTRL_COMMITTED |
> +			CXL_HDM_DECODER0_CTRL_COMMIT_ERROR),
> +	       hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D2
