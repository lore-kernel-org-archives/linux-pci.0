Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF0315D53;
	Sat, 26 Sep 2026 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790441894; cv=none; b=sqxmcL+fUlUYFgv90HBI1Ehmzw9piIGFRQQh+vqzjxbg+ItBUa7/5OPnziAtMSdogwDG3vhRa8K7fAE0Ajppimz/1KTqqsSrzVFtojyx5iwNYKXQSu0TDvdls3+A4KmMHEiAEi6u9xJsLAurY+SSE/Nhfi7BW721PBqPhQesQpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790441894; c=relaxed/simple;
	bh=2zvlJjMk3xRnUTbQBiQaugAB5gNEtB/G1QBotC267xA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MZNFS6G+/wVG2vjq1mPSJrEOW1qdY72tI0wS0jVqsUIhFK28I5yr9adyGwMWGn3AOILQ0s2DSGHutAxvwWnknq/NdPrYKAgKleJHs4iDU6EkyQWla+pYMNlmq8HhCKxLiam11i2uX3G0GZjwRtoR0kaMKaZC4cUYNwczztNfy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNv/El8x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNv/El8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EB51F000FF;
	Sat, 26 Sep 2026 16:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790441892;
	bh=8rHVHWDwI8K+3Fj53dqiLT5fT3kjwCMl8iDzx68xZgk=;
	h=Date:From:To:Cc:Subject;
	b=LNv/El8xST7pdvahB1Mqn4k8IncMZ8cYsAHpgap9AESW7bGgV1E5DvSbI0DiNuSKE
	 8iZ5eAtsV+VLeZwpg3N27bU7MfeN5W7i9/eC8ESQ5nMr+LMHv36UTj0qxQ4LGfwXLt
	 giW7U5S4NGLeBT2sHID0KOEfbWWfirGlwbUgbgWf0P+CGZBA7qz8Ot6Bmc5xUMmun1
	 dHn7VPk5MBigbk1BIlzuFbUliTTvr/Per3QvfyvVN2vzHMY7nrAz8iPmKYkbVQw1qU
	 0QDQQSQBVWxJponhtAKWvp2JTKZldlVIdWccpx2cIVtE8t6IPAnRS9j5auh61LMlIZ
	 pJHtTOhTuWYwg==
Date: Sat, 26 Sep 2026 11:58:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mikael Etienne <mikael1022bzh@gmail.com>,
	Arthur Husband <artmoty@gmail.com>,
	Alvin Lim <alvinwylim@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Roland Waltersson <roland.waltersson@netinsight.net>,
	x86@kernel.org, Angel J <iamanaws@httpd.dev>,
	Herve Codina <herve.codina@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Liz Fong-Jones <lizf@honeycomb.io>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: [GIT PULL] PCI fixes for v7.3
Message-ID: <20260926165811.GA2146023@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-2

for you to fetch changes up to 4fde448225123442c5796f54b7a4400e2d3cbaf6:

  x86/PCI: Disable enhanced atomics on AMD NBIO 7.7 and 7.11 (2026-09-23 13:42:21 -0500)

----------------------------------------------------------------

  - Make BAR resize work even for devices where no upstream bridge is
    visible to the OS, which fixes an amdgpu regression on SolidRun
    HoneyComb, which doesn't expose Root Ports to the OS (Liz Fong-Jones)

  - Omit bus properties in dynamic OF nodes when a bridge has no
    subordinate bus, which fixes early boot hangs caused by NULL pointer
    dereferences with CONFIG_PCI_DYNAMIC_OF_NODES enabled (Angel J)

  - Disable enhanced atomics on AMD NBIO 7.7 and 7.11 to avoid silent data
    corruption on 64-bit DMAs (Mario Limonciello)

----------------------------------------------------------------
Angel J (1):
      PCI: of_property: Omit bus properties without a subordinate bus

Liz Fong-Jones (1):
      PCI: Fix BAR resize for devices on a root bus

Mario Limonciello (1):
      x86/PCI: Disable enhanced atomics on AMD NBIO 7.7 and 7.11

 arch/x86/pci/fixup.c      | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/of_property.c | 11 +++++-
 drivers/pci/setup-bus.c   | 23 ++++++++---
 3 files changed, 125 insertions(+), 8 deletions(-)
