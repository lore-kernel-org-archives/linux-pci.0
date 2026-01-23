Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92728D8DA
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192924; cv=none; b=jQGnUF5/aduW154T3DAzvfvHJvQPAnyDQ15rAjchMiIkmUwSHccBC3HPom2PJZYJw1xEBqe3iAJfVTW/m0V5q0jMlTv7e57vvI/sO4FIas1t7RQQDtXSyaKtk74q9oJF8BhtSo2mormOcQd4aUKWGVzcYzAZfweNQh9RfObyQaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192924; c=relaxed/simple;
	bh=NDCO0BuqTbPOlMtMCnCz8aavhVwQY0bYs2+7VGl4ktw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rka0p8T/p8vXA/7pdq3zVZg2LxAe5u0JcEVgHEpojzScjGazczdUp7JldZyIy5OI3peaJxeo6nXtE7lavJbB8wx5qAA9ei7J+xQwmmrcSJxVHSCKbVky7ip/aUqhKMxKA05mnorV6kPd/TY6mMNi31QSSyhVYaSuDWDXA0R3bl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loSXo3W2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loSXo3W2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0451C4CEF1;
	Fri, 23 Jan 2026 18:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769192924;
	bh=NDCO0BuqTbPOlMtMCnCz8aavhVwQY0bYs2+7VGl4ktw=;
	h=From:To:Cc:Subject:Date:From;
	b=loSXo3W2XAHCKYD8Ahnf+J022kuI59tHocb6Jdb8qvG/pTl1Im1vxXkDwpKBrWLNU
	 I5YBIl4u0Wwl49uo8gMR81ngjCHqCw4T6sN6CMGbsBzF1BimDXpLKGGHCLjsjN3yKo
	 aE3MWb4bNALJM85cxErB131+akrMZv1GLvtNIb4lw86f1KjgzXB7HpHq3BpdztE0vh
	 9u4qCO16CR3G+T96Mul5DuqtUtw7QukWRAqhc0KMttIGaIZbTv1Aq3cCGmqdRi9qnL
	 arc/0A063Tc1k22dAjcykmibohfDwtlcvMHTMzis/Uzi6vXAHFUQWv3ppXGXJoQik7
	 1GOiNHw1kU1NA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	tim609@andestech.com,
	dlemoal@kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 0/4] PCI: dwc: Clean up iATU index mess
Date: Fri, 23 Jan 2026 19:28:35 +0100
Message-ID: <20260123182835.831710-6-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254; i=cassel@kernel.org; h=from:subject; bh=NDCO0BuqTbPOlMtMCnCz8aavhVwQY0bYs2+7VGl4ktw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKL917ONN0wcbUUy5/dYgJ2HxuUhOdPun9BVELZvKPW7 3Thp+mPOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRxDUM/32vJL5tqH7EHrMv ZsqZPat1rlxmTnfdGuKilLyO6+PkpFCG/+UbPrfnrWbLPXlEbuOLzkcB23ce6KjbpCV68M7Lrz8 CJjMDAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This series tries to clean up the iATU index mess, by treating
iATU indexing for outbound and inbound address translation in
a consistent way (increment the index after assignment, and only
if the function call succeeded).


Changes since v3:
-The ECAM config space accessors do not support cfg0_io_shared, thus if
 running in ECAM mode, and we are out of outbound iATUs, return an error
 instead of enabling the cfg0_io_shared feature.


Link to v3:
https://lore.kernel.org/linux-pci/20260123093208.593506-6-cassel@kernel.org/

Link to v2:
https://lore.kernel.org/linux-pci/20260122222914.523238-6-cassel@kernel.org/

Link to v1:
https://lore.kernel.org/linux-pci/20260122145411.453291-4-cassel@kernel.org/


Krishna Chaitanya Chundru (1):
  PCI: dwc: Fix missing iATU setup when ECAM is enabled

Niklas Cassel (3):
  PCI: dwc: Fix msg_atu_index assignment
  PCI: dwc: Improve msg_atu_index error handling
  PCI: dwc: Clean up iATU index usage in dw_pcie_iatu_setup()

 .../pci/controller/dwc/pcie-designware-host.c | 91 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.c  |  6 ++
 2 files changed, 62 insertions(+), 35 deletions(-)


base-commit: 0ecd890e3cf54a0586247b9a384702703277e4fd
-- 
2.52.0

