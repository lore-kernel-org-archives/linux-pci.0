Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACC549739C;
	Fri, 18 Sep 2026 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789758976; cv=none; b=PPv6mrWdJqWJMc0kHzIlhnJIAsN54XTXrzVV/qcZ4P6k54zMU2ZS/xyMeli9DtJ2QpTqpEZA1gnbQsZHCZdARUBUwWaajPYmV9aQiN1lVTfwjYwA0jK4i+b6vK2xNdXU1ZqjGaANyFpFoOMyAIZ2209NFKk2aAZE9fzWvbQdYsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789758976; c=relaxed/simple;
	bh=r3M4Ou+K5ururZWI+eRPUASdXzJVa0NcV8LVcX9hylk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qq+HcLha1KuTRTqJBsXdQkF3QunOySLpmegsRM2fGUu5BAvoQdsB+kxuZxhlZ7AnrXUphtnW1c9aNuT4J8saAJiPhd8IkjHxRlB8jyxJeVsLG7usDKHUQKmcf4gBCoK7HL96x5g8kHXH/tceztzhf36MmLcBSzrZl2MxQDovO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mklsk72c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mklsk72c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED41E1F000FF;
	Fri, 18 Sep 2026 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789758966;
	bh=f6Nzj72Zu8RZnooG6kDU/HmWZJYUx/sbSbmT6+PQ3Hk=;
	h=Date:From:To:Cc:Subject;
	b=Mklsk72c8seKxLlIGfJjnrCKvXABm+IPNp1sZNQrU7PjhoxNqHSQsDH1NzWMqoNQh
	 7rxtqJqmbHE+PGlWYXHaUR19MJ27rP7Pfvc9yLk8Yra/i+PG6mMLEI4p/jrJan01mj
	 eBQzn2WS5gtcjjLvb+l096uO5l73cuZcEXHC7bLDv2YduTBJ1UWv2Yp39pdtvAmAoz
	 HFCQ68RSNOtH1oBhywuzdlkVMht08cNp1FCkk90+8GYn9B8rPuB1D4O3hBzfhFfkhP
	 h7PbmBENdEaENpmJ0HApe4btB3gMYmlKcwNMK0kpZ07pdyfOVubWljJDlldgB06C6K
	 tBhSeugEwbn4g==
Date: Fri, 18 Sep 2026 14:16:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Leonardo Costa <leoreis.costa@gmail.com>,
	Franz Schnyder <fra.schnyder@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev
Subject: [GIT PULL] PCI fixes for v7.3
Message-ID: <20260918191604.GA1177751@bhelgaas>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-1

for you to fetch changes up to c9dc7d730319ad64b51570c5387f1fee7b07b510:

  PCI: imx6: Move clock enable after core reset assertion (2026-09-17 16:54:34 -0500)

(Sorry if you saw an empty message from me; I fat-fingered something
when editing the request)

----------------------------------------------------------------

  - Enable clock after core reset is asserted to fix enumeration regression
    on i.MX6Q Apalis platforms with ASM1061/ASM1062 SATA controllers
    (Richard Zhu)

----------------------------------------------------------------
Richard Zhu (1):
      PCI: imx6: Move clock enable after core reset assertion

 drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
