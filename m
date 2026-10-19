Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E75471D16
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399645; cv=none; b=n5McyOVsLFiPwVAOxgQgVMOoEA1L9LEIy4exQQ9csCdpkp5iGIoN6bADV0u30qCA1MBhoHmkCYE4sBKWge8wZemXP52IDy98lhmiYkKIWeOWLa/j7eWxv2KITqU+mUx6lat8vgeeQWRObg7f1NKMTBkWPmnzs3WBwxw2YB/Ytcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399645; c=relaxed/simple;
	bh=4ncD0F8UyKRALyRolo9L8HwTLWWA/SeractbizyJuEM=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=lSAW2LNagj7XNR/xZRzUQqIh0DGAhTJBlSzVyc9gY07gY1/Drs1kQEa8ZPPCdZH+RdxCafT10rvfS5syIHEj9bHgcGSh5nz3XsfFNEhfFXltt928+IP+mMaNTNl6hiP6+KeM9cnKGQN+dywtxE7mQCr8aGXZkk3L2HK3LSFel3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMrQm8+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMrQm8+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDD11F000C4;
	Mon, 19 Oct 2026 08:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399644;
	bh=4ncD0F8UyKRALyRolo9L8HwTLWWA/SeractbizyJuEM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OMrQm8+dyfmWED25Xrm8W3Ez702BigIi7ufwmFQMkv8B3WC/FdVjBAH+7/JXzdCW7
	 35dkWRZ4jfvE2t3SqDk/a5JVcjz0FAZ5KPJfVLpt1EIsGX1h7DBZHO4AxlD7OFHBQ0
	 pD7Bih9+MUXaXVsEckBSYHx+EYexN9NjUjYhcoPBpoe/pUN7VYH1fxbu8yRBMux2RL
	 20H2tX1a/4PCiwJHRlx2WLv+CWrbGiA8GZgfPwquulHm9PFq15Ca+3t8NSl1WeNhuW
	 NNuNfOb7+jiwVYM7cILwiVjZf2kBOC3SJSESSuOTwuXo0gUIga8pM43ymbzZMYCQDl
	 VkGfhrYQA6Yrw==
Message-ID: <sashiko-outbox-176836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/13] PCI/IOV: Introduce VF locking helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-4-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-4-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:47:24 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add pci_dev_lock_vfs() and pci_dev_unlock_vfs() helpers to lock and
> unlock all enabled VFs of a PF device.
>=20
> This provides a common way to serialize operations involving
> subordinate VFs.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D3

