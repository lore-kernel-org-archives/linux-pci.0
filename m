Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64AA47CA86;
	Thu, 13 Aug 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629409; cv=none; b=ONSdgDxiRgiY+hm6+HDBtGx6axExysqOWX5xs2zLP/5UoXJXc7khDwa8FXEV+PMEjA4QGy7Ie0S3QQY2Q636BHhcxyTfoUOb/KMnWqmWyCO1m9qvLNmHBHTQRIgGMTRby8Rla3TNSeKmEe4euWvHjswuImbory+Ig9Tn8eJdfCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629409; c=relaxed/simple;
	bh=4NTvo1YFeTFWJGrkSPZloLOnkvvJCJj29bVO4WH0AKg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=uIqT80psKMDYTJLO+4gOYHvEmTaNAl5e6Pu5sqRz52KBtPLZ4nhE5N2ZZxsyK/cVDq4U5GCMnAaw1/tyPDVxkM0chpoP8jHIq2l3iWt7yJzxja22iyadDkV9mchgeELLz120xY+pGi+P1jEZCqJiLUu6Hax6d102LkbvFmMtLVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtchCZVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtchCZVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC021F000E9;
	Thu, 13 Aug 2026 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629408;
	bh=OuU7BugDOrt5R31Fei9C/BxxP6AqiQ8z1kNXhFCE+Cw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=HtchCZVNvYtFYjMsimvAiujmVgMrDOEQyde7CfWgSRpCOVrZi9kiCyavedT63DJhS
	 bZFD5h1d5PQ+z90BkfohXZHEuoqnCcvxlIwjFPcu80dYfF4lnWJRS42dIK0kym0ZhD
	 +wHPYCNC/tBUwDJsRPtoMDPUlohqv/jZfaCWZ1RaP1HV2PgIcedpcVvhjhRhOEIg47
	 gANrKC+Jw6SurF1A2Vabi5Y59+U0BAkTkC8TqvqeHW65XVYwi3Re5bygiwvTEVs12s
	 k4o/wMnMJVGemsxltlwnB7bs7gePojCOiD5LXHjy93MRtHMOn6aZ02mESHiA08UyNF
	 7GqHw5G0cUXKA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 15:56:41 +0200
Message-Id: <DKNV9K3TXIU5.2F2Q4B3HHRHOZ@kernel.org>
Subject: Re: [PATCH v7 1/1] rust: pci: add extended capability and SR-IOV
 support
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260804161612.776752-1-zhiw@nvidia.com>
 <20260804161612.776752-2-zhiw@nvidia.com>
In-Reply-To: <20260804161612.776752-2-zhiw@nvidia.com>

On Tue Aug 4, 2026 at 6:16 PM CEST, Zhi Wang wrote:
> +/// Number of VF BAR register slots in an SR-IOV capability.
> +// CAST: `PCI_SRIOV_NUM_BARS` is 6, which fits in `usize`.

I think the more relevant point is that it is a constant coming from the PC=
Ie
spec. (Plus, more SR-IOV BARs than addressable bytes wouldn't make a lot of
sense anyway. :)

> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
> +
> +/// PCI extended capability IDs.
> +#[repr(u16)]
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub enum ExtCapId {
> +    /// Single Root I/O Virtualization.
> +    // CAST: `PCI_EXT_CAP_ID_SRIOV` is `0x10`, which fits in `u16`.

Same here, I'd mention that it is a constant from the spec.

> +    Sriov =3D bindings::PCI_EXT_CAP_ID_SRIOV as u16,
> +}

[...]

> +impl<'a> ConfigSpace<'a, Extended> {
> +    /// Finds and projects an extended capability into its typed registe=
r layout.
> +    ///
> +    /// Returns [`None`] if the device does not implement the capability=
.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// use kernel::pci;
> +    ///
> +    /// fn probe_sriov(
> +    ///     pdev: &pci::Device<kernel::device::Bound>,
> +    /// ) -> Result<(), kernel::error::Error> {

Just Result; please also import kernel::device::Bound for readability.

io_read!() should be imported from kernel::io::.

> +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap offse=
t).
> +#[repr(C)]
> +#[derive(FromBytes, IntoBytes)]
> +pub struct ExtSriovRegs {
> +    /// Extended capability header.
> +    pub header: u32,
> +    /// SR-IOV capabilities.
> +    pub cap: u32,
> +    /// SR-IOV control.
> +    pub ctrl: u16,
> +    /// SR-IOV status.
> +    pub status: u16,

This is not a raw value, but a bitfield and should be represented as such (=
might
be true for some other fields as well).

I think for this to work it needs Gary's recent I/O series though; I can me=
rge
both together next cycle and share with drm-rust.

> +    /// Initial VFs.
> +    pub initial_vfs: u16,
> +    /// Total VFs.
> +    pub total_vfs: u16,
> +    /// Number of VFs.
> +    pub num_vfs: u16,
> +    /// Function dependency link.
> +    pub func_dep_link: u8,
> +    _reserved_0: u8,
> +    /// First VF offset.
> +    pub vf_offset: u16,
> +    /// VF stride.
> +    pub vf_stride: u16,
> +    _reserved_1: u16,
> +    /// VF device ID.
> +    pub vf_device_id: u16,
> +    /// Supported page sizes.
> +    pub supported_page_sizes: u32,
> +    /// System page size.
> +    pub system_page_size: u32,
> +    /// VF BARs (BAR0=E2=80=93BAR5).
> +    pub vf_bar: [u32; NUM_VF_BARS],
> +    /// VF migration state array offset.
> +    pub migration_state: u32,
> +}
