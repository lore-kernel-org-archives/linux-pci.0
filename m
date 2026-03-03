Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5635898
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572546; cv=none; b=qAXaNDy4Aoo9uMMqriiePP/63Eq3/DkrQD8re5OQKQmgLoIPyLSf5i743ha6C3iKVUej+02Oxz5mFn/rfAskIBcDx3gyqjiUpfEsLv6hVRpoFQSPNcN7+dXpyIRbG1jRlx7CgpS4DtazaHtRaiJYfd/RLRZBfYVZirDAqHSZRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572546; c=relaxed/simple;
	bh=Ovi7q4LBinaNMgbwhfXjFRVkgoBkC//IcdGA6/LR988=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c/7A9xsnp/03IWPt5L4GB+9PjHxyfQ7oYq2Nxr1UMrf+SF66eoOhotD+r40Cup3EDU0qE6hAg7GGakfj2qwGg8Oald2edh7LAqjfOsDq1/4CYdak1L6EjnjcuzDKWq2gvKeC6KUn2rRMp9wE+DHeJyuWknzQlcAvi4Rpj9lyW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oau96xRq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0qN0E6i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oau96xRq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0qN0E6i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772572543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmGZI5WblWd631ssrKt08f4BijC6XK/3q+5rIjFI99c=;
	b=Oau96xRq+Xc6B98vW4u6bZQQvLR+WokphXHnnipTZnEs2IL8GUecJllh4v9GbQL9nctl6w
	GaVUxjJjegbCXA+rcEzYLqE/rVkqmuUY950n1MwUB0H8EEI7nhtPgKiJ3DysDnyvthGP4D
	KSbujvdure551ONYmA+zI9BIlAHb/W8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-BPnhmyxvMPCrPcgnP5RLIA-1; Tue, 03 Mar 2026 16:15:42 -0500
X-MC-Unique: BPnhmyxvMPCrPcgnP5RLIA-1
X-Mimecast-MFC-AGG-ID: BPnhmyxvMPCrPcgnP5RLIA_1772572542
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-503915b0a88so661311401cf.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2026 13:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772572542; x=1773177342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmGZI5WblWd631ssrKt08f4BijC6XK/3q+5rIjFI99c=;
        b=B0qN0E6iHUjtj5H5r8OZlT8CV/1awFd20j8XrWKPadjilWen9mvG5kLn3n1MxJr2q8
         uq8rBp8Q9LKycQJLayAaW+tB7SxzLHZoZ2zIyRpFdjtRJUrDI1End5DeZhbu7T3pOqHS
         hz0TG7fk9XLp1639q6soPgbBYYLFaBq/ls29gYEMsr3g48f33hUPcLbjVnx0MOcXM9Wt
         8tMBGR+rmxSc56PnxnwvQXP8IjisR7hO7/+KM7FbBl95pYMEPLxOb3ayMoBmHLnWReIS
         Dq9+B1WC5NmEgflA/mcRTZgSAQuZDYEDuBHCIhBB5sNKoVBiI+0Gb+8a8e/HnRUtyYro
         /CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572542; x=1773177342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nmGZI5WblWd631ssrKt08f4BijC6XK/3q+5rIjFI99c=;
        b=Lv2hMr+SbjS1FcZdA9XnQAs/MZ7BHNPTnaxrEnguOVRrb5OL3lkJiAMfhrs6MUJvrm
         XgvJWIheSw4qz2wkgs1imJj2yl4geKExiX1vyau/1KK5BtbXSkCWWMLAF61GgXpeCHqW
         cL0I+nbbcgi1W27uGHfgIOtT0beuSOv1CFomxHUuzfmxlNv7azADGqdYY0OCFhIsux1X
         gy69XZa2FNu9gyEQxnLGJGQNGfCXabKxb26J7sHk2/HVnS9bEHUCn2KEl0kmqhFuOuUW
         Iou9xMVcZ6J5SGWau0SII+us57zIx+hR6jDc52rj+n9IvJiPsZ4zJ5x2igcFsR1++8Ff
         zMUw==
X-Gm-Message-State: AOJu0Ywxhoz66a3A6Cgzh7AGTBpUBjZsk90U5fSVW+bxu1cbuSlKnzLf
	93esJ4mlSpzG8JxI0rRpkfUsGyMlfbsaSJJtdy9VqncXjipmckOfqhww/UjsquU5LTDCFCJtaeF
	RLJ95PU4JTaKySXINAg5o6qi4XxLRsX4GUQiO3kDKn9+mLTc8ifvyXFDGZ/fR4w==
X-Gm-Gg: ATEYQzwlPiJ1ygTn3rfwL3PsrIQOzy9MFq6NB2Bq3b3GoOIlsrRmVkXmyrkfGTiapxa
	wkmvOZfz7TVZDOaRktljqBrq6pPYL/IsM7o1vq2evOLkT6SHQqbJx/b6EiOofggBXIaYbdpiKHX
	TnC8K7QsX24YalSyyDpypN6vI/pC+8TMUHZUN01/AklsVC1A0F8V8A8P6BeAuWdrXlt6OluzQum
	H3vt0UYb2SFaqnlVjLKDKssEbFZiuCu6iL2HG8hJ1z3X+AOeYSYpbQU6r5cDRtVb38IsTEumn+x
	Zb1fD6Yetn/9DXYQnko3p03c+00C0EGPBDmXPv6SdD+tQzDPhDNbUSzQdOcpOnpQO/iY47CXV05
	8JNKDCJ5PJ8VKEGY7+k8rRIN2rQ==
X-Received: by 2002:a05:622a:18a8:b0:502:a1bc:5691 with SMTP id d75a77b69052e-507525a5444mr232050501cf.0.1772572541825;
        Tue, 03 Mar 2026 13:15:41 -0800 (PST)
X-Received: by 2002:a05:622a:18a8:b0:502:a1bc:5691 with SMTP id d75a77b69052e-507525a5444mr232049271cf.0.1772572540438;
        Tue, 03 Mar 2026 13:15:40 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b1e3:9a00:3c7:56c2:f819:96d2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm156286991cf.0.2026.03.03.13.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:15:40 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Tue, 03 Mar 2026 16:15:24 -0500
Subject: [PATCH v3 04/10] rust: pci: add vtable attribute to pci::Driver
 trait
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-rust-pci-sriov-v3-4-4443c35f0c88@redhat.com>
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

Add the #[vtable] attribute to pci::Driver trait and implementations,
to prepare a subsequent patch that adds an optional bus callback
sriov_configure() to enable or disable the SR-IOV capability.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
Changes in v2:
- Add missing #[vtable] attribute in PCI driver trait example.
- Add missing #[vtable] attribute in nova-core driver.
---
 drivers/gpu/nova-core/driver.rs       | 1 +
 rust/kernel/pci.rs                    | 2 ++
 samples/rust/rust_dma.rs              | 1 +
 samples/rust/rust_driver_auxiliary.rs | 1 +
 samples/rust/rust_driver_pci.rs       | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5a4cc047bcfc9fcef61373ace84ed43958a3bcbd..66a68048006fb33477bb00f61856c1aa92c0a8f1 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -64,6 +64,7 @@ pub(crate) struct NovaCore {
     ]
 );
 
+#[vtable]
 impl pci::Driver for NovaCore {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index e1cab1574a3d309d25bf5267c0b0d8da8fb66d44..a4c27c674bd8bdf5e3316789d38d566e90b93fe2 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -278,6 +278,7 @@ macro_rules! pci_device_table {
 ///     ]
 /// );
 ///
+/// #[vtable]
 /// impl pci::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
@@ -292,6 +293,7 @@ macro_rules! pci_device_table {
 ///```
 /// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
 /// `Adapter` documentation for an example.
+#[vtable]
 pub trait Driver: Send {
     /// The type holding information about each device id supported by the driver.
     // TODO: Use `associated_type_defaults` once stabilized:
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 9c45851c876ef33414eb0071c42a2fb4ac3f1e78..ae6f7328b830e32bcaf7f8b5f8b1f117135ebf8e 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -51,6 +51,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
+#[vtable]
 impl pci::Driver for DmaSampleDriver {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 5c5a5105a3fff90f5e396186776e1b3ffdf479b4..2f7ac8f7391f45827c086b704950fd01907c1825 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -65,6 +65,7 @@ struct ParentDriver {
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
+#[vtable]
 impl pci::Driver for ParentDriver {
     type IdInfo = ();
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index d3d4a7931deb0c1085cfd817990737717f466ea9..27e603a9509c19b6845c10ef06a0af897aa0e84b 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -92,6 +92,7 @@ fn config_space(pdev: &pci::Device<Bound>) {
     }
 }
 
+#[vtable]
 impl pci::Driver for SampleDriver {
     type IdInfo = TestIndex;
 

-- 
2.53.0

