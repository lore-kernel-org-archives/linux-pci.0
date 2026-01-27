Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF73E2F260F
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526656; cv=none; b=pGVlKjSMXS5ZOrBn6uh61WIhlB+nZPusNB4fJml499hTCChxnvB6ebw7nLh0YxHBSbiEywTeFMzGH+/f1kOTa802RyN7s6zJi7JjZ9vZmcCRPE+R4KtY/PX+IucM8O3Syyyy36ni4a8+d378Fh4811BoNm5o/SXaVjOk7bNN1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526656; c=relaxed/simple;
	bh=QX1h7TIHny2tP3nZOEuj4YQiP6qBmegKbZnzetfLHBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K884jWjdxmYSl62db70uzX9q9yySi+jF7a0ody2+Vsv4996m2++5LWQ6IBwMA9GgsVUD2CnXQmp2ObI+VQOeiBXCBqrXoCteY0dUVVALAOXxwqjdFQxf09oHV67J8lrOLIo5BqjkMnf18I3CvYNzrFP5b+JZu7rA8/XW+sUHjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbvYN5LH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbvYN5LH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17146C116C6;
	Tue, 27 Jan 2026 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769526656;
	bh=QX1h7TIHny2tP3nZOEuj4YQiP6qBmegKbZnzetfLHBA=;
	h=From:To:Cc:Subject:Date:From;
	b=fbvYN5LHfpy2pHRW2fcSPfTOx53eVm13tPmBdirNTUwkT/gLpJsZ8p6OtHnJhvIkg
	 RXsIKht9/IEgfNsYRYF3zPsU6cwWnSVnq74owNV7AFocravdqDyIM2HWyq3Wfm82CQ
	 5Gj+Gy/JEkP526fW0P/LFyHS9hW5FGfoldexXdtdztKRbv218m6R3S2G29l5hhSziJ
	 iYjZKw3caPEuBiJmr/iv9Ic1WGhS+XcfFBDDjs8vhPB+zuvzWGk4r00hbTLhDkEZKx
	 YNF84361VIk3/Np1NIafdcFCY/sqUkDpUgxV5qFyhTtO+fN2WgVCDB6AF3JcZ8QDtX
	 ZxxHtP2STkS3g==
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
Subject: [PATCH v5 0/3] PCI: dwc: Clean up iATU index mess
Date: Tue, 27 Jan 2026 16:10:38 +0100
Message-ID: <20260127151038.1484881-5-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=cassel@kernel.org; h=from:subject; bh=QX1h7TIHny2tP3nZOEuj4YQiP6qBmegKbZnzetfLHBA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIrrublx2kveyLXELf/lsq2jHQP44fVQc90Di9U/z5tj dK6l9lWHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhI8XxGhtOLWOqDAnezewj7 Xpr5crn13nP33tjOtz+4ctsMmdcHjkxk+M2WYMe63W2j5UG/LXG1vV/s+xdmLvTg4z7pWnJ4fZG uNhMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This series tries to clean up the iATU index mess, by treating
iATU indexing for outbound and inbound address translation in
a consistent way (increment the index after assignment, and only
if the function call succeeded).


Changes since v4:
-Squashed patch 1 and 2, as suggested by Damien.
-Added Cc: stable+noautosel for the ECAM patch, such that stable
 maintainers will see the dependency needed by this patch.


Link to v4:
https://lore.kernel.org/linux-pci/20260123182835.831710-6-cassel@kernel.org/

Link to v3:
https://lore.kernel.org/linux-pci/20260123093208.593506-6-cassel@kernel.org/

Link to v2:
https://lore.kernel.org/linux-pci/20260122222914.523238-6-cassel@kernel.org/

Link to v1:
https://lore.kernel.org/linux-pci/20260122145411.453291-4-cassel@kernel.org/


Krishna Chaitanya Chundru (1):
  PCI: dwc: Fix missing iATU setup when ECAM is enabled

Niklas Cassel (2):
  PCI: dwc: Fix msg_atu_index assignment
  PCI: dwc: Clean up iATU index usage in dw_pcie_iatu_setup()

 .../pci/controller/dwc/pcie-designware-host.c | 91 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.c  |  6 ++
 2 files changed, 62 insertions(+), 35 deletions(-)


base-commit: 0ecd890e3cf54a0586247b9a384702703277e4fd
-- 
2.52.0

