Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966E1E260C;
	Sun, 30 Aug 2026 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088600; cv=none; b=mlzltSoO9oH3jHmewe6H31yHsV2e95jpIv1QgRQ3OUoH5i847cB4/vUmPFcRBehN9D9/3/EwZncquqxakqwzJHMIIlNjPY9cWyrCSbyYiL8wVtg+5Cg7nfVLEZ4H/aOwu8HQaPZfFDJSgEUppeft52kzxAcuBMWquqdxbFbWSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088600; c=relaxed/simple;
	bh=nPj8qve1LFiI1kF1otSTCaRx0u6Nx4CXOy+kyj6PROk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=coFIeZwLQdIBgfUH5aPqP+SS+W9hpIsg6cOwWBQZ8nB5Qj0GskPjDYzN2A9Z1/D5a+4CGQp2zbO3wgtJf9j0pylsqHUDTdpijZ2R9FFVU0u38RvDhuPPDc/ZPQmdu0ZT6fyp9STco7Nhrao50HZg930WDPlJHDFWMzBYNdZZ9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdIMNz9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdIMNz9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CFE1F000E9;
	Sun, 30 Aug 2026 11:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788088599;
	bh=5maADKlOorCOIqx8zCUimrPkBqwSiL41twa4hkuqiIw=;
	h=From:To:Cc:Subject:Date;
	b=JdIMNz9Z13T2r/0BUINbjK+UxqXGZgzjKtPqKUxbytNRvPz8fekNNlgGVqxwnLT2S
	 V3iHX1JHxXAmsvF/GY767R9BOM8ClcsmPVhvDXIXJxG9YFOf94jjw5cfV9Be3ZqRgc
	 VsMceRZFFVK3iP37blIXN3PRj+UMuDcOf2GkBsmawDoBYevGg03Jh52VedtsphfzdI
	 fITINeQYF8AGuJTODnGjSDJ717pHTkc+xUyxuKKcaQKS/+D8zb5YVZzplM1IWIiJlv
	 mmdaL7+bPChxcgpc5EZYih4vTQdsPn9C2smnUtmdvln3BMQIhV5hvVkoC9C4+vYSYj
	 lE7DUrYy7UwGg==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tushar Dave <tdave@nvidia.com>,
	Matt Evans <matt@ozlabs.org>
Subject: [PATCH 0/5] Batch of PCI peer-to-peer fixes
Date: Sun, 30 Aug 2026 14:16:18 +0300
Message-ID: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260830-batch-p2p-fixes-b73c10cdeff8
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

Hi Bjorn,

These fixes come from my larger series that aligns the code with the PCI
specification regarding the handling of ACS bits [1].

This series has already been reviewed by Logan and Jason.

Thanks,

[1] https://lore.kernel.org/all/20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com/

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Leon Romanovsky (5):
      PCI/P2PDMA: Do not tear down the allocate attribute on registration failure
      PCI/P2PDMA: Wait for RCU readers before freeing state
      PCI/P2PDMA: Restrict the p2pmem search to pool backed providers
      PCI/P2PDMA: Safely terminate ACS redirect lists
      PCI/P2PDMA: Gate the host bridge whitelist warning on verbose

 drivers/pci/p2pdma.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)
---
base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
change-id: 20260830-batch-p2p-fixes-b73c10cdeff8

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

