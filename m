Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026CF3AF653;
	Thu, 19 Mar 2026 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954464; cv=none; b=fSKOsmdmQS5ineSeVFElzF/Ji3N58AngSxUebbww/IEZnIX7/QLyn8sCbtdO+64G0FUzoW4CuVmG8fLU92bPa9pgm95YT2oIW6NJG8QpllJiVxR1dnhgyyl7cauKY7tPIE+m0ogQtpSFnHPtXPbvfR5vSxY8IJsQ8vX8g1bE850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954464; c=relaxed/simple;
	bh=1tiMRpWwu/T9vg4fgA9WJh3wICGxyqy1NhkcAg+Mqmk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KTFCO6LyfWhjynipCUwP6e1Wnm+0W+z5uCel24Hbe0z28Z1NvZ8+D8e3ZbZD6qnCJo+rhAbmJUkAa8C0EITTo/6DgBNUb9Ja9DHGQiuRkr4qFiQEJGnUwo/JWg1Fb3Zm6X4SdPzQdX0h00Oi9oj4CNwMLNQ+zCYIL7L3p87GRiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBHBDbyE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBHBDbyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76167C19424;
	Thu, 19 Mar 2026 21:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773954463;
	bh=1tiMRpWwu/T9vg4fgA9WJh3wICGxyqy1NhkcAg+Mqmk=;
	h=Date:From:To:Cc:Subject:From;
	b=CBHBDbyE7pY7qBRmHq/5IZpKxCYmI6gXr7e4Obadgq2FiVJ02PJyCOPsjN7PZ6fO2
	 TycLVzn8v+Op4tRbHCv+ji09YlOh5/+VWe5F7XG4E+/l59O5w4naG45TUWXqSAVbTD
	 51SKsVN2SnunzO20+7akabKs9F7tzfrwOCFrRoHquSWI5dv5mZApULt8vzRf8ymJUp
	 aywwgKsBL5/hI8NAKbKG7/VtqFa/kZc4jmlKifQDWUqs8eP/RbvHMUXidzG1UO3T1A
	 10ifIRUXirZyrIco6aGtdcu8Kin3hZwHDcGd1WEzEmV5ZnLJyDHOytbVXLPl/A4SkD
	 hU/3p7EDMZ6IA==
Date: Thu, 19 Mar 2026 16:07:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Koichiro Den <den@valinux.co.jp>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] PCI fixes for v7.0
Message-ID: <20260319210740.GA528280@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.0-fixes-4

for you to fetch changes up to 21647677ba9af2cb6bc460e17d9f29a7132c40c3:

  PCI: endpoint: pci-epf-test: Roll back BAR mapping when subrange setup fails (2026-03-17 10:26:42 -0500)

----------------------------------------------------------------

- Create pwrctrl devices only for DT nodes below a PCI controller that
  describe PCI devices and are related to a power supply; this prevents
  waiting indefinitely for pwrctrl drivers that will never probe
  (Manivannan Sadhasivam)

- Restore endpoint BAR mapping on subrange setup failure to make selftest
  reliable (Koichiro Den)

----------------------------------------------------------------
Koichiro Den (1):
      PCI: endpoint: pci-epf-test: Roll back BAR mapping when subrange setup fails

Manivannan Sadhasivam (2):
      PCI/pwrctrl: Ensure that remote endpoint node parent has supply requirement
      PCI/pwrctrl: Create pwrctrl devices only for PCI device nodes

 drivers/pci/endpoint/functions/pci-epf-test.c |  5 +++
 drivers/pci/pwrctrl/core.c                    | 54 ++++++++++++++++++++-------
 2 files changed, 46 insertions(+), 13 deletions(-)
