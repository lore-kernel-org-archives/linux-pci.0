Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420E3DB964;
	Tue, 29 Sep 2026 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703790; cv=none; b=EBkgAEEzICyEfCTL0oGINr0NaZOGG/j4imOHNF7rGF/sDrazVqov8zms2T3N20hg8PMxyZUTOXYMtcyWHKV3uSLlvGSBrAOL2sayuZRv2hUUGYPp5HrRT9/CWdakrLSe81oSQf1tWWQ/Ubu9iOImj16n/D4CBDTkhw5jDBq9dsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703790; c=relaxed/simple;
	bh=Gne8gKcs3CPSQWXq8zJMGWfZJUiRi6YL3pVNhPI3Rt4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mjMh7E9j5rgy/ZNzL9bWmdxlyNPnpE8sz3SMBvPnq7hri5IPjHgRAv3e/InB76P46BiqY5Y8nwd15ugwjX1JFT9wr4zwX/4ISZQANo33Os0yKuiib4iaC5vkB0uRZFM8vqFWj0nYMOzP0Rh3ImEWL+yxvjB0v3hEyFbtZn78Ye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq8oLtlK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq8oLtlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912431F000FF;
	Tue, 29 Sep 2026 17:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703788;
	bh=Gne8gKcs3CPSQWXq8zJMGWfZJUiRi6YL3pVNhPI3Rt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dq8oLtlKUz4EnmHtASqltKwOp54g2ZgFsy1yDGmd5L9NKgYEysiwXlJggQjBE3h+u
	 R4KMeRhLoYeVfpwUwLBmSI8a37gepjq/qDntcQBtFMfKKrFX5aiecVu6CUDzBpbKTF
	 ENlOaSsIf8rNjW2IzmxASCAYsQIYFI+m1DXnFxJSh09sR8qp3i0LZq8HjelxEMEXR5
	 R/RnCryGnDyfDQUhiBS5XDYNWNqlj/QAPTZUSQwVUBRpK1W7DPgRtLiExs95nmedic
	 R8pEUKok/WaxJW1b+PjP3C9tx0KyHXpc+i8A7WzCd373Z3zMSkzjqvNxjb5HrmxutH
	 WLTCfcdR2iNFg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 06/16] vfio/pci: Gate interrupt configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260929173305.204856-7-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-7-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:43:08 +0000
Message-Id: <20260929174308.912431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Protect INTx, MSI and MSI-X hardware accesses in GET_IRQ_INFO and
> SET_IRQS with access_srcu. ERR and REQ only update eventfds, so leave
> them available while device access is blocked.
>=20
> SET_IRQS uses separate read sections for validation and configuration,
> with the user copy between them. Recovery must also wait for IRQ teardown
> to finish flushing the global virqfd workqueue.
>=20
> Assisted-by: LLM
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D6

