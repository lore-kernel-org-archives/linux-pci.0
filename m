Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 18 Jun 2018 13:36:33 -0600
Message-Id: <20180618193636.16210-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v3 0/3] Add parameter for disabling ACS redirection for P2P
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

As discussed in our PCI P2PDMA series, we'd like to add a kernel
parameter for selectively disabling ACS redirection for select
bridges. Seeing this turned out to be a small series in itself, we've
decided to send this separately from the P2P work.

This series generalizes the code already done for the resource_alignment
option that already exists. The first patch creates a helper function
to match PCI devices against strings based on the code that already
existed in pci_specified_resource_alignment().

The second patch expands the new helper to optionally take a path of
PCI devfns. This is to address Alex's renumbering concern when using
simple bus-devfns. The implementation is essentially how he described it and
similar to the Intel VT-d spec (Section 8.3.1).

The final patch adds the disable_acs_redir kernel parameter which takes
a list of PCI devices and will disable the ACS P2P Request Redirect,
ACS P2P Completion Redirect and ACS P2P Egress Control bits for the
selected devices. This allows P2P traffic between selected bridges and
seeing it's done at boot, before IOMMU group creating the IOMMU groups
will be created correctly based on the bits.

Thanks,

Logan

--

Changes since v2:
* Rebased onto v4.18-rc1 (no conflicts)
* Minor tweaks to the documentation per Andy
* Removed the "path:" prefix and use the path parsing code
  for simple devices (as it works the same). Per a suggestion from Alex

Changes since v1:

* Reworked pci_dev_str_match_path using strrchr as suggested by Alex
* Collected Christian's Acks

--

Logan Gunthorpe (3):
  PCI: Make specifying PCI devices in kernel parameters reusable
  PCI: Allow specifying devices using a base bus and path of devfns
  PCI: Introduce the disable_acs_redir parameter

 Documentation/admin-guide/kernel-parameters.txt |  39 ++-
 drivers/pci/pci.c                               | 336 ++++++++++++++++++++----
 2 files changed, 314 insertions(+), 61 deletions(-)

--
2.11.0
