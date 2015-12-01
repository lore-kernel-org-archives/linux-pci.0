Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <565CFC7C.101@gmail.com>
Date: Mon, 30 Nov 2015 17:48:44 -0800
From: Florian Fainelli <f.fainelli@gmail.com>
MIME-Version: 1.0
To: Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
CC: =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell Joyce <russell.joyce@york.ac.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 20/28] net: pch_gbe: clear interrupt FIFO during probe
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com> <1448900513-20856-21-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1448900513-20856-21-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 30/11/15 08:21, Paul Burton wrote:
> xilinx_pcie_init_port clears the pending interrupts in the interrupt
> decode register, but does not clear the interrupt FIFO. This would lead
> to spurious interrupts if any were present in the FIFO at probe time.
> Clear the interrupt FIFO prior to the interrupt decode register in order
> to start with a clean slate as expected.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Seems like the subject should be "PCI: xilinx: ..." to be consistent
with the changes you are making to this driver earlier in the series?
-- 
Florian
