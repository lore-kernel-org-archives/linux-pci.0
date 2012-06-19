Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Huang Ying <ying.huang@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: ming.m.lin@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Huang Ying <ying.huang@intel.com>,
	Zheng Yan <zheng.z.yan@intel.com>
Subject: [PATCH -v6 0/4] PCIe, PM, Add PCIe runtime D3cold support
Date: Tue, 19 Jun 2012 13:20:45 +0800
Message-Id: <1340083249-16266-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changelog:

v6:

- Disable device D3cold during system suspend/hibernate with a new method per Rafeal's comments

v5:

- Disable device D3cold during system suspend/hibernate per Rafael's comments

v4:

- Minors fixes based on comments from Rafael

v3:

- Drop device.power.power_must_be_on, use pci_dev.no_d3cold instead
- Drop device.power.power_off_user, use pci_dev.d3cold_allowed instead
- Use black list instead of white list in pcie port runtime support per request from Bjorn
- Various fixes based on comments from Rafael

v2:

- Refreshed based on comments from Rafael

[PATCH -v6 1/4] ACPI, PM, Specify lowest allowed state for device sleep
[PATCH -v6 2/4] PCIe, PM, Add runtime PM support to PCIe port
[PATCH -v6 3/4] PCI, PM, Do not call pci_set_power_state with PCI_D3cold
[PATCH -v6 4/4] PCIe, PM, Add PCIe runtime D3cold support

Best Regards,
Huang Ying
