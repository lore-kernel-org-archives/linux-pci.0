Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD754A2A77;
	Thu, 24 Sep 2026 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263840; cv=none; b=gcCpUNQniZ/hLCTiS+d4+RFtHabCxI/R4sjo0Xru/g9iMiZM7wHPMP85uqH3PxSfm5Uz/xoJngQS7Xry+ml7sjRj1Xek87JmWX9H3lOdKp+UsASqsSNo4MAp5CKea3Pm0I6t39GbJF9l61yasRbcsU+uJ4/VHdCKZuRc54is2ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263840; c=relaxed/simple;
	bh=VFc+i7ar8byAluJbIRNuTyMs8RcRPDKBU75L0RXSbXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y1OWKegbIGo4QN8ykdC2/wI5rzqc7rwRgRfFMlvw4pQpMbAgxrzYcAiKkNL6dW+q0ntpVZUlKbLofwFvSkDdu7ZSKqM6OmoPtyU8XrRdxO3jSfqgDkbXPdlcuCGa3lvGRD2BZIfhaf8AHVqOHdtzXWpxWegRizNcxsB+LlR3qiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX42Pfsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX42Pfsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14A51F00898;
	Thu, 24 Sep 2026 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790263838;
	bh=pDJlwOw2+JDo0jiD4ycltwPcw+aS30nwU3cZNN/8HPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WX42PfshhZcJ992CNtnwqkAi6ujawXM4bbq46VXTvbT3XgC1q9m1V8yHMGVdf56X4
	 pBATuBqTgbmvPAyB6b9nbX8oac4nq/MzyNR5BSYTmv//QqA0UiUFXqOVYWH+V2WvKf
	 I9z/vW4LJbOFjQqK0m9xMSx3XZp/8OOzAklEQs8EIi7nmme68Gq23PfxLCMtIRcloc
	 Dks1ftEeFbr4ntWgb5acf7twfht6CNH3uTqUsbt59VI6dro7moO/kuvkiPMgmWoWHT
	 m8PtxfWL2dfk7vevT8FVGWL1s/N9TVlN1jnrfSUHbwSb9KRYJGEU7oKPMyC5ghNgHl
	 9/zVxz49mFzCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/9] vfio/pci: Un-revoke DMABUFs in
 LOW_POWER_ENTRY_WITH_WAKEUP resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260924152159.49702-3-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-3-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:30:38 +0000
Message-Id: <20260924153038.A14A51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY_WITH_WAKEUP correctly revokes
> DMABUFs on entry and, when paired with a
> VFIO_DEVICE_FEATURE_LOW_POWER_EXIT, vfio_pci_runtime_pm_exit()
> correctly un-revokes them.
>=20
> However, when vfio_pci_core_runtime_resume() signals the eventfd on
> resume, the bare __vfio_pci_runtime_pm_exit() is used (which does not
> un-revoke).  Add vfio_pci_dma_buf_move(false) to the resume path,
> making it similar to vfio_pci_runtime_pm_exit().
>=20
> This also reorders the eventfd signal after the un-revoke and
> __vfio_pci_runtime_pm_exit() to guarantee that woken threads observe
> the new state.
>=20
> Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regio=
ns")
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D2

