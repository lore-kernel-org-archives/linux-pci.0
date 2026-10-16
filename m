Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCA05A0ABD;
	Fri, 16 Oct 2026 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174433; cv=none; b=q/ppUaszwcUi2t2qine3OfqfYHdOEOiFTwRXAQ+/C+fh63nwXeUF72eNFer7IUGroaaD+mtsUpWYWtARNv329bONKaaJPn2orRlWfMa8UAoXPUzTOe8//pOZPrfcFneE5EIrFgusXVcvc+F5fSrMeyz0o18XFObBosp3d8i9NMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174433; c=relaxed/simple;
	bh=v2PLuBmORCWcKZ8lY/MJYPYzLUpwUVFY6LOKNy4siDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pRLpOBSfd489yEN3yN9jI948qKt1IDS4TPi6OipXPWV+vkGPdQT7VN41Yvyteo5lFmHUXnrK7t+o957jUuYu8PeqBm/Fft/FSVZtkYyHaaipHjCJC+yG+MbJaezFnkQYVzuE0ScGYswbtTN9Pj4BdVxy1HBa6l5DApsqJywrFSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcAc8K0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcAc8K0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958DF1F000C6;
	Fri, 16 Oct 2026 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174432;
	bh=k1GCRW4QcQ5+tM48RvuJm0rIBocuw1scqGWi1vf+4EQ=;
	h=Date:From:To:Cc:Subject;
	b=DcAc8K0ftS96U7OSE6Ii7dizKHlcWNgsgEzxkKkKYCqYELNvF7SdsUTI2yAsC/ke3
	 tRgfPEYffl1aO6QWpBfOVsH8If30wK1F0wIqaEgOg47nPLheJ5eQw6AbRvNWs9UEXw
	 duavEfAyrSVzkqIzKRTXeTyEWMvX4KLn6Ry0I3WYcT4VhUeuklKn/iYypr+k374JwJ
	 dEnnz//7A+OCSl68Tz2BwsZNhRGTEyZ22Gn1mFJWuCa21qAuprq3R2Oo384AX23McN
	 komle0EY6uIVphldVzgT7AQ+c5dxMa58I39160f4vV9etalHIlRllsdwt0cFPMjCPJ
	 nocovq9g2TS/w==
Date: Fri, 16 Oct 2026 13:13:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alexander Gruhlke <gruhlke@mailbox.org>,
	Lukas Wunner <lukas@wunner.de>, Hui Wang <hui.wang@canonical.com>,
	Vitaly Chikunov <vt@altlinux.org>, Linux-Fan <info@masysma.net>,
	Raphael Norwitz <rnorwitz@nvidia.com>,
	Suresh Gumpula <suresh.gumpula@nutanix.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Daejun Park <daejun7.park@samsung.com>
Subject: [GIT PULL] PCI fixes for v7.3
Message-ID: <20261016181351.GA1880783@bhelgaas>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-6

for you to fetch changes up to e8df1d194c39b7a5159d570798941851f70a8668:

  PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV (2026-10-16 12:11:15 -0500)

Updated this morning to add Samsung 990 EVO Plus to the Immediate Readiness
quirk.

----------------------------------------------------------------

  - Ignore Immediate Readiness on Samsung 990 PRO and 990 EVO Plus NVMe,
    which falsely advertise it; removal of unrelated delays in v7.2 caused
    post-FLR state restoration to fail, resulting in a VFIO passthrough
    regression (Alexander Gruhlke)

  - Don't treat ~0 as 'device is ready' in pci_dev_wait(); with RRS SV, a
    device may respond with RRS (resulting in data of 0x0001) or may not
    respond at all (typically resulting in ~0 data).  A v6.12 change
    treated ~0 as 'ready', resulting in a regression with Intel and Samsung
    NVMe SSDs (Alexander Gruhlke)

----------------------------------------------------------------
Alexander Gruhlke (2):
      PCI: Ignore Immediate Readiness on Samsung 990 PRO and 990 EVO Plus NVMe
      PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV

 drivers/pci/pci.c    | 15 +++++++++++----
 drivers/pci/quirks.c | 12 ++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)
