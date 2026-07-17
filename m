Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011332B118;
	Fri, 17 Jul 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281251; cv=none; b=p57Uzqe3Uc+1yTotFkHDyTKp0BJsNpqAywEt2+eG5Sj5EfNYHKDi7rjBzqp5I2DFEdPV502Cvk1wHXcEhubG+ErEGKcd7iMIncpL1DHd+4V/VfzecxNX8YhxfWOYOZBxdBnHOjoFqjux1O8zHqpPLDFTFH7+dCDZdWmu/wmBgts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281251; c=relaxed/simple;
	bh=hUpneCRR7Zmjp4VPifSOXOk31FmdExZfNBPPZiGR7jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVYCHDbB3xJYD2el0Ri0DMI1NdZqeTSRHHm9c4CX1UrXXVVcTqDpMjiwgIyjf0TjLVQMNXjQyaIOm5IbhA5qvrgGQxQUJa5+st3L1PjuggH26jEH99hHF227iY4eVRSYddNohZQtnAFhZ7WAKM28uq+rLz8ZnM/wh0GwnkjXIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aLeyQQNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aLeyQQNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBEC1F000E9;
	Fri, 17 Jul 2026 09:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784281249;
	bh=24bith6PvfIO9Yx7/KB0oXppD1JzRw+O/DItVYf4buE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aLeyQQNrRfbgdQ4/h6LxqcCsHSGfz+UFqnSOwOMm9gI8ToOd7/q8UCRwaAllUHBgn
	 SxiNTh2QVQe7br/lIiUXMAZlGYsru88LlYofd2aCWXhk68MF0SOibT5V2nerFZNiY5
	 3ymZ+2dmzAxhTJ/Er6HdtlOdKc0G6Y40UMdhsvyw=
Date: Fri, 17 Jul 2026 11:40:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Igor Korotin <igor.korotin@linux.dev>,
	Rob Herring <robh@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 00/11] rust: driver: use pointers instead of indices
 for ID info
Message-ID: <2026071729-scored-ogle-430c@gregkh>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <DK08KE2A3M7K.3OQDFZB94SMFC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK08KE2A3M7K.3OQDFZB94SMFC@kernel.org>

On Thu, Jul 16, 2026 at 09:18:05PM +0200, Danilo Krummrich wrote:
> On Mon Jun 29, 2026 at 2:39 PM CEST, Gary Guo wrote:
> >  MAINTAINERS                           |   1 -
> >  drivers/acpi/bus.c                    |   6 +-
> >  drivers/cpufreq/rcpufreq_dt.rs        |   1 -
> >  drivers/gpu/drm/nova/driver.rs        |   1 -
> >  drivers/gpu/drm/tyr/driver.rs         |   1 -
> >  drivers/gpu/nova-core/driver.rs       |   3 +-
> >  drivers/pwm/pwm_th1520.rs             |   1 -
> >  include/acpi/acpi_bus.h               |  11 --
> >  rust/helpers/acpi.c                   |  16 ---
> >  rust/helpers/helpers.c                |   1 -
> >  rust/kernel/acpi.rs                   |  14 +--
> >  rust/kernel/auxiliary.rs              |  18 +--
> >  rust/kernel/device_id.rs              | 207 +++++++++++++++++++---------------
> >  rust/kernel/driver.rs                 | 137 ++--------------------
> >  rust/kernel/i2c.rs                    |  26 ++---
> >  rust/kernel/net/phy.rs                |  66 +----------
> >  rust/kernel/of.rs                     |  14 +--
> >  rust/kernel/pci.rs                    |  25 ++--
> >  rust/kernel/platform.rs               |   5 +-
> >  rust/kernel/usb.rs                    |  24 ++--
> >  samples/rust/rust_debugfs.rs          |   1 -
> >  samples/rust/rust_dma.rs              |   3 +-
> >  samples/rust/rust_driver_auxiliary.rs |   4 +-
> >  samples/rust/rust_driver_i2c.rs       |   3 -
> >  samples/rust/rust_driver_pci.rs       |  11 +-
> >  samples/rust/rust_driver_platform.rs  |   2 -
> >  samples/rust/rust_driver_usb.rs       |   3 +-
> >  samples/rust/rust_i2c_client.rs       |   2 -
> >  samples/rust/rust_soc.rs              |   2 -
> >  29 files changed, 178 insertions(+), 431 deletions(-)
> 
> I plan to pick this up soon. Please let me know in case there are any concerns
> from the acpi, i2c, of, net or usb side of things.

No objection from me fo rthe USB stuff:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
