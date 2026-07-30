Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79C38DC5B;
	Thu, 30 Jul 2026 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445248; cv=none; b=kBcesS9c8QRoA4ALC1hlBk8Lg1mjQFOagFABhy3F+xPONSnceB4Z6P04ZqREmhayvVPSn5X/sbv5kBLqoa2ICGmHDIftp009ppIJIizBHbdUfBUHdBJP8OliLVpjydJMl8x6xXN6FWeQTV0vjM+qHY34gAzEHVgRzK9rOQjjhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445248; c=relaxed/simple;
	bh=wopGtB1S22TrpBVMOBYbCsh1svYedp9ZYyUzDfjK2ts=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=C1PJ9xUyo52t+CzC1JXCCH0KUUOKf5Lil9Qq/XsePDmWrQCQa6RyhzdZZYRybmRBAKZHrJ1G1TanIH5Bj2icJRxhZt834IK7ycfgYRr2dDWbbBQYyqtdiV8NGisADRk3oOwwpDaaFQs9KOE7IlU2ROwL1I7KowmFXifSPkBCa44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlIrnsvx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlIrnsvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722611F000E9;
	Thu, 30 Jul 2026 21:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785445246;
	bh=GU4+hYZmZbT8tEUgTys+3//O3qZ0GI86e9VhsvZnCak=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=XlIrnsvxN8Tws6u8wpf2xhSPdpQHht3nk99pv2UUZrTJ7CnNuNd1V6nCgKcOici7E
	 1u4l/as7uDuGCMZcCATCX+vfNtTub5A/vSX6tZzdslKO+vYQrE/zLGe/ccTvDzzVBc
	 P+STc3ugdaY3KKCj0Toc6vC25GYbp1QZUQdFEsUdYjTcx6Yp8dIIBx+Oev7dr9AZPc
	 zu6XBHxm+7fy+kKyE1jJ507sJoBnw5H5eaggmkbYl/oMXml+8QgZ1InStH/bweo7Po
	 ZicWB64bO2erPMxgizFIxFBmnlOMbc4D36IhSRxFip3Lx9GTpQbbqtvD0u3kb2IKtN
	 1WMlasksKTS8g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 23:00:37 +0200
Message-Id: <DKC7IILD54UO.1N47QGSHMKENI@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 11/11] RFC: rust: driver: support map-like syntax for
 ID table
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <iweiny@kernel.org>, "Leon
 Romanovsky" <leon@kernel.org>, "Len Brown" <lenb@kernel.org>, "Igor
 Korotin" <igor.korotin@linux.dev>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 "Drew Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu
 Wei" <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-usb@vger.kernel.org>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-11-56fccbe9c5ef@garyguo.net>
In-Reply-To: <20260629-id_info-v2-11-56fccbe9c5ef@garyguo.net>

On Mon Jun 29, 2026 at 2:39 PM CEST, Gary Guo wrote:
> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> index c81fca5b4986..5f4d191fce51 100644
> --- a/rust/kernel/device_id.rs
> +++ b/rust/kernel/device_id.rs
> @@ -183,6 +183,17 @@ macro_rules! module_device_table {
>          $table_type: literal, $device_id_ty: ty,
>          $table_name: ident, $id_info_type: ty,
>          [$(($id: expr, $info:expr $(,)?)),* $(,)?]
> +    ) =3D> {
> +        $crate::module_device_table!(
> +            $table_type, $device_id_ty, $table_name, $id_info_type,
> +            {$($id=3D>$info,)*}
> +        );
> +    };
> +
> +    (
> +        $table_type: literal, $device_id_ty: ty,
> +        $table_name: ident, $id_info_type: ty,
> +        {$($id: expr =3D> $info:expr),* $(,)?}
>      ) =3D> {
>          #[export_name =3D
>              concat!("__mod_device_table__", ::core::line!(),
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index 2282191e6292..652819dff082 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -75,10 +75,9 @@ struct SampleDriverData<'bound> {
>  kernel::pci_device_table!(
>      PCI_TABLE,
>      <SampleDriver as pci::Driver>::IdInfo,
> -    [(
> -        pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
> -        TestIndex::NO_EVENTFD
> -    )]
> +    {
> +        pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5) =3D> TestIndex:=
:NO_EVENTFD,
> +    }
>  );

This LGTM, do you want to send a follow-up series?

Thanks,
Danilo
