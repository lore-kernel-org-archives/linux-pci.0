Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1146A5E1;
	Tue,  4 Aug 2026 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872992; cv=none; b=pgDefmPq7a8R2Sb1Lmiaz3Vlj5e7TbI0mf2gpiW6SrOp91jwzFTId9l0KqsmPtIefRMs8zmiedsNzCQqBg/5bo8rDkJZyOnRXlpEYvYDUaJSu/+tUQO0FFQdrN3hf9SjSpbMMWsAcoLLb4T+fsaGNeDvfY5JqIhUCgvpXaNgv0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872992; c=relaxed/simple;
	bh=tNXF8j7VrIfLS0XxoghC25GZpRC0Oa1lBtrS1tkqpR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hovnim9bv2GAHo8KShgLcY637MCY6zFKF3Ly9XStwwKNqxlMab5+tV+nHW6IXEam3yyEdc5lBl/TNFa09p713qhpTDlMj14Ph2RXCDIqsCiGr1NpA6imRA1GLZzNGlG2wuoQlEof62VPldkUm/5mxSLM/TVw7nAVYTgG9wZ02+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPmJDSF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPmJDSF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789C31F000E9;
	Tue,  4 Aug 2026 19:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785872990;
	bh=rqCYr62xs9dAw4288zOnrA2/ffqzdVWlWyO9J08wGWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oPmJDSF+s/F6P9RSLEJeWsh7VKBcxQPeTQ0b2bWMpx4MfJlQXTvpRabL5huS455G+
	 OaILp+EiFtIcdbwvW2zYBQ+aZVp0bxDn7M7kLmoCU++Imwbsi0Q4D4Hs3ExDjN4nGk
	 53B2NZZxjCVTqcR7bjwunV+rhSM20tNZzqGPd3k+JFg3vHL16dtamlKU071l0A/pkW
	 EPCITVWdVVcjisRtiHE+xTdR2ExTiEsD6qjd6YusTAMNTfJ3F94yXcO93jehlchViB
	 eUaWJi3euFiSMhkP69Lbm27kANSLgn3CKkPt9gG/6RQ7g3M17ghkxp/HaCYvPb01W1
	 xLykCCyEEojKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/12] cxl: Pass decoder settings to HDM commit
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260804192958.1823952-3-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:49:49 +0000
Message-Id: <20260804194950.789C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] New pre-checks in `setup_hw_decoder()` permanently wedge the decod=
er after an error and cause spurious failures during quick reset-recommit c=
ycles.
--

--- Patch [2]: [PATCH v10 02/12] cxl: Pass decoder settings to HDM commit h=
elpers ---
commit e130015805d1a3746154432a62193b6dcb3f71f9
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Pass decoder settings to HDM commit helpers

Introduce struct cxl_decoder_settings as a plain snapshot of HDM decoder
programming state and pass it to the shared commit helpers. Split the helper
entry points into cxl_commit_start() and cxl_commit_wait() so hdm.c keeps
the existing DPA-lock and commit policy flow while later reset restore code
can reuse the register programming sequence.

> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index dd8bed3d3ff0c..dd5e0cc82da49 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c

[ ... ]

> +static int setup_hw_decoder(struct cxl_decoder_settings *settings,
> +			    void __iomem *hdm)
>  {
> -	int id =3D cxld->id;
> +	int id =3D settings->id;
> +	u64 target_or_skip;
>  	u64 base, size;
>  	u32 ctrl;
> =20
> -	/* common decoder settings */
> -	ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> -	cxld_set_interleave(cxld, &ctrl);
> -	cxld_set_type(cxld, &ctrl);
> -	base =3D cxld->hpa_range.start;
> -	size =3D range_len(&cxld->hpa_range);
> +	ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
> +		return -EBUSY;
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT)
> +		return -ETIMEDOUT;
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR)
> +		return -EIO;

[Severity: High]
Will these new pre-checks permanently wedge the decoder if a previous commit
attempt timed out or encountered an error?

If a commit times out, cxld_await_commit() returns -ETIMEDOUT leaving the
CXL_HDM_DECODER0_CTRL_COMMIT bit set. Because CXL_DECODER_F_ENABLE is not s=
et
on failure, cxl_decoder_reset() refuses to run, so the COMMIT bit is never
cleared.

When a subsequent commit attempt occurs, won't it immediately return
-ETIMEDOUT from these checks without attempting to clear the error?

Similarly, for quick reset-recommit cycles, cxl_decoder_reset() clears
the COMMIT bit but does not wait for the hardware to clear COMMITTED.
Could this leave the hardware in a transient state that triggers the newly
added -EBUSY check?

> +	cxld_set_interleave(settings, &ctrl);
> +	cxld_set_type(settings, &ctrl);
> +	base =3D settings->hpa_range.start;
> +	size =3D range_len(&settings->hpa_range);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804192958.1823=
952-1-smadhavan@nvidia.com?part=3D2
