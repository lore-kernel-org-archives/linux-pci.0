Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E58195811
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779413249; cv=none; b=Zb7psNAqCU/0VBhHDyamcAVaVyioegTznZTf1zZZAA+w549+rl3+ysK/xHB/3avALK3AhxYoeBKi31Kw2Iq8WlrSgfb+plrsBTEQY5Y8Ql/31AG3DU1l6/AECfbyoH0WZA8a4pdkZW7HgRfSFYVxvvg2sGzYsp99K9JDWZeu7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779413249; c=relaxed/simple;
	bh=jpaxq2ivz3z/RB55AKGAsV5juqEyW7N/MbXg2L4dUzU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u/h0PFdFL49gcy1I58zsk5Dh1qIxlZGRVu7+0h5x3PDHc3sxfdwhBej+cDmk9xalg8ZlSDxIr17PSFYA1/z7AmNVgFNOaXeqODCbj5LysWBc3h0+0JrBg61K0f5yFN+Zc6r0yjs6MlLCpCz86FsbgNUjzsV5j6uEWr42n+WNv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKVsRev3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKVsRev3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1785D1F000E9;
	Fri, 22 May 2026 01:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779413247;
	bh=aA8+r7TCIxE35nkOfwCTjWkgI/z4/lWrRJrjVNIDvig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cKVsRev3s7roqMCg7gCS28kGusmQRhSFjKBUYkKd5OSSd2NxzzjqNLPmJg4mBUN2u
	 w/EDSZYM3lD2PzovI6qmyLNf0bI687SLx2yORYAD9ZPEdPx1Y4klplJsBD96eGAdP+
	 O5bdPHvZt/rHynTtiD3ad4vM+c9wNJYTK2BUPNc6Un1o4TSK58Pm40E+uA98N0ehOy
	 uM9azbfAeFfzAEAZBRn1Wgd/rVnJUE656pXo6RaMJ8jqBMloHRDOXEw46tKgWgzv1g
	 CN5oKNJ+SXv2ET1cITQwvC+ixGHWrJ9OmZarV/DJOjb0fGPft9JWJSKJggVSuU/8AD
	 xLDMZX+CiatuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/27] samples: rust: rust_driver_pci: use HRT
 lifetime for Bar
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260521233501.1191842-20-dakr@kernel.org>
References: <20260521233501.1191842-20-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 01:27:26 +0000
Message-Id: <20260522012727.1785D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `unbind` method signature in `SampleDriver` is incompatible wi=
th the `pci::Driver` trait, resulting in an E0053 compiler error.
--

commit 831cba69e4ec48baa461ce6291b9b8ed80543fae
Author: Danilo Krummrich <dakr@kernel.org>

samples: rust: rust_driver_pci: use HRT lifetime for Bar

This commit converts the sample driver to SampleDriver<'bound>, taking
advantage of the lifetime-parameterized Driver trait. It holds &'bound
pci::Device and pci::Bar<'bound> directly, removing PinnedDrop and runtime
revocation checks.

> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index 0353481b0690d..0ae2373d74fde 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
[ ... ]
> @@ -140,56 +138,49 @@ fn config_space(pdev: &pci::Device<Bound>) {
[ ... ]
> -    fn unbind(pdev: &pci::Device<Core<'_>>, this: Pin<&Self>) {
> -        if let Ok(bar) =3D this.bar.access(pdev.as_ref()) {
> -            // Reset pci-testdev by writing a new test index.
> -            bar.write_reg(regs::TEST::zeroed().with_index(this.index));
> -        }
> +    fn unbind<'bound>(_pdev: &'bound pci::Device<Core<'_>>, this: Pin<&'=
bound Self::Data<'bound>>) {

[Severity: High]
Does this method signature match the pci::Driver trait? The trait
implementation here uses this: Pin<&'bound Self::Data<'bound>> which imposes
a stricter lifetime constraint than the trait allows (an elided lifetime).

Will this cause an E0053 compiler error? Could we remove the explicit 'bound
lifetime on the reference inside Pin?

> +        this.bar
> +            .write_reg(regs::TEST::zeroed().with_index(this.index));
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D19
