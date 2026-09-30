Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD94B4031;
	Wed, 30 Sep 2026 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766816; cv=none; b=j3dtPLOrsCoFJ3db/hZnmj0h4Fg5ew+kQIhxEwNukcX9dT7XoVgMs1DimLDD5OFNegNIB6wF7+Ty1mimQGhUPz1aqvcfhUvXu0WOGU/jn/vtBBwKCgmOa41ArLiIuOXT6WOPcOTc2iXzP1xnnupmUoIxtQ+IiQJuDwtbsHo0eb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766816; c=relaxed/simple;
	bh=QEM39wlCCg0lvt3nB55HRNjsjsbcQcl20N7cPW6NAug=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=a+XfidJTFnKaNMRG8FcLcusNTJJaVshgoSbaXBOFAUCTUzwieJfCOZ69SeiIRWVqvolvhd/pDTzbLxOeZ+D/AosTZu4bFwW6YL00toTBSRT2MTum602OtNlOg8h2wiRcVgPxwfxw5EGjwycmclZxM5zPDVpIhDC1jMShtg72gLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7qo5ffp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7qo5ffp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C1E1F000FF;
	Wed, 30 Sep 2026 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766812;
	bh=jW2HwPUTyH+T8DgW2QqCZduqxGErq/+WJc1xQpFDJ1A=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=L7qo5ffp0c5uKB9Y6kl8uVHMdu59IaAFEAmtC9zlR4EEn8zv04bL2qykM+fXjt413
	 /+ckREgJ1F5DZMwajN37O92sppzQYAPZReFxX89YbQtum5x6KHxigoisqrpmuvNYcH
	 8GPcJkKiHckq/RPX5YGnZfvOZSeu+iBDBwxp0+wxlo3k92bXBtzudnA38qag+iUtFw
	 0vWZT4PmSobqqSthIIGeGsUaAC2H12l4/Cwc99rcBLFwJiHrosKZCtqJDV7qrweBi0
	 WbgGHxdUY8uwYh2oKdrat9S1t0rzuxP4Bce++3myEHyZCUwVTjh1i6qWFmBxyH3Lu1
	 5AifSBvT+DwIw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 13:13:25 +0200
Message-Id: <DLSLUPDXOA11.VWE3XT1CRSRQ@kernel.org>
Subject: Re: [PATCH v3 05/10] rust: pci: add num_vf(), to return number of
 VFs
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <jgg@nvidia.com>, <alex@shazbot.org>, "Peter Colberg" <peter@colberg.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <c65da1c1437da6a543720b1e04e977a665ae2de7.1790759932.git.zhiw@nvidia.com>
In-Reply-To: <c65da1c1437da6a543720b1e04e977a665ae2de7.1790759932.git.zhiw@nvidia.com>

On Wed Sep 30, 2026 at 12:18 PM CEST, Zhi Wang wrote:
> +impl Device<device::Core<'_>> {
> +    /// Returns the number of Virtual Functions (VF) enabled for a Physi=
cal Function (PF).
> +    pub fn num_vf(&self) -> i32 {

For the reasons mentioned in patch 1, I'd make this return u16.

I suggest to do the converstion with .try_into().expect("pdev->sriov->num_V=
Fs is u16").

> +        // SAFETY: `self.as_raw()` is valid and this call runs in the PC=
I core callback context.
> +        unsafe { bindings::pci_num_vf(self.as_raw()) }
> +    }
> +}
