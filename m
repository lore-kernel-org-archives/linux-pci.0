Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A62E7F20;
	Tue, 11 Aug 2026 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491602; cv=none; b=HzEHTgp48/XlCkCI2DivTf4MSwutSNYaUA0crg8r42N0H4O2CKXPBRnz4bAHV9bkaBnQBvOVHimDeWb85Ld+aBuEfOfCAuITr+Kf6+6Y7V3VVSbLkuGs4O2iAVm7pOs+touX6s3vr2EYrtD/ZOxCvETGp6NZfdxPBuyL9GK9QJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491602; c=relaxed/simple;
	bh=q5gjVHYqEx6HSxACoftd1UB1dx+juwm7uwUFV7A2d9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCRkVTHLr+RKxaGwZt/2Cc7XoHeJ8YzYtgQBJWQWUCKDKv5uIwWBvTRLbk6bFy58WKaQkEK09L59Kz6OP3eeH51FiAiEjgjPfI77Xav7ydl5D/Sg51R8Onk2I0vMUpl3BIKmTQ7fmduCApBqr4rvI0xpaYTXDJAMPQgsqkevOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcpLa+X2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcpLa+X2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058BD1F000E9;
	Tue, 11 Aug 2026 23:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786491600;
	bh=WkgTJEu1MpUCIiw0gNRH3dwQwi8LVNrORLwhVthIoJg=;
	h=From:To:Cc:Subject:Date;
	b=lcpLa+X2Prj1Dewr1ZcwCjmmZqLTNaIGjJWD7m72zGrPXIyk1tKR/z+Dmgz13gm01
	 OfOAVv/bSHQC+M11qKsfuYoVntYlodp6P2/UsF47AwOfgsrhnK7F97hmJIQobHV26C
	 qenR1ZPxzZipTXciIpSmqn7JqW2G5agr0tO2PM+qHqMllSuJ025a2XOl+NvDJ2iLHS
	 S9Hmg2ErM9B0yf1gYX9APPPnmR9blQbge6eS1dJbh/EnPw/T+MP3RbeUpC668qhP9Q
	 XSlNiUZuKgpfOOfd+bKyJZu7wqSQ1HlDtiLylp47MfpOQYYBhU3TkMMNTbS61mcRDS
	 ddqfNAe36ZArA==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	dakr@kernel.org,
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
	zhiw@nvidia.com
Cc: driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Rework PCI IRQ vector code
Date: Wed, 12 Aug 2026 01:39:31 +0200
Message-ID: <20260811233952.3000968-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reworks the Rust PCI interrupt vector abstractions, motivated by
review feedback on the nova-core interrupt support series [1].

Convert IrqVectorRegistration to a lifetime-managed owning type, replacing the
devres-based approach. Since vector() borrows the registration, the returned
IrqVector inherits that lifetime, preventing the allocation from being dropped
while any handler is live.

IrqVector embeds a resolved IrqRequest, making the conversion infallible. The
request_irq()/request_threaded_irq() wrappers on Device are removed since their
&self receiver could refer to an unrelated device.

Add pci_irq_type() as a C function in include/linux/pci.h, replacing open-coded
checks across drivers [2], and wrap it for Rust.

[1] https://lore.kernel.org/all/20260808031120.363869-1-jhubbard@nvidia.com/
[2] https://elixir.bootlin.com/linux/v7.1/source/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c#L196

Changes in v2:
  - Drop the IrqRequestAnchor approach and keep IrqVector as a new type over
    IrqRequest.

Danilo Krummrich (5):
  rust: pci: convert IrqVectorRegistration to a lifetime-managed owning
    type
  rust: pci: resolve IRQ in vector() and embed IrqRequest in IrqVector
  rust: pci: remove request_irq() and request_threaded_irq() from Device
  PCI: add pci_irq_type() to query the allocated interrupt type
  rust: pci: expose the allocated interrupt type

 include/linux/pci.h    |  25 +++++
 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   3 +-
 rust/kernel/pci/irq.rs | 234 ++++++++++++++++++++---------------------
 4 files changed, 144 insertions(+), 123 deletions(-)


base-commit: dbaafe9cc56a996931eedfe043eb34418cc9cd9b
-- 
2.55.0

