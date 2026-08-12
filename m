Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A23793AC;
	Wed, 12 Aug 2026 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564395; cv=none; b=OwSLnuku99H58uFTSIq+sB+/bBsztKWlxWrnEdKkFiNLuoh8XI1Q3sbgkAEvthKdXuVyhap6d6kLRTVGFoeOKU97AbNkYm42MFNgEeCvjyEybGb9Ek6Sy7ZbK8ju71uwbh+yDApq4rsrgS2chL8izr0bajc747DDOnur1wV3fhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564395; c=relaxed/simple;
	bh=HWcB9dW46NCDdMFgEmztPn3SKd3bbuPHW1LTSQ3duZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PgNRhlRIiOQjYA0rzDtsn3uIGQYtiE2ENDG4xc9KjgL5oZgTcJE5IQ58iQcE6Rhb2Ph6lM7WaFpmTkQqdtEl4McgjO0Jgith+JZmZ87+gMdsMtQgraWAZK87Z93ZawKK92ukvq7lCVWBl6rLGRaNBY2anHOjwMk3vnv5GtIitrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SiTXzoCv; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gp0R1ymz; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SiTXzoCv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gp0R1ymz"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hKzgW6XB7zKw1R;
	Wed, 12 Aug 2026 21:53:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786564391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svkrkIj8EgL3gAvbJQNXbPx1gnIdqah5+1xl05bhyEg=;
	b=SiTXzoCvYFqQiQfZPYyTQb8oAObpW6nLlzAzzWrhMbXacBLqvfARDvp105dmu17x2tsPGe
	rFpLEGEVVL36aovbzOOe9R2qDw0fhXfi0rwUcTL8vRGVUQTvI5tD6TswK4LFJD21PAXM2a
	mhgkSAe1Su6ofIMWgy7+IQjViqqyfhWviNmmPuGJaplqRPoh1Rh2XnUJUM5r/3CVkVsxyt
	b+09aiOESBWGCgdReNOaSqSa5Zt2Ge8oWeP6zSVQkQN4SGbz5AeVMYu5LXBB/eoc9yoh3v
	+reHO7qH2saJUcs9kN+azvoAZO05EB4PMmoJp8mbKWfcCfmZAlLnrBitUw7WVw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=gp0R1ymz;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786564390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svkrkIj8EgL3gAvbJQNXbPx1gnIdqah5+1xl05bhyEg=;
	b=gp0R1ymzBJO9XHyIK/6UazUn4aIpN+i7NRPc7RKM4H+N5saFYmmhbkwG+KruD3hBwmkj/I
	74QrUCc0wlL84vYcsO22JRg+7BhzKBSr7pWrjpRl1sbIj/lmc3ilLznSqBX9X5rJC2IQrJ
	zn5MBqK3fdAq+Vf2QM/+HuCI+qtcWttmdyGJjM/Bn6MxkK7Dk2p68Hxp8Uz5no2Kfy9K1C
	aqKLzyLML23U7/e93xqzD3h36z90829uqNwxmqAxZCWD7E69XAQL2uibIE9fosduBVSUQe
	njgCPSyejl/tKR+dLQH0L1eu1uVkPTh3G9XWCBIkjiOb1LI7Lj3y2HNsVeQFxg==
Date: Wed, 12 Aug 2026 21:52:38 +0200
Subject: [PATCH v3 4/5] rust: completion: add complete()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-b4-rust-pci-edu-driver-v3-4-5d0b5594e52b@mailbox.org>
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
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
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786564358; l=1716;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=HWcB9dW46NCDdMFgEmztPn3SKd3bbuPHW1LTSQ3duZs=;
 b=NbOFNRlSeu7hQ7ESR5yFNjSaCs08cN07YlPptrDlriaIGtRW9iLhUTSi81jFg6uYbSEvVSOrP
 DMPhziCQg0+Dthw/XOU7hOmd/zxh3R0poYKWekE013Ff0I+ahoLW0w/
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: jcjnyktc496jcd7r5eau4i949ap7anu6
X-MBO-RS-ID: cc005bbae02b89dbc92
X-Rspamd-Queue-Id: 4hKzgW6XB7zKw1R

The initial completion abstraction only added complete_all() and
wait_for_completion(). complete_all() marks the completion permanently
done, which makes a single Completion unsuitable for signalling the same
event repeatedly: once complete_all() has run, every subsequent
wait_for_completion() returns immediately without waiting.

Add complete(), which wakes a single waiter and increments the internal
counter by one. Paired one-to-one with wait_for_completion(), it allows
the same completion to be reused across multiple cycles, e.g. to wait for
consecutive DMA transfers to finish.

Acked-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/sync/completion.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
index 35ff049ff078..a54361b53644 100644
--- a/rust/kernel/sync/completion.rs
+++ b/rust/kernel/sync/completion.rs
@@ -90,6 +90,17 @@ fn as_raw(&self) -> *mut bindings::completion {
         self.inner.get()
     }
 
+    /// Signal a single task waiting on this completion.
+    ///
+    /// This method wakes up a single task waiting on this completion.
+    /// If no task is currently waiting, the next
+    /// [`Completion::wait_for_completion`] returns immediately.
+    #[inline]
+    pub fn complete(&self) {
+        // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
+        unsafe { bindings::complete(self.as_raw()) };
+    }
+
     /// Signal all tasks waiting on this completion.
     ///
     /// This method wakes up all tasks waiting on this completion; after this operation the

-- 
2.54.0

