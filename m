Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF3D5237AC;
	Thu, 15 Oct 2026 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068005; cv=pass; b=S4U62gYeP+SJ6TIcwAsFn/NRYR90k/pTLISDcuR53DiW06ReOXmxfkVJylhJCwtu9q9uwKLfaU5PMzPurtjMDKUhunpQwOELJtG24oAX21aQ3Wd96REtpObaZeHmnKRPC3D02j+gNGt+lTTPpzKpX5xwcd7C3857g/RxciXMzjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068005; c=relaxed/simple;
	bh=OQ/2ZTObRXfXyA1s1RLOwAja4CiHkovNX0EvPoYCNPU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KNXAsFtJxtvpA2LM5eqFfL3vB78dseoG5S14chtZzWOJTVyhXZuAmeGFE0V6jKW8+QHxIuglrSI9ROKmMUjA7RyMo+XguOJg93nAio/0nuDqsc73UHToYziNYlocTPYnIXN3J/90OgUKCq5IYuZc0+QnLK8jQ78kQdPrm82cT14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=QdSJw4To; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="QdSJw4To"
ARC-Seal: i=1; a=rsa-sha256; t=1792067961; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Tjon6KLoMZGTD3gYcYFkxUTwF+kL/rEvtPXr/cLuEUe0xAJZEi4CaPX5SAOalGxj47gyaa7EUmOWssido+ThW29/sXeDlFM4k2lnvT5Wh2kUBslvTcUoOp3UumqasYY72nBCuqqKkyIAHS4U1E4B/efPA3B0+5GyJsE/aLw+qLQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792067961; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b8QxlcXuE8fvWepGOYNbeyD9I1BGJwMpPeaLkpEcykM=; 
	b=Fpk+np0RBTlIkbUHRGiugJ20uaCXC0VsxEl2oFYM8i4oxQKATFX3oSlr4dGQKBN28JExT0xlke9QmFGWgUnDmBpOyIdlM2GKKHIQq9gBGu6GwyjCmzhVVgTo4IjLrGzv9CUDTtD/fTAYVjiEV7QC3rbX0L2x3tOoZMZnnpsZgnk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792067961;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=b8QxlcXuE8fvWepGOYNbeyD9I1BGJwMpPeaLkpEcykM=;
	b=QdSJw4To7te5oLZBwuxM/5Rm1bpc3a31680SH4Uhs+gIggIWD/6BUt+jejrwcLiW
	9LH6cnMbzu/uzMhEaEtQb6R5kuIY1KWIw0N2xRl4/6vrQxvL2KMH7YpIbkwamL3e6fF
	yPlMA+B2TCNfJwyQRiScx8bSmHtRo6NkqtslmNLY=
Received: by smtp.zohomail.com with SMTPS id 1792067959377676.561264213707;
	Thu, 15 Oct 2026 05:39:19 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH 0/7] rust: io: add read-only and write-only views and
 registers
Date: Thu, 15 Oct 2026 09:39:04 -0300
Message-Id: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAxA0atI1g3MjFS0VyldxJhqhDoyURHEu
 3dsl2/x/wEmScXgURyQZFPTOGX4WwE80NQLapcNwYXKO39HjUjMYoaf2Imhb4hD64hCWUOu5iR
 v3X/H5+tvW9tReLk2cJ5fAraH63MAAAA=
X-Change-ID: 20261015-io-access-modes-19ac2b0aa238
To: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

This series adds read-only and write-only I/O views, and the #[ro]
and #[wo] attributes to register!. An access in the wrong direction
then does not compile.

This is needed by Tyr, where the doorbell registers are write-only and
the CSF control and output blocks shared with the firmware must only be
read by the driver. Laura's CSF interface series [1] will be the second
user.

Patches 1 and 2 split IoCapable into IoReadable and IoWritable, and
IoCopyable into IoCopyReadable and IoCopyWritable.

Patch 3 adds the ReadOnly and WriteOnly views, returned by
Io::read_only() and Io::write_only(). They wrap any view, and the views
projected from them keep the restriction.

Patch 4 makes the primitive accessors (read32() and friends) project the
view directly instead of going through the generic read and write
methods.

Patch 5 lets an IoLoc carry an access mode, which is applied to the view
projected through it.

Patch 6 adds the #[ro] and #[wo] attributes to register!.

Patch 7 marks the read-only and write-only registers in Tyr. Where
regs.rs does not document a mode, it follows the register permissions
for v10 GPUs in Arm's kbase driver (r54p1).

This is based on drm-rust-next.

[1] https://lore.kernel.org/r/20260915-tyr-interfaces-v1-6-5d28f1f75aca@collabora.com

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
Daniel Almeida (7):
      rust: io: split IoCapable into IoReadable and IoWritable
      rust: io: split IoCopyable into IoCopyReadable and IoCopyWritable
      rust: io: add read-only and write-only views
      rust: io: project primitive accessors directly
      rust: io: let I/O locations carry an access mode
      rust: io: register: add `#[ro]` and `#[wo]` attributes
      drm/tyr: mark read-only and write-only registers

 drivers/gpu/drm/tyr/regs.rs |  77 ++++++++
 rust/kernel/dma.rs          |  29 +--
 rust/kernel/io.rs           | 416 +++++++++++++++++++++++++++++++++-----------
 rust/kernel/io/access.rs    |  76 ++++++++
 rust/kernel/io/register.rs  |  71 +++++++-
 rust/kernel/pci/io.rs       |  10 +-
 rust/macros/io/register.rs  |  34 +++-
 7 files changed, 595 insertions(+), 118 deletions(-)
---
base-commit: 5a1b7121a6c4db6c0239d3ac3fd1c2bb33a40025
change-id: 20261015-io-access-modes-19ac2b0aa238

Best regards,
--  
Daniel Almeida <daniel.almeida@collabora.com>

