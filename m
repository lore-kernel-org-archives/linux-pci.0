Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC1346E47;
	Sat, 20 Jun 2026 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945186; cv=none; b=NrmI39Cge95BDa0Xr+944HXfZOofx5tPSa5HgFsAUHOxKjX6oJeKrIMJ1yToAbwb+EobfLq2T+P8/phy1jTOyTV6QEwb3N9lm7yPZlMRok4hoEHjq4pnzR7/Pkx1s43uLgl7PUoXVUQSjHkRd35VOWchvrRQFoLZfvzL0EbzpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945186; c=relaxed/simple;
	bh=5zO1LX2TjSxxpWL8R+mXZSW9SAxY1Aoy5xk3OqjvANc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZvnZs/eiQhRYTK/2GtSl90tPU3fGMISP3LYsBqqUxRUwtBo2ttI07Q/eHo4ASD8s9R4mKNLnEbwO73YvC1jMMCqircYAqTIqRjwsJ81qQFrz49p3Ygih66ppAgrW7FoYqsw4E2kkWsamGhyehb+BDK32qM5WOt62016dre3fGqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=di5rjYsv; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PtHxUios; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="di5rjYsv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PtHxUios"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gj7Nb0Vy8z9v6p;
	Sat, 20 Jun 2026 10:46:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781945183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INTljHFG9d2Ck4YcbsrhwBLKJiKcfKJFTC6LKqWYgmI=;
	b=di5rjYsvRkr2Pm64gAxMEOH9mxwewLWbqNYHjAxvQUvaVP3cHOmIo0BJZ/Cgj5BLETpr69
	vCzsGYsbxTW/l8lt+OHgDT3fvPIzS4XpO0R9vL71I9/YVnsNxX2Dq4xZqg8cw97jOGMqwB
	WYY/iIBOt56IpDVENwB2PcLg6s7QpSjdhLW6yVt+a7+bpd9JWA768voteXBhtmTSPjDNeH
	Mo426QS3PIi6ot8KEFIY9IkxYcmIhh6ZNOeHWd7NG5C1LLhlQkRGquLZ1iufuUmwI04TM+
	rXVdQlAlWFC6fIuyeDRl7CfrbMCHv8g7JYb7+85MwFJl0+Wb8BQ5ES7CJqDY8Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=PtHxUios;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781945181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INTljHFG9d2Ck4YcbsrhwBLKJiKcfKJFTC6LKqWYgmI=;
	b=PtHxUiosKZrwSXK4ORcej0xJOI+V9lSujyoU0qJaH26hPssuidRT5829S3Z3vas/w4abVg
	bR2NdvBExETpDPhe3+HEAMl/mhWDFJQcTKV9cokvI2G+SBWUto78UGAAgCQPWhvkemNmMr
	1Smx+Lz9IO7dLkxcDaL3jA8/Wicaz39TTY7xhBrEjJqq7tUrufYqW26Du6dIwjmYtRg6K9
	S/QKzwaDdqJqBFdwrzXb3vwaGfQ12/lIeLuWZfJiiOhZ63YfeYlUTFHEzJzD6VM0txxms4
	kdAcwYuVaeI9UCH7cW6GUGq23yHv9zCVW5MDy/OKXTKlNbSalLJK+zrcafKHLA==
Date: Sat, 20 Jun 2026 10:45:47 +0200
Subject: [PATCH v2 3/4] rust: completion: add complete()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-b4-rust-pci-edu-driver-v2-3-6fd6684f2c14@mailbox.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
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
 Lyude Paul <lyude@redhat.com>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781945156; l=1677;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=5zO1LX2TjSxxpWL8R+mXZSW9SAxY1Aoy5xk3OqjvANc=;
 b=wcI0NXj/uL/RuqphHQBkSaX4zmV+luvlFre2UOITkc1L4cvywvMHvNGGV7O0TKYn+1ojLkrog
 +26SEOGgPpEBR1O3xADSALg3voxED8LqvQmQUGVMyZ/mlQwjpiU0DBN
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: k4e18kozx6y5upidcpmtxbpuwozzfaap
X-MBO-RS-ID: 063168d94adc5845821
X-Rspamd-Queue-Id: 4gj7Nb0Vy8z9v6p

The initial completion abstraction only added complete_all() and
wait_for_completion(). complete_all() marks the completion permanently
done, which makes a single Completion unsuitable for signalling the same
event repeatedly: once complete_all() has run, every subsequent
wait_for_completion() returns immediately without waiting.

Add complete(), which wakes a single waiter and increments the internal
counter by one. Paired one-to-one with wait_for_completion(), it allows
the same completion to be reused across multiple cycles, e.g. to wait for
consecutive DMA transfers to finish.

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
2.51.2

