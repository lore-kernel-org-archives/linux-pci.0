Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956470;
	b=4/FRJhcHjgkSXkUOr5UuyGuQLgEZyqQXgleWj/mMv6YYRuopX2hcdFykPXfuBNaqfwpI
	 7IboCjvpM5Zsus5oX2ubOWI1iiHQJJtDZALC66SOynEqSvocJ0FzJvbuyaopXUgqAl87Q
	 mL0y5XTMzOoCofIU3YhiBpOPzCdpRYpHfnwbe3Y1ZlNxJy0YRkca+U+2cB08Y5z2jn32F
	 At6eI4ZmZokAzBSvnx5oATFpDX0GGOCOmovbVyDaso0cfE7YtYG0hQJSckrdSm0DWW6fj
	 PTXdb4Z1or/Var9nzB2en3Ool2PM7z8G+asb2139T9EOBuxTDOyR4n0rbZapun7mmWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-Patch-Reply:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ordF8Xl9MrG3IxJ3aZ5+9rpPu7ItAa1DdgPWffnzDzw=;
	b=cF7lx5U7Wkt92aaBjQaD3w2WBOs1o9EvCBPg0vEQ04tNdsKKyBRg6f0zn+07ft28W5lg
	 ZTGK7ddIXS2gK9ClUoR1alM0rLslruISaHmvDENXgV7hQuyd157mAKEEYvP8m6A/QXHTC
	 lp8LUic8Tcus/pd62onZC1TiGDi6s0d4bTCsR97uap9yvT8srhB5l7m2ONzBLSjGcB+Qv
	 47Jz+89uTQ0CuDKAcutpfOzszQ7KLCo7TBklmQMCqT+S+kag2TljQqrHqCGm31Aa5VsT4
	 8E2CAEW/lConuJGGvjfEPRvTTI1R8vzh9RKCNN5I6xGmUDAvbaJmNksZaghwM8ewj+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AUcHw7/r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FFC606A332;
	Tue, 17 Nov 2026 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AUcHw7/r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B397A1F000C6;
	Tue, 17 Nov 2026 23:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794956470;
	bh=ordF8Xl9MrG3IxJ3aZ5+9rpPu7ItAa1DdgPWffnzDzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AUcHw7/r4hbT4aHj5pUIw14vyA7+R51odcdkCOS6jMdFaMsfQmzJBW4q9KaGo4TzQ
	 mzbClE5GcBgvD+wVUgBX+wJ7Liew33463auMfPgzx10aJXXYHMNaagB+hWuOH2CSYI
	 eP/oUxLshvIvyqvaUBHMdo083tiEvmgC1zwOqnFPWDvTtmTusZIPzpN+TJyx4KAS92
	 +B4CCTIMbQuWhzXTHYLp8Y4eJ3DPmQ8ukwmPiJlqGeeiwQSJiC60fSgye2C6GrE7oc
	 AwLksyzml4w2pzaFmvktBGMbSm/dIG5IPSfsZBxQEVUK33+85gfIne4eq78DvC8Z4h
	 S29qfkKk82ixg==
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
	markus.probst@posteo.de,
	jhubbard@nvidia.com,
	apopple@nvidia.com,
	joelagnelf@nvidia.com,
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
Subject: Re: (subset) [PATCH v6 00/11] Add Rust PCI SR-IOV support
Date: Wed, 18 Nov 2026 00:00:55 +0100
Message-ID: <20261117230055.2181422-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111223337.508989-1-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
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

On Wed, 11 Nov 2026 14:33:25 -0800, Simon Song wrote:
> [PATCH v6 00/11] Add Rust PCI SR-IOV support

Applied, thanks!

  Branch: topic/pci-sriov-7.5-rc1
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/11] rust: pci: add internal SR-IOV enable and disable helpers
      commit: 04d0402a3363
[2/11] rust: pci: add vtable attribute to pci::Driver trait
      commit: 95a327110699
[3/11] rust: pci: add is_virtfn(), to check for VFs
      commit: c2e223197829
[4/11] rust: pci: add num_vf(), to return number of VFs
      commit: 06a9b147241e
[6/11] rust: pci: drop driver data before remove returns
      commit: 5120ea00f3f7
[7/11] rust: pci: add typed SR-IOV PF registration data
      commit: 5f0bc9be855a

      [ Accept any initializer error E convertible into Error, drop
        unnecessary initializer lifetime bounds, and adjust semicolon placement
        in set_vf_registration_data_ptr(). - Danilo ]

[8/11] rust: pci: add SR-IOV enable and disable tokens
      commit: 36051c35fdb2
[9/11] rust: pci: add SriovEnable::enable_all(), to enable all requested VFs
      commit: 666087381bc0
[10/11] rust: pci: add SR-IOV enable and disable callbacks
      commit: bcb6cb005449
[11/11] samples: rust: add a Rust SR-IOV PF and VF driver sample
      commit: 73d3502c8172

      [ Reorganize the sample into rust_driver_sriov/ with separate PF and VF
        files and a local Makefile, and move the registration lookup into
        PfApi::submit(). - Danilo ]

The patches are in the topic/pci-sriov-7.5-rc1 topic branch and will be merged
into the corresponding target branch soon.
