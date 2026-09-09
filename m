Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6755199C
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956968; cv=none; b=lT34Ifh0PjdRCC6TFZsCEjTi1/jeeJg0qvYVxELVPfFfBtewAhlIXq2XnBbrh4SqmC1HN9qfD/BaqGl3DakiQi9JolBzXxGXR2+CDjXG07XggKO/yZG+L8UrL96kCsuqh/fhxFeVoW0KfDSY3UXEv6pXOVxPEf+jcgmMaOf8rJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956968; c=relaxed/simple;
	bh=rBITHdSzJOOavAP3Jg2ypebz/7zgX7SYGOH3v1EJCIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oyZ2ZdztOxJ3Dx/NCHA30LI+siyylHaRAmJnRUk9T1mK50DT8xordor5bQqRq4yzPJX6V51PcX5LNppoODsLlbNKDTSeADAC5a/82Eb4S0MeaESDFXdX+w0i2122L8qiDt30szGx25Hum7pPe22NU74oUPIrtzGkOtHd+Vm/qEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDYA/e0Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDYA/e0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F5D1F00A3E;
	Wed,  9 Sep 2026 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788956966;
	bh=rBITHdSzJOOavAP3Jg2ypebz/7zgX7SYGOH3v1EJCIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gDYA/e0Z59VIkKiuSEjkdnGtJY8284EGGs8TqqWYW6R1NYxCBi3yrJd4BE4vi9LLk
	 Wn7CvNvpQ0lcBfM4Wvm72nXABVU+h24ICME7XVCACjRJwuUl4SRLSXiWiR6FJOvoPs
	 Q5qO4FKMopGNMhlZ7gU7F5yzhlVl8aUo9uA/AFM1laQvv4Cz/erCuHXuBB+sKjuH31
	 F08X5EM71nGWStfLc8R/C2FUe1oxZUJO0007TOn4fEJ2+5RTko9dcG9RJXx+GkHBQn
	 dMMvYq1nIs50KTg0DO1140BVvl1GEQdzQ0SPAA0QXR9M2VDPQVH0et5HoAM2ca2gk7
	 3/lq/lAoSRgkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] PCI: host-common: Fix early bus-walk exit in
 d3cold_possible()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260909-shutdown-v6-1-62b7bd123236@oss.qualcomm.com>
References: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
 <20260909-shutdown-v6-1-62b7bd123236@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 12:29:25 +0000
Message-Id: <20260909122926.56F5D1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> __pci_host_common_d3cold_possible() returns -EOPNOTSUPP for the first
> downstream device it finds outside PCI_D3hot, and pci_walk_bus() aborts
> the walk as soon as its callback returns nonzero. Any device enumerated
> after the disqualifying one -- including a wakeup-enabled, PME-from-D3cold
> capable endpoint -- is then never visited, so pme_capable can come back
> false even though such a device exists on the bus.
>=20
> Since pci_host_common_d3cold_possible() already returns false whenever
> any device disqualifies D3cold, aborting the walk buys nothing for the
> plain suspend path: the overall bool result is unaffected. But it
> silently drops pme_capable detection for any device ordered after the
> disqualifying one.
>=20
> This matters for the upcoming shutdown path in particular: unlike plain
> suspend, shutdown forces the link into L2/D3cold regardless of whether
> pci_host_common_d3cold_possible() itself allows it (see the following
> "force_d3cold" changes), so at shutdown time it's common for an
> endpoint to still be in D0 and disqualify D3cold while a later,
> PME-capable device is never visited. dw_pcie_suspend_noirq() still
> uses "pme_capable" to set pci->pp.skip_pwrctrl_off, so an inaccurate
> result here can cause Vaux/wakeup support to be dropped for a device
> that actually supports PME from D3cold.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-shutdown-v=
6-0-62b7bd123236@oss.qualcomm.com?part=3D1

