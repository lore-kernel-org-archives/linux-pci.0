Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ABF3FCC;
	Sun, 14 Jun 2026 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781452835; cv=none; b=JIRREILVIB7G2JrytN0f+CGhEC/oLeD4tJADMakA1Ek60B/wtVdte1pgRku/0ak0yfY71Z29Bxm8DHWI+LGQuHqILU3ohyt6a0Eoem4f7rqQnQHe3RbfQYa8oYPRHmbjetukkREDTweFKVWGJiHptCLOj7VRrZjW04ctoi1+FFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781452835; c=relaxed/simple;
	bh=lOo7b+/ZRS+MDUYbMxrSx6Cn9X2DD39Reb5MPEqBax8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oZfnUNmUuXt+eyiuuj3nFWpot0vCuZszn/80tf5NiQjkinzHfmj5vz3zv3fKQtPv2pkb7gpqt+s+jQNMy+P/coXAVmRbVujZ9jrTB7+CC6ioH5IJVeG9k5bFPKzUjGXIC9LcVC4KIJyqEACNOdOQZGvpPbNISiBDbL4VWzHM+IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=URqCSRE4; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oHb8kclw; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="URqCSRE4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oHb8kclw"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gddJJ42Khz9tFL;
	Sun, 14 Jun 2026 18:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781452832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZLRJVMX1DcglL5OK9RXqQlmPbTuxamFlNUJrM/pB+I=;
	b=URqCSRE4pTw8HY85jcQ5wfNpNl8GfAP3JH9a9Q07DRZK3Io1fuqR70OQ/02zdj4K+czwXR
	Gi0M1mBPRHB+OmcJmChsNly4AE8LGMgdkdpfj3v5bl6w5Jl7PRgEGYTdX7lwE2U7S9uxbG
	oIgxPiQGQ6GJd9W8GOAMb1rRll9azmDF6lCKqdAXFE0spEXKTTHuBtPtSoIxdPUCXsfUU/
	90Q1CDLJZrIBYxd8+kM7+hzjRMImiD3UYwjnss9FZ4Vd+8liDPpYeZR1WM8uZv3x/pNlvM
	5FfrG+kJe/jwYlF/ZuBQPppJqxPFIdZdvMhciS3t6iQp5n8uFe+fRsFgULptDg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=oHb8kclw;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781452830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZLRJVMX1DcglL5OK9RXqQlmPbTuxamFlNUJrM/pB+I=;
	b=oHb8kclw8z53qymhU7j7stf6OsOMSlcoOslAekxfkDVuD7EXEmmiUAoIYSHjPmqvq73uG9
	6gUGGIsxyX0ntoxtF3pEAZ3lO03FOcPN7TLh2ouExa4Mq0MIPdRM+dh8HbPaIf2r7P6nsm
	nyqA41I8FK5UOiSFWP5XrSvygpqzw+4ufv9GI+vL5MpbbOJDIUydMZw0Thyb4ub8T44pqZ
	lAZqp6Fix1m2AFREhxmUmNn5wdelea7zx33BCb+DvN/6hEODiGrIsd17xRmwRmuH2loplE
	QhPPcWiKIVcRvFM/Kn9qA4rjyO8e8u6ssUgaEh1DMrllayBhPDWZF9ug/KtDGg==
Date: Sun, 14 Jun 2026 17:59:47 +0200
Subject: [PATCH 3/4] rust: completion: add complete()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-b4-rust-pci-edu-driver-v1-3-e3f2471b595c@mailbox.org>
References: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
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
 linux-kernel@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781452788; l=1963;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=lOo7b+/ZRS+MDUYbMxrSx6Cn9X2DD39Reb5MPEqBax8=;
 b=QLlEE4ZX+PF7aZRRjUSlqXGQHWwrCDARj3llwyDoiRi+ZgnC0mrKf6YUQf3Vk59oTjAgWZyQI
 +ONbEEkt+mjAglSAKKyHBCnWHXl1adwkMXKDaaKDb/L6AwraovmnOYv
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: jd8y1bpyxs1wkwdoajpjxth1r737m8sd
X-MBO-RS-ID: 2dc01a8ff9852c4acbc
X-Rspamd-Queue-Id: 4gddJJ42Khz9tFL

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
 rust/kernel/sync/completion.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
index c50012a940a3..b386b84222f9 100644
--- a/rust/kernel/sync/completion.rs
+++ b/rust/kernel/sync/completion.rs
@@ -90,6 +90,20 @@ fn as_raw(&self) -> *mut bindings::completion {
         self.inner.get()
     }
 
+    /// Signal one task waiting on this completion.
+    ///
+    /// This method wakes up a single task waiting on this completion and increments the
+    /// internal counter by one. If no task is currently waiting, the next
+    /// [`Completion::wait_for_completion`] returns immediately.
+    ///
+    /// Unlike [`Completion::complete_all`], the completion is not marked permanently done, so a
+    /// single [`Completion`] paired one-to-one with [`Completion::wait_for_completion`] can be
+    /// reused to signal the same event repeatedly.
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

