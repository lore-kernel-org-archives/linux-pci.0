Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB7E30F92E
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661958; cv=none; b=jFUL0ezKf3s/h23QWPe6LlwwodKLw0ep24DGcy5JVCdOz1L5b8hraD9v0exn4+V7hHPmuRk10eZYrQHE9JfLuVZcB4PzXs079AQHsruRtnp6KvRLepfbqJsXM2voyeganB+8l+VdEGZkskVWUwcufPGkw7ArASBysLj5qBk6Cio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661958; c=relaxed/simple;
	bh=3xaqrNnaHz//4/bm87tCOREQK5OKT5hcG+xjqE/5wwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xzj+8CWCp3ZOlcV0d2GgprOCQxtfMkTsxTxG2/k41jq32NLHDBu4PaxOV2wZyiuLpqhkdcVwzqxJMR0kMUsFmCzppGahIzKez4As/SyReYmdZuM3X/w6OyQ9KNdnIjQ8Q2YPFSBInh11Hh+8GrSUk0Mc3u1XkvAFWQDaGfpsYY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoMF9J7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoMF9J7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EC31F000FF;
	Tue, 29 Sep 2026 06:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790661956;
	bh=3xaqrNnaHz//4/bm87tCOREQK5OKT5hcG+xjqE/5wwQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DoMF9J7emTOMXTaKXVkAtfxvbEarDXHZkDkKWmFS6cqLcLD5qa6yQg6Xxy/cCQxq1
	 rHj3a7VK3Moxs1NQA3UP1nwqUz3QiZNqstMqLauy9d7JbnjOJhx9lGSMAm6qBx3zPa
	 zmOfpFYoAHkBVL1P/j61RI1a4R8p1LoWJ9XvI7BIo412y8CQUUHEC9LrJQYrkXS/ei
	 qBwVSjYFcTjl28EWDukywKbJySh3ae79C1frQ/7kHsDvK3DZbzNdiNk1yf6yG+SgwC
	 ZiAV0DfcBLWS+7OgrF3QcpZFZMAjsWIwTJjLNCd6hCVjQrdnS7ewOU0hSIS4bbaeUs
	 Jw90tYNUMsQcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 12/16] iommu/tegra241-cmdqv: Add a helper to quiesce
 VCMDQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-13-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-13-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:05:56 +0000
Message-Id: <20260929060556.87EC31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The tegra241-cmdqv driver supports vCMDQs which need to be quiesced using
> the STOP_FLAG. The current driver implementation only uses VINTF0 for
> vCMDQs owned by the kernel which need to be stopped. Add a helper that
> sets the CMDQ_PROD_STOP_FLAG on these vCMDQs.
>=20
> Consolidate this logic by renaming the implementation hook to
> quiesce_and_drain_queues and ensuring that the tegra241-cmdqv driver
> gates all active local virtual queues before starting the drain loop.
> Additionally, clear the STOP_FLAG in tegra241_vcmdq_hw_init() as a part
> of tegra241_cmdqv_hw_reset().
>=20
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D12

