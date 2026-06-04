Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086647F2C6;
	Thu,  4 Jun 2026 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581265; cv=none; b=r9LFhiDFdSmzjVd3y9vhFFWNaN88qwBHu6oydt8tcZJKRCpRMEMz7LMcwIRTo2VWhp44v3Sxg86fa8QwOdoZAYuQKAKnMcGHpMLhCjB6tvmB2TqwphrRuAuxySnbilsDnj/yScvq1Zbg0xXwvhM70PVjCrttfzlc0DC0dS4Yfaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581265; c=relaxed/simple;
	bh=IzUMgWYk9dSwwtoywu6VDh6y92FMyGyxrMWD+unNGck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IuWBSL6O2thNRT3ATUKeiLIIXse1XQAewEjvlldt022cu69NTA6u4zONTCtjHa0nqzDglaXcxm05WJRdYKzu22/RXkWGiZjj+7w/+Heb8iGrP+Dpg7xgqZWJbaby2pq48cyecSYi1dy3nlXESh0GiEg7Ve0xyqn7lL6vJ/tb/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaC6Dg5e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaC6Dg5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750F21F0089A;
	Thu,  4 Jun 2026 13:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581264;
	bh=KpdwwRLPPcJiI4tEi9pb2m/BW2dQFgSRJYHF8ZMh9ZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IaC6Dg5elxbn3KsRQ9bKhyXFQeAo3C9t/adGiAu1p9P6JVrivvb0SNRY+qvjp8DDw
	 CEr3yojKCYHyenSATXNjZlzu3kJl91E07lVtOMnBWkutm1OueFN2xbZh/drVzIpCnB
	 Ab/riC19K05KgpEBltdHQVyu3E+G1r8cDWqELB4Yr4h0AlpMD//WmP5Go67a+3Avb/
	 I8NZML3ARLEbEqWfVxyx4fproKK1HzhlzG1DWtVOdvpwBPWHgqkWldZxjy4BCdKoyx
	 EmXBPtjk7RUJZbEFisXVdF4yhtZm2xfzduDMD+y0VT3PzP2L8AOiKrqN0xS+TaxqC6
	 wpdT06pBG80SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 09/12] vfio/pci: Add TPH_ENABLE feature skeleton and
 unsafe module parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260604132804.28678-10-fengchengwen@huawei.com>
References: <20260604132804.28678-10-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 13:54:24 +0000
Message-Id: <20260604135424.750F21F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Lockless modification of the `tph_permit` bitfield causes a C11 da=
ta race with adjacent bitfields, potentially corrupting device state.
- [Medium] The `tph_permit` flag is not cleared when the device is closed, =
leaking the enabled state to subsequent users of the device.
--

commit d0a7c28453cdbf1699133633ce00cd13507a2648
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add TPH_ENABLE feature skeleton and unsafe module parameter

This commit introduces the framework for PCIe TPH (Transaction Processing
Hints) support in VFIO. It adds a global enable_unsafe_tph module parameter
and a new VFIO_DEVICE_FEATURE_TPH_ENABLE uapi to allow userspace to set a
per-device tph_permit flag.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 3f8d093aacf8a..ae05343701f76 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -1516,6 +1517,24 @@ static int vfio_pci_core_feature_token(struct vfio=
_pci_core_device *vdev,
>  	return 0;
>  }
> =20
> +static int vfio_pci_core_feature_tph_enable(struct vfio_pci_core_device =
*vdev,
> +					    u32 flags, size_t argsz)
> +{
> +	int ret;
> +
> +	if (!enable_unsafe_tph)
> +		return -EOPNOTSUPP;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, 0);
> +	if (ret <=3D 0)
> +		return ret;
> +
> +	if (!vdev->tph_permit)
> +		vdev->tph_permit =3D 1;

[Severity: High]
Does setting this bitfield without a lock cause a read-modify-write data
race with adjacent bitfields?

Looking at struct vfio_pci_core_device, tph_permit shares the same memory
word as pm_intx_masked and pm_runtime_engaged. Since C compilers implement
bitfield assignments via read-modify-write operations, could a concurrent
lockless update here overwrite a state change made elsewhere?

For example, vfio_pci_core_runtime_suspend() updates vdev->pm_intx_masked
without holding any locks. If the ioctl and runtime PM suspend execute
concurrently, it seems one could overwrite the other's state change, which
could cause the kernel to fail to unmask INTx interrupts during resume.

[Severity: Medium]
Is there a mechanism to clear this flag when the device is closed?

Because struct vfio_pci_core_device is tied to the PCI device lifetime and
is not reallocated between sessions, it appears a subsequent user opening
the device will inherit tph_permit =3D 1.

While hardware state might be cleaned up on close in functions like
vfio_pci_core_disable() or vfio_pci_tph_deinit(), could failing to clear
vdev->tph_permit bypass the userspace opt-in requirement for future session=
s,
allowing a VMM that never called VFIO_DEVICE_FEATURE_TPH_ENABLE to configure
ST tables?

> +
> +	return 0;
> +}
> +
>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  				void __user *arg, size_t argsz)
>  {

[ ... ]

> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 2ebba746c18f7..5f32830766a0f 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h

[ ... ]

> @@ -127,6 +127,7 @@ struct vfio_pci_core_device {
>  	bool			needs_pm_restore:1;
>  	bool			pm_intx_masked:1;
>  	bool			pm_runtime_engaged:1;
> +	bool			tph_permit:1;
>  	struct pci_saved_state	*pci_saved_state;
>  	struct pci_saved_state	*pm_save;
>  	int			ioeventfds_nr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604132804.2867=
8-1-fengchengwen@huawei.com?part=3D9
