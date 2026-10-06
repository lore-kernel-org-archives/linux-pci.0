Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D0395AD2;
	Tue,  6 Oct 2026 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315934; cv=none; b=VZRve9D2c6QlvJ9YWklXuzHJYiLhcHYxHgjyPd/fO4Cgg32ay6yJYW/CEzqITGADRpotSlSnEFEtKv/rLMyHHdgb3/PB2IJrB0ifNJoCF6eXyo/hUvAJVkdd9e/22Y/0cd3Y7NxIKWufoKK8UC32Wafmpmzur19k1QYRcEL9KyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315934; c=relaxed/simple;
	bh=RX18lwHBkBSso8kTfMi+hads2BFyCPNwznHsHejZ8wU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=m4b4QuYiAJPZJk0WFj4zKwCDdEZe49JYg3Grw9XSNz0hn0nJw2M9eH2yK1/hB4trBvR17C4TxslcxBG9XCtDmcy1wXlf4pY63+up+yF/eay7u9H3iuBZiR4WE9PlpQt6w+mzVrVWY3kBGYBgZwwiuTi0cuh8bla3EY8AzIC4fPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZnoChiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZnoChiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165371F0089C;
	Tue,  6 Oct 2026 19:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791315933;
	bh=ChD/me/I18cTRqIGrdJDGDJkKSGPR4tvhYXJ9VV93D4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZnoChiY2zMILVg+bD/b98xTbcKvnuoVT8+WQepElMWunO8drdHvmBMsvoGAcqhAH
	 DunsKiUpVzLk7a7fbeuCp1NCg+tvFCLWFzmoB/44hGHVExFSarbf1AtJlDbcqxfaP8
	 WZ2OYO+v0J51Ak4M2cifv0mxZjvOXktmbNwL0c/LpILoYwiXTz33ftnCY+0cQ7nnfX
	 +xjnhtYVELQkdSEx0Xan28v3E8/qjgSrJdpJ1juScTzXihxO6etacVLyHxMWQYSdff
	 H2SJ9/FKuCqu+TQmu28Wq7EcHQkqslLK1KWLxn8JM9/JjhiArbXN2siPh0FIXFLM3b
	 qy3I37UmOv4Bg==
Message-ID: <sashiko-outbox-162409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/9] vfio/pci: Un-revoke DMABUFs in
 LOW_POWER_ENTRY_WITH_WAKEUP resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261006193643.76330-3-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-3-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:45:32 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D2

