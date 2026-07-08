Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFA1DC198;
	Wed,  8 Jul 2026 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783470275; cv=pass; b=EWizRc24IeyGTMPT1o5JGaMF/XCrpAZzKf3DCL0PfZDZFeHLeQP+vwbIMcpo+JkCUMP/SimiybRETntqL4ZTQyr9mxy0+8zfI174A1qU4m+Gts3dIoiPIEy38oKPDeuTsQy6QwGF/YNHHkCeF7Id0tqeeq0mUWpndyNbndJ/Kqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783470275; c=relaxed/simple;
	bh=T5phQSMf9GvrAN5+gXMjqlbyH09POBaanjLNoMJje2Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K/qkbuhgwGnS+Apvhm0lrzo2QnQ8756EWZWm2/3Hf79j2geb0RJzGjmR+UnElekzrm8xQ4bSalmJfAdjl4A9J4XXGyTjdcDEvBSdcdnpn/jMFWPbtgVkVdDYMhMkElpyOJ3LQTuXTQRdcKtNloW6ehHxtj9uw6ZCRiO0KGBVis4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=fIy+B01d; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="fIy+B01d"
ARC-Seal: i=1; a=rsa-sha256; t=1783470238; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Eh/CRicKhYzjAv+NkC3XCS25mmZD96sPKSruzOkCfP5bgbvgku0FzBwmRFC07FGconTni+IdYYYThbTp1Tjy5PD0eI5FbEXxcMNXwHqW7tdlp9lrI3/eI5js2EzQU1IB864bb4zoX2tji6k/1/ZlUAnaywP1EtH/ESaghFo81FE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783470238; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DYXyLoAY8AaVmLnx+7/pJaDvxt1RZKBKQrdv8WKrV+0=; 
	b=gpRcMdoSv41OxUEsFya+v8vuaVmWGvUCXk9yOe5VzX0FpTr0vHlREjaDJJvS/XpAKnwoaorVF1uMqJGyzcBuR4jzI2vwxodq6dAIT/YxFi/R0xvm4b3lwwIp5FTBYlxnt/W2Z9GedSAbCKdqTScXp9phXD7MJyf1sb5Z+AEHrbw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783470238;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=DYXyLoAY8AaVmLnx+7/pJaDvxt1RZKBKQrdv8WKrV+0=;
	b=fIy+B01dwvb7JLCtbCEEFHMplUsc1qCuaJIei5Iz7trHUoEwhpaOfJzVIwr35YSs
	Qf8VskDPmrcCsDL8a8X8eioLjPM1KhgXQCrOSxURNX1+Dk+9JyO9D2waeu7dxTN2I7N
	ruMqs5dyw5VX6RVW2qXQH5+3mFEjLtb/GDpQfoNs=
Received: by mx.zohomail.com with SMTPS id 1783470236194104.25200355621882;
	Tue, 7 Jul 2026 17:23:56 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 03/20] rust: io: restrict untyped IO access and
 `register!` to `Region`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-3-72cd5d055d54@garyguo.net>
Date: Tue, 7 Jul 2026 21:23:35 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 linux-pwm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <613EE0AC-716C-4382-8CB4-1EA03B915A46@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-3-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> Currently the `Io` trait exposes a bunch of untyped IO accesses, but =
if the
> `Io` region itself is typed, then it might be weird to have
>=20
>    let io: Mmio<u32> =3D /* ... */;
>    io.read8(1);
>=20
> while not unsound, it is surely strange. Thus, restrict the untyped =
methods
> and also the register macro to `Region` type only.
>=20
> Implement it by adding a generic type to `IoLoc` indicating allowed =
base
> types. This also paves the way to add typed register blocks in the =
future;
> for example, we could use this mechanism to block driver A's =
`register!()`
> generated macro from being used on driver B's MMIO. The same mechanism
> could be used for relative IO registers. These are future =
opportunities,
> and for now restrict everything to require `IoLoc<Region<SIZE>, _>`.
>=20
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Link: =
https://lore.kernel.org/rust-for-linux/DHLB3RO3OSF5.2R7F27U99BKLN@nvidia.c=
om/
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

