Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824093;
	b=NlnSl1Yd3vLjd+PANv+kK0yvLOKAp5/eKDe3cszq9jq5cJWN6Z+ehzbSCKGwWWtGka5M
	 8dyH19oqU86TH0EQvF+NqjdUvbzWSIa+/yVA78ffI0GAXQsBQn4w4p/Yez/dB8DpoaFlU
	 V5jIZ8qfHGwD5GIGLzfgR3TWxB3jep5kfXDVeskqCzAih/u6dO4ktxDv6EHtU4/oH8X/B
	 WJcc7Vo0YwONVnm/1ICTW4xESxVHyPoImhjcsedRwXrqyyMIhKrCuyBanT9CeJAgAdt+p
	 vIwnDq5kNF6VFrxZ0bdDZ0JUPArh6TouQs83q1aIivIZZpzCy+17bqppnkWx3i4yoZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824093;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zx7vQakKRWOGssCLucv9LYE/i7UNnLfuAIv4KBHXtaI=;
	b=oiiCB/oZY5JDx4SQj/zj/KkwK6fQJDdRzphw+unWjiQuwBre+60yn7MiWUePtVMakxEH
	 FEVCuMiXIhmVINPZf+DYxN764lMzW46H0T6U9N/Pgl5OIcVjfdhHw4jMzLNiqs0VtB0IF
	 6CjDIRaAkw3BkHrHJEtkp4yExOWbHPzTs6b0vUEQ7KL0KoOlx4NYRpo8uM8SRiSru9Cvv
	 C0a53s47pst13R74Ff6qSfHmbQbyC6AJGSpJT38Iu1Rouu5hD6FThJwuk6mv3gzyBjg2H
	 mmPlX6LT4LlK1MnT0JB8/D6rp+CweFcseCxsLvT2XHQ4fSI2neqHmq91gLhdQPqxv4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=me0he0N9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77FD606D820;
	Wed,  4 Nov 2026 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=me0he0N9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124781F00919;
	Wed,  4 Nov 2026 20:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793824092;
	bh=zx7vQakKRWOGssCLucv9LYE/i7UNnLfuAIv4KBHXtaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=me0he0N92eGhML5+ab2HEKO1s3+/ThOJS1MnB0H9y8DOpOiWdVQBE/v5AWBRcvGOM
	 uwYQ24ZtPG310/i9KozHOJoDr/t/kTpm1wgpFWVfw+WPPBN40yVi9bINORseyXijMb
	 ZQjeoYFLuE5ewDfzAXkgqOO2/Z3iSm//OMXRX8IfnYmn9xGU2hcPWwQE9Hj2XwhFaM
	 FOzUOopa6PS/rjMXvBpX/kFEli7r1TTgdYcaRlSEPsfWvweSxMXqT5taSCevncfoqJ
	 tHEosM/HvX7j6GrRqhydgibAgDTLogQ8Y+8SzslTovUf8XJVIa3VzyYVx10yyc2hn2
	 f2QX6VjrrRamg==
Date: Wed, 4 Nov 2026 14:28:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Song <xinmengs@nvidia.com>
Cc: dakr@kernel.org, acourbot@nvidia.com, kvm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
	linux-pci@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com,
	yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com,
	airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, markus.probst@posteo.de,
	jhubbard@nvidia.com, apopple@nvidia.com, joelagnelf@nvidia.com,
	ecourtney@nvidia.com, cjia@nvidia.com, smitra@nvidia.com,
	kjaju@nvidia.com, alkumar@nvidia.com, ankita@nvidia.com,
	aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
	linux-kernel@vger.kernel.org, zhiwang@kernel.org, zhiw@nvidia.com,
	boqun@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
	work@onurozkan.dev, jgg@ziepe.ca, bhelgaas@google.com,
	kwilczynski@kernel.org, dri-devel@lists.freedesktop.org,
	peter@colberg.org
Subject: Re: [PATCH v5 6/9] rust: pci: add typed SR-IOV PF registration data
Message-ID: <20261104202810.GA1422371@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030171230.196717-7-xinmengs@nvidia.com>

On Fri, Oct 30, 2026 at 10:12:24AM -0700, Simon Song wrote:
> From: Zhi Wang <zhiw@nvidia.com>
> 
> Rust PF and VF drivers bind to separate PCI devices and may reside
> in different modules. A VF driver that calls PF operations needs
> typed access to the data exposed by the PF driver. This data must
> remain valid until VF driver removal completes.
> 
> Add VfRegistration to register a pinned object in the PF's private
> data. VF drivers can borrow it after checking the requested Rust
> type, using a higher-ranked closure or a covariant lifetime encoding.
> 
> Capture the core callback context in the initializer. Reject active
> VFs and an occupied registration slot before initializing the payload,
> then recheck the slot before publication in case the payload initializer
> created another registration. Publish only after all fallible work.
> 
> During registration teardown, disable SR-IOV and wait for VF remove
> callbacks to finish before clearing the pointer and dropping the object.
> 
> Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# include/linux/pci.h

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1..9b6ae544469 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -551,6 +551,13 @@ struct pci_dev {
>  	u16		ats_cap;	/* ATS Capability offset */
>  	u8		ats_stu;	/* ATS Smallest Translation Unit */
>  #endif
> +#if defined(CONFIG_PCI_IOV) && defined(CONFIG_RUST)
> +	/*
> +	 * Private data owned by the PF's Rust driver, readable by VF drivers
> +	 * through the PCI VF registration data Rust abstraction.
> +	 */
> +	void		*vf_registration_data_rust;

I assume use of vf_registration_data_rust is meant to stay
encapsulated in rust/kernel/pci.rc and rust/kernel/pci/.
