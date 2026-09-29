Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF345452A0;
	Tue, 29 Sep 2026 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704083; cv=none; b=u3+hVbueUR+ibxSdtimmTypGFvU32/Yiv+Dnc5mcCylBGm2Gjb/9nozFT21Dx0204hJEP/GL1BLqVU+I2G73DdtFjVket+9T2MgPJ2+Z7yCHuudIQmpj2EGTGRE4Z1CIi9sSy1BqNkYQM7W6NfjPwQiBAzao5SMeGHzX1nAPjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704083; c=relaxed/simple;
	bh=UuDeCmMw78Qv4rSiGwPjv0k9jBX8Z2yxZ6VEu6nCKaM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZEIBgfEAfbLYLCuv9k33rIOlrZeoye3hVMe3MNZLknmIPC1lf2EJvvFaTlEDn8P5uPykNAOKTvb43IbllXUtcM+v7Y9bthVQzoNQQ2+hGrzHUJw2hMPI98NQImSWfqOI1UdzzxOIQC2ldYu3uiCdS/5WTm8PJUubHlYBP+bkK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1mHYFhE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1mHYFhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6F11F00893;
	Tue, 29 Sep 2026 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704081;
	bh=UuDeCmMw78Qv4rSiGwPjv0k9jBX8Z2yxZ6VEu6nCKaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W1mHYFhEabUPpsdWkib9+s4IwABdMGxdfkq9BEapjGWWI/W7L2Jp+rBhOyyT15VbI
	 /DoqN57gyBO67E4UFik0JkwbOyjgK4Po5gzi4y5z6nsLqvM+0UiPxFu1yh7OmjewRM
	 irPU+zyS3WttpcFhdcIlfJWYjm7XiyhHLpyy8ErrgsRcZ1ECghqV6nlojpb/cfH01c
	 LGXaHQgTwORu57JU8h3b7ih2rEgajtSqkk4578BpeZmOVfBScHmb4+Q3dlvmBCRVu5
	 bW3j03uhb1un831DeqkinYdvBCbFeI6Vn/B+AX4DktP9s5kuld92A0TKCH58DoKvha
	 OV4VJskZsvvWQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 07/16] vfio/pci: Gate function reset and runtime
 power management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260929173305.204856-8-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-8-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:48:01 +0000
Message-Id: <20260929174801.BA6F11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Reject function reset and low-power entry or exit while device access is
> blocked. Hold access_srcu across reset and runtime power-management
> updates so recovery waits for admitted operations to finish.
>=20
> Perform the reset ioctl's D0 transition before taking SRCU, preserving
> VFIO's pm_save handling. Keep memory_lock held across D0 preparation and
> reset so a concurrent guest D3 write cannot intervene. Check the blocked
> state before D0 and check SRCU admission afterward. A rejected reset does
> not queue a deferred D0 request.
>=20
> The reset uses pci_try_reset_function(), which returns -EAGAIN if AER
> holds device_lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D7

