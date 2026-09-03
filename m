Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECCB4FECC1;
	Thu,  3 Sep 2026 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463400; cv=none; b=t9H/IPxtVM6EHjmccA/zEuTS48W2Se3IxJ/vNbLjfHTJ0DfW9rbgoZYTsd7Z1HFXhpv8JkPvSmYrXnymF5Zfa2xl9mQDKAeYf12dtOZnXNCzRSYSXWG9aq8lj0pLuHYyhUsYuHTygCb8z8LHtvxVMDSFJrs+RhwyIIvu8/JqLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463400; c=relaxed/simple;
	bh=SC12UwwV5la5+z9xpG2T1lhISLeO3GCXp9Z+NUbIUV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=davlOM/B4kVAGy/AFumyin4n68cmulqCbVU4cB3jvkeZSJ4FTjW8U2cN/QL8kIaSs14OPt8Q0SRELYK9Db66iZNTxUXwd3JZotBBQ3/xaNbwzXtftLo1QJ3hHj+xXs3Y9Y1hpdDEQrX2CeuMHtIm03+NIDBRMGInlLj5eEK8+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUVHrE1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUVHrE1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81151F000E9;
	Thu,  3 Sep 2026 19:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788463390;
	bh=M//v4OlN6lA74lYfatdtwp/pjR6qLsg6V+uG4pDwqbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IUVHrE1Nu8l8phRUdBa7pS6Vop9cvMyvheupOvgqzSdmM7Q6iK42Y9rjOvwNZnxum
	 YbrkOhKwCTh8iIsQm9KBckb13pEN2GUQAHuffDsopuP6KUu3Qk/zbPJQF/YIsHBwO3
	 +eNnAGS+xPWHudkGGDjK835IluKjBMbP+qW3e4niEqeVkLRTXzq4/dxVZHfXwnsJwq
	 7ZBp2NqODTvwKYmLHa3GiyuL1fdUEvD+CdM3j75ptc04mLKQSfD26rWh9XfacoGOvz
	 gRkJzUlcZ2GKhTM7WwN+FKlX6hRhOViqDwQrL+RBl6MXcbMXSc4yFDABiwyDSaU3SB
	 VGu3zxKId5rBQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 00/16] rust: io: support register projections and remove relative registers
Date: Thu,  3 Sep 2026 21:22:48 +0200
Message-ID: <20260903192248.2248560-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 17:50:24 +0100, Gary Guo wrote:
> [PATCH v4 00/16] rust: io: support register projections and remove relative registers

Applied, thanks!

  Branch: topic/rust-io
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/16] rust: io: register: reimplement as proc macro
      commit: 63b2578517df

      [ Fix typo in module-level doc comment and fix ArrayDef syntax
        description to match the actual macro syntax. - Danilo ]

[2/16] rust: mem: add `transmute` with deferred size check
      commit: 82591c20bcb3

      [ Fix doc heading to use plural "Examples" and add missing closing code
        block delimiter. - Danilo ]

[3/16] rust: mem: add `AsRepr` and `AsReprMut`
      commit: 968f30ade612

      [ Fix grammar in from_repr_unchecked() documentation and rephrase
        confusing safety comment. - Danilo ]

[4/16] rust: io: perform conversions using `AsRepr`
      commit: 1e707b76716a
[5/16] rust: io: support register projections
      commit: 34b6dc471749
[6/16] rust: io: register: allow explicit base type specification
      commit: 70a122d5a342

      [ Remove unnecessary #[allow(unused)] from the 'base' field. - Danilo ]

[7/16] gpu: nova-core: specify base type for registers
      commit: a07fa2c979c1
[8/16] drm/tyr: specify base type for registers
      commit: 573228e75c33
[9/16] samples: rust: pci: specify base type for registers
      commit: 54b04b9fc0ea
[10/16] rust: io: register: make register have a typed base
      commit: 35c21468c294
[11/16] rust: io: register: support fixed offset register without bitfield
      commit: ddeaaa3a0fbb
[12/16] gpu: nova-core: use projection for PFALCON and PFALCON2 registers
      commit: 6d5f14077811
[13/16] gpu: nova-core: convert hshub0 from relative register to projection
      commit: 4a7a27bd1947

      [ Split nested import into kernel vertical style. - Danilo ]

[14/16] rust: io: register: remove relative registers
      commit: b6af037d9499
[15/16] rust: io: register: remove `Register` trait and cleanup macro
      commit: dfec6f41d053
[16/16] rust: io: register: unify handling of register with/without bitfields
      commit: 35423e8fd718

The patches are in the topic/rust-io topic branch and will be merged into the
corresponding target branch soon.
