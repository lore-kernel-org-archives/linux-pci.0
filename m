Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7323E49C7;
	Sun, 16 Aug 2026 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786924675; cv=none; b=bjCrxmEZiYnHVTxfzLKBVG1T3EQ7ToQH9p1hPvIaOtkhJvRhyRl4HHvhfl7oA0pPNs8kBQhdyW1ALVGKcZqjzZr4b3c7pAyrDCxDhv3Ti87kgbhq71ufEHIIqwaWfimp0OsT09CdlQhMkvvwfkcgFfi4E3ipfF+a2Uc+PRLLfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786924675; c=relaxed/simple;
	bh=QPDOqpxrjN3QBcYOLC9kGMjIGXMlUkpeIp4YrXXrfQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWK49DgHsdN+noIEEg2Ek8cmHWHCD3DP4yvjW6yfpFZmSqY4y2dL0xYj9iV6ie2wYvBWPvyBxqLm2s4ETTRuC8AWQphqnozk6STZgYojtbmkWmYQ9fLGY5eumxZJpBXpq2l2c5XbUp8n/LtH8bt19EyXBkJCNdqyr1/UD4W5Jww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlGPT335; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlGPT335"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C411F000E9;
	Sun, 16 Aug 2026 23:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786924674;
	bh=qtvnP0LtDe8Hti1OyUjc69500NzUGQMPeXz+jX4MKW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VlGPT335RaYCvhnTd/SxzkCXQO1OPE6jJA0S0AKpPq6u1pRy1p6fauasFZcPGLPt+
	 b6hXTk5mr/aaajPp1sPWVsAM6cgWa7z3IYRwxDPXxU2uZ2rVmG82yQe6wtWDSYwjrY
	 Lw4GhzP3D/ZtHa/0hP7mBZiN0/JwGOkWe5mJdfzILHdrVLbhMyDd/jxNzpSKtgtyjk
	 nNLytto5PHa5FROuZCNFaVERLImKKpON3EckRu4eq+lT3mxUUjBTjWHlwNYEATii6u
	 aCCN5KVaXZ82aJO4pgPRSC1idoiyWoW0AqN/gV8jY56SW5Vh8aTq0CNErDTVMEPhN4
	 koeQZFXS7A4eg==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	aliceryhl@google.com,
	daniel.almeida@collabora.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	jhubbard@nvidia.com,
	ttabi@nvidia.com,
	apopple@nvidia.com,
	ecourtney@nvidia.com,
	shashanks@nvidia.com,
	zhiw@nvidia.com,
	driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Rework PCI IRQ vector code
Date: Mon, 17 Aug 2026 01:57:46 +0200
Message-ID: <20260816235746.425240-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813165234.620555-1-dakr@kernel.org>
References: <20260813165234.620555-1-dakr@kernel.org>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 13 Aug 2026 18:52:00 +0200, Danilo Krummrich wrote:
> [PATCH v3 0/5] Rework PCI IRQ vector code

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/5] rust: pci: convert IrqVectorRegistration to a lifetime-managed owning type
      commit: 17d4a399e8b8
[2/5] rust: pci: resolve IRQ in index() and embed IrqRequest in IrqVector
      commit: 2fb7755b0a7e
[3/5] rust: pci: remove request_irq() and request_threaded_irq() from Device
      commit: 6ca38086b4ee
[4/5] PCI: Add pci_irq_type() to query the allocated interrupt type
      commit: f146c7bc85a5

      [ Add missing pci_irq_type() stub for CONFIG_PCI=n. ]

[5/5] rust: pci: expose the allocated interrupt type
      commit: 3b5ea0f078e1

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
