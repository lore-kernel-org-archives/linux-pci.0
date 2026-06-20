Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70832298CB2
	for <linux-pci@vger.kernel.org>; Sat, 20 Jun 2026 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781948943; cv=none; b=E3eFIaa8H8521lpV66ESiy+Ra1GrZhofgvVctcVMxgtnKYAqKqnJoyzHEnv6rpT2d+lU1q5//BHwRkZBdW742BKfwWuKUi8usUgi78n4LwV8aRWO5kv9d9I4AfH6CgjFOAfM1sR+JQaS62nTHdl9BtNTsDHaA0HgudYa1mRGwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781948943; c=relaxed/simple;
	bh=LPb0j87d2Jgf8EFIhFesYMwLUtggaFn078FL61s94kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/subqBecS3+WQKMCdH7wJRstgREsYlrJ9KP9+/bDwG0iALpqZXlK7N30F+Bz+FTLIS1FCwb8XWv7r9kFo9udo/yDOb/KUjdwdoKVE3w6ZnteMqEvDquowO6g8bHwvdmMJTUf/oB0WWy2ertnI25oUa3fliBmyBOroHF05w8Mpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=JrdURwlz; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="JrdURwlz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781948933; x=1782208133;
	bh=zKViPEjhmpyarryAiawBUlFXwkyn4b4qL83w5A4Wajo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JrdURwlzDL7i1nHF97qtht0g8IW1sL3Yj7QqUhn6CV5XxDSBEjusBmpLspUlAJDQ9
	 XCP1KVCtNhs0xE4FWRau9liMDC+eurVliaCk0d9PYZ4Vq4swd0xmke9EMsufhmU0DJ
	 FZ6/vCkWS8kH4PpYe1QWfp5McVpwwg1rez1SMjBlkwjwv2l4PiQK4z4CG8jHnPaiEh
	 VRqSChnsuwum7bD/pGcPkd4I0rf7DBOc/6KEBL7RhSC/+iczUa8zgH7WtREqOT+9qe
	 +oCfERZcsHaFz5rFoTj25rGFFrRzbNlnuQ1vshQYcJ1/95wp8u7qlLAqMfp6xWyzs+
	 BfUnZGMqHzCWQ==
X-Pm-Submission-Id: 4gj8mf3v4cz2Scmd
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Lyude Paul <lyude@redhat.com>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v2 1/4] rust: pci: make Vendor::from_raw() public
Date: Sat, 20 Jun 2026 12:48:46 +0300
Message-ID: <20260620094849.8741-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-1-6fd6684f2c14@mailbox.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org> <20260620-b4-rust-pci-edu-driver-v2-1-6fd6684f2c14@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 20 Jun 2026 10:45:45 +0200=0D
Maurice Hieronymus <mhi@mailbox.org> wrote:=0D
=0D
> `Vendor::from_raw()` is currently `pub(super)`, so a Vendor can only be=0D
> obtained through the named constants generated from the=0D
> `PCI_VENDOR_ID_*` defines in `<linux/pci_ids.h>`. A driver therefore=0D
> cannot match a device whose vendor ID has no symbolic name.=0D
> =0D
> Such devices exist. QEMU's "edu" educational device and the legacy=0D
> qemu/Bochs stdvga both use vendor ID 0x1234, which is not registered in=0D
> `pci_ids.h`. Per the policy stated at the top of that header, IDs are=0D
> only added there when shared between multiple drivers; a single-driver=0D
> ID is expected to be open-coded in the driver instead. C drivers already=
=0D
> do this -- see `drivers/gpu/drm/tiny/bochs.c`, which matches with a bare=
=0D
> ".vendor =3D 0x1234".=0D
> =0D
> The Rust abstraction has no equivalent escape hatch: there is no public=0D
> way to express an unregistered vendor. Make `Vendor::from_raw()` public=0D
> (and const, so it can be used in the const device-ID tables built by=0D
> `pci_device_table!`) so that drivers can construct a Vendor from a raw=0D
> ID, matching what C drivers can already do.=0D
> =0D
> Reviewed-by: Gary Guo <gary@garyguo.net>=0D
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>=0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
=0D
> ---=0D
>  rust/kernel/pci/id.rs | 2 +-=0D
>  1 file changed, 1 insertion(+), 1 deletion(-)=0D
> =0D
> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs=0D
> index dbaf301666e7..fe3b0047179b 100644=0D
> --- a/rust/kernel/pci/id.rs=0D
> +++ b/rust/kernel/pci/id.rs=0D
> @@ -156,7 +156,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Res=
ult {=0D
>  impl Vendor {=0D
>      /// Create a Vendor from a raw 16-bit vendor ID.=0D
>      #[inline]=0D
> -    pub(super) fn from_raw(vendor_id: u16) -> Self {=0D
> +    pub const fn from_raw(vendor_id: u16) -> Self {=0D
>          Self(vendor_id)=0D
>      }=0D
>  =0D
> =0D
> -- =0D
> 2.51.2=0D
> =0D
