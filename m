Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
To: <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
	<lenb@kernel.org>, <izumi.taku@jp.fujitsu.com>,
	<wency@cn.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
	<ddaney.cavm@gmail.com>, <chen.fan.fnst@cn.fujitsu.com>,
	<helgaas@kernel.org>, <okaya@codeaurora.org>,
	<bhelgaas@google.com>, <jiang.liu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <tglx@linutronix.de>,
	<linux@roeck-us.net>
Subject: [PATCH v3 0/2] pci: fix unavailable irq number 255 reported by BIOS
Date: Wed, 27 Jan 2016 14:08:42 +0800
Message-ID: <cover.1453862105.git.chen.fan.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

see each patch comments.

Chen Fan (2):
  pci: add an irq_invalid flag to specify the IRQ is not connected
  i801_smbus: fix unavailable irq number 255 reported by BIOS

 drivers/acpi/pci_irq.c        | 10 ++++++++++
 drivers/i2c/busses/i2c-i801.c |  5 +++++
 include/linux/pci.h           |  1 +
 3 files changed, 16 insertions(+)

-- 
1.9.3



