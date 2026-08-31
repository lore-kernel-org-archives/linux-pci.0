Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60777235358;
	Mon, 31 Aug 2026 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156514; cv=none; b=f7Yx0IStOJF78bFHgKrgq6phwJs7XkjV8zAtT+23eQr3UaO2rdQv4ryPowR/E1D46+pyUgpZIxHqBl+hLH/SLqYo8wyzayQMs1Me/JvzgmkyjG0tL23nYF+C4IQsWs3EonALYMz1t62rMFwXOG98rw5n8HXWX3/8w7N8SIv7kHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156514; c=relaxed/simple;
	bh=0p6h47JEfYZuvur53+xaA7VuE9gmoOblMeS++jbKNKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vB92L6h7JN+OoiSAJYKoEm6L7VCEfPkixGEp0W3Xzxqriudx681iWv2b0tzoKNKP+wcocfOaZ0k6AOg4XhxDKa3IyQ4m1KsDSR4MPJMiQ+0OAgcJVklgLZrwRR878Z5J9foQPFPJ8x25YmXCOOzqzmH12QOEJR6IdJgDGxysZ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmuECeev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmuECeev"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB11DC2BCB8;
	Mon, 31 Aug 2026 06:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788156513;
	bh=0p6h47JEfYZuvur53+xaA7VuE9gmoOblMeS++jbKNKg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=fmuECeevk3LKGdjA4szA0QGSOw5D2DnpQAGzFhEdU9kAiT/mORGArqrIVK62JYzZl
	 /9i0SR79kvvEkdD8vtIhC/iCuAiIzgoSm2jd4lwLPHkTnUYHLggjKcOtzPKS75FViW
	 idqo8th8b22XEv8RPUtJNkvxKV73DHhGsgUmpopwgrJmeCt7rVtrpDWD3PRHdib5bZ
	 ezABbFqXLsSwk6aOo4f+XKY0NvsyVnHgoEKEu4Ym30qtlf3GztiF3J42VkUHoAmJPc
	 B6Zfd+mXlLqW3K4C0ubxyATEK4y10Pfhv1zEqS/WpZbDwvx7120EgM/CkGJ2RcKfrS
	 stbOkSxURZKNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2679C61DF0;
	Mon, 31 Aug 2026 06:08:33 +0000 (UTC)
From: Sophon Z via B4 Relay <devnull+aiqubits.hotmail.com@kernel.org>
Date: Mon, 31 Aug 2026 14:08:25 +0800
Subject: [PATCH v2] rust: pci: Reject IRQ vector indices that do not fit in
 u32
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-fix-pci-irq-vector-index-truncation-v2-1-4030ea7746a9@hotmail.com>
X-B4-Tracking: v=1; b=H4sIAFgalWoC/5WOQQ6DIBREr2JY9zeCEWpXvUfjAgHrbypYQGJjv
 HvRnqDLSea9mZUE49EEci1W4k3CgM7mwE4FUYO0DwOocyasZLy8VBR6XGBSCOjfkIyKzgNabRa
 IfrZKxswDFzXrK1FTWWqSTZM3GTtW7u0vh7l7ZnpX740BQzZ9jhuJ7r3/FhMFCppXjArdNB0Xt
 8HFUeLrrNxI2m3bvtOKzczqAAAA
X-Change-ID: 20260831-fix-pci-irq-vector-index-truncation-6752f3751a0d
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
 linux-kernel@vger.kernel.org, Sophon Z <aiqubits@hotmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788156508; l=1800;
 i=aiqubits@hotmail.com; s=20260831; h=from:subject:message-id;
 bh=JB/vDrVKoSMdb5udCU7YZtYM2GvhKfSyR/Fi+588RxA=;
 b=lajGYWVxLYRWQ1oDpiwfLyx+cSA2JychjNd4DIGdGGYkY2mUfaf10rG3OuyF5c1H3EaLyWi/G
 Y0uhMRHvJ1tAMvPmWWRtPqZBa23F6bGcAS04gZjNeMIgAmN9a/72MRc
X-Developer-Key: i=aiqubits@hotmail.com; a=ed25519;
 pk=+mrkwQAyCCkZdVPpu+CBQr1VZQlkXa7/1WizfeSF/yg=
X-Endpoint-Received: by B4 Relay for aiqubits@hotmail.com/20260831 with
 auth_id=992
X-Original-From: Sophon Z <aiqubits@hotmail.com>
Reply-To: aiqubits@hotmail.com

From: Sophon Z <aiqubits@hotmail.com>

IrqVectorRegistration::index() accepts a usize, but pci_irq_vector()
takes an unsigned int. On 64-bit architectures, casting an index
larger than u32::MAX wraps it before the PCI core can validate it.
In particular, u32::MAX + 1 becomes zero and can resolve to the first
allocated vector.

Use a checked conversion and return EINVAL when the index cannot be
represented by the C API.

Fixes: 2fb7755b0a7e ("rust: pci: resolve IRQ in index() and embed IrqRequest in IrqVector")

Signed-off-by: Sophon Z <aiqubits@hotmail.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20260831-fix-pci-irq-vector-index-truncation-v1-1-d63217d99b67@hotmail.com
---
 rust/kernel/pci/irq.rs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index 6741046ec1c0..1bf91973cb1f 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -151,8 +151,10 @@ pub fn irq_type(&self) -> IrqType {
     /// [`Self::len()`].
     #[inline]
     pub fn index(&self, index: usize) -> Result<IrqVector<'_>> {
+        let index = u32::try_from(index).map_err(|_| EINVAL)?;
+
         // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct pci_dev`.
-        let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), index as u32) };
+        let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), index) };
         if irq < 0 {
             return Err(Error::from_errno(irq));
         }

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260831-fix-pci-irq-vector-index-truncation-6752f3751a0d

Best regards,
--  
Sophon Z <aiqubits@hotmail.com>


