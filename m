Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EDF470EA8;
	Tue,  1 Sep 2026 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255981; cv=none; b=iidYw60R+cBzKMYJbZgAb5OUxicd4M7BuAxqrSDb4w8YFiiGkvjDzlvyDWMs3nEuQa9nFRYG8AtL2H9PQHhFuoHIHz4JkiAn7daGG9vM2AJ1jBqxwLTFgvEhxG4DdxwKbHAsNNrQ1c4Yqg8DFmMoWCt83NUKmrZtC9orGIdylYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255981; c=relaxed/simple;
	bh=MNDvjwNjtFV4OvCr4CAGheu33UIycLSRCz4pbCT3npQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mVsjr+ocXqcZClYk53UmcPEqSauioxc5Xt5VNCRt8/lUly3baqDxXHNYL/HzKKUN8KRfLIcqAMuA18+0lu3kJfBCBFnBXrt7ju+2zfCQW97D7YMnILlM1ovcsvBqU+ZGvrjkuLsvtbrDvKGmjYJXevHgjR2VGWb9Gf/8tN18iK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP09eZQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP09eZQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B155E1F000E9;
	Tue,  1 Sep 2026 09:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788255979;
	bh=MNDvjwNjtFV4OvCr4CAGheu33UIycLSRCz4pbCT3npQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LP09eZQhWxo0DKGJN8XwYpsRhocnAYFqP+X/8gdeJAw4oxGZO96XJVrMzQWvwbTUY
	 yp7+Sm6nyLfDIJebMm9W1bl6AnhsdzFoEiYIibw9uJdMG8EVi5P/vmlgCuUM4Uawpv
	 e0FmRiDIsEKvVIT3Qv7imbjOiT2Z4BtB6uT/CPPkM75yoAuPKIEPoaAr8ebBmh6z3E
	 7cVd14BtupOXyUsi61RMCDcKSxsdAqnbpxnw0dr6eVXYy9iFQ+7m61d6AKxWsz35c2
	 VHwzO/hLqopM8C/iqSGbyQyqk/+RRVuvVoucZG0RXEifNV0RPIM+6Apa54FQ8SiZph
	 0qNWBeOBtLehg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 05/19] vfio/pci: Serialize config access with
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901093217.8539-6-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-6-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:46:19 +0000
Message-Id: <20260901094619.B155E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Hold recovery_lock for reading across each config space operation, so
> recovery can shut out new ones and wait for whatever is already running.
> The user copies stay outside the lock, since a copy can fault.
>=20
> Take the lock in the dispatcher rather than around the individual
> hardware accessors. That means once recovery blocks access every config
> read fails with -EIO, even a read served entirely from vconfig which
> never touches the device. Userspace which wants to know what is going on
> reads the device feature instead. That one stays available during an
> event.
>=20
> The PCIe and AF capability writes no longer reset the device themselves,
> and the power management write no longer moves it to D0 itself. They
> record what was asked for and the dispatcher does it after dropping
> recovery_lock. Both take pci_bus_sem, which AER already holds when it
> calls into the driver, so doing either inside the lock would be the wrong
> order. A reset method reaches it directly, and a D0 transition reaches it
> through pci_set_full_power_state() calling
> pcie_aspm_pm_state_change(). The lower power states take neither, so
> those still run in the writefn. The writefn declaration says so.
>=20
> Both stay best effort, as the guest requested FLR always was. The result
> is not reported back through the config write. With recovery enabled they
> are dropped while a recovery or reset is already in flight, since that
> leaves the device in D0 and reset anyway. The reset helper tests the
> recovery state for itself. The power up does not, so the dispatcher
> tests it before that one.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D5

