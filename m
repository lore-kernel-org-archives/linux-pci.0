Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 09 Jul 2012 14:25:31 -0700 (PDT)
Message-Id: <20120709.142531.1530660875837931629.davem@davemloft.net>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, sparclinux@vger.kernel.org,
	dan.yeisley@unisys.com, yinghai@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sparc/PCI: replace pci_cfg_fake_ranges() with
 pci_read_bridge_bases()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120709203214.28178.71922.stgit@bhelgaas.mtv.corp.google.com>
References: <20120709202308.28178.58942.stgit@bhelgaas.mtv.corp.google.com>
	<20120709203214.28178.71922.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 09 Jul 2012 14:32:14 -0600

> The generic code to read P2P bridge windows is functionally equivalent
> to the sparc-specific pci_cfg_fake_ranges(), so use the generic code.
> 
> The "if (!res->start) res->start = ..." removed from the I/O window code
> here was an artifact of the Intel 1K window support from 9d265124d051 and
> is no longer necessary (it probably was just cloned from x86 and was never
> useful on sparc).
> 
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: David S. Miller <davem@davemloft.net>
