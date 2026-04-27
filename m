Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77AE38B15F;
	Mon, 27 Apr 2026 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323034; cv=none; b=oEBsXMS9js74qDR2hZKe21cpPkjZK67WuL1vG25KbSHKAtWFzno2NG0TPQWSrMV72geuEbyUGosXsNQMMdzoPI+FOXriE78nVyOnAjUHcBppl2JpkvXtCBYJzw65BoXuTies0RHellB+cFfPBETZlgv7PNGrrEjbXGEd0wug/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323034; c=relaxed/simple;
	bh=fkR0V9zNfvX+GsYFVJoHDgpeIO3IQgP658jb7Aq63Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QWmNb/Syy4w+bYY+sOtguHfQQyxL/ZhKYNCdr5dvxS669UWmC6TGq+f4uq8QdiA6/Za0PK/lAUFxM4YJX43mD/Nv/51NNSs2RXvVIrooFP4oqJ8w5KyygdH4zlDF/h2+xuqNJpQbOT9px476X7m3YL9HKe+AMhGXyvv+D/B8pQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4sXhCP4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4sXhCP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F87C19425;
	Mon, 27 Apr 2026 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323033;
	bh=fkR0V9zNfvX+GsYFVJoHDgpeIO3IQgP658jb7Aq63Pg=;
	h=From:To:Cc:Subject:Date:From;
	b=D4sXhCP47fzykxzLeDFCHa8bVyA1ukfG1+allDv/uNS06Be1Rx+P/U4fABEWdmfcC
	 lW4u0a+TU9uk+0OnCyq4Ei3UjDwA9hgfbp460YAZXtmfs1F8pgQh/bF1A3/ATYD+Xo
	 gGZ+GTi1vGMMHZVvVRbGEPN5iCBGcXPds/hzyVEb5PWX0yD3GdRT37D4dBlY3webOi
	 DOeAU3ekkVk/PVIOR6t9nJIvGcu/baG7+hqG63UsN4y6mfUdyDQG7SiIezJx0MdkLg
	 /XmAqUPSxIfPu7KfcTdXWqkDCv21QNBr2JxfAf9uTWG13PjoNKbzI55heSo9L0kx2z
	 vJTGUfYjtgw3g==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pm@vger.kernel.org,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 0/6] Improvements to PCI hibernate path
Date: Mon, 27 Apr 2026 15:50:18 -0500
Message-ID: <20260427205024.254677-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A few cycles ago I sent out a kernel series for using the S4 paths when
the system goes to S5.  Some parts of it got merged, and Rafael suggested
to split the other parts into smaller pieces across multiple kernel cycles
to make bisecting easier.

This fell into my backlog behind other things, so I wanted to try again
this cycle for the PCI pieces. I have been carrying it, rebasing it and
personally using it for a while now though.

This series attempts to unify the PCI suspend and hibernate paths and to
fix some things that I observed to be wrong with how I expect hibernate
to work.

Based off v7.1-rc1

v2:
 - Include Lukas' patch from pci/pm directly in series so Sashiko can
   better review.
 - Include linux-pm in CC.

Lukas Wunner (1):
  PCI: Stop setting cached power state to "unknown" on unbind

Mario Limonciello (AMD) (5):
  PCI/PM: Disable device wakeups when halting or powering off system
  PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
  PCI/PM: Run bridge power up actions as part of restore phase
  PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
  PCI: Put PCIe bridges with downstream devices into D3 at hibernate

 drivers/pci/pci-driver.c | 109 +++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 40 deletions(-)

-- 
2.53.0

