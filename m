Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49642AFA7;
	Thu,  6 Aug 2026 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015528; cv=none; b=VZg431viX578yKd/MhsWyJKnNQwDx6/xgGVAU8ZK6UNTcO2aN8urZ2UVwipjsKIWNRENpYZ2cPHKAuz947MPMvZI7Bmo42lxNK94ICUzDjGA/oCHfZ05wsLjLhoaE4djlLk3rpIYinkExOVxQT6WMb3Rmsk2fESCaMWwTtlMYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015528; c=relaxed/simple;
	bh=tN8597V8SHo1hq7amFrn9sb1izGa5g4OJu4pP6w58pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ECF2HDnaYMOAzgbvr5Nk1dx1dRkPinm9kHMTcR38o1dL2PxVZqO53aVpme0PN+L2Gw6g1ZU/RRLH7J3hOYbFrTecpX/u4bvBF/kPKGysYOHn7JxIgMIxZAuFAmI0ig3QyzD+0lgI0Vlao+2LDdfIQdyMVa05VkP+LJT45JvUeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fynKwgZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fynKwgZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7B51F000E9;
	Thu,  6 Aug 2026 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015526;
	bh=QWKlUY7AppVGV7/mfaNKd4uQ7Yo6C5B8wPHOoAPpRi8=;
	h=From:To:Cc:Subject:Date;
	b=fynKwgZARIUvaf7LfWLFW4RyKquVZIACP5nrfElFPLnms11bI/Wet4gbzMqCkypbp
	 bx2q1+TtXdNnDxcPi77jIQWJKmWCccdERfMiJu1YdE2joW0OOq4vhYHYGMl67bGIkN
	 t+VV8n3GITNw+tKtlxTuO+bArpatWP3xLGW5uGh8IOeICq8kAeu9mijGNqyvQMIcmR
	 SLLuctxAoojRwRJPWi7Y+KIcEAWHT5RRKag51+esox7mGdUas0ZCXQB9SkdIQbWMj7
	 gPNLxQDbex8r41fD6s+BfWgbJM1+Od2ZcvqN7azXgR1nd9owktXCHQ3gdknwzK4MKU
	 pTrcJzgIpLgSg==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	"Claude Opus 4.8" <noreply@anthropic.com>
Subject: [PATCH v2 00/13] PCI/P2PDMA: Fix ACS egress control handling
Date: Thu,  6 Aug 2026 14:24:07 +0300
Message-ID: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260713-fix-p2p-acs-725f8dd7b0e8
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

PCI P2PDMA treats any enabled ACS P2P Egress Control bit as an upstream
redirect. PCIe r7.0, sec 6.12.3, table 6-11 says the Egress Control
Vector bit for the target port decides instead: a clear bit routes a peer
request directly, regardless of P2P Request Redirect. Firmware can
therefore enable Egress Control with a permissive vector while Linux
incorrectly rejects a valid direct P2P path.

Table 6-11, where E is ACS P2P Egress Control Enable, R is ACS P2P
Request Redirect Enable and V the Egress Control Vector bit for the
target port:

  E  R  V  Required Handling for Peer-to-Peer Requests
  -  -  -  ------------------------------------------
  0  0  x  Route directly to peer-to-peer target
  0  1  x  Redirect Upstream
  1  0  1  Handle as an ACS Violation
  1  0  0  Route directly to peer-to-peer target
  1  1  1  Redirect Upstream
  1  1  0  Route directly to peer-to-peer target

P2P Completion Redirect lies outside this table and also forces
host-bridge routing.

The same interaction affects target-independent ACS isolation checks.
Request Redirect does not guarantee that peer requests are forwarded
upstream while Egress Control is enabled because a clear vector bit
overrides it. Such checks cannot identify every potential target, so
treat Request Redirect as ineffective while Egress Control is enabled,
which merges the affected devices into one IOMMU group.

ACS Direct Translated P2P routes a Request carrying a Translated address
to the peer regardless of Request Redirect and Egress Control, so it
voids the same guarantee unless Translation Blocking rejects the Request
first.

Two pre-existing gaps come first. A provider and a client below different
Root Ports share no upstream bridge, so the walk reached the host-bridge
route without recording a single ACS port and left the operator no
pci=disable_acs_redir= hint to act on. The routing analysis also covers
only Requests carrying an Untranslated address; ACS Direct Translated P2P
overrides those controls, so that scope is now written down rather than
implied.

It is nearly impossible to test all possible combinations due to limited
hardware availability, so I added KUnit coverage for ACS routing
decisions, isolation checks, Egress Control Vector lookups, and
provider-to-client path traversal over a fabricated PCIe fabric.

Disclaimer:
All patches were prepared with AI assistance, with a significant
difference between the code changes and the KUnit tests. The code
changes were thoroughly reviewed and rewritten.

In contrast, the KUnit patches were produced entirely by AI with
minimal human interaction, and multiple AI tools (Claude, Codex,
and Gemini) with frontier models were used to verify that the tests
comply with the PCI specification.

Thanks

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changes in v2:
- Added Logan's ROB tags
- Added commas in Documentation patch
- Link to v1: https://patch.msgid.link/20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com

---
Leon Romanovsky (13):
      PCI/P2PDMA: Safely terminate ACS redirect lists
      PCI/P2PDMA: Report ACS ports when the paths share no upstream bridge
      PCI/P2PDMA: Document the Address Type assumption
      PCI: Account for Direct Translated P2P in ACS isolation checks
      PCI: Add ACS egress control vector accessor
      PCI: Account for ACS egress control in isolation checks
      PCI/P2PDMA: Derive peer-to-peer routing from ACS control bits
      PCI/P2PDMA: Honor ACS egress control vectors
      PCI/P2PDMA: Document ACS egress control handling
      PCI/P2PDMA: Extract pure ACS routing decision helpers
      PCI/P2PDMA: Add KUnit tests for ACS routing decisions
      PCI/P2PDMA: Add KUnit coverage for the ACS P2P routing walk
      PCI: Add KUnit coverage for ACS isolation checks

 Documentation/admin-guide/kernel-parameters.txt |   9 +-
 Documentation/driver-api/pci/p2pdma.rst         |  14 +
 drivers/pci/Kconfig                             |  15 +
 drivers/pci/Makefile                            |   1 +
 drivers/pci/p2pdma.c                            | 141 +++--
 drivers/pci/pci.c                               | 102 +++-
 drivers/pci/pci.h                               |  23 +
 drivers/pci/pci_acs_test.c                      | 674 ++++++++++++++++++++++++
 drivers/pci/quirks.c                            |  15 +-
 9 files changed, 950 insertions(+), 44 deletions(-)
---
base-commit: 43598807f71ac1c9164f26004acf2496d4038daf
change-id: 20260713-fix-p2p-acs-725f8dd7b0e8

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

