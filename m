Return-Path: <SRS0=JpDh=DO=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=JpDh=DO=davemloft.net=davem@kernel.org>
Date: Mon, 18 Dec 2017 15:13:47 -0500 (EST)
Message-Id: <20171218.151347.1350225863037729767.davem@davemloft.net>
To: helgaas@kernel.org
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org, ganeshgr@chelsio.com
Subject: Re: [PATCH] cxgb4: Simplify PCIe Completion Timeout setting
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171215230150.177674.9821.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171215230150.177674.9821.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Fri, 15 Dec 2017 17:01:50 -0600

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Simplify PCIe Completion Timeout setting by using the
> pcie_capability_clear_and_set_word() interface.  No functional change
> intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to net-next.
