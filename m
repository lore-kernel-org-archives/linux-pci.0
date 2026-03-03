Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFFE3C3BFA
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572551; cv=none; b=oTpBAOMOiCiw0URXOUYYul64YiSV1qQ4eM1Vj5X97EpPDasLVQxtDIbMM9vBKDGaDTS6Z+1Kj7StoGTeTYZXoDTk5Vtd2t1TMr1aqWt6ALUWIcDX0Oq6Hf3LitF1AHr1mWMIf4Kj1jakITTjYuKSbLIsLsflupFVukNiC4l2q8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572551; c=relaxed/simple;
	bh=s6mYU8Hu6u0tbKnwvAlOQsSAlR2qHgbV7fvzmNOhT1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPnqY7Mm1vexlPSNGY+Cf++ppgb8BcEt92XCytDHcfmgv+ewUIiX7KUoA5tK+Tz9sApaUrz7d+yAMRjA2FFQjRNITrtm/hC0Fmuvnzco0wZDqQO4MqUrzQ4ZBTTkiWyU/HRCcVM0TyOoxpgiThPrwNG+hk73tbPoSUDZjUNlC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTkyQ1MI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kCAw1JBI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTkyQ1MI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kCAw1JBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772572548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLYDkNQ8A4x2T95jGRETa6NwStvleq7OKd2uXV0vocw=;
	b=BTkyQ1MIwdUr4SBnXaUoXkx2/qFXyrU5CIbfGcjArGrolbt/qJhAi2ziLVJz6vGm6IY23v
	UryGmw1nwaJVbxhzmYw/2pymwQ8XtHp17lugdIOZ9Q9g6Og820zug/p1Ip5J8SE0Mk91mb
	7FMRsKvQOEObo489Ivyt+Wyxi/oCehw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-zPrYiNMVNGGlGpCMPmutLA-1; Tue, 03 Mar 2026 16:15:47 -0500
X-MC-Unique: zPrYiNMVNGGlGpCMPmutLA-1
X-Mimecast-MFC-AGG-ID: zPrYiNMVNGGlGpCMPmutLA_1772572547
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5033c483b74so85776001cf.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2026 13:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772572547; x=1773177347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLYDkNQ8A4x2T95jGRETa6NwStvleq7OKd2uXV0vocw=;
        b=kCAw1JBIAXWRPZw4JUJv49YAWrljxCYbXksrBYpDoKBqfunUfLS7XVJD34AMw7f9pe
         lBP1ZOc6g2DZt9+ns25+uobgikZUqykOa6qiBIW+8Z6HDs3PQkeOn7oop4BuHgH2fU0+
         tyR6uRyuj41vz0FroNhHCjkmE5cabgSEgLWg7iZKShrJDXnc8UMmwJjxTMgiI1P3tsSv
         x2/6YqkSZgykeNdS9iOKTP25rRy32reg30RkLHB5d9B2be7QENmC9tAVVCikFcbaqii+
         3ExfTwxriP55kHvkyPhwceUhX+3o4RHe6gIsk8tNooyfKnefiYQoBGa7nU78ddbgToCW
         n2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572547; x=1773177347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qLYDkNQ8A4x2T95jGRETa6NwStvleq7OKd2uXV0vocw=;
        b=N6+MTELaKbbQcgjVryW8s4oxqgNvkle31dGE2qw1sVR1lHhgGO1WyYkgmNCVM2FYyU
         CZ4T1XanZPxUa1q32I8LeggyzFxF68h0CJ9Wbz3HuVTYwdL3RN8F5XCiFejE0dh2eOG9
         MCIqUP3IuNMPk0WCwirCu5LXR751W4iq0K4YyGz/kdLzXOz8vIH2b2cr5ACV0Vt4M4U2
         wGHFnRBXGdJR48uvq/B+CRFY89bl1HMcS2O7aGqb9G2kFUnjJ8rCert6umeAdPkFeVuO
         z3Aagig6nO0GUQDz9Emi4MzU373ON1W0Y6XAGWumZjUINrtHvvLZOWbDsxUzILZ7tH4A
         48qA==
X-Gm-Message-State: AOJu0YzeZg1UcOiuldk8RUTjHm2+75in2HaSXNu7Cs1fWC7cqhfEtOnN
	2FTNm2WallK7Sao1KWY50U4xd/3Ubqmh9/zMXj5p6hJWTow57KhlseTTPhZ2KFB6/I6b/QnpMog
	v7DJIP3TQwdpcMSlB5sz+zmSwzrjQn/RJhTkLwFFLj2jyJlrShAZzJcocWBxp1w==
X-Gm-Gg: ATEYQzzKHmCq91HTfH5nSQmq8G4DtJNl2VEgFhKkklFotSaR7CQol6X1CFzH966ShkD
	+xdhYHOpdH+gh1NS1pTtuNzVab1cICUDJ7mnDyjM1x7r5lYLOpih86tmwly4wRpJsqIdp1XFgiz
	jnYHmwHMfYZfOVpudZaimQ7hTB4ed9b2wvF2lAh8HobzeULbmOUYewe3AUrRF7V+xBBoXKDdO7W
	QveZkOAjPGldk/GTCOB1Vn4c1YqW+lmu75WbT7SQwpyfWXX0Rg3df3OW0Rf6SzsIf8EZZmWLt7F
	7RPsYTlGRTa9zn4TnfyjVR1eKz0w4qJoJ8nWs7r8tmZrU/x3nbdhK/RerXHS41F/ll+DPK2QGoK
	4EhGM2wAvZAI1ccrOCrQ8ry3thQ==
X-Received: by 2002:a05:622a:64c:b0:4f3:5652:6743 with SMTP id d75a77b69052e-507527cc1c1mr213308971cf.39.1772572546795;
        Tue, 03 Mar 2026 13:15:46 -0800 (PST)
X-Received: by 2002:a05:622a:64c:b0:4f3:5652:6743 with SMTP id d75a77b69052e-507527cc1c1mr213308331cf.39.1772572546254;
        Tue, 03 Mar 2026 13:15:46 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b1e3:9a00:3c7:56c2:f819:96d2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm156286991cf.0.2026.03.03.13.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:15:45 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Tue, 03 Mar 2026 16:15:27 -0500
Subject: [PATCH v3 07/10] rust: pci: add is_physfn(), to check for PFs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-rust-pci-sriov-v3-7-4443c35f0c88@redhat.com>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
In-Reply-To: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
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
 Moritz Fischer <mdf@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Boqun Feng <boqun@kernel.org>
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
2.53.0

