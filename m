Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223644772A5;
	Tue,  1 Sep 2026 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256572; cv=none; b=p7xE673tlgWnW9pnN3zDarirsB93DKuROX+9MrPyONYCtYT8AyoE6kVFqInHFGPiSsp1J26WYvUY/+2Kpb5S+PtKiwVPRKLtnNAMcxW81UdLXmHU+o17fjzg83NxEOCkCUP6LrrY4MbpJb6kiqJ01ZqmahW/79XSZzin0y76eHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256572; c=relaxed/simple;
	bh=O01/i0FOtcWR5vlYuQ3arLu3rjhvrUtH2P4I62qUNzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L5h6nEuwg6Q9avdIKK+jGlC7h0kI2LoUSS17N2lfU8elQKF98oaNOylSlm7ucvmf9wLYzOqUXoqvVoH7KVC9ARsg0en6DZPes6xFr6KftZ0O0EAVSPoEcDazkC/x4zGXXm9MrwHttKdnE1W90mJR7IV0pr46zyRaZgP7D0+Z5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4diq/AK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4diq/AK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826851F000E9;
	Tue,  1 Sep 2026 09:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256570;
	bh=O01/i0FOtcWR5vlYuQ3arLu3rjhvrUtH2P4I62qUNzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B4diq/AKdGTbKvTL6KXE0OTHHf6JRgSxotO/YsopDKMCTV6jfrCLV+XpU9EhmF95b
	 JX2jKjAFGbkTushKeAOn4+wdoHG2Mu/cz4xb4THgJT9FUsAbOvqbFX9lBbWtdBIBTa
	 prFsib32fF36nJz64r9QqAY8kw9/QQOgKjaKE3OmxNnpg93U4Z3uUzmmmdswaa7TBE
	 Wkxxc1pNSaw80XV3bPeAvzJ59LJUaXLNDXJtAtxn42lkXETz1Sx9ZPMe/D5ozOLsO1
	 GIN1my4Ak5GqPboi/BM3Gi0zQQS6pqL5lhnd0Ws0lup36vH7e8Xll0/iqDHXi/z4an
	 mfAHiQywnFwoA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 19/19] vfio/pci: Expose and enable host PCI error
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260901093217.8539-20-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-20-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:56:10 +0000
Message-Id: <20260901095610.826851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a VFIO device feature that reports whether host PCI recovery is
> enabled, whether recovery is in progress, whether the channel was frozen,
> whether the host reset the device, and whether recovery failed. A sequence
> number lets userspace distinguish events.
>=20
> Installing a dedicated recovery eventfd enables recovery. The eventfd is
> additional to VFIO_PCI_ERR_IRQ_INDEX, which keeps reporting errors as it
> does today either way. Recovery can be disabled only when not in progress
> and before terminal failure. Reject both enable and disable while device
> access is blocked so feature changes cannot race lifecycle teardown or an
> explicit reset.
>=20
> Clear the sequence number and the status bits whichever way the feature is
> being changed, so a sequence number always describes an event the eventfd
> holding it was notified of. A user which replaces the eventfd would
> otherwise read status for an event it never heard about.
>=20
> Variant drivers return -ENOTTY as they do not advertise recovery support.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D19

