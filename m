Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264553C23D9
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120963; cv=none; b=Y1oxIDxtamTdLIvB3UPM9Hruh4g6uVN/skr+Qrvtj2IpuLc124kIXriAhG6hy+AAFbaUdTYs1QmOizQfPjSUv/Dar+Ks9aytyX1xUTtUOWJppY9Kqs0ZWfMkmmmZYTbg9BZcISFjcWo7Tgd4Zrdv9DsaVxYxdmcrUDSwHMovuWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120963; c=relaxed/simple;
	bh=jZ+GwXaHld1JIHylYiSQt7CpAKN4r0mAXG+hD99m+ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=enGf3JIqA7eP94ZwEsWmAiO0xCCDlEJ774BpGbEXSvEWDoccU/vigOWS45mQ7VEdJAjvYlujWtEINsipZndCzOc4aPfFgz9mSTWFCt1THwESMwW1BWVts3hoVBhItg8XTKbG09/Df9eohbPK6JA6/jbvjGLR1KB5xWv+2dsTcoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLBPhAjo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLBPhAjo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895ACC116C6;
	Thu, 22 Jan 2026 22:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769120962;
	bh=jZ+GwXaHld1JIHylYiSQt7CpAKN4r0mAXG+hD99m+ss=;
	h=From:To:Cc:Subject:Date:From;
	b=ZLBPhAjogRdHioalnlmi9fqjdTqhRHvvzzBA9DQPCPbv7tS/hnoV+SAhmCc+u8j0j
	 7Mw/ZVq5/PKV4J1dwJ7pbPxreUfNw1A4AhnxodyM3yggXIv6zbDWkAfMKjvoK7P3V3
	 qJyhIDrYtwQAkC06QwtRZtVrsn10bejGjlYO3VXuqzmyaMlOj2SUQsLdgNGht3RNcw
	 QRdAdg6Z89QbbeMBL79fDl1xqW4/4PjuCSCCLkFXgmW/agvy1gD06iIeBMgFbjCpgA
	 khSLWIUWb7TICDsH6Vf49i2dk3EV2eAf48pkYxlgRCX7e+WjOGgfER0Qm9K8LlNsU4
	 acc8/Gc806DMg==
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
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 0/4] PCI: dwc: Clean up iatu index mess
Date: Thu, 22 Jan 2026 23:29:14 +0100
Message-ID: <20260122222914.523238-6-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=cassel@kernel.org; h=from:subject; bh=jZ+GwXaHld1JIHylYiSQt7CpAKN4r0mAXG+hD99m+ss=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKLluzSzp/QPqFzt4H5gumL6xdzplXLSmoJec4Qq/uqP 3Wmj/+XjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExEqpfhf8Ku5R84b72WZs3o Xdzo9CvYsMFiWVTnjP0uOoy7GCY7CzAynLZ5v2l3XveFFcmOrsu2sn9y1/oVnHGpQXZ6qzXzo5g yfgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This series tries to clean up the iatu index mess, by treating
iatu indexing for outbound and inbound address translation in
a consistent way (increment the index after assignment, and only
if the function call succeeded).


Changes since v1:
-Added patch 4/4 from Krishna which fixes iatu indexing when using ECAM.
 I've adapted the patch to my clean up series and fixed some bugs.


Link to v1:
https://lore.kernel.org/linux-pci/20260122145411.453291-4-cassel@kernel.org/


Krishna Chaitanya Chundru (1):
  PCI: dwc: Fix missing iATU setup when ECAM is enabled

Niklas Cassel (3):
  PCI: dwc: Fix msg_atu_index assignment
  PCI: dwc: Improve msg_atu_index error handling
  PCI: dwc: Clean up iatu index usage in dw_pcie_iatu_setup()

 .../pci/controller/dwc/pcie-designware-host.c | 92 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.c  |  6 ++
 2 files changed, 61 insertions(+), 37 deletions(-)


base-commit: e9a5415adb209f86a05e55b850127ada82e070f1
-- 
2.52.0

