Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808922F6931
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083334; cv=none; b=SGgwkEXy/aVJ8zPGDee3r62Hz87qrdmOYZbk2doJjF8hTXQ40hCxB8VrDs33cJU6RNeB99FwECbwHms1bu6Q+xuWrRfbON5gCr5VkIpKSxfUX7uxxxmnxIfP4jol6AKd0H985sYB/VKIgtoYK5y5/KzD6zKlqSeHgm2G73YKFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083334; c=relaxed/simple;
	bh=nJnMRhaoPge6jAMcgsQNdtQQtHlc7oYz+Ro415W3RcQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n7uPrHHrue/SsMIat3hbz9HbH0sU7/rqMJhoIxEaVl82MCSPJq1aLHYpp/47GC2evPpheJHTYotEvZHFFlHYYc1rW8cL2W7mrqw+6zqPDPbj6q0bTEOpi2vLoYdT2jC6DCIzPVoYdx+VMo8w7q54y3ChMFyGimnuxB6jboamGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6xLit06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6xLit06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1E41F000FF;
	Thu, 10 Sep 2026 23:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789083333;
	bh=nJnMRhaoPge6jAMcgsQNdtQQtHlc7oYz+Ro415W3RcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V6xLit06hwFt7X4RembmEkUvk6qRIytHhLWz8wqdcCWJ7FGlS+DW6behhl+qKfcI/
	 Z+KPsVIELP9ZUdO37YHZmbXKD5Mdwo7j+MtFskFAr8h9DsBNVtLcoesPA08sRKWa3v
	 69X/JSVQ6cEcBIFibAjNt8aZjSGKmN/Ok4WFORB+cRmon9suWB+dHsmiZN+JahSzcP
	 NdCTVwsUDiHBhjjHMOGEjcSUk8pq7+Z+FfmgNPNZ0nXf6llPxaxRo/B78DtV/gL1+h
	 AjAh/KgXFBIPReiSa9OOwRhYRqQVb/E2lx+6zNETdEPdPeAPIrxP8i0B01qjD5eIJ9
	 V9WQHInJ4lMfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/15] iommu/arm-smmu-v3: Flush in-flight fault work
 on domain detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <848cb4c8a79da1f434966d998be0f4ebddf80fb7.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <848cb4c8a79da1f434966d998be0f4ebddf80fb7.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:35:32 +0000
Message-Id: <20260910233532.EE1E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> After the hardware queue is drained, an event may still be moving from the
> IRQ thread to the IOPF workqueue, while earlier IOPF work is still runnin=
g.
>=20
> Synchronize the EVTQ and combined IRQs, then call iopf_queue_flush_dev().
> This finishes all old-domain work before the IOMMU core frees the domain.
> Skip synchronize_irq() after a drain timeout because a stuck consumer can
> otherwise leave it waiting forever.
>=20
> If arm_smmu_wait_for_queue_drained() times out, fault work may still be in
> flight, and iopf_queue_remove_device() would free iopf groups that the wo=
rk
> also references. Skip the iopf teardown and leak the master_domain, rather
> than risk a use-after-free.
>=20
> The skip also leaks the iopf refcount, keeping the device enrolled on the
> IOPF queue, which would strand its fault parameter on the queue list once
> [ ... ]
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D5

