Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795558909;
	b=dloCBrbKiXPG55bbNRjDppqLu1hSuteOszeAKNyk3BtTJRmLmzlEHFQ/CFKq1WoSL3+Q
	 pis0O5kd6iagfYva6TXz03RGSmZ/jqIXGjFjzgKdXEOGcRHMsvlkKzmDNbpHKJQWh+oXo
	 Kqgc6KCsptgyHp89kJABUKkmh1x98Jy4ENomUN4bEvghMGIJLhKb9ioaLmtwRsE1l5DYX
	 JjbaCkVbWE3QdyLwKb9xnVh7GQhJ8WyGNiSEWIsNZ9PZpfMr/blIMw5oBmJT7yDOBWLUh
	 ++iVe0Jsd0XxJuhwGCOB+wsYYoYyoB+fj+SwPoA4Zs7Dnt1b02Rk8HdsquKdcwuXwwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795558909;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-Patch-Reply:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=oKVvl+Rf2neqQIoPuWXSrWxr2CVrLHBFoRvvQa6Paew=;
	b=Y2jK20de/GWEkkNXE1zqqDyk8LHc9NZMfVu9awSuxgvG8rJ/vCwfJ9w4hDC9XiZRkoPX
	 C9HBNnE2otGTgJSbGYyV6S3RS7J5/l3Z/W7MSJPIy3/zzeIcbAwFNRVKzDcPvZPU1XRna
	 5P1tL6FuKYaCMhRUllTlcLWkncOWBcTKZd19rErwYkKgrmMFB38u52w0jQdG+TCr+Cdfq
	 iM/Bpqg2byBZ0Xk5GIrC6YFSztWxsO1ezfcVtHxNwYcssjHGg5Du03CRBNpavXgdrVw7d
	 czLmqLNykbVtQAednr39fQog5NdMc1V/6bT5oO+bA1+T4BQZWFQpsFKoXddgeGpfEsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrYN+lxG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57307606A31E;
	Tue, 24 Nov 2026 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrYN+lxG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ABE1F000D0;
	Tue, 24 Nov 2026 22:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795558908;
	bh=oKVvl+Rf2neqQIoPuWXSrWxr2CVrLHBFoRvvQa6Paew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IrYN+lxGsElt2tX2RKLt0jlr8DGHREKvRQCsdfuzj4oSeVObDlg+GTaS4E4ItmK/O
	 GTnQEl9OeUwZ8FLbgZlBuY7mktztTpKEo8DxWIkN7obYttTBrSW0QSdccKOFGDLSAb
	 cuSoVic+zf16VLR/VqHem6u9YOXinT1xxIq2ogCMd22cS27piSIXouNYQ1nYVdj/d5
	 9y3dS+qAw6B6y3NiEqErSqa1lTbyuxe/u39MKemD/VBpbvnlXEFS6sPkIjmXQpC/qV
	 rjIasUIJiWdEtLcZo6YTpq1iwphq14J0UeqU/nx/GX/zMYnM98sZ7kHGy8Il7LvmXg
	 EeI37NNYWXCLg==
From: Danilo Krummrich <dakr@kernel.org>
To: Simon Song <xinmengs@nvidia.com>
Cc: dakr@kernel.org,
	acourbot@nvidia.com,
	kvm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	alex@shazbot.org,
	jgg@nvidia.com,
	yishaih@nvidia.com,
	skolothumtho@nvidia.com,
	kevin.tian@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	jhubbard@nvidia.com,
	ecourtney@nvidia.com,
	cjia@nvidia.com,
	smitra@nvidia.com,
	kjaju@nvidia.com,
	alkumar@nvidia.com,
	ankita@nvidia.com,
	aniketa@nvidia.com,
	kwankhede@nvidia.com,
	targupta@nvidia.com,
	linux-kernel@vger.kernel.org,
	zhiwang@kernel.org,
	zhiw@nvidia.com,
	boqun@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	work@onurozkan.dev,
	jgg@ziepe.ca,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	dri-devel@lists.freedesktop.org,
	peter@colberg.org
Subject: Re: (subset) [PATCH v3 0/9] Rust VFIO PCI support and NVIDIA vGPU driver
Date: Tue, 24 Nov 2026 23:21:36 +0100
Message-ID: <20261124222136.2363532-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119215046.2892839-1-xinmengs@nvidia.com>
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
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

On Thu, 19 Nov 2026 13:50:35 -0800, Simon Song wrote:
> [PATCH v3 0/9] Rust VFIO PCI support and NVIDIA vGPU driver

Applied, thanks!

  Branch: topic/pci-sriov-7.5-rc1
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/9] rust: pci: add VFIO override device IDs
      commit: 50e74d48053e

      [ Slightly improve the doc comment. - Danilo ]

[2/9] rust: pci: expose the VF index within its PF
      commit: 563a20c3c250
[3/9] rust: pci: allow drivers to manage DMA ownership
      commit: 867380955ea7
[4/9] rust: pci: add reset callbacks
      commit: 4db2aa70fd43

      [ Slightly improve the reset callback doc comments. - Danilo ]

[5/9] rust: pci: add an error_detected callback
      commit: 817438b2de84

The patches are in the topic/pci-sriov-7.5-rc1 topic branch and will be merged
into the corresponding target branch soon.
