Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90940449B32
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 02:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599471; cv=none; b=rY06fB0ij27pBnxAx46itqdWnxpxMjOSp/1gCn0XH0jvotN62bKLEJPeEFrdcfxgmnU/99h8ZQg9FJ8oXBmwi6rQhMO6itgDEAmqY/0MOzXEBg+pu6dv/ZWq5Unq0thL11DAYAlto0CsPnIY3CeufdiY6PYX5nFmiVFj93UvdXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599471; c=relaxed/simple;
	bh=Rrm0hauarpsenYuAiXX2jDGD98xbOn9yjCMw9MnsvRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sb9e+AhUmvQZIX/77m2qn2eeCqz3OpA/vp91YFSvqFbjJLZszx6NYpJsrk3b2mrTYFygIkJXTw3tj4XadLPAO0sWY5qme8twmUOimtONo/sQZ5HfxSywllBf4gDuau17SHvm7mXzVQWk9lzKVs31aVLeWjAnJ8HpDDAuLjDHGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFkSjc/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFkSjc/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030E51F00A3A;
	Tue, 21 Jul 2026 02:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784599470;
	bh=DeoT5wtS4o57XeZ3xt57AGyGtUT1NIv9EA4J7VhvoYg=;
	h=From:To:Cc:Subject:Date;
	b=jFkSjc/6F+ZW15ri1wUJ0yMVVyv/O3N0+1ondlOPFAxsDF6B+t7SvnE/7XpRaZUYA
	 sWvqdLJNogbDwIkG0Zwxa3gJxP85YTs4rEjLCModizfV+P8xT5Xgvb9dAT4tL+lm1V
	 OlwPD2K4lS6hhzHO1I/4Gc1EtaNyl2WoGL1ynu+dugsv8ieZGmO8Yky/9jFpCV0mGF
	 lCpEY9lvNE75r1QnIjwyTaiB3DgsbTzXp+OSvaeHvjMdRxT3IVZ92BVDu5SCjH76xq
	 lZ66uVGha/TYnHvOspofP4wwPVD1VXjKuYVt+hX5rXt33HSFi20CFzxFOmslTs9ctz
	 lOukZ76fqm1qQ==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/3] PCI/sysfs: Follow-up to the static attribute conversion
Date: Tue, 21 Jul 2026 02:04:23 +0000
Message-ID: <20260721020427.1541197-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This series is a follow-up to the PCI sysfs static attribute
conversion [1], carrying the clean-up changes from its v8 revision.

The v7 revision of the series was applied and went out with the PCI
pull request for 7.2 [2], so the changes from v8 did not land in time
to make the 7.2 release.

The series consists of three clean-ups:

  - Add the pci_ prefix to the generated PCI resource attribute names
    dev_resourceN_{io,uc,wc}_attr, for consistency with the macros
    that generate them and the arrays that collect them.

  - Make the attribute name suffix the first parameter of Alpha's
    __pci_dev_resource_attr() macro, resolving a checkpatch.pl
    complaint about two consecutive commas.

  - Add the pci_legacy_resource_{io,mem}_attr() macros, and use them
    for the legacy I/O and memory attribute definitions instead of
    open-coding each struct bin_attribute.

These correspond to the items listed under "Changes in v8" in the v8
cover letter [1].

No functional changes intended.

1. https://lore.kernel.org/linux-pci/20260619085200.3729431-1-kwilczynski@kernel.org/
2. https://lore.kernel.org/linux-pci/20260624110021.GA996382@bhelgaas/

Krzysztof Wilczyński (3):
  PCI/sysfs: Add pci_ prefix to static PCI resource attribute names
  alpha/PCI: Make the suffix the first __pci_dev_resource_attr()
    parameter
  PCI/sysfs: Add legacy I/O and memory attribute macros

 arch/alpha/kernel/pci-sysfs.c |  26 ++++----
 drivers/pci/pci-sysfs.c       | 119 ++++++++++++++++------------------
 2 files changed, 68 insertions(+), 77 deletions(-)

-- 
2.55.0

