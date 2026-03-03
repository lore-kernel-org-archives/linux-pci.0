Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18C442F566;
	Tue,  3 Mar 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550052; cv=none; b=uWh/0jJo2D6O8BDTa4kE7zXiUZ858dObd85Q2DgpKjNvG6pB/0nRRyrfjy2YMsIpcVn8rTnpudD+aeWY8IfrxQTDIgGRSG/D7TPOWRkyeZ55FQtw6P2xmA3FKUDUDfFY4VXYQHqqxG1IusDZRNLzNahvbbNYs65Z4He2cfAIDWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550052; c=relaxed/simple;
	bh=0oZrxQ9yQk2I9dUJY4B6e8lDEKDior0f9dncYIHTP2U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQ/t43/yaaDtecbVTO9rXv2s5X3zRvC4y+T1DTxDUWdtBXoVhjo/Ao/U/tSEZIPArTNTgh9T4ym223LqVdJfOumENJMT2HAU6SzY9VlhDtrwFip6yk7oDOKFTzMNm5K1rMvvr6zAmiYfydr7blRvO+n0M4DbeyiomXFc4MUDsZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQJr966Y7zJ46Yd;
	Tue,  3 Mar 2026 23:00:09 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1590640589;
	Tue,  3 Mar 2026 23:00:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 15:00:42 +0000
Date: Tue, 3 Mar 2026 15:00:40 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <lukas@wunner.de>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair@alistair23.me>
Subject: Re: [RFC v3 22/27] lib: rspdm: Support SPDM certificate validation
Message-ID: <20260303150040.00007458@huawei.com>
In-Reply-To: <20260211032935.2705841-23-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260211032935.2705841-23-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Feb 2026 13:29:29 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> Support validating the SPDM certificate chain.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Only minor thing inline + observation on the code that I think we want to remove
for now wrt to checking the root cert.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 1e5656144611..728b920beace 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs

> @@ -743,4 +746,92 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
>  
>          Ok(())
>      }
> +
> +    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
> +        let cert_chain_buf = &self.certs[slot as usize];
> +        let cert_chain_len = cert_chain_buf.len();
> +        let header_len = 4 + self.hash_len;
> +
> +        let mut offset = header_len;
> +        let mut prev_cert: Option<*mut bindings::x509_certificate> = None;
> +
> +        while offset < cert_chain_len {
> +            let cert_len = unsafe {
> +                bindings::x509_get_certificate_length(
> +                    &cert_chain_buf[offset..] as *const _ as *const u8,
> +                    cert_chain_len - offset,
> +                )
> +            };
> +
> +            if cert_len < 0 {
> +                pr_err!("Invalid certificate length\n");
> +                to_result(cert_len as i32)?;
> +            }
> +
> +            let _is_leaf_cert = if offset + cert_len as usize == cert_chain_len {
> +                true
> +            } else {
> +                false
> +            };
Same as the following?
               let _is_leaf_cert = offset + cert_len as usize == cert_chain_len;


> +
> +            let cert_ptr = unsafe {
> +                from_err_ptr(bindings::x509_cert_parse(
> +                    &cert_chain_buf[offset..] as *const _ as *const c_void,
> +                    cert_len as usize,
> +                ))?
> +            };
> +            let cert = unsafe { *cert_ptr };
> +
> +            if cert.unsupported_sig || cert.blacklisted {
> +                to_result(-(bindings::EKEYREJECTED as i32))?;
> +            }
> +
> +            if let Some(prev) = prev_cert {
> +                // Check against previous certificate
> +                let rc = unsafe { bindings::public_key_verify_signature((*prev).pub_, cert.sig) };
> +
> +                if rc < 0 {
> +                    pr_err!("Signature validation error\n");
> +                    to_result(rc)?;
> +                }
> +            } else {
> +                // Check aginst root keyring
So this is the check that Dan and Jason are proposing we drop (for now).

Works for me as easy to bring back later and lets us move forward
in the meantime. As long as userspace gets nothing to indicate
that we have in any way checked this root cert we are making no false claims.

> +                let key = unsafe {
> +                    from_err_ptr(bindings::find_asymmetric_key(
> +                        self.keyring,
> +                        (*cert.sig).auth_ids[0],
> +                        (*cert.sig).auth_ids[1],
> +                        (*cert.sig).auth_ids[2],
> +                        false,
> +                    ))?
> +                };
> +
> +                let rc = unsafe { bindings::verify_signature(key, cert.sig) };
> +                unsafe { bindings::key_put(key) };
> +
> +                if rc < 0 {
> +                    pr_err!("Root signature validation error\n");
> +                    to_result(rc)?;
> +                }
> +            }
> +
> +            if let Some(prev) = prev_cert {
> +                unsafe { bindings::x509_free_certificate(prev) };
> +            }
> +
> +            prev_cert = Some(cert_ptr);
> +            offset += cert_len as usize;
> +        }
> +
> +        if let Some(prev) = prev_cert {
> +            if let Some(validate) = self.validate {
> +                let rc = unsafe { validate(self.dev, slot, prev) };
> +                to_result(rc)?;
> +            }
> +
> +            self.leaf_key = unsafe { Some((*prev).pub_) };
> +        }
> +
> +        Ok(())
> +    }
>  }


