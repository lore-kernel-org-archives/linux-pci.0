Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622050;
	b=bFPDZszsiHwSVivFGDtC88iFX6cWovUHtYsRmmm/uql1FxyStIK0unk+AbjTvyAIiiMS
	 sBLjYi5UX/THNbMmQ0LaMHoSzGauu4KpG8fShpF9o65h5lZ4Qcz7wTDxWkpDEdm0JN8XF
	 7jMdEgprzqtxYWpQ7yGRZ0aMAjKWFieL528/i2DkHQWa820PBXzTWckskI4IOWguhK16v
	 2GCKm27mJR5Kc482pg61h015iqokErnL/or4D4/9w2wFLUClfMyISGsKHQujbvT1jVgDw
	 ldKegMoBdRw7HIPibGqD2Ale+R0DzqtPxpeanpIY4+3K4v720XNJwoUiNhEF1+C3Kyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622050;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VZ5GU6LWEPGdtJyw6k1PUxVIs1nQczr/WxFna29tRlM=;
	b=p7w1jFPvKuLe6CDLB/ixUE07NAH9uRNjMN2OzujAZcbbnltBaJ5k5koWL8o859dfeALx
	 DjjjWcXxfCfI2Bo8e8dhSsb/ha28xYwyU2Yc2D/4UmLd8sBU+kCOWF3D7PxjT4Lm7F2yU
	 snhbOLP1B4vAO06ufAwYHKo9LPLlTvQbmcaHM8pApk/TEWRBH98rVRedYUKk2EH9tCj3J
	 4dONl1E3FldXprXUG3Wf/z1VZShLQCemlKIc5AkwqtEcuWFuQD0haoEqT6Y+CY0RDEHs/
	 Iaxzi+Cof/1117xOfYJvYfeCcxSzvh5lCkxJfGO89B1ngyaCyhcPXz6PEU+c6bOfahA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIUcBivf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5808606A332
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIUcBivf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523FA1F000C4;
	Sat, 14 Nov 2026 02:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794622049;
	bh=VZ5GU6LWEPGdtJyw6k1PUxVIs1nQczr/WxFna29tRlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bIUcBivfZ8jD0IHX9kW6fhh4hY1x0nWpl6OJ7QTaEHeF+LI4pe6I6eAR24A4NXkBU
	 NEnt1wXy9hvLn+LCMKnj980EBiL/qJEspLuNVqFPnpp3zJ4z4weMKTpYCDvRvJDSOx
	 zXkBF4aArFKuizh6GwMRXhL+dGHOWW2Zjqhwz+1Dq7iK81UtiB1Af8HY1srNjTLZaQ
	 Zu0E3Z2gf9aeCr1bAXKK9VOHxaaO0ZGyCjSDfDRNAJb3KCst0FlV7Ui7qOo/umasik
	 BNgBdZ6jsgjjF7RYrIcxLy/EhmOSNAIc4RdMTD25Wh6/h7tXRJ5feM0aIct9ByYbHX
	 HzizMMQnLbF/w==
Message-ID: <sashiko-outbox-214041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/4] PCI: host-common: Fix early bus-walk exit in
 d3cold_possible()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261114-shutdown-v9-1-5430c9f242ed@oss.qualcomm.com>
References: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
 <20261114-shutdown-v9-1-5430c9f242ed@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 02:07:28 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: host-common: missing Fixes tag for
  __pci_host_common_d3cold_possible()
--

commit aa32aa4f9c8a904800280b84e3ea0f5b2f37243e
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

> PCI: host-common: Fix early bus-walk exit in d3cold_possible()
>
> __pci_host_common_d3cold_possible() returns -EOPNOTSUPP for the first
> downstream device it finds outside PCI_D3hot, and pci_walk_bus() aborts
> the walk as soon as its callback returns nonzero. Any device enumerated
> after the disqualifying one -- including a wakeup-enabled, PME-from-D3cold
> capable endpoint -- is then never visited, so pme_capable can come back
> false even though such a device exists on the bus.
>
> Since pci_host_common_d3cold_possible() already returns false whenever
> any device disqualifies D3cold, aborting the walk buys nothing for the
> plain suspend path: the overall bool result is unaffected. But it
> silently drops pme_capable detection for any device ordered after the
> disqualifying one.
>
> This matters for the upcoming shutdown path in particular: unlike plain
> suspend, shutdown forces the link into L2/D3cold regardless of whether
> pci_host_common_d3cold_possible() itself allows it (see the following
> "force_d3cold" changes), so at shutdown time it's common for an
> endpoint to still be in D0 and disqualify D3cold while a later,
> PME-capable device is never visited. dw_pcie_suspend_noirq() still
> uses "pme_capable" to set pci->pp.skip_pwrctrl_off, so an inaccurate
> result here can cause Vaux/wakeup support to be dropped for a device
> that actually supports PME from D3cold.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

[Severity: Low]
This fixes a bug in __pci_host_common_d3cold_possible() where returning
-EOPNOTSUPP aborts the bus walk early and skips setting
PCI_HOST_PME_D3COLD_CAPABLE for subsequent devices (which already affects
dw_pcie_suspend_noirq() when pci->pp.suspend_poweroff is set).  Should
this include:

  Fixes: 1d2a29ccd3a1 ("PCI: host-common: Add pci_host_common_d3cold_possib=
le() helper")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-shutdown-v=
9-0-5430c9f242ed@oss.qualcomm.com?part=3D1
