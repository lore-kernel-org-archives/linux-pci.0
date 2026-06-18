Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CE7381AF1
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773511; cv=none; b=k5rE4lRQs2n+ZVXn1ynUVWB+FsTUmcc0tXdbRbTu3vmiI9lXxypc69FEUhOtV782tcWQK2YSwz86RhyTXma12ghSRvhjtnbsRsln62T/PX482J140/2R+gAegBrBp18l4W6UW1HArRqTCOv+/EwyWbZpYs7jqEPiiFLWLpqR8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773511; c=relaxed/simple;
	bh=4/PNZH+N8f+A3KbhXS0MPaDs2fRN2vS12JxtF2sh/jQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JB+kpV7J2B/VUk+r2UgNTSStkYAv5Hfy4fkKEuIC2vP7Of7aC9c7UFVOSJPVKhmsfHIZxQ5wEdj0BCSGHp7VaLfI22TGH0lscwkkZ9IZju9tnxMUz9cLYI+mhZDSMjQ/WkGVaxto4eI9hQVHyERWR5jE71Sta3jISczXqsJbemE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iR2IBofM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iR2IBofM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896AE1F000E9;
	Thu, 18 Jun 2026 09:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781773509;
	bh=MLoABPZvXTHt+nDtdMsBoY9FjLAGPHkx9IoXQgwiejc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iR2IBofMSEeW0bUtC4/Cn78uazgLBVT+ghHEV+cU3QCKqSVmpzD8MS/t9mTVpQkpm
	 Nva1RAwUlZulT3rmhUS3nrbfOGMvlIjn3NT0l0z+lfYpH2ZDxeVKTmenDXj0x2NTCk
	 nMOp+qlu7UjHsqLkhk4zutQLOmlf2rsg+TVab3VskTSYbPXJAssuAmTRBS5VAYaGNs
	 7vhO1BqGl9Lh/RXJC0NXP9gVg9ldiUs7iyjW2Ob9UmXU0kQtsAcennJMZ4oRdTnj8v
	 xtu9XcV5Ac/crt2+d+OGZwIMiOj9QXMLroczElx5n4oeim49AeWeZyJBn1KRpBHqxO
	 4S2xOREOLL7VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_core: Add reset_type parameter to
 hdev->reset() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chandrashekar Devegowda" <chandrashekar.devegowda@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260618085016.9173-1-chandrashekar.devegowda@intel.com>
References: <20260618085016.9173-1-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 09:05:09 +0000
Message-Id: <20260618090509.896AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] UAPI Breakage: Redefining '1' to mean 'deeper reset' breaks existi=
ng userspace scripts.

Pre-existing issues:
- [High] Data Race: Unguarded write to `dev_data->reset_type` in `btintel_p=
cie_hw_error()` clobbers concurrent sysfs resets.
- [High] TOCTOU Race Condition: Concurrent driver unbind causes NULL pointe=
r dereference in `reset_store()`.
--

commit 4b14894786f1236a0de480b4c65121356669aba4
Author: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

Bluetooth: hci_core: Add reset_type parameter to hdev->reset() callback

Add a u8 reset_type parameter to the hdev->reset() callback to allow
userspace to select the reset level via sysfs. Each driver interprets
the level according to its own capabilities.

> diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentati=
on/ABI/stable/sysfs-class-bluetooth
> index 36be024711747..fb445e20f9726 100644
> --- a/Documentation/ABI/stable/sysfs-class-bluetooth
> +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> @@ -3,7 +3,14 @@ Date:		14-Jan-2025
>  KernelVersion:	6.13
>  Contact:	linux-bluetooth@vger.kernel.org
>  Description: 	This write-only attribute allows users to trigger the vend=
or reset
> -		method on the Bluetooth device when arbitrary data is written.
> +		method on the Bluetooth device. The value written selects the
> +		reset level. Each driver interprets the level according to its
> +		own capabilities:
> +
> +		  - 0: default reset
> +		  - 1: deeper reset
> +
> +		Writing any value other than 1 defaults to level 0.

[Severity: High]
Will redefining 1 to mean a deeper reset break existing userspace scripts?=
=20

Historically, the reset sysfs attribute triggered the default reset when
arbitrary data was written, and in the Linux ecosystem, userspace typically
writes 1 to trigger boolean actions.

If existing scripts use echo 1 > reset, wouldn't they unknowingly trigger a
much more disruptive reset than before? Could we map 1 to the default reset
and use a distinct value (e.g., 2) for the deeper reset to maintain backward
compatibility?

[ ... ]

> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 9e39327dc1fe2..d3a03cf964216 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
[ ... ]
> @@ -2729,7 +2735,7 @@ static void btintel_pcie_hw_error(struct hci_dev *h=
dev, u8 code)
>  		return;
>  	}
>  	btintel_pcie_inc_recovery_count(pdev, &hdev->dev);
> -	btintel_pcie_reset(hdev);
> +	btintel_pcie_reset(hdev, (code =3D=3D 0x13) ? 1 : 0);
>  }

[Severity: High]
This is a pre-existing issue, but does the unguarded write to
dev_data->reset_type earlier in btintel_pcie_hw_error() cause a data race?

While this patch updates btintel_pcie_reset() to safely assign the reset
type under the BTINTEL_PCIE_RECOVERY_IN_PROGRESS bitlock,
btintel_pcie_hw_error() still directly modifies dev_data->reset_type
without holding any structural locks or exclusion bits.

If a sysfs reset (FLR) is concurrently triggered and acquires the bitlock,
could this unguarded write in btintel_pcie_hw_error() silently overwrite the
pending reset type to PLDR, causing the asynchronously scheduled reset work
to read the corrupted type and perform the wrong level of reset?

[ ... ]

> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 8957ce7c21b76..a4fe329158cf7 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -97,8 +97,14 @@ static ssize_t reset_store(struct device *dev, struct =
device_attribute *attr,
>  {
>  	struct hci_dev *hdev =3D to_hci_dev(dev);
> =20
> -	if (hdev->reset)
> -		hdev->reset(hdev);
> +	if (hdev->reset) {
> +		int val;
> +
> +		if (kstrtoint(buf, 10, &val) || val !=3D 1)
> +			hdev->reset(hdev, 0);
> +		else
> +			hdev->reset(hdev, 1);
> +	}
> =20
>  	return count;
>  }

[Severity: High]
This is a pre-existing issue, but does checking hdev->reset and then calling
it after kstrtoint() introduce a TOCTOU race condition?

Because kstrtoint() is an external function call, it acts as a compiler
barrier, forcing the compiler to reload hdev->reset from memory before
invoking it as a function pointer.

If a concurrent teardown path sets hdev->reset =3D NULL between the check a=
nd
the execution, could reset_store() dereference a NULL pointer and crash the
kernel? While a smaller race window existed before, this patch significantly
widens it by inserting the kstrtoint() call. Should the function pointer be
cached in a local variable before the NULL check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618085016.9173=
-1-chandrashekar.devegowda@intel.com?part=3D1
