Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] PCI: rcar: Misc error path fixes
Date: Thu,  7 Dec 2017 11:15:18 +0100
Message-Id: <1512641720-4715-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

	Hi Simon, Lorenzo, Bjorn,

This patch series fixes two issues in the error path for the R-Car PCIe
host bridge driver.

The first issue is triggered easily by not having a PCIe card inserted,
and may cause a crash.

Thanks!

Geert Uytterhoeven (2):
  PCI: rcar: Fix use-after-free in probe error path
  PCI: rcar: Handle rcar_pcie_parse_request_of_pci_ranges() failures

 drivers/pci/host/pcie-rcar.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
