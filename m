Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy5-pub.bluehost.com ([67.222.38.55]:59630 "HELO
	oproxy5-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757187Ab2CME4c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Mar 2012 00:56:32 -0400
Date: Mon, 12 Mar 2012 23:56:14 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull]
Message-ID: <20120312235614.1f22c90b@jbarnes-x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The following changes since commit
4f262acfde22b63498b5e4f165e53d3bb4e96400:

  Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm (2012-03-07 08:33:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jbarnes/pci for-linus

A single fix for a regression that affects some people who try to
disable ASPM for whatever reason.

Matthew Garrett (1):
      PCI: ignore pre-1.1 ASPM quirking when ASPM is disabled

 drivers/pci/pcie/aspm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
