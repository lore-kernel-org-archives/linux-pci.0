Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF37C13D638;
	Mon, 23 Feb 2026 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857963; cv=none; b=gjVrG9/7ssWk7UnM/nlKkT5oBTa5h3oxosiq6bgV07r0TMJXIWglegxVLHww3KHOaS+64VECreQmBM7JroRorks2l9VSLSo2wQhW/jceiN96RruCJR4yLtGuWS9vdXBlMStAQtEkG+6TWK8GPeM4Z8gAdMbVkX1EzGIt3Zg4VT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857963; c=relaxed/simple;
	bh=0oOacB7wekfab+QGwcpYIGrgFEdHi1JQuMOHXuEbmYE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VXSXp7+El8Te0CGQacFl168rI+m/e9IMuCrfpSTxZ5HQujGok7euSCX9GeZf7zrkA043NXa1KE7hPW1t2LErJQrvlN/17uqCzGZjhUtRitNHQXhFoaM1eXVs95V25Zctrv+Lllzg61BteI9MW3OQB8CsgqiO9MJDEiSNkn5hoKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImI0cTgH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImI0cTgH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B600C116C6;
	Mon, 23 Feb 2026 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771857963;
	bh=0oOacB7wekfab+QGwcpYIGrgFEdHi1JQuMOHXuEbmYE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ImI0cTgHNGr1GsDYBSBk4HyxLkGcIXDf2IriqbL/fPtG0hZzk6nQpF9Y6wLjJQ386
	 I5Ek8voK8B/lXaYL2c6+gcw68y2TQZBtUSaG4eS4ZpC3mSNeFNb6Vnfs0fvozk1YSu
	 Ug+AHbFQHCNmpdO5rkrDW/p0XgBus65ZCfkApFhg4LotdzCsAnbAxE6u+Ojuqt+SM+
	 Bo6px52A9QqoZK8AU2F0InDGq26KBBPjOTd91NlEo7cqLSqPVoRAxK6pqBfFH0fXBc
	 aBtWaJdmR/hz7WM7xf8tsGoIr55Gm8slq0bM7wRRsMiD58AhCm7M3zW0H4GxiWUoca
	 VodG0fjeH5i5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823AFEA4FC6;
	Mon, 23 Feb 2026 14:46:03 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v2 0/2] PCI/pwrctrl: A couple of fixes
Date: Mon, 23 Feb 2026 20:15:58 +0530
Message-Id: <20260223-pwrctrl-fixes-7-0-v2-0-97566dfb1809@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZonGkC/32NQQ6CMBREr0L+2pK2CBVW3sOwoPUjTYBiP1YN6
 d0tHMDNJG8mM7MBobdI0GQbeAyWrJsTyFMGZujmBzJ7TwySy4pLodjy9mb1I+vtB4kpxpmuOeq
 Ca92jgtRbPB5hqt3axIOl1fnvcRHE7v5bC2KfLCslsLzUxbm/OqL8+epG46YpTwJtjPEH5dUs/
 7kAAAA=
X-Change-ID: 20260217-pwrctrl-fixes-7-0-b90eb30bbfe7
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=0oOacB7wekfab+QGwcpYIGrgFEdHi1JQuMOHXuEbmYE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpnGgpmt4euzNlq9RltGhY8m2X7sgkRa8vB45wV
 NBkzXb+7K2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaZxoKQAKCRBVnxHm/pHO
 9Y48B/wJzuwMEfa6vNHi9r0Gd95e9L7tbzABDyDIZDY+B76k4pE95SFkhRhQz8IOwgk0Wp5k6lc
 ++WYLoIiw5YGqnaHbq9+grzTVygO1oQQqiqVQme+EWNBmhfn3kzf71H1qMgBn/N5dEoX7jkCbys
 yf4tdRILk+rR2C7MkvhljuiGYlETnXmRsI0bp2qDyToud2FwpFh9BR0eUlBql7B9NTMnMYTR7KP
 hd4kQUaw2B110rsfLncxb7mbpDfDhwwLYH3VNqIpz5pcfnEZH6W/mMmc0d/dQ8NQ6X243TE3eJn
 n3k+P9DK6wk1tzXr96oeICdXYu7V7Siz2ZZy572hFUsZ9or3
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series fixes a couple of issues introduced in the recent pwrctrl rework
for v7.0. Both issues are due to some incorrect assumptions on deciding when to
create pwrctrl devices. First issue is due to assuming that all OF graph nodes
require pwrctrl and another one is due to assuming that all PCI child nodes are
PCI devices.

Both issues are fixed by changing the pwrctrl device creation logic in
pwrctrl/core.

Testing
=======

This series is tested on Lenovo Thinkpad T14s.

Note for Bjorn H
================

Even though only patch 1 is fixing a regression on the IPQ board which was not
part of the testbed of the pwrctrl rework went in for v7.0, patch 2 is also
fixing an actual issue, but it is not impacting any of the current upstream
supported platforms. But I'd like to get these two patches merged for v7.0 so
that both the issues are fixed in the same major release where the issues
originated.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v2:
- Used the compatible match for detecting the PCI devices in DT
- Link to v1: https://lore.kernel.org/r/20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com

---
Manivannan Sadhasivam (2):
      PCI/pwrctrl: Ensure that the remote endpoint node parent has the supply requirement
      PCI/pwrctrl: Only create pwrctrl device if the device node belongs to a PCI device

 drivers/pci/pwrctrl/core.c | 54 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 13 deletions(-)
---
base-commit: 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
change-id: 20260217-pwrctrl-fixes-7-0-b90eb30bbfe7

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


