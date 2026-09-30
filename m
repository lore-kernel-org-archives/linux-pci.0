Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09076513551;
	Wed, 30 Sep 2026 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800476; cv=none; b=OmK84SxBYEN4d9nF0fI0iIr3gQB64PJOQL7io5AQ+vSD+Npixj/22tejh17dS3p9qOLjZU3hQZGo55AwqUdksjGiK4ysLSrjRVJk11FnO1LGd4ZhQx9Us0CH+BQJiJW8+3snQ+AfjgyF1/u6nLlOLY4WakGnOIAzVLGMFaB9uyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800476; c=relaxed/simple;
	bh=MXJoWh27o9MwkRcEATF3A5TQDOZPuv4rjg5+A1xWiX8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=B2JtiQt2YwsjknqVt4zeVURwpwIwLHS9Dx7G1opX0mDYR7yuOwnLkAhms85W8Ml21nbOkIPYi8mo0I41lhUx0H+eVXxGxLVhcr87PWyawk4VcVL98Z9OYMdxrX/LgFjCx2NnIaEux5L8Q9BLga/Jkxcs92xL9mLtTot6k4ZDdC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPnL235e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPnL235e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB8C1F000FF;
	Wed, 30 Sep 2026 20:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790800474;
	bh=ylQ0OITIo4dh+Zpz7IdOtmIaWbcTxvEIto7puD4Q1qQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=GPnL235e6qVPtblrQO9gWHazeNFm6t3ehtvJmBmJMkpSufXfk2qDUStBov1nZaLAS
	 xcaPxbjBmc2UB9j10FOxkrLQuLnqy7L+mtwdwxy00f6jIbnyi7WwVnXCH85TVIHwF0
	 btVEGE4AifXoPvVVExkRpV737QqLL1iVJ9LI94OayZ4M2gIstxH+onWrN2GPEALfhc
	 vzZe8naUlZSNaTuXeIieOtz+uatIQ6/UjJCrfDW1LFAP4tarhUvyacnmOzW4vK0rt+
	 exR+sEBV+HV9iSB4bvyJrPGEaolZd31aX+1O4GXptScwiDYUA+bh9/Gnt4G98QocG6
	 /DRHgclyskunA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 22:34:27 +0200
Message-Id: <DLSXS9MO4YW5.2YLITM1OJ7P0P@kernel.org>
Subject: Re: [PATCH v10 1/1] rust: pci: add extended capability and SR-IOV
 support
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260906060404.3336193-1-zhiw@nvidia.com>
 <20260906060404.3336193-2-zhiw@nvidia.com>
In-Reply-To: <20260906060404.3336193-2-zhiw@nvidia.com>

On Sun Sep 6, 2026 at 8:04 AM CEST, Zhi Wang wrote:
> +    pub fn vf_bars(&self) -> Result<impl Iterator<Item =3D ExtSriovVfBar=
>> {
> +        let slots: [u32; NUM_VF_BARS] =3D
> +            core::array::from_fn(|slot| crate::io_read!(*self, .vf_bar[p=
anic: slot]));
> +        let mut slots =3D slots.into_iter();
> +        let mut bars =3D [None; NUM_VF_BARS];
> +        let mut count =3D 0;
> +
> +        let mut decode =3D || {
> +            while let Some(low) =3D slots.next().map(BarLow::from) {
> +                // SR-IOV VF BARs describe memory-space apertures; an I/=
O-space encoding is not
> +                // valid for these registers.
> +                if low.io_space() {
> +                    return Err(EINVAL);
> +                }
> +
> +                let low_address =3D u64::from(low.address()) << BarLow::=
ADDRESS_SHIFT;
> +                let bar =3D match low.memory_type()? {
> +                    BarMemoryType::Bits64 =3D> ExtSriovVfBar {
> +                        address: (u64::from(slots.next().ok_or(EINVAL)?)=
 << 32) | low_address,
> +                        is_64bit: true,
> +                    },
> +                    BarMemoryType::Bits32 =3D> ExtSriovVfBar {
> +                        address: low_address,
> +                        is_64bit: false,
> +                    },
> +                };
> +
> +                bars[count] =3D Some(bar);
> +                count +=3D 1;
> +            }
> +
> +            Ok(())
> +        };
> +
> +        decode().inspect_err(|_| {
> +            dev_err!(self.pdev, "invalid VF BAR encoding in SR-IOV capab=
ility\n");
> +        })?;
> +        Ok(bars.into_iter().flatten())
> +    }

I don't mind too much, but can you please remind me why we decode the VF BA=
R
registers and can't use the PCI core's VF resource information instead?

(I gave it a very quick try and using pci_bus_address() and pci_resource_fl=
ags()
actually turned out worse, but that could be me spending less than 5 minute=
s on
it. :)
