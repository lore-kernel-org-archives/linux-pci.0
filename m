Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CCB32F76D
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778196508; cv=none; b=ZVQrjJSyS9eHPbeFIw6Qh/YwsvfNcbPpUlPHTdlcpNcqflKcT+C2rZY/UEaokGzObxg/Dao2TPtZeFl3SbqGbboRYKZzF6tQxSgQ+qlzGbQFaSgd2nrDox4Leocqv5oghA3XNKGgOfQa3WCYg6TQ1qin3XDKt7PjKP4mt3jnn+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778196508; c=relaxed/simple;
	bh=b2WYSRDOi60IJD/yGwl/TJZbr3kbvYmpL7/CMkOeDtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bN7R3YNA853iOBGI9XVVtyQwJlZW//XNuiDEa5U5Xf+x6Uw6wLrNMFhT1Suq3z4YqMZIgShbDQbuaoGsGR/pqXKNngn7hcRAP/n15nnEhbZi7hiXd7Wn2QarZnMNbp7Hoxt3mgmevaoCNrUayG/WlliO+u86XaHjjfSNs95UW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQ21rt+8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQ21rt+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D87C2BCB2;
	Thu,  7 May 2026 23:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778196508;
	bh=b2WYSRDOi60IJD/yGwl/TJZbr3kbvYmpL7/CMkOeDtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tQ21rt+8u8jhWIFvvrHWhVXdapJAxAXULV5rOvSlQOQu8FYOsFtXwfNXCrswMxCif
	 f9YeITvMFLQ2oWPyvfNeAPt6rA467VQlC1FH1WgDa15OkEOi2FQkplDU/zSESpoxlm
	 iVB8mIjNpIxB2leDlTchXkjd4j5zgfuJVjgDJJ9F4zX5s5W99bjCFICxc1tZ5jNHRw
	 QhyaazbBmiJox2IjT0qPhEF+6MXnm//JLI+YT9Y3XKvSJw3OyIiYuIXrKK9vLsu0yh
	 mzBZpDaHuWXunGU33HZ4soPP7hPtMPQGErN9u08y1PjqA3PXPN6iQmRefQzRn9L5xx
	 x3KCTj3yVf3Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] power: sequencing: pcie-m2: Allow creating
 serdev for multiple PCI devices
Reply-To: sashiko@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260507-pwrseq-m2-bt-v2-2-1740bd478539@oss.qualcomm.com>
References: <20260507-pwrseq-m2-bt-v2-2-1740bd478539@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 23:28:27 +0000
Message-Id: <20260507232828.14D87C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Logic flaw prevents tracking multiple PCI devices, defeating the c=
ore purpose of the patch.
- [High] Lockless check of `serdev_ctrl->serdev` introduces a data race dur=
ing concurrent device additions.
--

commit c7f58507c704ae72da8e4afb0e0855215048187d
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices

This patch introduces a list to track multiple PCI devices per M.2 slot
by creating a 'pwrseq_pci_dev' for each device requiring a serdev. It
replaces the single serdev reference with this list to scale the driver.

> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index b2ed336fd5ad9..469e130330faa 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c

[ ... ]

> @@ -248,17 +259,23 @@ static int pwrseq_pcie_m2_create_serdev(struct pwrs=
eq_pcie_m2_ctx *ctx)
>  		return 0;
>  	}

Since the intent is to track multiple PCI devices per M.2 slot, does this
existing early bailout:

	if (serdev_ctrl->serdev) {
		serdev_controller_put(serdev_ctrl);
		return 0;
	}

prevent adding subsequent PCI devices to the ctx->pci_devices list?

If serdev_ctrl->serdev is already set by the first device, won't this return
0 without allocating pwrseq_pci_dev, leaving the list with only one device?

Additionally, is it possible for two PCI devices to trigger the
BUS_NOTIFY_ADD_DEVICE notifier concurrently?

If both threads observe serdev_ctrl->serdev as NULL without synchronization,
could they both proceed to allocate and call serdev_device_add()? This could
overwrite the ctrl->serdev pointer locklessly.

If the slower thread ultimately fails device_add() due to a sysfs name
collision, it could execute ctrl->serdev =3D NULL in its error path. Would =
this
corrupt the serdev controller state and silently orphan the serdev that was
successfully registered by the first thread?

> =20
> -	ctx->serdev =3D serdev_device_alloc(serdev_ctrl);
> -	if (!ctx->serdev) {
> +	pci_dev =3D kzalloc(sizeof(*pci_dev), GFP_KERNEL);
> +	if (!pci_dev) {
>  		ret =3D -ENOMEM;
>  		goto err_put_ctrl;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-pwrseq-m2-=
bt-v2-0-1740bd478539@oss.qualcomm.com?part=3D2
