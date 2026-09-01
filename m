Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013D31E846;
	Tue,  1 Sep 2026 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256057; cv=none; b=EfKfrvjAC8zQYT0HkhmTujeVMhQrx65FFVybBODH0nUsmRmRhOZ8H84UD74xWRQde9pKjnIi4GwFEEI9EUD5U5QvAH8ZjVEq+jugqdCwuCjg0xwFxa7CxEUppdm36lXU58BhycRwK02KrlBsfH6UqtqPBV/d+Hwm+l4hO9zfVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256057; c=relaxed/simple;
	bh=ufr0k3XOUOCZJ79uw2Wq+k45ckO6jAVwT3pyWX3PfX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uCMsfASY46NyHZPyHAJNj7Gm+WTtiYAyK05bVapSge57mQPuNn/++GQfUVBjqpabXQQ7r/+trzPSyTUyY1QHNl09/27+z+z2+mYF8olrMzq6dz8vvLp/9AVbHVbatTp6ZqdTeDvaoAOsvIPpuImeEtMmuqC9YfLkHZFlPwf8Sjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeuJAmjy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeuJAmjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915D91F000E9;
	Tue,  1 Sep 2026 09:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256055;
	bh=ufr0k3XOUOCZJ79uw2Wq+k45ckO6jAVwT3pyWX3PfX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VeuJAmjySszcejcxGGURm/NufoDlDbXzoFbcr+vn6kohEG53CuFDEvo3n8Dz1EtTE
	 6BAywJfUZu0vE35CW4zS+COS+Ljyksp4sKp4yW/fnGwSH/BuHAP5OX2DsBJkQwT5tm
	 RDFp/PnGeoWMVxaNS9mbgHjh1q3W7hQbbEzQiaVXhvyTpD0tAwUtZWzvrODlE3lvaI
	 M8VFmbs7KDkwv+eoFoNgDzs+HBtpevpQ4EoaNJ5rJe7yMWXIXak+T5qeRMf5Us1SvE
	 eYnHg3sU7KpnLMhd+0b0ydTK9TT+gZkwCFAZExMFU66mk5JzHAIOL/xhaS5v/CtmGB
	 NtttsUuYwOB3Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/19] vfio/pci: Serialize generic device lifetime
 with recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901093217.8539-3-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-3-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:47:35 +0000
Message-Id: <20260901094735.915D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> vfio_pci_core_disable() frees vconfig while holding only the vfio
> device_set mutex. The PCI error callbacks never take that one. They run
> under the PCI device_lock instead, and vfio's close path does not hold
> that. So a callback still running when close starts can walk into state
> which is being freed.
>=20
> Publish a device_open flag under recovery_lock. enable() clears it before
> it touches the device, finish_enable() sets it once vfio_config_init()
> has allocated vconfig, and prepare_close() clears it again before the
> teardown frees vconfig. All three take recovery_lock for writing, so a
> callback either gets there first and close waits for it, or it finds the
> flag clear and does nothing. The access guards added later test the same
> flag.
>=20
> recovery_lock is not held across vfio_pci_core_disable(). A later patch
> has error_detected() take it from under pci_bus_sem, and disable() gets
> to pci_reset_bus(), which takes pci_bus_sem the other way round.
>=20
> access_blocked is only ever set while device_open is set. Nothing sets it
> without testing device_open first, and close clears access_blocked before
> it clears device_open. If close left it set, nothing could clear it
> afterwards.
> The transaction which set it cannot clear it once device_open is gone,
> and every path which refuses work on a blocked device would go on
> refusing. Clear it before device_open so a lock-free reader never sees
> it set on a device which is closed.
>=20
> open() now refuses a disconnected device with -ENODEV. That is new.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D2

