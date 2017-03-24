Return-Path: <SRS0=ccIc=3B=linuxonhyperv.com=kys@kernel.org>
Return-Path: <SRS0=ccIc=3B=linuxonhyperv.com=kys@kernel.org>
From: kys@exchange.microsoft.com
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0/2] pci-hyperv: Some miscellaneous fixes
Date: Fri, 24 Mar 2017 11:06:40 -0700
Message-Id: <1490378800-26907-1-git-send-email-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
List-ID: <linux-pci.vger.kernel.org>

From: K. Y. Srinivasan <kys@microsoft.com>

Some miscellaneous fixes.

K. Y. Srinivasan (2):
  pci-hyperv: Fix a bug in specifying CPU affinity
  pci-hyperv: Fix an atomic bug

 drivers/pci/host/pci-hyperv.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)
