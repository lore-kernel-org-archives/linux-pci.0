Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333215A86D;
	Sat, 23 May 2026 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779551215; cv=none; b=OtK8HfMXWqHeaysK3ueKmV+Zjq5afoE0j8uBoK9alCAglYm2/uZq4WU6Bf2MGRO+S6fZ5TtbTwP1SgF2WSeTOa7ofxbx0+T1OYWzFdb2vVR8crdNDl2tPYAUadSQSnMtX8D0GAq7Ycy5miM8IQI01XH9RJ7ozo1QGKjFVzG9PPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779551215; c=relaxed/simple;
	bh=nLBZR1yPNJIwvSHlyra/l/GfIWnzfGqqm1BCrTrJ6/Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=QTppHdsemlgk1lB1/FzmACV3mzvCNqQ1dGvTZXLJ94MYjyJDtMs1ARv76dt+5Hj0Vwptc9nt1RG15OinLK7ILhAUp701B5rrBInYPRssbleHoOGp0JWihCGGIx0HBMudRAj8o/2eNYLGLFpyHEfiWP6qXx6cw1+tihUFf6bSPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtGo7vjv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtGo7vjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF321F000E9;
	Sat, 23 May 2026 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779551214;
	bh=o01mZIap77JdV7lnWDWkCgBFoE4EHf5jWItgL7KxWEQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=XtGo7vjv/u2jBKRoLHA3oC9OmfZu2mVOGV/5v91LFo3aenQIJ3Cybr0FFjI67nVMk
	 rsOKWs1mXpXve5q7T/hfXdkKBYgWVqT1s9evRpWtpIRO/d3Zltm68xofkt3Wt1bVLO
	 7jJavYWoDXZxu8XNR30oIIFFxdR2KkchADzY/WPMvjqNlfN/M2a7heUiyegIGuuEDZ
	 0xFLspwBB4sdqtVmDAwEwrZr/JcayDEPbyHrjLY5NnXGo9x902lQgoa6YqcXzCVGGt
	 KRFJt1o421jQFFp3Lh9B9DfEag4cUfKMND6Kt4a3SRvOVNHtRbb3Wha0CnuBfBGbKX
	 RnfmInEnTQ2zg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 May 2026 17:46:46 +0200
Message-Id: <DIQ696JK4WV0.2HOQ57L342S77@kernel.org>
Subject: Re: [PATCH v4 21/27] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>,
 <pcolberg@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-22-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-22-dakr@kernel.org>

On Fri May 22, 2026 at 1:34 AM CEST, Danilo Krummrich wrote:
> [ Handle macro_rules! invocations in the ForLt! proc macro's covariance
>   and WF checks.
>
>   Proc macros cannot expand macro_rules! invocations, so the
>   syn::Visit-based has_lifetime() and replace_lifetime() helpers cannot
>   inspect types hidden behind macro calls. This caused the covariance
>   proof to be silently skipped and lifetime substitution to fail for
>   such types.
>
>   Add an explicit Type::Macro arm to Prover::prove to conservatively
>   require a compiler-assisted covariance proof. Detect macro-containing
>   types with has_macro() and use a WithLt trait projection for lifetime
>   substitution instead of AST-level replacement. - Danilo ]

I was made aware by Gary that WFness is not actually being checked, which i=
s why
the static expansion was needed in the first place.

Thus macros will remain unsupported (even covariant macros are rejected), y=
et we
can improve the error message by adding the following diff on top of the
previous v3 patch.

diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
index df2027789713..75d0ce450bf0 100644
--- a/rust/macros/for_lt.rs
+++ b/rust/macros/for_lt.rs
@@ -107,6 +107,12 @@ fn visit_lifetime(&mut self, lifetime: &Lifetime) {
                     self.1 =3D true;
                 }
             }
+
+            // Macro invocations are opaque; conservatively assume they ma=
y
+            // reference the lifetime.
+            fn visit_macro(&mut self, _: &syn::Macro) {
+                self.1 =3D true;
+            }
         }

         let mut visitor =3D HasLifetime(lt, false);

