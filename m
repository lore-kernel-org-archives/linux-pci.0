Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A64F5E09;
	Fri,  2 Oct 2026 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958876; cv=none; b=QoFit1cvWp5eGf35qC4jY/f6RMusa75skaGt5uLlI75kXYJUQDg+krsy0j17caSA1RPNKtTEBA2L1ykqEcD9KXPa1o4ldKtABigmghxuQE50XV8a7q++sqFgFTfFF095zQJbfntlHChCmDkVu3/Mf+A/vIL+n+wpiKdwRtWzZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958876; c=relaxed/simple;
	bh=snvUQh4yi0AXgl5L8ejjqrb+PJaQypt6hAx1cf01EZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PbB0MydsFCA/Cr1yE65B4A1PeLeS8uOJjHuD6NGlG3fsCajDDqxjMYfrpXS6o22nwpyCNilKkDZDr5gyWkDV9hTTrR3TRdkfaodMB61wtqGSFUiQrV1OzxxeENMziyUIr3xIdRbiEiGMeNrJok4vVUWI2zu6j1zqWdIl0y++cFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maQQ026M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maQQ026M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF141F000FF;
	Fri,  2 Oct 2026 16:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958875;
	bh=Wo+zKTpYMWd/TMUaOJGuksdk/SRzka2Tj1wP5j1KCNQ=;
	h=Date:From:To:Cc:Subject;
	b=maQQ026MpNvDhFARJuWpZngmcAOmnZGMmv6+uV4X3pxJ3xUEUm5L0u61iAfBUxYGN
	 X8H1HsvsLLoEtnboFgHtg3VCAp1mBlBI0oW94GSSOM5/XoFN89H6b6k93gMYrU7m5E
	 DO98YzdoP60IdM0eFaxdXHeozRJ+TXJ9I0hQIO0nsuoBjWRZLCfLcNd/XBy9NRwpMm
	 ddLjbJyRVZFfWD2qDwbWHNZPxMkPbGy1TeN7++9WyR2Sq/s1f9DFc7uhK/e12TgrJz
	 F9i0upl2RZaY7iG+5Nc1V3hfvLNT68JFQhQgbn1J1TuAjAnLPJIubtee1z6dO2lmdm
	 tBURaJwz6d/mg==
Date: Fri, 2 Oct 2026 11:34:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Nikola Prica <nikola.prica@amd.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alexander Schmidt <alexs@linux.ibm.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [GIT PULL] PCI fixes for v7.3
Message-ID: <20261002163433.GA117980@bhelgaas>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-3

for you to fetch changes up to 40cce45b921f7930886bcba43069edc579725457:

  PCI: Accept AtomicOps already enabled by the hypervisor (2026-10-02 11:21:28 -0500)

----------------------------------------------------------------

  - Allow driver to use AtomicOps if already enabled by hypervisor; fixes
    regression when Root Port is not visible in a guest (Nikola Prica)

----------------------------------------------------------------
Nikola Prica (1):
      PCI: Accept AtomicOps already enabled by the hypervisor

 drivers/pci/pci.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)
