Return-Path: <SRS0=JpDh=DO=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=JpDh=DO=davemloft.net=davem@kernel.org>
Date: Mon, 18 Dec 2017 15:13:54 -0500 (EST)
Message-Id: <20171218.151354.978438255508508144.davem@davemloft.net>
To: helgaas@kernel.org
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 Ariel.Elior@cavium.com, everest-linux-l2@cavium.com
Subject: Re: [PATCH] qed: Remove unused QED_RDMA_DEV_CAP_* symbols and
 dev->dev_caps
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171215230301.177993.80284.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171215230301.177993.80284.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Fri, 15 Dec 2017 17:03:01 -0600

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The QED_RDMA_DEV_CAP_* symbols are only used to set bits in dev->dev_caps.
> Nobody ever looks at those bits.  Remove the symbols and dev_caps itself.
> 
> Note that if these are ever used and added back, it looks incorrect to set
> QED_RDMA_DEV_CAP_ATOMIC_OP based on PCI_EXP_DEVCTL2_LTR_EN.  LTR is the
> Latency Tolerance Reporting mechanism, which has nothing to do with Atomic
> Ops.
> 
> No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to net-next.
