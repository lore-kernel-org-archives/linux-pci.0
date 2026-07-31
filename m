Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A83AE6F7;
	Fri, 31 Jul 2026 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512393; cv=none; b=GYlVyFv78VAwcxr+C4Oy8horAO+s/1EJY0sKQWqnpdXxB/GkzT4qA7lT77lwKzOAA3Vem87vcogtqX0MCdHBBL9i7p5noIF+zwvPpk83WGQZaMgTOU71aK4Rff4QRJrMoNguusN1cqsS8uYY0n1zQWeQh1XFSR2XZGOaHfBAuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512393; c=relaxed/simple;
	bh=AbWZWvP/xg1zdT6nX8N/rTmxfrK35r55GslXQdbpmKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a2oNMJiB1Mh3lB3Jc3JilEw/rGQlvFUBFbM9Q0zivWoQBDWLA9O0QgpaEDIhKof05nuulPKKkjMOkM98hsFBpgSfl4LzX04BIRvqfNngnuKYVAa+e2JG94Ws+Y8RTAPNj1wM1HKD6Fs5HCR9/hQpSH8OrpV/E2wvz5ZMmKYz1us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwmYsAjM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwmYsAjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0381F00A3A;
	Fri, 31 Jul 2026 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785512391;
	bh=/Dwbx27pCjRRJmpWEgZPGkRWrWf88735WSWMjoc4Rac=;
	h=Date:From:To:Cc:Subject;
	b=dwmYsAjMrDCO6E+oN73Nunu4whlVH270cG9zuDJ2nr/RR+skE8we7Kg5kZDYexiFS
	 oZ0yt6ZkJOOiLiA4fFNn58WchKZC8PgQHQFNu0E+DEPEQc1CNpdnc2udiAVBE0PT/p
	 fLyndVaw+bN+IVgnbgneh/gDNnYHdx0jytL9MSfYuf4csRBw87iucNq+jtQyLO1cbk
	 0aJPyFBwDb8w92q6pGbLHX8yp1weXot3xnwukBLoGGJb/1ndulYHDOf863nYqIqkVl
	 rzsgoj39sIF6jzEIhCSbTbPLHHTevhaFyvS7fcWQQy59JQLclIcpZj48extTRThSg9
	 49F5rQWiPZT/g==
Date: Fri, 31 Jul 2026 10:39:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Leonardo Costa <leoreis.costa@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Soeren Moch <smoch@web.de>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Mitran Karthikeyan <kmitran@axiado.com>
Subject: [GIT PULL] PCI fixes for v7.2
Message-ID: <20260731153950.GA1568891@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v7.2-fixes-1

for you to fetch changes up to 7678e81498e20e78d7d5f64e552cd153117c1d66:

  PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing (2026-07-28 11:37:06 -0500)

----------------------------------------------------------------

- Remove Karthikeyan Mitran from Mobiveil MAINTAINERS PCIe entry since
  email bounces (Manivannan Sadhasivam)

- Preserve i.MX6Q, i.MX6QP, and i.MX6SX Root Port MSI/MSI-X Capabilities
  when using iMSI-RX to work around hardware defect (Soeren Moch)

- Reorder i.MX6Q/DL PHY power up to fix boot hang regression (Richard Zhu)

----------------------------------------------------------------
Manivannan Sadhasivam (1):
      MAINTAINERS: Drop Karthikeyan Mitran from Mobiveil PCIe entry

Richard Zhu (1):
      PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing

Soeren Moch (1):
      PCI: imx6: Keep i.MX6 Root Port MSI/MSI-X Capabilities with iMSI-RX to work around hardware bug

 MAINTAINERS                           |  1 -
 drivers/pci/controller/dwc/pci-imx6.c | 52 ++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 23 deletions(-)
