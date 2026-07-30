Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A831A37FF5A
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436762; cv=none; b=V3RHq80DvOykul1q0GrZed6U9EdSlC1BNsAlMJ7q0fpXwUKibmc0W7TSC5UXjyd3ch+qVvtWIz8hEMm6Q7DuYcsE/hyY3O5xk0zluv77QiCJ4+sEGALCu3TO+s9yeorJPOJlcs0VmfGmdTNwRhIieq4mdRDSfrnOTG8gLOprOkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436762; c=relaxed/simple;
	bh=y3MRoYUjl+4l4YnPdhklAG4TGK9bW8uLtp8nSQ7p4Bc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VOBZ5ko5bOHlY/EKmuYOHwg+gjt/6WukSonzFN9JZ9b6jLSvmjkPA5/5AHytoOUT7xMRm5JdAm6CJbWKeVeiFpEPY92c+CBVlmmazGE8aj5YRfLR5KJsqehxyWEHb9b4Pj5xJ4evmbqHw6eTECyjtgWPHM3phMoIkuI/hpFjKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ5fIE6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ5fIE6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00061F000E9;
	Thu, 30 Jul 2026 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785436753;
	bh=T7t2qbAELIQlhhMy8VuMVkkH4UXE0mj+uSFUBq3ElWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OQ5fIE6f6b9YzglkzyPjZxGEiZiAskBsSksu+Chi0b46h6AAopzPr4yxNuSNuwn1v
	 YaL3sHFdE7e2nxU2wcSgpHrhFdQss409FQeWQPPi0aOqjp5+APsvKoUnVUQCwaNt9R
	 SXlv/vKir2w6AR0QtM5CUGVyN3KzpsmOx6myFN6Cp3AvURtZ/UfYEbdsr03RNpRHCT
	 ldltBkBuHI8Wkj+biS32cI5CvIjYQw1ZIXVhyYmAI/2LYDUyxPSQoLkrVeKk19Ivty
	 JmS+l89PbCRuMT/tKXWo1NTjErzHooUSdurc7CdRmHLQpD6uE7zuuvNWqJry3CswJ4
	 2reeIdLb2I2ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/1] rust: pci: add extended capability and SR-IOV
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260730182954.783568-2-zhiw@nvidia.com>
References: <20260730182954.783568-1-zhiw@nvidia.com>
 <20260730182954.783568-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 18:39:13 +0000
Message-Id: <20260730183913.B00061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing `#[inline]` attribute on the `ExtCapId::as_raw` abstraction=
 function.
--

--- Patch [1]: [PATCH v6 1/1] rust: pci: add extended capability and SR-IOV=
 support ---
commit 69f27ed67b8e8dbe83e8e431269f12c739076818
Author: Zhi Wang <zhiw@nvidia.com>
Subject: rust: pci: add extended capability and SR-IOV support

This commit adds support for locating and projecting PCIe extended capabili=
ties
in the Rust PCI abstraction. It defines a typed layout for the SR-IOV exten=
ded
capability and adds helpers to decode VF BARs.

Link: https://lore.kernel.org/rust-for-linux/20260730180349.771719-1-zhiw@n=
vidia.com/

> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
> new file mode 100644
> index 0000000000000..08c044bedb706
> --- /dev/null
> +++ b/rust/kernel/pci/cap.rs

[ ... ]

> +/// PCI extended capability IDs.
> +#[repr(u16)]
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub enum ExtCapId {
> +    /// Single Root I/O Virtualization.
> +    // CAST: `PCI_EXT_CAP_ID_SRIOV` is `0x10`, which fits in `u16`.
> +    Sriov =3D bindings::PCI_EXT_CAP_ID_SRIOV as u16,
> +}
> +
> +impl ExtCapId {
> +    fn as_raw(self) -> u16 {
> +        self as u16
> +    }
> +}

[Severity: Low]
This isn't a bug, but should this function be annotated with #[inline]?

The Rust subsystem guidelines specify that small functions or functions
forwarding to a binding call within abstractions should be annotated with
#[inline].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730182954.7835=
68-2-zhiw@nvidia.com?part=3D1
