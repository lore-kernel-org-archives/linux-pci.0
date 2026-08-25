Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3B23507B;
	Tue, 25 Aug 2026 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639292; cv=none; b=ikjGgTB288URELoS+9TA1Mc5Y7X2dZWdw8P8asLzU29pFxdXV/Ff8Qv5GADg9qKJJyUUU15NA6NaNTtinF+wrdN3uS40U+X1H2GWpraolzikeqnn7PZVy3/pZwf5uTg14282055FPhoPDCHGoTn4XzTGMWDmc6jzrWny3Pml3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639292; c=relaxed/simple;
	bh=ET4SZuMGA1L0rQXmKIZibFTiG++QZqvbSyMGtpg7rUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V+4P7sgf5nqvAVlL3eDlpkcIdPS0qDHp0cm5lw0A8QwcNjLOt2NqIupwWvwmEXZEmcS9cAvA/sZ9+terLpz6bEHYxByVJwT+w4jn/e+MwXpeqcNUbF7nAoqM731AnF8msBg+ktrWW3MGwdjeAcM374r9Myf5LXmfIcbDIVHJ3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVEAhocc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVEAhocc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1491F000E9;
	Tue, 25 Aug 2026 06:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787639291;
	bh=TP56VsXx4o6K0JUttMJo51Rr9+rzcKB07guB4pW2+gA=;
	h=From:To:Cc:Subject:Date;
	b=cVEAhocctiz3IGvk7fyBIg2AOTvIzbAHSnvFlWwjNMLxyOLDAmninH3TYVhdjr+rB
	 i1MPsoZp7XzvU4k3FaT4W0xsroh7cCWPH6LOMukTwyZJX7Ul/ZPI/806emzuF5wUPl
	 O6oTaj/L5HYfK+syLZK1+LVNZuWpgSGXavWE41+Gq+OCfS0t9UrLmPGpg4pgidtRJg
	 P0/Wov3NNvrsJnGNw/IL97svfQWOdzbvvCEV+VQ5lilhAr+xcpC+T9IuUCn2x86ehw
	 1UGvl4qtOwVFAN+gfDscahFl+DcUomgUGtB+ZTMMT6tkCumcnsuBtNBZjjDg1ZTquL
	 ANYX/YkNVDTYg==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [PATCH 0/2] Document the DMA-buf mapping lifetime negotiation
Date: Tue, 25 Aug 2026 09:28:00 +0300
Message-ID: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260820-document-dma-buf-3f8b41e32f57
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

DMA-buf lets an exporter pin, move or revoke the backing storage under
an importer, and which of the three applies is decided by the optional
callbacks each side implements and by whether dma_buf_pin() succeeds.
Nothing in Documentation/ describes that, and the single reference to
the mechanism still names move_notify(), removed in v7.1.

Thanks

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Leon Romanovsky (2):
      PCI/P2PDMA: Update DMABUF lifecycle docs after move_notify() rename
      dma-buf: Document how exporters and importers agree on mapping lifetime

 Documentation/driver-api/dma-buf.rst    |  6 +++
 Documentation/driver-api/pci/p2pdma.rst |  6 ++-
 drivers/dma-buf/dma-buf.c               | 85 ++++++++++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 3 deletions(-)
---
base-commit: 8049741ac93acd3a590dac070e12571fddf0e294
change-id: 20260820-document-dma-buf-3f8b41e32f57

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

