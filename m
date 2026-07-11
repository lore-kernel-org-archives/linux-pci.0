Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841D2C21E6;
	Sat, 11 Jul 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783786272; cv=none; b=Y/m1XE2+ipSB+nxNf2YabZzi7NcqmPw7yB9Mo4hb0on80LhbltnTapE1hTyxfPWwaritCXI73UP6algB3yFejW6ZC2D/obnfKSmXC3AHUYN5LcLSlBCO02OGK7113QehDYBXFm4a+YMrxACPySqGKcvboJEt8dC6pDvzIof3WyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783786272; c=relaxed/simple;
	bh=PEmfnP3Viq0Iq57bVtkUe663Z9qvI2bWV0EPII+zm3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHD6SciXtHgrcJ6ILjhIZ4l72CVGGmf1WUKG251cfbcOz1otVtUoFYmXsXjhqh9yR6In/3pKB2LC7AsfDfGgpBxvDVh/o9JI7yuqFoFdddVgnaHH/9TX8ohvCWxXxZeVkfxyg63z/e5hR09j6mzsVEN9gdHjhm0w0BGX1uJrvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lArd3Na1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lArd3Na1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5631F000E9;
	Sat, 11 Jul 2026 16:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783786271;
	bh=l157i8Cbrra3gsqHh/wXLRqMCSqeyLs3OdEljp8wurU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lArd3Na1tBACCTa0rtlAkbcQ+djURemz6aRjlt6N0k/8t6r0PBRgovVvcyHCDbHzA
	 LJwYirK/usCJULhtOoOIqTJDf9ZLKevYYc2OU8GG9bTsLm281wrQNBsbZF8u8B6LOC
	 w8G3MjGwmEdaPpbIlk4SZBdIr/XLdvY8Km86tNKxbqPu+BCHBwyqaEXqLtUCW5kGAk
	 mTs10adg9ucQ/28mQ4N/G7R9GfS7sJuMi4pzJgxHJ7r9v/9/rhbVh5Lv83aDCB/mG4
	 CdVGUi5+2Z1raFOA8856mTZUnkfLayu7BgYnzHGHZgAEAXkMPpEbXMw72EsjOsfXsZ
	 92Ix6+oXxDefA==
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pwm@vger.kernel.org,
	Laura Nao <laura.nao@collabora.com>
Subject: Re: [PATCH v6 00/20] rust: I/O type generalization and projection
Date: Sat, 11 Jul 2026 18:10:36 +0200
Message-ID: <20260711161035.370023-2-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 06 Jul 2026 13:44:13 +0100, Gary Guo wrote:=0D
> [PATCH v6 00/20] rust: I/O type generalization and projection=0D
=0D
Applied, thanks!=0D
=0D
  Branch: topic/rust_io-7.2-rc1=0D
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-=
core.git=0D
=0D
[1/20] rust: io: add dynamically-sized `Region` type=0D
      commit: 426c92ca1bdd=0D
=0D
      [ Add brief explanation on MIN_ALIGN. - Danilo ]=0D
=0D
[2/20] rust: io: add missing safety requirement in `IoCapable` methods=0D
      commit: 65f6abf9fa81=0D
[3/20] rust: io: restrict untyped IO access and `register!` to `Region`=0D
      commit: 6461c5776bf0=0D
[4/20] rust: io: implement `Io` on reference types instead=0D
      commit: 46b1b54139c3=0D
[5/20] rust: io: generalize `MmioRaw` to pointer to arbitrary type=0D
      commit: 9734e905119c=0D
[6/20] rust: io: rename `Mmio` to `MmioOwned`=0D
      commit: 691c75967d44=0D
[7/20] rust: io: implement `Mmio` as view type=0D
      commit: 9f64c84af008=0D
[8/20] rust: pci: io: make `ConfigSpace` a view=0D
      commit: 6e5f28968d7b=0D
[9/20] rust: io: use view types instead of addresses for `Io`=0D
      commit: e0454ec1220c=0D
[10/20] pwm: th1520: remove unnecessary `deref`=0D
      commit: 0adc93b85374=0D
[11/20] rust: io: remove `MmioOwned`=0D
      commit: bed01ca9e9cf=0D
[12/20] rust: io: move `Io` methods to extension trait=0D
      commit: 9b36c13cbd4f=0D
=0D
      [ Add comment explaining the purpose of the Io blanket implementation=
.=0D
        - Danilo ]=0D
=0D
[13/20] rust: io: add projection macro and methods=0D
      commit: 1f989555fe5c=0D
[14/20] rust: io: add I/O backend for system memory with volatile access=0D
      commit: 2fabff780785=0D
[15/20] rust: io: implement a view type for `Coherent`=0D
      commit: 1d409d1e7a87=0D
[16/20] rust: io: add `read_val` and `write_val` functions on `Io`=0D
      commit: 89814c42c19e=0D
[17/20] gpu: nova-core: use I/O projection for cleaner encapsulation=0D
      commit: 0722567f5085=0D
[18/20] rust: dma: drop `dma_read!` and `dma_write!` API=0D
      commit: 6ff7d69b7e6e=0D
[19/20] rust: io: add copying methods=0D
      commit: e7219e53c525=0D
[20/20] rust: io: implement `IoSysMap`=0D
      commit: 11a4784f902e=0D
=0D
The patches are in the topic/rust_io-7.2-rc1 topic branch and will be merge=
d=0D
into the corresponding target branch soon.=0D
