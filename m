Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840D2652B0;
	Fri, 23 Jan 2026 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191586; cv=none; b=mJ8eukKusBkwNNzhnvfZNjO8YFarNv8Z9gOn51d1ghkJyMWYIDCU9WhFNhLys396A86Pz9UBjViFdn3R004+ZfSsgs244W1cb4bdltDt4eIqWCU3J6jWtk2NrwZhjYPnTFq6OT3dPOSaj5JeTZvOaNWx2+8vsIayv8ZJpmWvDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191586; c=relaxed/simple;
	bh=vKdFSJUF/jrsBh4v0vcIMJgMf5IpcxbgubYnNncUDLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YfX2AJZJ2/8htufDjlXh3+5O3t1gmUOKyXscMSqg2811WaxU4HM9pc6vfNT9Q9Z/9yc0ZogKYPU8S6X45o18NPBNORR2Xl57zK4KlnasqD+X1N36cBodW/2Axa9dMEFXnWgLN7hsre5JZY8Qj2kRBer8T4xyRWIgnyE5/8noLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qH4Rp1rY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qH4Rp1rY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D572CC116D0;
	Fri, 23 Jan 2026 18:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769191586;
	bh=vKdFSJUF/jrsBh4v0vcIMJgMf5IpcxbgubYnNncUDLI=;
	h=Date:From:To:Cc:Subject:From;
	b=qH4Rp1rYH0wOqyipw6v3OdDDIdhtojxv/ShBDq+/35rDCe8Omp6FsMOp0BBHBLU7E
	 LdUQ22Cbxmepwgvw/GfeCdUZ78to1NlgNq870C/TievT8c9jw+Ahd4R7Q5yoCoaxR+
	 LxcV/rn3lWyTQbOq1FvK7sAnMCcTJ6NxikhRjx9dVPMn01UiOEKtkcKOb3f5G+t+md
	 Y0KxWFr9HK7pEutIKDrA6VPtWNmwKvFFCSiScbL2/ttX2THTdtjgXq64463YWIV4VI
	 VlW9/2vinNhni9NmJfHSH8Hse47+OWibH7dRCzwwWUn/3K8NyHxq6M0rkADiI68rYt
	 Yxpi8Hd49CuNA==
Date: Fri, 23 Jan 2026 12:06:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: [GIT PULL] PCI fixes for v6.19
Message-ID: <20260123180624.GA84249@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.19-fixes-4

for you to fetch changes up to 5528fd38f230c906fcebb202cc94fbb8ed8f122a:

  PCI: Fix Resizable BAR restore order (2026-01-22 10:29:55 -0600)

----------------------------------------------------------------

- Fix the pci_do_resource_release_and_resize() failure path, which
  clobbered the intended failure return value (Ilpo Järvinen)

- Restore resizable BAR size before value because the size determines which
  bits are writable; this fixes i915 and xe regressions (Ilpo Järvinen)

----------------------------------------------------------------
Ilpo Järvinen (2):
      PCI: Fix BAR resize rollback path overwriting ret
      PCI: Fix Resizable BAR restore order

 drivers/pci/rebar.c     | 18 +-----------------
 drivers/pci/setup-bus.c | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 21 deletions(-)
