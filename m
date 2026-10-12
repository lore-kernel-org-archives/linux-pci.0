Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4211A4A6CEC
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834030; cv=none; b=Lzg/xKAhz71OzHPXu2YuRyDzgGVcPKVLK3OmwyXJLjJxwGhdAzZAD/3x9vjl6GLQw4yq0YTHXgSsWdVCC5OtHDLRYfhaEofOz8qg2hguAAWHaSm8MUzd0cYRp5Gfi2h09TX3w0N81xWtZ2cwxyFJOjnGVkqsmqwqCMp2x5UuLNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834030; c=relaxed/simple;
	bh=0rr8uH3MNk0yPU+CRZPr7sMXDh0YYZvMIzqHEWd8JN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayLUE8ApV4QmUiTNiu7JDflod9uLjOMv9vT5gabQp0Msq1FX6vcbBiGAqf27YkHZBi9gN5uN5/BadkXKOZh0topvZa9qdV684bdfzKQau7OgkJ5PjL6Cwh/HyXZPlF2wJ7uh4NW/9ba8Bh73G3Ser+8CT5YBmLv6NHcLmQ1zgRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=varram.me; spf=pass smtp.mailfrom=varram.me; dkim=pass (2048-bit key) header.d=varram.me header.i=@varram.me header.b=kaQcBx8T; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=varram.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=varram.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=varram.me header.i=@varram.me header.b="kaQcBx8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=varram.me;
	s=protonmail2; t=1791834018; x=1792093218;
	bh=0rr8uH3MNk0yPU+CRZPr7sMXDh0YYZvMIzqHEWd8JN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kaQcBx8TVbXB0m2ELbR9skuUwmX07YJLisqJqiTpfAtDjUnUBykMbNYoq1tiD8v+u
	 aslfAhwfuB78kW91IXBntdgB2eDUiDuEIn9lmE7bhQety41EQCp/kidwzTK6Y4yfYa
	 IXLFrWUIGqnr2KSqNKhvVAemOTKX4LYZvbeGLFvOPH2+WP5g3sjHVUBC2AAu09HngN
	 Vv0UbEQY+7d8lu3A1JWaMz9vefpTB9+/k88tHiZbwCw0TG8q20eTH9sm4zkasIs3kz
	 BII035RvZ7I4c/lK4VoCgB8/Tpgjf7tzSHrrQRRfcxj0ZNFJ7d89FLmPjfPwyXcX9p
	 gohv7WFGr1Hrw==
X-Pm-Submission-Id: 4j3SVP636Mz2ScX5
From: Varsh Satti <varsh@varram.me>
To: Rickey Bartlett <subtexel@gmail.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Flush initiator posted writes before demuxing interrupts on Meteor Lake
Date: Mon, 12 Oct 2026 14:40:11 -0500
Message-ID: <20261012194011.48215-1-varsh@varram.me>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260825043220.9047-1-subtexel@gmail.com>
References: <20260825043220.9047-1-subtexel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 24, 2026 at 09:32:20PM -0700, Rickey Bartlett wrote:
> Meteor Lake VMD (8086:7d0b) is affected by erratum MTL016: the VMD can
> signal its MSI before the posted writes carrying a child device's DMA
> data have landed in memory.

Arrow Lake-H is affected too. It uses the same VMD device ID
(8086:7d0b), so the existing match already covers it.

Hardware: ASUS ROG Zephyrus G16 GU605CP (BIOS GU605CP.307), Core Ultra 9
285H, with a WD PC SN5000S (firmware 34230100) as the only device behind
the VMD.

Without the patch, on 7.2.9, I got 13 "timeout, completion polled"
events in about an hour of desktop use. Each one froze the desktop for
up to 30 seconds. Disabling APST and ASPM
(nvme_core.default_ps_max_latency_us=0 pcie_aspm=off) did not help: I
still got 7 in a 10 minute boot.

With the patch backported to 7.2.9, there were no timeouts in 13+ hours
of normal use (~340k reads). Average read latency went from 77 ms to
0.49 ms. Apart from context, the only change the backport needed was
adding struct vmd_dev::features, which 7.2 doesn't have.

Since this fixes 30 second stalls on laptops that are already shipping,
would it be suitable for stable?

Tested-by: Varsh Satti <varsh@varram.me>
