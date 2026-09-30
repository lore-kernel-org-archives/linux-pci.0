Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987474DE728;
	Wed, 30 Sep 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778355; cv=none; b=UM/Yy0XrN1zDL3c1SjmxoWvgVQnpUM00xk1jEox0lWbW894RIpXYVe9joKaGW3CZVIB2zfT2gTr9/pcITjkQXzH2wE1JEtJAQV1RpUPs112c0HWmQfZsGmFW9O2vxdxf8w/aZqxEe+XbnSWQR0Kt2Qw7pf/6V7sVS6ps75exYUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778355; c=relaxed/simple;
	bh=sFTRJFqtVYKWAfrFtg2v2Y1AVLhVCYKz9iekFUdvHhA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=KqC3/64UQAclnrdzaGaS+FbgNDCDovzMFeJRgKxUf945P0iL9aRE5zqyes/4wqm398GZL1ECOoObmS1Mn4jAbs13nLskAnzC/XSfIjw/cnKSu5BXYtn84GJTQ05wSzLHiUkCbbJQ03c9ARRluHrMYqT3S7NH/Nzc2iel2R3BeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTppVOQq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTppVOQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328521F000FF;
	Wed, 30 Sep 2026 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790778343;
	bh=Jqaukmxoh+YmJmbm/EJ3OHqbjz+fE8i2VWtHgQPGwbo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=eTppVOQqzCpPEmLEytkG1MLDSXhlxypE36QFo6qp0UrfRANgPu11aWJHiaPip3kNZ
	 oU7NfPFOorpQ90KxV6rhOYt4e1tzkB4deBOJK2Wxbzu9gS8i3BE+v32nE+m7kN3kqw
	 8nMVR7aUyZclv9wkIvkruhuDPc7FffLEeVSym5ahgHLGYOwoNBrgWrlg9vLD87KtAE
	 0enOppQyziCs57SxJzp4WCqmCKukWstT/5J6K4HYxocR8cqthIg62xxl4joo6fZD+7
	 YFTKHc4ooj1UXldEIyfLypFPJX3kmxlxEmO3KnD7NPVgb9hPjXQMZ5R8nE0bghpH+Q
	 bztKY0xT9D5eA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 16:25:36 +0200
Message-Id: <DLSPXUPSF0TC.3PC9F8RTDV1IL@kernel.org>
Subject: Re: [PATCH v3 08/10] rust: pci: add SR-IOV enable and disable
 tokens
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
 <9b092d339961f744c7ded1e4f21911b66c80ecb4.1790759932.git.zhiw@nvidia.com>
In-Reply-To: <9b092d339961f744c7ded1e4f21911b66c80ecb4.1790759932.git.zhiw@nvidia.com>

On Wed Sep 30, 2026 at 12:18 PM CEST, Zhi Wang wrote:
> +pub struct SriovEnable<'callback> {

I understand why you chose 'callback, but I think just 'a is good enough.

> +    pdev: &'callback Device<device::CoreInternal<'callback>>,
> +    num_vfs: u32,

Please see patch 1.

> +}
> +
> +impl<'callback> SriovEnable<'callback> {
> +    /// Returns the number of VFs requested for this callback.
> +    pub fn num_vfs(&self) -> u32 {
> +        self.num_vfs
> +    }
> +
> +    /// Enables between one and the requested number of VFs.
> +    ///
> +    /// VF drivers can probe before this method returns, so the PF resou=
rces they access must
> +    /// already be initialized. The returned guard disables the VFs if s=
ubsequent setup fails.
> +    /// Return it from `sriov_enable()` to leave the VFs enabled on call=
back success.
> +    pub fn enable(self, num_vfs: u32) -> Result<SriovEnabled<'callback>>=
 {
> +        if num_vfs =3D=3D 0 || num_vfs > self.num_vfs {
> +            return Err(EINVAL);
> +        }
> +        let num_vfs =3D c_int::try_from(num_vfs).map_err(|_| EOVERFLOW)?=
;
> +
> +        // SAFETY: The PF's driver data and registration remain installe=
d throughout this callback.
> +        // The registration owns final VF teardown after the enable guar=
d is disarmed.
> +        if unsafe { (*self.pdev.as_raw()).vf_registration_data_rust }.is=
_null() {
> +            return Err(ENODEV);
> +        }
> +
> +        self.pdev.enable_sriov(num_vfs)?;
> +        Ok(SriovEnabled {
> +            pdev: Some(self.pdev),
> +            num_vfs,
> +        })
> +    }
> +}
> +
> +/// Enabled VFs awaiting successful completion of `sriov_enable()`.
> +pub struct SriovEnabled<'callback> {
> +    pdev: Option<&'callback Device<device::CoreInternal<'callback>>>,

This doesn't need to be an Option.

> +    num_vfs: c_int,
> +}
> +
> +impl SriovEnabled<'_> {
> +    #[expect(dead_code)]
> +    fn disarm(mut self) -> c_int {
> +        self.pdev =3D None;
> +        self.num_vfs

Instead of the Option dance, you can use ManuallyDrop to prevent the destru=
ctor
from running.

> +    }
> +}
> +
> +impl Drop for SriovEnabled<'_> {
> +    fn drop(&mut self) {
> +        if let Some(pdev) =3D self.pdev.take() {
> +            pdev.disable_sriov();
> +        }
> +    }
> +}
