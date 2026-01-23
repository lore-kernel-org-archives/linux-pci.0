Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594CB353ED9
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160791; cv=none; b=eBujwTOIhKmPxT739xaosUUfxD9Kk2AAW++1cNetowfy/JIcjHrZZaGsb6UcIxQyHXnkUaSPmFxQ2WQJ/u7hz4dV8XNUcVBlLaDZCccyeAi2GMtzqAWkwxAcWu5ZrPe7NXLIPwRede//tb7w1a7HoHGbRSq1yAXpdQyZmEKIIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160791; c=relaxed/simple;
	bh=t/d+y1xQ3rR46wkdK8wnSxu5w/vZ8VI6lLDYNWc71l4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YF5hnuQyaILQ/25HJNSFalEd/8ZtaYp6jqJqJpuoPXZaY0dmi3CfpQ7SCUHMc+WcwPB2Gv3do49fa53gR24w7aoL/9Z9wsamx9SjdIKFYUCbdt2eIQDiugEUA5neS3qZMSL1Zh8RqghTKBUiiuoM0KIv7SdQQEBJt5rG1ZXuaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blLuHu91; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blLuHu91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D462C4CEF1;
	Fri, 23 Jan 2026 09:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769160790;
	bh=t/d+y1xQ3rR46wkdK8wnSxu5w/vZ8VI6lLDYNWc71l4=;
	h=From:To:Cc:Subject:Date:From;
	b=blLuHu91XZJL4Jsz0PP3V/DJvO9JL5T3v2W0Xyg9qIdFd1XHSjBI1eD5PLMh82HUL
	 fwIlJrODf3199wN3/OlZRJBUHr5+MRJ7W0avyKVVvl86hlUOiBWCxoznAKN9qUQQiV
	 E3NOE0rj3PPOhAxr5byPXT//F77FoX+anDYsAlXtMN/uWq60CInoTzS0DVdJe9470s
	 GbH54oEKgCqhab2+UWp6Aa/A7HR87X9SAETfYzyugFV8NAvq+jn7W3OO46or6WCgpx
	 0P5PV7CyJMmRym6PTrloI9FrAMyI6tHVGanvAZHLubRkDv4dPnH6c1J4vEGj3q+dFc
	 BdkE81x4qsuZA==
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
Subject: [PATCH v3 0/4] PCI: dwc: Clean up iatu index mess
Date: Fri, 23 Jan 2026 10:32:09 +0100
Message-ID: <20260123093208.593506-6-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1017; i=cassel@kernel.org; h=from:subject; bh=t/d+y1xQ3rR46wkdK8wnSxu5w/vZ8VI6lLDYNWc71l4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKLHSTUai0unBIW+MB5r8ozeY/x1t57M2wlxVfyc0w5d ejFY1+TjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzkbCEjw9EpXtvfT5+xReTO /GCuZzfDk5V13jw66RDufPWFDefmbQ6MDE+D/57O2zVhvkLlh23rlztF3vabIO/Orsr/4u/tBK6 lFhwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This series tries to clean up the iatu index mess, by treating
iatu indexing for outbound and inbound address translation in
a consistent way (increment the index after assignment, and only
if the function call succeeded).


Changes since v2:
-Fixed review comments from Mani.
-Picked up tags.


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

 .../pci/controller/dwc/pcie-designware-host.c | 85 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.c  |  6 ++
 2 files changed, 56 insertions(+), 35 deletions(-)


base-commit: 0ecd890e3cf54a0586247b9a384702703277e4fd
-- 
2.52.0

