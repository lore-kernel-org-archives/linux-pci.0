Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A9B3016E1;
	Thu, 16 Jul 2026 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784229497; cv=none; b=RRid2NcTZskay+JLyRXzpwySKT4so/okrMVNd8rH4qna1pqY0NeScBYTcst3wctIXy+q67eY9qw8kbv9bugKV/ipQsWBsv4RwZtxyWV82mWtuQrzGCj2PaCzGUX71buH33BVeTubaGe5yWtDheMOqcNBjW4seaPiE8gTRIXZ8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784229497; c=relaxed/simple;
	bh=9hGdsbCTkZ7KSRTrLF/K6PtcT7p+1U1ItNmWf+JSwc0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=jpFZO9/MNm8WGFnsk7epNf+sV3ul6xa9u/7sqjW5tXVed3E3XRfw17V9PY1X1g8ZgictU0WdjXjq60jJ6TN2Mp3GZh34KCTXh5oydFPhsaZd5EMiu/X7dMaE/Px7V7qS9R/DxSdMxBmH0BVBP4RQI6g/6AIXTMIyUZ9tp1Orkp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3GQPr0k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3GQPr0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190FA1F000E9;
	Thu, 16 Jul 2026 19:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784229496;
	bh=mm3gd88M8vHvfDbkay5kKqa4Pt+DlNaxfY+bDClihtg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=I3GQPr0kiybSyrJWe6zFu1hn/2Oi7ybH+Xllp0AZgCxCxtguf99L5TtUBCO7GqeGC
	 oPQow+GJffWyt0RQ3HflSGICSMR/H6eSgmfxcTLBFGV2wH3Z4WKK3FuLIbwImGvV/l
	 567+2xoZleLdCeeErvz7topxq9fo+m2NFlp+moZK8Qz1sKQVlxnOIuQtezVSdQvJs8
	 QBgtsZcgmOXEfkPpllJ0h+62qI61Vn0tzV5bGj2Vt6nmD0+dxOdKB6zYVOf/vl24Co
	 VhoGT5cKW/TorfHex+N4kkyQTcShb+vZibcozlgaxBBTdFsSlxoQ52xkgrqCfRuexM
	 mkXK6GvaHXY4A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 21:18:05 +0200
Message-Id: <DK08KE2A3M7K.3OQDFZB94SMFC@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Dave Ertman" <david.m.ertman@intel.com>, "Ira
 Weiny" <iweiny@kernel.org>, "Leon Romanovsky" <leon@kernel.org>, "Len
 Brown" <lenb@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>, "Drew
 Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-usb@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 "Igor Korotin" <igor.korotin@linux.dev>, "Rob Herring" <robh@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 00/11] rust: driver: use pointers instead of indices
 for ID info
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
In-Reply-To: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>

On Mon Jun 29, 2026 at 2:39 PM CEST, Gary Guo wrote:
>  MAINTAINERS                           |   1 -
>  drivers/acpi/bus.c                    |   6 +-
>  drivers/cpufreq/rcpufreq_dt.rs        |   1 -
>  drivers/gpu/drm/nova/driver.rs        |   1 -
>  drivers/gpu/drm/tyr/driver.rs         |   1 -
>  drivers/gpu/nova-core/driver.rs       |   3 +-
>  drivers/pwm/pwm_th1520.rs             |   1 -
>  include/acpi/acpi_bus.h               |  11 --
>  rust/helpers/acpi.c                   |  16 ---
>  rust/helpers/helpers.c                |   1 -
>  rust/kernel/acpi.rs                   |  14 +--
>  rust/kernel/auxiliary.rs              |  18 +--
>  rust/kernel/device_id.rs              | 207 +++++++++++++++++++---------=
------
>  rust/kernel/driver.rs                 | 137 ++--------------------
>  rust/kernel/i2c.rs                    |  26 ++---
>  rust/kernel/net/phy.rs                |  66 +----------
>  rust/kernel/of.rs                     |  14 +--
>  rust/kernel/pci.rs                    |  25 ++--
>  rust/kernel/platform.rs               |   5 +-
>  rust/kernel/usb.rs                    |  24 ++--
>  samples/rust/rust_debugfs.rs          |   1 -
>  samples/rust/rust_dma.rs              |   3 +-
>  samples/rust/rust_driver_auxiliary.rs |   4 +-
>  samples/rust/rust_driver_i2c.rs       |   3 -
>  samples/rust/rust_driver_pci.rs       |  11 +-
>  samples/rust/rust_driver_platform.rs  |   2 -
>  samples/rust/rust_driver_usb.rs       |   3 +-
>  samples/rust/rust_i2c_client.rs       |   2 -
>  samples/rust/rust_soc.rs              |   2 -
>  29 files changed, 178 insertions(+), 431 deletions(-)

I plan to pick this up soon. Please let me know in case there are any conce=
rns
from the acpi, i2c, of, net or usb side of things.

Thanks,
Danilo
