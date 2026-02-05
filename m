Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DA5333452
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325238; cv=none; b=qtF5ns/vWgl/zqkRgfKy+wKT5ztBH9NETOlaAwQH+0XzH13aVtcEoCn6uUCPgEOlTvfGOcYzk9C0afcXaeEPmQJak9trAaUuSz297apue4dCfQhVIbMLvBsiLSaQzCteKX0ctjQJAOsuNGEPZyUmoKd1NJArTWsUP9xMQzy5izg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325238; c=relaxed/simple;
	bh=0n3HUB5a0dbq5Vp3zcn3fKughLCja0FW1cbYz+y6V0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s76I0HDm4IeOxgHA/g3J6HYoWCl+h4aRqxsWPr7GNH/DKCJLAcEF2K0MPaYZ5v+J/8QMYupOqEvH5D4i4WIR7iOH1ocCa7DvUReO+M4huSaUj7uV0V3A1QEGpmk0NZag5ex+999SCj4PlGIN8Zi+RBo1qQDQhmPdKJbKiCT5l0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5Bnq9Zw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJRyOtFk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5Bnq9Zw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJRyOtFk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770325237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gGPFCPOPX/fBbf5qQfZiwEzewT+3Ulk7LVkRWF8dEo=;
	b=S5Bnq9ZwrCaHAWjhsveZG8+FeBF8WPKG05djIc2YY5sjWU6PJ0DHkEWWaVjkacvJCpynza
	colUDhZgNV1Sk5epkD4tZQYrlGbgMatF1pFQHGAiwfNxm3ZFpsGLxkHFkuj/Bnsg5vyW12
	s01Crg7fOXDOmkXzS14aVhhxR3PUFtM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-Vx7OeF2fM82mSryQ7L0jLQ-1; Thu, 05 Feb 2026 16:00:36 -0500
X-MC-Unique: Vx7OeF2fM82mSryQ7L0jLQ-1
X-Mimecast-MFC-AGG-ID: Vx7OeF2fM82mSryQ7L0jLQ_1770325236
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8bb9f029f31so505694785a.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Feb 2026 13:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770325236; x=1770930036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gGPFCPOPX/fBbf5qQfZiwEzewT+3Ulk7LVkRWF8dEo=;
        b=DJRyOtFkMsI56US+c6NOdfhByUFio75q00vlHZbra4em7TLWYHg9rKAmMm/epAyWPs
         hSFC4G2LSEtPVxaHk9ZQ4KYKrCJIPyHSTxLvpRhPnsCSlwHI7y4sa7TyjNPBZzbgVR8C
         09B4gK0amQJqQ1YJgAPeyN7dchCz13rbztccDwQs3D/IW1PBauK2zHGpkNo48saBL0AN
         CAoA0uXDdII9Sr6m6UW3FtuaHeICm5Nkm+32CFSXF4ZAlHeDf9ULVCE5eXlXYg4GdIPm
         OD4Pr3b5c7Qt4j0+0EnfKZs/vUY7C51qDB79wc3my5PkBCU28vzICduaq9X7WofM1jv6
         xIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770325236; x=1770930036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2gGPFCPOPX/fBbf5qQfZiwEzewT+3Ulk7LVkRWF8dEo=;
        b=t70zj7KYN8w11cBEQtPqKqAYvnwn9yWceW5oWFdRcmiXGQckDs761p3h0/X7SBYBUn
         zbPkYZjGnsnYevkvdXgQPJErf+YovqUrvYkBqvRC6Uy2T+c+ZB026CeFyjlVVcLWy351
         iyZXTY6VCrhYmKL1TdNj8ZAz7gjX/ydPb9WBkdP879Z0N1JPYkTvvliGIIEVjrbGUGEU
         EbDK4Y0XepCnbWZE2I3j85HdVfrqOaTKTrTZwu+vaE9H4MpOS5KBSal9Lut0e+KJ1Jl6
         qPBHCXGsLJGYZo2eDvOILn3MMfT4gIv9a0IqIg0mb5dRtnPVeLuaSuJbdzDZCX5/v5wn
         F2pQ==
X-Gm-Message-State: AOJu0YzWW3iVjkE+KejnP1QNaVJoStx3qH/HJ/mfK4KZLpvxfAOM/tqX
	0JfZzJ2Piim1tbuGqgxG8ulJu45+QOTYMaUL2+ZsAgjoBgXe5I9ilKiykSAttIDDC8sDwO4VTE3
	DBmTgfEViMAItTck3NPeKsmnRuvfeCtwrZDGJq4CWBmwLKe1Z6P3OU+oSwrevlg==
X-Gm-Gg: AZuq6aKrdCAEvUwkpRG5gYiNJjynlWEZjGYinjIBYhxhDw0BYAmUTxSboN7RQq1a5zR
	UWZOim97W2gCOshqOF7NvHEkI0rTC4xtsYFcYrbw2z6YMkh0g9367iPHV9dfmLMdog6SRYQD6vC
	Z063E+6fvGKYUkdfEv2fjrjyQ9s13de5XFxt10ROh/RJs49teYAgiw6bYsYGm6S+yxY/BtLDmnk
	mDPnWDAZGno1rDoyjG1cdtU8IvAK2uOIH06F9P6MMa/La2MfWPJCjxaM9mg/DMlkzolCCT8K8Vp
	lUxkK4tjsAem0m3sASIE7N/BNZHmXxbxRGqx2SD5brvd+BxzNHoAqpqvB/gba2/nq5wzqjfawoT
	0BwfNtDUlwqzOBYg=
X-Received: by 2002:a05:620a:1a04:b0:8ca:4438:b8f4 with SMTP id af79cd13be357-8caf13fedb3mr61792585a.67.1770325235695;
        Thu, 05 Feb 2026 13:00:35 -0800 (PST)
X-Received: by 2002:a05:620a:1a04:b0:8ca:4438:b8f4 with SMTP id af79cd13be357-8caf13fedb3mr61780085a.67.1770325234922;
        Thu, 05 Feb 2026 13:00:34 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b010:9000:4c85:f148:4c91:943a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9fdf692sm17571285a.44.2026.02.05.13.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:00:34 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Thu, 05 Feb 2026 15:59:54 -0500
Subject: [PATCH v2 07/10] rust: pci: add is_physfn(), to check for PFs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rust-pci-sriov-v2-7-ef9400c7767b@redhat.com>
References: <20260205-rust-pci-sriov-v2-0-ef9400c7767b@redhat.com>
In-Reply-To: <20260205-rust-pci-sriov-v2-0-ef9400c7767b@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
 Moritz Fischer <mdf@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-fpga@vger.kernel.org, driver-core@lists.linux.dev, 
 Peter Colberg <pcolberg@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.2

Add a method to check if a PCI device is a Physical Function (PF).

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
Changes in v2:
- Replace VF -> PF in doc comment of is_physfn().
- Add #[inline] to is_physfn().
---
 rust/kernel/pci.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index db05641186c3a42922e2b6a463de9c1b099a4673..df39ad3f0d5fd898b034609efb03368f83c2a2e9 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -484,6 +484,13 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
     }
 
+    /// Returns `true` if this device is a Physical Function (PF).
+    #[inline]
+    pub fn is_physfn(&self) -> bool {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).is_physfn() != 0 }
+    }
+
     /// Returns `true` if this device is a Virtual Function (VF).
     #[inline]
     pub fn is_virtfn(&self) -> bool {

-- 
2.52.0

