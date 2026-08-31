Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0373AC0D9;
	Mon, 31 Aug 2026 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156281; cv=none; b=Dax1zYHgG9FxOT3tpCLmib5mza7sCjz3OlRGhH2ZzAlxg+k7+XX6MIuhFWXI5Nv1zclXl6ZnWp14XKBxeXjgsgtW87ZHW1P44BkkwkLS+k3TAI7Uex7r1tEXTe1D9hCppmVp0/Va81iEDcnqOyUkqvJqEVAuhC3073N49bhkPj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156281; c=relaxed/simple;
	bh=r+78EeOd3F73//qZlzI+jvIQhC/Dn89tSZ9iXsA/rMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dkfyAICAf5ufYCEqbCj18RCDHXgQFCeX4Ex6tQBVc0BXp4nqvSyb/2QsI20Ozt0Yq7rMXuZPVbYYP5RsGipLiE/7+uh9BBmSz8wFGwdl0tKj5e3bSod0as13dCeryDs6hjPiuzFQsHn/OmfkANHqgyb/4RxRvxkIDHGr1Q6Hpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCLfHjJv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCLfHjJv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 609F3C2BCB8;
	Mon, 31 Aug 2026 06:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788156280;
	bh=r+78EeOd3F73//qZlzI+jvIQhC/Dn89tSZ9iXsA/rMY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HCLfHjJvo3yJVL9GFXakaL0uCdDcxF9B51oS+132bXyFFydh7r6cd7vbm+sJSF5bm
	 WvDdWo2IPZrPCTiIIeDhbthGfcswiV4ped5N0wreSsanx8r9FaJtQbUM+VsYlCJHNt
	 LSeHJRAMDxykMWQ2fnkNgFFn5wgMmUVyHk30OI4FVOSyASqIcjKO2I7bD7ynorBhay
	 9fsG2/N6Rc5jLWigSyomiSTX/O7mzrx4ssRJVuigqXUv/FH8MgMcbmkbqLv66xyrP9
	 keMQBj7Iz4OBYlikxuEyAlBnachypLVjz9ZvmlNY8JfawH/r1XtXL+R0WuIVxewgn2
	 q7+J2OqgOmfng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C40C61DE2;
	Mon, 31 Aug 2026 06:04:40 +0000 (UTC)
From: Sophon Z via B4 Relay <devnull+aiqubits.hotmail.com@kernel.org>
Date: Mon, 31 Aug 2026 14:04:37 +0800
Subject: [PATCH] rust: pci: Reject IRQ vector indices that do not fit in
 u32
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-fix-pci-irq-vector-index-truncation-v1-1-d63217d99b67@hotmail.com>
X-B4-Tracking: v=1; b=H4sIAHQZlWoC/yWNMQ6DMAwAv4I811ISBFT9CuqQJgbcIYATEBLi7
 3Xb8Ya7OyGTMGV4VCcI7Zx5Tgr2VkGYfBoJOSqDM64199riwAcugZFlxZ1CmQU5RTqwyJaCL+p
 j2zVuqLvGehNBS4uQar9L//xz3l5vtb9puK4PLIBAx4cAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788156278; l=1555;
 i=aiqubits@hotmail.com; s=20260831; h=from:subject:message-id;
 bh=rcVDRPrSPnO1Ee98t164DOTONn63WizVtKhr1VeOh7E=;
 b=LgZKS9pMGXvpbAQyZ5Hry/cE3R8kl1Bl5vL+AIH8R4F7C5szyNioSICnCSc6RthNm2KJeSkLx
 CsOlwGpNTz9CfotyhIy50EhtQoOy0oJodwRebOr2/Sz9bYyplCx6cES
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


