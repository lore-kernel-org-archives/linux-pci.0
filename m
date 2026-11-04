Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833549;
	b=V+x55sw2PWbiuDjciJf+sfFKoJ8CNcMZeY3mnIJ0PxuahUDrGZNwVJzY+5whSUCGEu3J
	 op2J5TtDTNRpn6aGe7Y8kVIIJKdM5LS8VQr4Sac3hiUS+QpiD9/Z0Gj2Oh9/YCAFLkamK
	 63SLDt37pdDZUKw7CInSz700f3KOu+5VphNMb3SRq45ggG42fw4xMhnbqMgKV9wQtn+dU
	 dNtXmUss6UFCAoWyF/4d1iUv/B6U1pJFRMC7N31N+yYmet+9xUzNmyfkLVrTeYr/7763E
	 7m4LiHoy4WRDJggzEFG32JLBiucPkXtm2hii2tGP1mLO9cC0RC+7Mv1kjOi0i9g3OzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833549;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=jbTkdQmJKGsdTp05UextFv3WctlitFzbNsJ+32KHR6Q=;
	b=gLf0p6bCz3SeYalfWr2e5ihtdLuoC3w76Ymm6Nu5upCpolKjUSvqyfF1OcUJTD6+VHg6
	 Aw0wEbI1qi3oOIxi/H0rVJl4ib1AJ/o521zDTjWY7M2vkc73BmQPmIW+abaD9q1lZ+C/L
	 ZGUPlNUwTLuIOWDwgk8iecK07q4StE3mAGHBmrZawJvpXOKRyJcSx5GeUAy9rTQKyyJRJ
	 RPE/8UY93fxusLk/HUFGHdWZCBDYB67Tjj4Q4l1qZi03CoqZ+BIJmcdeWTiE4jDfqwXzx
	 TjcLFpJNHKVJeuVMVuMsUBZ6VSZbNaDEsfX/d3wcsOjzvQ9U6j7cKrcNvh6Ij/JBDrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="r/nfy1QZ";
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C4606EE88;
	Wed,  4 Nov 2026 23:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 219C4606EE88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=r/nfy1QZ
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jKgyx1lmpzKn9v;
	Thu, 05 Nov 2026 00:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793833545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbTkdQmJKGsdTp05UextFv3WctlitFzbNsJ+32KHR6Q=;
	b=r/nfy1QZ9Zdo/QU5jWEqE95NJuNq1IS3iuuQLRAui9DxFNWKnzC2hJKHPUxF8/BuWPt+rf
	JfS74OEhxDx0nKNYLRH7JhzhsB0Ws0rtcbsaKqdomK1eIuv3HbYGqM2JzcA3EN4+wMOSnq
	qi7q+8a8EAXa+e2oKQRVm46KzupY1xhhBF2HYLXKSso4YsFU/dTYeR1zuonqIEqGTqzmRj
	eHZ8hNJMOMumaE2nkFhcHJAX3/9ltUEy8+DX2j42kWxJbtxYhlIs9Wt7joIXs+PwXQ4UE1
	g/91ZZD+6GKFXS17YMRoh1AJNQo9//6OFi6rQEZ83PPskLDo8EXQi5y3QXHn6g==
From: Maurice Hieronymus <mhi@mailbox.org>
Date: Thu, 05 Nov 2026 00:05:34 +0100
Subject: [PATCH v4 3/7] rust: pci: require an enable guard for
 `set_master()`
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-rust-pci-edu-driver-v4-3-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
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
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793833536; l=2151;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=GNdyqXDLOCW4DpbKGxI85gc9zzXrjd6g32f2xdqiVUg=;
 b=/mQrjSkxD1o9FWDl3mwp3Nu2WFjB6B0Tke1XXJGm0Un5m3N6OJLvIHgbzxLWTyss8LYWKD72t
 jzhCdqjnX3EBt5dY9hlfCQLrQY0FxWuOXF4a1aac+z3LpkDbvAqGpIZ
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: 6683e78207fd56d81bc
X-MBO-RS-META: 3tyocz9m1k3gjjsbdkbj7uiafebkha8n

Require a borrowed `DeviceEnableGuard` for the same device before enabling
bus-mastering. Check device identity so a guard for another device cannot
satisfy this requirement.

Keep `set_master()` on `Device<Core>` to retain callback synchronization:
the guard is shareable, while `pci_set_master()` modifies device state
without locking. Convert nova-core to pass its enable guard.

Link: https://lore.kernel.org/rust-for-linux/DLNQ5C9BTIAJ.1XEWLZ13TU1VF@kernel.org
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 drivers/gpu/nova-core/driver.rs |  2 +-
 rust/kernel/pci.rs              | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index f0aebfe705ba..94f207c6078d 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -107,7 +107,7 @@ fn probe<'bound>(
         try_pin_init!(NovaCore {
             _enable: {
                 let enable = pdev.enable_device()?;
-                pdev.set_master();
+                pdev.set_master(&enable)?;
                 enable
             },
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 75efd5c5ee97..20f45ca960cd 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -516,10 +516,18 @@ pub fn enable_device(&self) -> Result<DeviceEnableGuard<'_>> {
     }
 
     /// Enable bus-mastering for this device.
+    ///
+    /// Returns `EINVAL` if `enable` belongs to another device.
     #[inline]
-    pub fn set_master(&self) {
-        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+    pub fn set_master(&self, enable: &DeviceEnableGuard<'_>) -> Result {
+        if self.as_raw() != enable.dev.as_raw() {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: `self` is a valid device in core context, and `enable`
+        // keeps this device enabled for the duration of the call.
         unsafe { bindings::pci_set_master(self.as_raw()) };
+        Ok(())
     }
 }
 

-- 
2.54.0

