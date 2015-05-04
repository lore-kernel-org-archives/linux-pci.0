Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55479D35.3060603@ti.com>
Date: Mon, 4 May 2015 21:54:21 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	<jg1.han@samsung.com>, Mohit Kumar <mohit.kumar@st.com>,
	<kishon@ti.com>
Subject: [Query] PCIe power management with designware
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I'm planning to add power management (suspend/resume) support for DRA7xx and 
have a query.

The pci_pm_suspend_noirq callback being a bus pm_ops gets invoked late i.e 
after the suspend hooks of the pci devices (including the RC driver). The 
problem is after the 'suspend' of the RC driver, the clocks are disabled. Now 
pci_pm_suspend_noirq has a call to pci_save_state() which tries to access the
configuration space registers. Since the clocks are disabled by now, this 
results in an abort. Shouldn't we do save_state() earlier?

After working around the above problem, I face one more issue with broadcom 
BCM95721 A211 card. After resuming, I'm unable to access the memory space. I'm 
not sure if that is specific to that particular card, since I have no problems 
with USB cards.

Cheers
Kishon
