Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED92116F4;
	Fri, 27 Mar 2026 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622163; cv=none; b=FlpSTuQaHYpU53De09eCK62IrihQs2qvFSGA+QONUEWjJg3W7fbmahn9WEHyV8s0akMEcV7mV1wV+5eSRSURr2mU1ez1K6rztitwpJul2c+0KkTg0j1tIPk/tLMOSHHTmAvcCy4GYOOmTT6ic7Id9icjezIU04kegM6HC4VE5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622163; c=relaxed/simple;
	bh=g2AM3GF+7CYU6ha2hIyBcc+i4rjjR+LPYKeLDHkVCjs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RijN5kwSYweZOsQBEkRdXCfD7x5GabE3t9b6xLEWF9H/b653Ob30MRNY8iFPpQ1esczFzvLHeIYO7q5bo/EJekXApB8iw1+KLfrkBW0+hPIsU8wazLtIo3Ez7R6Vo9kAtMOwMKkoCFWKnCv4E/WVX3ADQroj25tok2QUts7ZbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWj4hFY4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWj4hFY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89082C19423;
	Fri, 27 Mar 2026 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774622162;
	bh=g2AM3GF+7CYU6ha2hIyBcc+i4rjjR+LPYKeLDHkVCjs=;
	h=Date:From:To:Cc:Subject:From;
	b=oWj4hFY4J89Iodi3tKXgosv2k/clrPaYkyIhxm6Orj889nmOugftJVVo4mUTRawW2
	 GI9wnE7v7UjUia6jwEQWBzI72fQujGJzrLn+7JCYCOnVUv3DYlF6jrHYD9+WZXuMU6
	 QXCf6L6iGlP/tJYHARXjPRghof8a3TvRTi0cxlGp+1GBB6+E2S3JLuT4uDoVMRDg5V
	 2UrOBOSlwXu/JgsxkBffrexqoIFNk3qRiiYCW8JYKFr3awcdJpfzVuf3L4EMdEhJcW
	 zBloeunwXxPtr7ivSJ+K5XcILg6I83lC8hQcFE/z5KV4zAtnrqFBSQumrKFk6WaCiU
	 zP+oWyjvkxt5w==
Date: Fri, 27 Mar 2026 09:36:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Maciej Grochowski <mx2pg@pm.me>, Felix Gu <ustc.gu@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: [GIT PULL] PCI fixes for v7.0
Message-ID: <20260327143601.GA1460168@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v7.0-fixes-5

for you to fetch changes up to 05f643d6f7e699198ccc47e634de3879a8ec26a3:

  Documentation: PCI: Document PCIe TLP Header decoder for AER messages (2026-03-23 15:58:02 -0500)

----------------------------------------------------------------

- Remove power-off from pwrctrl drivers since this is now done directly by
  the PCI controller drivers (Chen-Yu Tsai)

- Fix pwrctrl device node leak (Felix Gu)

- Document a TLP header decoder for AER log messages (Lukas Wunner)

----------------------------------------------------------------
Chen-Yu Tsai (1):
      PCI/pwrctrl: Do not power off on pwrctrl device removal

Felix Gu (1):
      PCI/pwrctrl: Fix pci_pwrctrl_is_required() device node leak

Lukas Wunner (1):
      Documentation: PCI: Document PCIe TLP Header decoder for AER messages

 Documentation/PCI/pcieaer-howto.rst      | 10 ++++++++++
 drivers/pci/pwrctrl/core.c               |  4 +++-
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 12 ------------
 drivers/pci/pwrctrl/slot.c               |  1 -
 4 files changed, 13 insertions(+), 14 deletions(-)
