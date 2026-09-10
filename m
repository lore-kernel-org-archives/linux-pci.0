Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DA93A782D
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083223; cv=none; b=sOOLmBC1tUIIcDJxJvY0BSKPy14QYflMyR8AEmsdbBP1IwTvW7rMnTVzCXMVzc6NUDBnn8YZuF1NRXqdycJXtd0Gv4BMP7GCjgJ12kkW7mQVKQobI3NIt/iE1N2ezzjZUjeVQUf1hsrDW3eunKpYUqG8QUGXjkHOZKpdZKPfrHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083223; c=relaxed/simple;
	bh=W8dtAkMqEv0cmAODGwxHMkT20xlkTvMg4v4+NPfKcpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UBAGyMnBxq5t+mnvKzzobuGDzoTMcMP8ldPXtBXnvhNWz3JVuW8O4HSV9ldxPaPacmAIYspv4R/F4YeRI7TVgUfq9p+riLhAFYUTXvaV5s/LMvvWlci40vdNNHnU3VGcFsuaG25IErBbWgA4pNmnbUd7cX5kOvub0euESXL42yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L53KZxCx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L53KZxCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8BA1F0089E;
	Thu, 10 Sep 2026 23:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789083221;
	bh=W8dtAkMqEv0cmAODGwxHMkT20xlkTvMg4v4+NPfKcpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L53KZxCx6Y5YE93PzoCGwN2cDgGHtOE8LbErDimFlw9ExKY70DiVW0EaacDZkG3go
	 1YadvDLHIBG4zHkHcmFIZBAI96mNZMhOrsmpUlx6aLTsWkm52ZDBpdEsHM0Kik9M6m
	 0cZhvorwiSUXpgiSTPBlwnq3tLvG7zhv/aZlGv4p2b2q+cpnn2T1fOAfmAeT6JU0ad
	 mrZtMRn7/f4uUSY3Jy01IEbTejTkpKyp+C98J4CjCMEPsggke0pd6RH86g8xoHsNAz
	 GD39orU7EyJO3181gnRQChP6Q31ZtG4w8sOspWtKhy8glZqewD6QSc/CdgcFI60SiQ
	 4azpXdldXwPUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/15] iommu/arm-smmu-v3: Discard partial PRI faults
 on PRIQ overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1c274d8836e59c549130170d5794d22e9b8c7d7a.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <1c274d8836e59c549130170d5794d22e9b8c7d7a.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:33:41 +0000
Message-Id: <20260910233341.8F8BA1F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On PRIQ overflow, partial requests stored via report_partial_fault() whose
> LAST-page entry was lost stay in iopf_param->partial. Drop them by calling
> iopf_queue_discard_partial(), matching intel-iommu's handling.
>=20
> Do it only after the queue is fully drained, since the visible entries all
> precede the loss point: a group whose LAST-page entry is still in the que=
ue
> gets assembled before the discard, rather than losing its stored partials
> to it.
>=20
> Nothing can arrive in between, as an active overflow inhibits new entries
> from being written to the PRI queue until a final CONS write acknowledges
> it (IHI0070 8.1).
>=20
> Suggested-by: Harsha Vardhan V <harsha.v@oss.qualcomm.com>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D11

