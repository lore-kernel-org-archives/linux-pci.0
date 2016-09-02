Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 00/15] PCI: rockchip: Cleanups against v10
To: Shawn Lin <shawn.lin@rock-chips.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Date: Fri, 02 Sep 2016 10:53:50 -0500
Message-ID: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are cleanups against 2098142ae87d, the current pci/host-rockchip
head in my tree.

Changes from v1:

  - Rework HIWORD_UPDATE
  - Remove duplicate CSR definitions
  - Move CSR block offset from read/write caller to CSR definition
  - Organize CSRs into logical blocks
  - Fix some inconsistent CSR names
  - Add names for registers at the base of CSR blocks

I was disappointed to find how disorganized the v10 CSR definitions were.
It was quite a hodgepodge.  I should have noticed that earlier, but as
penance, I tried to clean it up myself.

These are in git as pci/host-rockchip-wip.  Again, I intend to squash these
all into the single commit that adds the driver when I finally merge it.

---

Bjorn Helgaas (15):
      Remove unused symbols, unnecessary parens, other minor comments from
      Rename pcie_read() and pcie_write() to rockchip_pcie_read() and
      Always use "rockchip" as the pointer to per-device struct.
      Rename struct rockchip_pcie_port to struct rockchip_pcie.
      Use a local "dev" to avoid repetition of "rockchip->dev".
      Add comment about why 32-bit read/modify/write isn't safe.
      Simplify the confusing HIWORD_UPDATE scheme.
      Remove duplicate CSR definition.
      Move CSR bases into definition.
      Group related CSR definitions together.
      Rename PCIE_CORE_RC_CONF_SCC_SHIFT to match similar definitions.
      Rename ROCKCHIP_PCIE_RPIFR1_INTR_MASK and ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT
      The register at PCIE_CLIENT_BASE presumably has a name of its own.  Add a
      Simplify testing of link status and speed testing.
      Move msleeps to address Guenter's comments.


 drivers/pci/host/pcie-rockchip.c |  842 ++++++++++++++++++--------------------
 1 file changed, 391 insertions(+), 451 deletions(-)
