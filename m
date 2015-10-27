Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vijay Mishra <vijaym@nvidia.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: arm64: PCI: HAVE_PCI_MMAP not defined
Date: Tue, 27 Oct 2015 09:11:29 +0000
Message-ID: <fdc3df19fc8940f48cc9744855b796b1@BGMAIL104.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

I see "HAVE_PCI_MMAP" is defined in arm32 but missing in arm64 support.
Is it intentional or missed out because no-body asked for it.

Regards,
Vijay
