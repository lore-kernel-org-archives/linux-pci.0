Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD9331211
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326835; cv=none; b=eKtsfu0e4QdcsXE9CdmLVHlNRe1P4csSvg9eEonk6FtpSbnOIqrzr5sUN0KrAlIejIZ/sIO7iDIX4cX4OMInNckUsp+yk8l/OXbT7hB3W8/CQRnQpqnbnRKwQm9eD+Lk5pu1xKd6NY6wHBcWgkBe8qx6EhcdhYTWyNRMDsqr5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326835; c=relaxed/simple;
	bh=onUcEIsNRNpDK4k+ZwYKjhl/82j2tz+8TXLBfpER88U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5wwuyqUz7MZWgcNPNiqZxMIEUZYRA+v6fN3PaPU/yZ7W3Ae1Qzu81REgu0exCLQiRWoRc+JBJNydDbPu5iM5lBvbbrE+Rsi6paqCBLoQv+x4RCmOMoV14Ny82/kgoTf5D00TPR9i+tvRFBZ4PGsmAbCNhAHQvhQAbI6PnU4pVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkiV7WEJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t5/opbZR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkiV7WEJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t5/opbZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770326834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGchRpNtHpsURPrx/vVHrgmCPFSkjjSjv6Ar1R+yRYU=;
	b=IkiV7WEJpTiUrUhfoG8JMj94girazSGWjdLGAtGZEOv7sed9e42/rXhlHFO8DCuriBG8Qj
	2aEkFF04gs/+SnxlVIazVjrJe5qSwrQeFG3dn8Rm3mbcKdqs9ljGO0MHYsNTsuaJ0FPoNO
	fm36TnwoajBXyO71WZarSqwjfXP5EOE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-8eBD3gRaOMyaZ_NhU9hHZQ-1; Thu, 05 Feb 2026 16:27:13 -0500
X-MC-Unique: 8eBD3gRaOMyaZ_NhU9hHZQ-1
X-Mimecast-MFC-AGG-ID: 8eBD3gRaOMyaZ_NhU9hHZQ_1770326833
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-502a8fa0a28so1386991cf.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Feb 2026 13:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770326833; x=1770931633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGchRpNtHpsURPrx/vVHrgmCPFSkjjSjv6Ar1R+yRYU=;
        b=t5/opbZR5FktdI9ygVqVAfgHLxwRfyRQ9NuHv98/ycoStCB9zUWEHlHfMBMVSsDxgF
         VXAi5Kq3m8BctAP0SZvwowe+kEeWZ2Pq+ntDwPxquLqS8+eQU88WYEiY/iPU2VVA0/sl
         cA5ibjdHOaPqBcgQD4gzE3Ao7BwvmCLmyQkRFsZ14nyghgqJp+bxncP7inURSiBie1Hp
         C+UgLJE16ZEOUBNXt0ezMuuSquzZJNyDYl+pup6rYS1nmCFycmZ8J7pObGd8uFM7/x9+
         zl8zo56ORyiXr668sVXC3/78MXRklSFalR2JU1VMaRuhJjf00azAFnBBBJvpVCvEmu8O
         aXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770326833; x=1770931633;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGchRpNtHpsURPrx/vVHrgmCPFSkjjSjv6Ar1R+yRYU=;
        b=dy5//0v8zObM82rg+WJB8pm47nA3ZWv5G6r+Vr43UTh3eT5gvXS9tuG1X8scBgviLp
         OVeUxiuhD9BgOeg/48pJrY4mAcyM/i8EAvCAUHjEGG0zak/6gDaaZAU2JpdEa1w1IroC
         ZONVzDWBE6NaZGzOFH2g+7FBzdcxmhqsb2DvbzW9lcTAi8FcWmKASDh9E6VLHZ2ojP91
         qS6CUv5m4Ddbhvhc+kIzBsN0kyZwy3ZZuBJA/hAq4BQQY5D/3wWZu/Jqn0tbmBb8JrUM
         e7aX5sdHXIoUwEIAxckS+W5mwN9EilhgJdi+b7JU0x3iPuwr+PBgfH55vH3s3Yg60CtV
         S0HA==
X-Forwarded-Encrypted: i=1; AJvYcCVPZ4wb2YJLFZGUaLHPszhw89gTKMv2D879aj+hY6SkMx9ZNXtPihNXh+xEKOJS5pRjLdLG7lpoNpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxbdSxRTtwpTYRXoNTW5YmfUIHP6xlunBm5rFy7KsTsryuqXBa
	ZaBZYtV+Grn+EhmduFNlbY2IyXn5RUhaX8Q0I8ftW45pVB/9+bfKEFKlvegF6cEO8ShLSgZEwfs
	bJ1E8RoPfCZIXVyivCwpGU1tpk4AVJDuYTzByLC7CNGy5Dd1UrLhr+D0fiNZUuQ==
X-Gm-Gg: AZuq6aLydnSzu9C2KPiDWVQmQ88Hd9I7vCJwEI7wDvO1t/HSV/EoeGMuDVmxT78AsoM
	GibzWnal06jejFJQ4tsrAyBaMBCIoVEjYGx/ZpYc9LF0XH4/oSFRZlwJUHW8iWeVf5V/PecV1Fb
	DYQtNZn9WpDVVzQlpsPJZolRtcQCpgSzGIBYYwQMs2eSDZUQJ496WaGW8suaaDqnNCFqd4cSrwj
	8S1XdlxVQTWDMfLeu2bcJ3/2w9mOFlIEA8G+blcXwDgFe94tiz2igOrn79iY7Q2+tcZmO7Qxg6O
	jJcs1cxhDuXDWPf5uLshUf7CUX4HNHtUsvm3QCUEc9xoWDpRuyPFZy3izIIO84YKc0h7jkk3CkO
	p3JgdkSdGCw==
X-Received: by 2002:ac8:598f:0:b0:4ee:1b0e:861a with SMTP id d75a77b69052e-506398477b3mr7896151cf.13.1770326832965;
        Thu, 05 Feb 2026 13:27:12 -0800 (PST)
X-Received: by 2002:ac8:598f:0:b0:4ee:1b0e:861a with SMTP id d75a77b69052e-506398477b3mr7895841cf.13.1770326832454;
        Thu, 05 Feb 2026 13:27:12 -0800 (PST)
Received: from localhost ([2607:f2c0:b010:9000:f569:ac10:227c:5156])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-506392902eesm3841121cf.21.2026.02.05.13.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:27:11 -0800 (PST)
Date: Thu, 5 Feb 2026 16:27:10 -0500
From: Peter Colberg <pcolberg@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Subject: Re: [PATCH 3/8] rust: pci: add {enable,disable}_sriov(), to control
 SR-IOV capability
Message-ID: <aYULLucqol7jRoDC@earendel>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-3-883a94599a97@redhat.com>
 <20251121232833.GH233636@ziepe.ca>
 <aUrquI3X68Ilmebh@earendel>
 <20260106012236.GR125261@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106012236.GR125261@ziepe.ca>

Hi Jason,

On Mon, Jan 05, 2026 at 09:22:36PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 23, 2025 at 02:17:12PM -0500, Peter Colberg wrote:
> > Further, enable_sriov() is prevented during remove() using a new
> > flag inhibit_enable in the pci_sriov structure that is set before
> > and cleared after the PF driver is unbound from the device.
> 
> Doesn't this need something concurrent safe like a revocable?

Thank you for the follow-up and apologies for the delay. I have now
posted a v2 series that takes a different approach from what was
described earlier, after discussing this further with Danilo.

In the v2 patch [1], when the new PCI driver flag managed_sriov is
set, which is always the case for Rust, SR-IOV is disabled twice if
needed: once before the unbind() callback for a well-behaved driver,
and a second time after unbind() for a broken (but nevertheless using
safe APIs only) driver that re-enables SR-IOV during unbind().

Together with commit a995fe1a3aa7 ("rust: driver: drop device private
data post unbind") which ensures that the device private data for the
PF device is still alive until after the function pci_iov_remove() is
called and forcibly re-disables SR_IOV if needed, this upholds the
safety guarantee which pci::Device::physfn() depends on.

As an alternative for preventing SR-IOV management during unbind(), I
briefly considered adding a new context, e.g., CoreInternal => Core =>
CoreUnbind => Bound => Normal, where {enable,disable}_sriov() are
implemented by Core but not CoreUnbind, but discarded that solution
since it seems too specific to this case to warrant the complexity.

Thanks,
Peter

[1] https://lore.kernel.org/rust-for-linux/20260205-rust-pci-sriov-v2-1-ef9400c7767b@redhat.com/

> 
> Jason
> 

