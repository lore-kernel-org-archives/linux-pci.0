Return-Path: <SRS0=/aB5=46=linuxonhyperv.com=jloeser@kernel.org>
Return-Path: <SRS0=/aB5=46=linuxonhyperv.com=jloeser@kernel.org>
From: Jork Loeser <jloeser@linuxonhyperv.com>
To: jloeser@microsoft.com,
	helgaas@kernel.org,
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
Subject: [PATCH-v2 0/5] Hyper-V vPCI: use vPCI protocol version 1.2
Date: Wed, 24 May 2017 13:41:23 -0700
Message-Id: <1495658488-13199-1-git-send-email-jloeser@linuxonhyperv.com>
Reply-To: Jork Loeser <jloeser@microsoft.com>
List-ID: <linux-pci.vger.kernel.org>

From: Jork Loeser <jloeser@microsoft.com>

Update the Hyper-V vPCI driver to use the Server-2016 version of the vPCI
protocol, fixing MSI creation and retargeting issues.

Changes since v1:
- reduced spew in protocol negotiation (Dan Carpenter)
- work-around work racing Hyper-V patch (Stephen Hemminger)
- formatting (Dan)

Jork Loeser (5):
  Hyper-V vPCI: Minor format and semantic fix
  Hyper-V vPCI: Use page allocation for hbus structure
  PCI-HyperV vPCI: Temporary own CPU-number-to-vCPU-number infra
  Hyper-V vPCI: Add vPCI version protocol negotiation
  Hyper-V vPCI: use vPCI protocol version 1.2

 arch/x86/include/uapi/asm/hyperv.h |   6 +
 drivers/pci/host/pci-hyperv.c      | 445 ++++++++++++++++++++++++++++++-------
 2 files changed, 370 insertions(+), 81 deletions(-)

-- 
2.7.4
