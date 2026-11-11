Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397518;
	b=NWJWiSjoHEfi+XAtHyZ0kxfCV5vK0HlfiANgm+DvbLTBSlMQQUmtX3B4xj4GzPpL0Uza
	 psfbIjWFc/R91y6k0NMF19XgvqcZAfdzxweXYl8NGokG6Tu7W5EGii3RF2K8e6v2dvauI
	 WoIfm/XXZzoUGD3OGc3j+2/til4smcRKKk1Z+/NQlCDy+5s6TJZzFzMSrjGSPVg0MucPY
	 lYe2o+YogVQmP8N2w9bQsjMiMVDMO/jwg4u6JbFzK+VwVIeEU8VVoAWMh5sewDwi2FkZe
	 qrYp9eO12m6v4IlNNsGaapZ2n2bcK5xLq35f4hN0R/pzBn6q1PwYIZEYkH2+L6jOSKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397518;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-Patch-Reply:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9odmmksbvbXK9RpsONFmoCAl5mLWfbpD2OKCSrcI/Ng=;
	b=TOOMflad5lBu98msBo4thvEwGNIVBuMWKSzdUcyplrwe1Id76TED+yD3DOdoyQ77r7Dk
	 CLUd/r/qWR9IuOsXr44iI0qMZ8/cAmGRadOr0mGLXd4bfdykG/JivZgIjTXmkoMAMMRid
	 HKf8yFHpyKw0tRqDGlXJXkR36cp9ldYtwuAy5hhbAJJ6WEuCdGwjp9dqnFsn/D1+QL7D/
	 5301d/nIkpzDYW/RSRb2lwtBSoeelTzWGKh+FdNoUcbIVtHldso5TOXN/7TZHxxSuTUL/
	 9W5hlYcjGul7DJUYmfeBVMKbX7B3niVtIyiMKeRaw9alrNVmZLxaDlrDcHdlJe7d+sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3pbwZsz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4E606A331;
	Wed, 11 Nov 2026 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3pbwZsz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AC91F00A05;
	Wed, 11 Nov 2026 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794397518;
	bh=9odmmksbvbXK9RpsONFmoCAl5mLWfbpD2OKCSrcI/Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E3pbwZsz6ScOB1sFCMSC8hMZAbKKzFDZi9iab8fbnpunpZlywdQ/WPNumIn5dMaeX
	 Vdy2qAASqhIbJhv0bKzVWqQ+u70Dqnzp/3yMMdkWwqyFiRwfy/61+El+WXVq2OVrlS
	 EZvtNABcLiRoCIPc/KT0MTFehP56I48ZjPiPzagAfcm1AV1J6LUW4iUGUVNZ/q3gr9
	 MydRvthWo7O3BlsrSZOj2GIJyjXrj41ZbP3OpD99qTLawM4H24jXG2ihscwuqZ1Zpg
	 78B2nHYAHY9MwFlS05aYiyjtwaUrXNzg5RPK5PkkRLE2Zy72tz/u3MdK53rNqu2VAD
	 fJLn4qw4wXDwg==
From: Danilo Krummrich <dakr@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] gpu: nova-core: add two prerequisites for the r000 GSP firmware
Date: Wed, 11 Nov 2026 12:45:11 +0100
Message-ID: <20261111114511.562279-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110033655.148487-1-jhubbard@nvidia.com>
References: <20261110033655.148487-1-jhubbard@nvidia.com>
X-Patch-Reply: applied
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon,  9 Nov 2026 19:36:52 -0800, John Hubbard wrote:
> [PATCH 0/2] gpu: nova-core: add two prerequisites for the r000 GSP firmware

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[2/2] gpu: nova-core: factor out and expose Falcon::is_processor_suspended()
      commit: 6e557330b874

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
