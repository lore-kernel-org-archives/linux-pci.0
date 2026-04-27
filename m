Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BC3612EF;
	Mon, 27 Apr 2026 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262026; cv=none; b=cKn6+6aJWkqoGjBYeNCPGtIe/7XIcDIRKbCEyMNolm8iRQgB7ki8HfBgB4GQdvmYI7zhz7OH4IFiCeyqkPs7w1SfDJSyHQjDd5ft++6XKtJarWpLcqAoTr6vFJDiHagDDNcLxvbNrUlSNOVmn20ExnE/azMhQVloECP8ZnfjefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262026; c=relaxed/simple;
	bh=2L2mGWLqxP2hYwMCN1jkfEAl4ifp/rkqnY48ye6/kW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lo1sgtZ+NPIDUz3VoceX0Rg30MJt4XcgTn9njtbQrnHYg2XpItZZ6nPZ+dw2Si4Kg4pEE1zpelqx7twX7Q+GvphwUjFfij/+ECAq3cnwYouUi3aeVxvLIrUckERGrAh22dVIv4u/4qNyrCFF2PEsou3ugcFVtSnOYTbWeSPmDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcYgI0Pp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcYgI0Pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD52BC19425;
	Mon, 27 Apr 2026 03:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777262026;
	bh=2L2mGWLqxP2hYwMCN1jkfEAl4ifp/rkqnY48ye6/kW8=;
	h=From:To:Cc:Subject:Date:From;
	b=pcYgI0PpSUYQIbABOj+lvw4EJMChQqj7U+88i2GHsZE42AQW7Wl5qHXDo00ML0c23
	 zcbMyudnYqAqkLBCWrkMorS2TbhQjo8bWEf36Ctov2y0I3ZpnbDdAXQ6VLL4Ei+5br
	 +WEmCewwBcemZ+IK0IZXuo/D08RDclviG3iBgYVcjs0Yh7b1rj2NBgvzJ9YYg+q3F5
	 ryHFgoYv0PockaZqUXVr5L50nYzYeFTnnmacfrIL1iWD7um3K04HPPFqK9rarsJUut
	 GtrN9zoXi0O+ga2NGiJd/cnIHSYRW0ZiQ7ueeoOiQO0ws9xmx7cRlOCEA/OWbZbOxu
	 v9665E//c0Ldg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 0/5] Improvements to PCI hibernate path
Date: Sun, 26 Apr 2026 22:53:36 -0500
Message-ID: <20260427035341.1425576-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

It is based off 7.1-rc1 + Lukas' patch:
"PCI: Stop setting cached power state to "unknown" on unbind"

Mario Limonciello (AMD) (5):
  PCI/PM: Disable device wakeups when halting or powering off system
  PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
  PCI/PM: Run bridge power up actions as part of restore phase
  PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
  PCI: Put PCIe bridges with downstream devices into D3 at hibernate

 drivers/pci/pci-driver.c | 103 ++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 34 deletions(-)

-- 
2.43.0

