Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690092EEE61;
	Tue,  4 Aug 2026 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885868; cv=none; b=mNz7Pk9p3wUpJlKdm4u/Opi6OdZMv0xAJy39mpUNFmH98U3Be4MHJViwIscGFDtHQFqeUJiD2+JIC88aalfFfp1aTdd8e4HU4HI5MY3OE+bD95Xnnq/ac1l+V1OpjfG1WsY4YIgq5mkXEjOAuNtI4uYi4f7QRIQeB/AL+cXwiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885868; c=relaxed/simple;
	bh=r6YWrTSSZ/fVvahnW52FQdLveWySWKDiTBbHwwFFWJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rEDVoSOPVrTumouXoQLqb1bj3IxVqynFhLjTkN9DxVEUOkj1BdqSutcl4E4Ca/g9zg1p6hQLLA2JPNLAm5b9JbOho7YtP0eksVkN8KAaURXsAWhjk64UsA7SRkviJn4Sd2qdAMXFHK5yr3ZMdqbOo5XhR5+HcibY0Euk/HLxp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c78WDMft; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c78WDMft"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00D3BC2BCF4;
	Tue,  4 Aug 2026 23:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785885868;
	bh=r6YWrTSSZ/fVvahnW52FQdLveWySWKDiTBbHwwFFWJQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=c78WDMft3E92kYhv54gb878Gx8MIDTtp8wp0l/ic2oCggUn3KlSM/9gwoYMeg0YF0
	 6S22MEOP/vpGPTQitON6yOMHL8nUaC8Ei59FMtqUBZs+YblK3yuR3iYF57L+y+Ge98
	 N+qBqTBDJlrIU9gVqRERNkzaJ4nTd720OQZ9WXIjtNA7yOTxg8iZBQgnjx4wQI54WH
	 AiU5IoDcaPpeA7Pm/JZiEp3c0LkbRb3rqORh1E+s95VDzPA7g19Zco92rQysZ764yG
	 +ptmKXBOoLLP9dmQBY6waFaFkqNckojgCN9eG/tFBnrCrffrNT5/GduR54QvjbUTOz
	 pEzntq53mp4oQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD76C55184;
	Tue,  4 Aug 2026 23:24:27 +0000 (UTC)
From: Ethan Plant via B4 Relay <devnull+plant.ethan.gmail.com@kernel.org>
Date: Tue, 04 Aug 2026 16:24:25 -0700
Subject: [PATCH] rust: pci: Mark Device refcount methods inline
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-inline-wrappers-v1-1-16916db867e5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBBG4VeRWRuIIkF9ldKFl992RGKYsVUQ3
 92oy29xzk4KYSjVyU6CPyvPPiJLE+q+jf/AcB9Nuc2dLW1h2E/sYVZpQoCoGUpXtQ6FsxkoVkE
 w8HYfX+/H+mtHdMu1oeM4Ad+QKANzAAAA
X-Change-ID: 20260804-inline-wrappers-f869b6e4601e
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ethan Plant <plant.ethan@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692;
 i=plant.ethan@gmail.com; h=from:subject:message-id;
 bh=9Vpgdz4Y5wf49bgzEW37pW0bIiE7fP8d5f85n0neKYk=;
 b=owGbwMvMwCXmcODvRtktquaMp9WSGLKKSlY/ZivYJxtf+nl+7uG8UHEdiXvKPfsnWOqbzctv0
 SlI2PWso5SFQYyLQVZMkSX0y9T9W5PPeCx5K8UEM4eVCWQIAxenAEyEl5vhn+2S+wL1TXnHUkM/
 RM3KL0oODvaSCGhQjXsjWvHm4+xbuQz/kw58DxY7eDOn9/jptdcab4fKh0859+bgVLXpcs99lYy
 bmQE=
X-Developer-Key: i=plant.ethan@gmail.com; a=openpgp;
 fpr=55F495BFB563CC48A4ED1A0240C0FDB11DB42537
X-Endpoint-Received: by B4 Relay for plant.ethan@gmail.com/default with
 auth_id=917
X-Original-From: Ethan Plant <plant.ethan@gmail.com>
Reply-To: plant.ethan@gmail.com

From: Ethan Plant <plant.ethan@gmail.com>

When building the kernel, the following Rust symbols are generated:
$ nm vmlinux | grep ' _R' | rustfilt | grep -E 'pci::Device.*(inc_ref|dec_ref)'
... T <kernel::pci::Device as kernel::sync::aref::AlwaysRefCounted>::dec_ref
... T <kernel::pci::Device as kernel::sync::aref::AlwaysRefCounted>::inc_ref

These Rust symbols are trivial wrappers around pci_dev_put() and
pci_dev_get(), respectively. It doesn't make sense to go through a
trivial wrapper for these functions, so mark them inline.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1145
Signed-off-by: Ethan Plant <plant.ethan@gmail.com>
---
 rust/kernel/pci.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..3e80ec1160b3 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -482,11 +482,13 @@ impl<'a> crate::dma::Device<'a> for Device<device::Core<'a>> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+    #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::pci_dev_get(self.as_raw()) };
     }
 
+    #[inline]
     unsafe fn dec_ref(obj: NonNull<Self>) {
         // SAFETY: The safety requirements guarantee that the refcount is non-zero.
         unsafe { bindings::pci_dev_put(obj.cast().as_ptr()) }

---
base-commit: dc01dfb37b34beeefcfe1c3055364d41a4070c7e
change-id: 20260804-inline-wrappers-f869b6e4601e

Best regards,
--  
Ethan Plant <plant.ethan@gmail.com>


