Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101D27B343;
	Wed,  9 Sep 2026 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914768; cv=none; b=sxG1LqVM9sbrIEAfGrKuZX+/FG41prsRtczfWaLcCzXBGa57bevzyVig8LFX4qjh2Rj4yMPIHlo+UB8Dyqo56Dfs3eyd01jkOGrXVjp9a8RY0Dr4tqP6zIdpsZq68ebOP6MMjVFsuoqSdwIOtGutC72PN+pXEuaR4y20ArxgJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914768; c=relaxed/simple;
	bh=3csRxgHY1NRFTt3T4JJQmfXtqTsExOkj5g+KJj2MDoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjnwUGkthHC/qAix5+hXZMJtbDIGsV3VEcXUQODgxGN14Z3xRH5SXcmdrQkuoBjeXsSuP1GPOHJTYdnVFijwvWgLl5fTuILSdzkz7eeMp6bGQp7E8qTj1IR8xxjDWih+O1Fqhc/yMPyQ791DoHX5Aydfr1sOzfperOfjWJm2Lz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7Gvqoxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7Gvqoxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FC61F00A3A;
	Wed,  9 Sep 2026 00:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914767;
	bh=WbKWTKTHy2GBCP0gRslnxrAt/ZfFqNFahM0EIwRKWxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f7Gvqoxt7MdJ/P4ggsIgBPpBkoT4muq9S7g8kZDbcsa54OB34Dn8uQGJ54e8BPzuH
	 zz9G7u2Mou+xfL0XA6nGeOzvi0NTWVsOysjR4dn0sesNEkFsVAlSA1ceeZM1Faj8Id
	 /iLzu3TnmbM6qvbslPE4FrAZQ654mG2wRc7f3vXipKmgnjAMb4/Vius/L/pMdE7B7U
	 KS1hVt0RtYriQHmM250QoyrPllxNYln9DwePsN1fw+M8OkVO59NDaByH5eKH8A/ITj
	 9WJnJ/+8BiVeoxMoyX0VPzKQ49Ap2AHyZUXbsW9Mmxjefk9D2EjqqYTLhJK+/viIDW
	 3iBzULtkLvXbA==
Date: Wed, 9 Sep 2026 01:46:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, djbw@kernel.org,
 rust-for-linux@vger.kernel.org, lukas@wunner.de, alistair@alistair23.me,
 linux-cxl@vger.kernel.org, bhelgaas@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH v3 19/21] lib: rspdm: Support SPDM certificate
 validation
Message-ID: <20260909014602.6a5d41d9@jic23-huawei>
In-Reply-To: <20260901010347.2614656-20-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
	<20260901010347.2614656-20-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 11:03:45 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> Support validating the SPDM certificate chain. This only performs basic
> sanity checks on the chain before we continue on. This does not ensure
> that the root CA is trusted, we leave that for userspace to check and
> enforce. Instead we just make sure that the chain is correct, uses
> supported signatures and that it isn't blacklisted in the kernel.
> 
> We then store the first leaf certificate for use later.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

One small thing inline

>  
> @@ -846,4 +858,136 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
>  
>          Ok(())
>      }
> +
> +    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
> +        let cert_chain_buf = &self.certs[slot as usize];
> +        let cert_chain_len = cert_chain_buf.len();
...

> +        if let Some(prev) = prev_cert {
> +            if let Some(validate) = self.validate {
> +                // SAFETY: Call the `validate` function provided.
> +                let rc = unsafe { validate(self.dev, slot, prev) };
> +                if let Err(e) = to_result(rc) {
> +                    // SAFETY: `prev_cert` is the previously parsed
> +                    // certificate from a prior loop iteration.
> +                    unsafe { bindings::x509_free_certificate(prev) };
> +                    return Err(e);
> +                }
> +            }
> +
> +            // The leaf key is the same for all slots, so just store the first one.

I'd be tempted to call out MULT_KEY_CAP == 0 for this comment.

> +            if self.leaf_key.is_none() {
> +                // SAFETY: `prev_cert` is the previously parsed
> +                // certificate from a prior loop iteration.
> +                self.leaf_key = unsafe { Some((*prev).pub_) };
> +                // SAFETY: `prev_cert` is the previously parsed
> +                // certificate from a prior loop iteration. We are setting
> +                // the `pub` key to null so it isn't freed below
> +                unsafe { (*prev).pub_ = core::ptr::null_mut() };
> +            }
> +
> +            // SAFETY: `prev_cert` is the previously parsed
> +            // certificate from a prior loop iteration.
> +            unsafe { bindings::x509_free_certificate(prev) };
> +        }
> +
> +        Ok(())
> +    }
>  }

