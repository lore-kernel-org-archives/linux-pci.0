Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D83A9871;
	Tue,  1 Sep 2026 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256439; cv=none; b=ePsLXpfUdBv38I6x2OFeFnSowLcp/4CkCev3+sE2VpUBsH3ANFZ6/9/DATSzLZ4zcU8bol+HHUaAxUO87PjhSXUDXol2RcZsk+N8zf3ckt03AG21W+33BgPiyLymmhrx3nfgPOyxjyxQUnusZ0fE6IDV+tPvwKbnk8LTUSsRr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256439; c=relaxed/simple;
	bh=6npHcmr/+bPNiE1rWkdkyEDyjw0PQWuVpv4NNIxY9r4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HeASf7Zi+mSl5JWWsDCLCKD/P7iZjen5rxTagL9UUnSIMWhnodCZ5+HHX+VrHNk6zoyKvp6lxlrmIWTldY1X3XSsYcuyfLnj5sP93gLPMAp9S3GkZh1roR495Ih58+1pUn4zN/ZnAVY6wwJREPWoIpsY4oFKgvvX0O6MXCXH4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXTBc6WD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXTBc6WD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D241F000E9;
	Tue,  1 Sep 2026 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256437;
	bh=6npHcmr/+bPNiE1rWkdkyEDyjw0PQWuVpv4NNIxY9r4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXTBc6WD9hlTNLx0pGuAcVQPdRUGMCFiwqW10C4U0MiEE/BmQJUrwumW57Scf/+6R
	 U0zWlUlUfxbcI6LkiokhliTC74/peCUytjApX3lVE9dbQpajr2oHeQotS6x9wWuk8i
	 aIRYv+/qwKGROLiMVzb+mPyZBOf5eSqTWEo3Jqg+81BC/rvPmmOXvXCmqY3blAzWaB
	 osDCpdkrybx6meN0WSHYjQ7UYow8zE2mAc/mSL9j6tg9GIVGf1Apmdlivn+UIwwXTf
	 4mdHh0gAZhinxSQx9YZf2SV6AerPUMvQeYxe2F+srZdxo8X0vM41won+iyrjxhY+Fp
	 x7Y2qJcdqZqqg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 14/19] vfio/pci: Add generic PCI error slot reset
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260901093217.8539-15-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-15-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:53:57 +0000
Message-Id: <20260901095357.A5D241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a slot_reset() handler for vfio-pci-core.
>=20
> Restore the saved PCI state first. The host resets the link without
> restoring config space, so on entry the BARs read as zero, and tearing
> down MSI-X before the restore would write through a stale table address
> the device no longer decodes.
>=20
> Then tear down the stale interrupt configuration, holding recovery_lock
> across it. vfio_pci_core_disable() runs the same interrupt teardown when
> the device is closed and takes no igate, relying on there being no other
> user by then. vfio_msi_set_vector_signal() frees the per-vector context
> with no atomicity between the lookup and the erase, so two callers which
> both find it free the irq, the name and the eventfd context twice.
> vfio_pci_core_prepare_close() takes recovery_lock for writing before it,
> so holding it here keeps close out.
> [ ... ]
> The handler does nothing until a later patch starts a recovery
> transaction.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D14

