Return-Path: <SRS0=WVLE=JH=flex--rajatja.bounces.google.com=3UTksWwcKB1QDw5wF5w2AA270.yA83072wwE60D907.AD2@kernel.org>
Return-Path: <SRS0=WVLE=JH=flex--rajatja.bounces.google.com=3UTksWwcKB1QDw5wF5w2AA270.yA83072wwE60D907.AD2@kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Jun 2018 16:48:25 -0700
Message-Id: <20180621234829.224566-1-rajatja@google.com>
Subject: [PATCH 0/4] Expose PCIe AER stats via sysfs
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Thomas Tai <thomas.tai@oracle.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com, helgaas@kernel.org
Cc: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

This is a follow up to:
https://lkml.org/lkml/2018/5/22/1057

Respinning as a new patchset because the old one has been refactored
to include new patches (that were not part of original), and dropping
some patches. The major changes are:

* Provide breakdown of Fatal / non fatal errors separately
* Include the "total" in the same file
* do some PCI cleanup before the actual aer_stats stuff
* Include documentation in the main patch
* Rename variables / attributes to better match the newer reality.

Rajat Jain (4):
  PCI: Move pci_aer_init() and pci_no_aer() declarations to
    drivers/pci/pci.h
  PCI/AER: Define and allocate aer_stats structure for AER capable
    devices
  PCI/AER: Add sysfs attributes to provide AER stats and breakdown
  PCI/AER: Add sysfs attributes for rootport cumulative stats

 .../testing/sysfs-bus-pci-devices-aer_stats   | 122 +++++++++++
 Documentation/PCI/pcieaer-howto.txt           |   5 +
 drivers/pci/pci-sysfs.c                       |   3 +
 drivers/pci/pci.h                             |  11 +
 drivers/pci/pcie/aer.c                        | 198 +++++++++++++++++-
 drivers/pci/probe.c                           |   1 +
 include/linux/pci.h                           |   5 +-
 7 files changed, 337 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats

-- 
2.18.0.rc2.346.g013aa6912e-goog
