Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994448BD45;
	Thu,  2 Jul 2026 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997012; cv=none; b=g5d6wZolfGSGZpx5Ypu6LPFdgRDliC9NQJRRjeRwaHIQFWjYySzcRzEsvLg9bAGCncHreyQBL71pv/mWOAJ/7GOa3m7P2jYCg+V5qT/D0iUr5Wn9NxYUksLk3Eo0CR7Y8aW/TjKpZmi488pMRkjd331bIUt7v71UuIaMyhochVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997012; c=relaxed/simple;
	bh=i8uge3bp4Bwj68QE6T/FncOPEQ2EHRWdYPBSTSROF9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SGmMHvqVFNrEZE6Gs6emg52jmmot2b5ydOPMYMouFyFZJJ2L+3xL6l8bsUGE8LomfnhFRMdTwXqBodNWoVxLOqKtb4lWQz2al+ZWX7FQpDKPo6MJl8ogWgFp3eRejG4S9nuIM+XYZp89CsL1JYgVUJLgVmBsngQ9u52Yq5UfZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVrFOixj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVrFOixj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B991F000E9;
	Thu,  2 Jul 2026 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782997010;
	bh=p62X4Ao+pP+VVrP7Fw1rOlZrvAk0SuDSJhW4+yUJL80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kVrFOixjCRk+rieFU7mE8p4FlIjpC6EPmYSRiCs1rSvqb4jWUAeaMplWJZ5BL69mR
	 Qt0bCtPt402AAXlrTODfazIjl7GzTbYf7cI+tBjcBrWGGJhuuKnP95dXR/c/VJLu3Z
	 ll2hASwnWjZm7c5ZcmuQsRRNuxdyvmYnTVOERL748d8aTicnLdVyhUt77Re4nAnoUK
	 RMvAAEVODkSZzObsTS7aRN55jYDKTTcYIfODfNbxIUWbq/VhvIUJscVQ9heoVkFZoI
	 PB6+rnirZwwPgA5CiyimCm0zEtSMnd4dK8TLwDgLfXmLMUWelTy/nIa+U/WJuouyVJ
	 +yI6bPjoy9NOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 05/18] PCI/TPH: Refactor pcie_tph_get_cpu_st & add
 explicit variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260702124224.57168-6-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:56:49 +0000
Message-Id: <20260702125649.D5B991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refactor pcie_tph_get_cpu_st(): extract core logic into static internal
> get_cpu_st() helper accepting explicit requester type parameter.
>=20
> - Preserve original pcie_tph_get_cpu_st() unchanged as auto wrapper; it
>   uses existing pdev->tph_req_type automatically, existing callers require
>   no change.
> - Add exported pcie_tph_get_cpu_st_explicit() with bool 'extended'
>   parameter for manual STD/EXT requester selection, consumed by upcoming
>   VFIO TPH code.
> - Add capability check: reject explicit EXT request when device does not
>   support extended TPH requester.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D5

