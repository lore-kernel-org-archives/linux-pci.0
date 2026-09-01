Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8279476CE6;
	Tue,  1 Sep 2026 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256760; cv=none; b=p2YDhsTriRc9iTArK/VQH4a//jXHEaH0DjaUP5p3OyJRZO7LffvMsHsFzJ3sIuO5/+DXoLPFqjjWm2L4TvXe3dO/k7yRukcYLldhSMHNIuqh2loeANGMsMA/JwkE2OTCoLVIWB4JTbhml6n4xO8D6UxF2vbGIXLOEbueI1DUf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256760; c=relaxed/simple;
	bh=vGLCNssVfeizYIDdOyml1AIOhZIuxfN+6vD6m8t/1tA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oErCpN7r62N9JRGokRBSKXl7Is1lPnHCOl+fJ/FOYnszTlKdmgQnPT324zF+E3+8LNgh61N2Pb1vzmvbmKi6G4764kG33BStdMiKaSaMYLQRcicsoNGwy13AM0lA37lmwJqintq5V3A9femTzIrXtxXHOTwwuh7Kmm2jMDlNXb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQempH7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQempH7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168DA1F000E9;
	Tue,  1 Sep 2026 09:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256758;
	bh=bNXYoqUZyjRVDySKF6T7nJQbg2nJcW0MVOIc38ScLE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FQempH7B+rlSxaDEdvsiFH4p1CYhu4nyNwXSgmnZXIs1KshoJEkMJ9Mu1/MfthqFi
	 6l3SnSI7OwM5wnfhMcmKWrd2bKV7spTRA4wkBg9KT1gTBLdxOlSFhAwqHFJ3AcpOYc
	 e+ziUcPxuaOfk6F/5EfyGQyhKCWIu9OvykpSGMKdpRWHxn4rmG9nvcemWmwOA0XKR8
	 0v2iA5IWQWIiLnUWH3MoweIU8hTwnAq9S1XnUGq84JnKmVRMIXKmLCPDLUknlGyyCw
	 Rql8WBEKz9QUr211N1t7SB1ABn2MMZIiJyRtcSgamGvfml9f+mUna2aR3xPxxK5DIg
	 NnLnBY2KnNe5Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 15/19] vfio/pci: Add INTx helpers for PCI recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260901093217.8539-16-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-16-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:59:17 +0000
Message-Id: <20260901095918.168DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vfio_pci_intx_recovery_command() unconditionally sets PCI_COMMAND_=
INTX_DISABLE without checking if the device supports PCI 2.3 INTx masking.
--

commit e9304e8881d7f9626b1abc86dddca1139e91674f
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Add INTx helpers for PCI recovery

This commit adds helpers the recovery callbacks need to keep INTx in step
with an error event, and the two per-context flags they record it in.

> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pc=
i_intrs.c
> index 64f80f64ff57a..c4a075b5bb2e3 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c

[ ... ]

> @@ -247,6 +283,86 @@ static irqreturn_t vfio_intx_handler(int irq, void *=
dev_id)
>  	return ret;
>  }

[ ... ]

> +u16 vfio_pci_intx_recovery_command(struct vfio_pci_core_device *vdev,
> +				   u16 command)
> +{
> +	struct vfio_pci_irq_ctx *ctx;
> +
> +	lockdep_assert_held(&vdev->irqlock);
> +
> +	if (!is_intx(vdev))
> +		return command;
> +
> +	ctx =3D vfio_irq_ctx_get(vdev, 0);
> +	if (ctx && ctx->masked)
> +		command |=3D PCI_COMMAND_INTX_DISABLE;

[Severity: High]
Is it safe to unconditionally set PCI_COMMAND_INTX_DISABLE here without
checking if the device supports PCI 2.3 INTx masking?

If a host PCI error recovery operation calls vfio_pci_intx_recovery_command=
()
on a legacy PCI device (where vdev->pci_2_3 is false) whose INTx is current=
ly
masked, this erroneously adds the INTX_DISABLE bit to the saved command wor=
d.

Writing to reserved bits in the PCI Command Register on legacy devices
(pre-PCI 2.3) can cause undefined behavior or hardware malfunction. Should
this check vdev->pci_2_3 before setting the disable bit, since other INTx
handling paths in this subsystem correctly verify it?

> +
> +	return command;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D15
