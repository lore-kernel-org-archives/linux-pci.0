Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F72044DB62
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183651; cv=none; b=F+S90wa9OLaoE7cdv15C83sTExGTYoozWgRAzaph5/BXDbe9XdH6KlwNvFBJ9ht7L2ujh65cQct+A/HSu1K4+Gjh840RLq/5rlkS5dtsDgPWPlpzKCGLiUaq/V9f+PS3lUtmEmFsYOV+iT3sPsTXGZ0HOJxClxN3CNWDXcB39Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183651; c=relaxed/simple;
	bh=fCxxoo3RFt5BAP+/VRk7gcxEg2tTab0T5Dc0I4bdBYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E5cRegd4doFzXuJAkR80hFVCV8vcWciBjqsch2Ty3kIZ6MKF/DIh3qi7H0ZbidSJ7TWQUWDf5GpmDtTwu7N2L8yFs4BsysNnkSIPXDl1h/jbZA1yApODBC/iqGVV/PPmRFB+z9Rp/2BdojJxb3vYy/guAjV0bvXUSBUmQCTP0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+Cn2ff0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+Cn2ff0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B79C2BCC9;
	Tue, 19 May 2026 09:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779183649;
	bh=fCxxoo3RFt5BAP+/VRk7gcxEg2tTab0T5Dc0I4bdBYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=J+Cn2ff0oNrW/Gkhdv9WFYlFzCLPgTjJauR6P9bA8osfGCZQmOpfDdx19KSyv3Hoj
	 C6kb1MVBUrW7qvlRI4Q34nUo5emenCEOT9/8naBBN8eMOkZ2Om8l/TDCO4amYZBIm0
	 iLrlJZi/HkUMUkHapQ6LqDsQza6zW9JvSvZMbBbqbXd1yP46RXAnzjSE875eAHZgGI
	 by0eHK/m6e+sFqAI4cOG5dLspeIqyd+iTveSaytv+TrYgGffPdH/4uCIRFl1dET9MP
	 4u/uA7tqesnxodEvTW0sfgZ8Rs0tSg+bW9GzP4OhEUfgvv4eMSmsWQuYPYAYpl7yVf
	 VGtFLX3oeuDOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/9] power: sequencing: pcie-m2: Allow creating
 serdev for multiple PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260519-pwrseq-m2-bt-v3-2-b39dc2ae3966@oss.qualcomm.com>
References: <20260519-pwrseq-m2-bt-v3-2-b39dc2ae3966@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 09:40:48 +0000
Message-Id: <20260519094049.85B79C2BCC9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Broken resource tracking and dead code due to early bailout
- [High] TOCTOU race condition causing serdev controller corruption
- [Medium] Guideline Violation: Mixing goto-based error handling and scope-=
based cleanup
--

commit b104c6cb6784fb376741e248e91c6f3721818285
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices

This commit introduces struct pwrseq_pci_dev and tracks them in a list
within the M.2 power sequencing context. This is intended to scale the
driver to allow creating a shared serdev for multiple PCI devices.

> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index b2ed336fd5ad9..469e130330faa 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c

[ ... ]

> -static int pwrseq_pcie_m2_create_serdev(struct pwrseq_pcie_m2_ctx *ctx)
> +static int pwrseq_pcie_m2_create_serdev(struct pwrseq_pcie_m2_ctx *ctx,
> +					struct pci_dev *pdev)
>  {
>  	struct serdev_controller *serdev_ctrl;
>  	struct device *dev =3D ctx->dev;
> +	struct pwrseq_pci_dev *pci_dev;
>  	int ret;
> =20
>  	struct device_node *serdev_parent __free(device_node) =3D

Does this function mix goto-based error handling with scope-based cleanup
helpers? The cleanup subsystem guidelines state that goto and __free() shou=
ld
not be mixed in the same function to avoid confusing ownership semantics.

> @@ -248,17 +259,23 @@ static int pwrseq_pcie_m2_create_serdev(struct pwrs=
eq_pcie_m2_ctx *ctx)
>  		return 0;
>  	}

Does this early return prevent tracking of subsequent PCI devices?

If the serdev is already attached, this returns 0 before allocating a new
pwrseq_pci_dev and adding it to the pci_devices list. If the first probed
device is later removed, it appears pwrseq_pcie_m2_remove_serdev() would
destroy the shared serdev even though other devices on the same slot might
still need it.

Also, is this check safe from concurrent execution?

During asynchronous PCI enumeration, if two functions trigger the
BUS_NOTIFY_ADD_DEVICE notifier concurrently, could they both read
serdev_ctrl->serdev as NULL and race to call serdev_device_add()? It looks
like they might both overwrite ctrl->serdev, and when the second thread
fails in device_add() due to a sysfs name collision, its error path could
set ctrl->serdev to NULL, potentially dropping the valid pointer for the
first thread's serdev.

> -	ctx->serdev =3D serdev_device_alloc(serdev_ctrl);
> -	if (!ctx->serdev) {
> +	pci_dev =3D kzalloc(sizeof(*pci_dev), GFP_KERNEL);
> +	if (!pci_dev) {
>  		ret =3D -ENOMEM;
>  		goto err_put_ctrl;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-pwrseq-m2-=
bt-v3-0-b39dc2ae3966@oss.qualcomm.com?part=3D2
