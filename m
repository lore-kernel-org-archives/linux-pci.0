Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305901;
	b=BZ+AxSbFGtNlJ45e6qUGByHoSi4qmULzItwCVqz6ocme/1s2JAY9vXl53i93T4co4q2M
	 slI/+dr3KU3DeZmY9GJfHOMVcLGtScK22qlIQZyvdZhNoAb1zeaVdSte6H+IUsMum0qvI
	 N9+9gapTYg++iTpioA5nYSlJtP0OQQLhkhIzKAE0JDnW6UNIOMMkPF9BbasBQ5PZ5rm8q
	 jMWf2UPJufvWfdMCc4exr82x1KSpRbwfqhDBrPW5QLO+R6mIcwAXVaaXwgNkImzP6+bqT
	 TTPXsOW6m4A9lzC4rTqIhCmAiCVRJgQaXEf18JzUGOHYYvu+qOVh9UwMhc36EX+wVPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305901;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=soKi9Lw1ANjh+LV7c9MyHoFjoXKBUKu0wPONHsQPJ58=;
	b=TtlFCKt7j1Npgsh4rp35a5TgaAHxjddCJnSB6Go9elkPefhLgcFza/ONjZzYFebEbyFP
	 NKH4KGzcxQtkatx49gK5VPObmO+JHhnzPdai4otQ6twCdf70FwHzgt+VYzt+mk/WkhyAn
	 CybBAB21jo38j5w8l+Rh0tN/jRIO8/qptzpaLRFVEbujZEzZpzNI8onL+vjQxyg7z0rCb
	 UThEa3OgQbZuftlq88VTgEx2xpFc6cY3pw1IvaRglFmoFdXyqUgYNzpGCMEZqkkohbGmH
	 XvORS01la9nA2vQ5Y/jxYK3f1YrEfSLFH+Er7GH4atqlS/nZMkcA8jVMfHixQnupGGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggCeHHnL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D49606A32A
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggCeHHnL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C746B1F0089F;
	Tue, 10 Nov 2026 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305900;
	bh=soKi9Lw1ANjh+LV7c9MyHoFjoXKBUKu0wPONHsQPJ58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggCeHHnL30JTy/uEHiqD3WI7VTloqpP0FETTqKFzUkqMsYoUzUqmu5McEucZNTgaY
	 9Evt6vIAdnioP4FdTACbLMbSJHrt7P45yJBlQSHCRbTuPoO2Kj9wx09aTDxSaB4Uzb
	 bEo+1VZ3PxgsRxRUOjXgFaIabFsR69+IUD0vocPxeNJWNqtLnSoD9axRwY1pfbJdtP
	 qAYpDfeTZ4vetdSqhph0+SSI29JEUX6j+CK4FORlKlk9Th1j5PWQNDpnGYsDcWzjOv
	 6qXN+dYdGTxU0xXck1fvFyJHo/lxNhcR50p/7MMkZYpYz+an5rIc6lWFQiSX7O18b8
	 H8/2+dHKDRO3Q==
Message-ID: <sashiko-outbox-206852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: keystone: Fix device node leak in
 ks_pcie_set_mode()
Reply-To: sashiko-reviews@lists.linux.dev
To: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110100955.1046-3-zhaofeng2@cmss.chinamobile.com>
References: <20261110100955.1046-1-zhaofeng2@cmss.chinamobile.com>
 <20261110100955.1046-3-zhaofeng2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 10:18:20 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] PCI: keystone: OF node leak in ks_pcie_init_id() [1]
--

commit adfea56e642f99fd836f33feabf3e85f9ea278a1
Author: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

PCI: keystone: Fix device node leak in ks_pcie_set_mode()

This commit adds an of_node_put() call in ks_pcie_set_mode() to drop the
syscon device node reference acquired by
of_parse_phandle_with_fixed_args().

> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/cont=
roller/dwc/pci-keystone.c
> index 832589152570a..12c6f7d9a64bf 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1029,8 +1029,10 @@ static int ks_pcie_set_mode(struct device *dev)
> =20
>  	/* Do not error out to maintain old DT compatibility */
>  	ret =3D of_parse_phandle_with_fixed_args(np, "ti,syscon-pcie-mode", 1, =
0, &args);
> -	if (!ret)
> +	if (!ret) {
>  		offset =3D args.args[0];
> +		of_node_put(args.np);
> +	}

[Severity: Medium]
This problem wasn't introduced by this patch, but does the same
args.np device node reference leak [1] remain in ks_pcie_init_id()
and ks_pcie_am654_set_mode()?  Both functions also call
of_parse_phandle_with_fixed_args() to read args.args[0] without calling
of_node_put(args.np), leaking the syscon node reference on probe.

[1] https://sashiko.dev/#/bug/linux-2281dc7f-5c66-431f-8423-64e501436da0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110100955.1046=
-1-zhaofeng2@cmss.chinamobile.com?part=3D2
