Return-Path: <SRS0=ZFmV=4Y=linuxonhyperv.com=jloeser@kernel.org>
Return-Path: <SRS0=ZFmV=4Y=linuxonhyperv.com=jloeser@kernel.org>
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
Subject: Hyper-V vPCI: Use current vPCI protocol
Date: Thu, 18 May 2017 12:14:26 -0700
Message-Id: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
List-ID: <linux-pci.vger.kernel.org>

Update the Hyper-V vPCI driver to use the Server-2016 version
of the vPCI protocol, fixing MSI creation and retargeting issues.

[PATCH 1/4] Hyper-V vPCI: Minor format and semantic fix
[PATCH 2/4] Hyper-V vPCI: Use page allocation for hbus structure
[PATCH 3/4] Hyper-V vPCI: Add vPCI version protocol negotiation
[PATCH 4/4] Hyper-V vPCI: use vPCI protocol version 1.2
