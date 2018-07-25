Return-Path: <SRS0=OKM6=KJ=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=OKM6=KJ=davemloft.net=davem@kernel.org>
Date: Wed, 25 Jul 2018 13:52:59 -0700 (PDT)
Message-Id: <20180725.135259.776764053086649839.davem@davemloft.net>
To: helgaas@kernel.org
Cc: jdmason@kudzu.us, netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vxge: Remove unnecessary include of
 <linux/pci_hotplug.h>
From: David Miller <davem@davemloft.net>
In-Reply-To: <153237958637.172194.6734539971240967379.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153237958637.172194.6734539971240967379.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 23 Jul 2018 15:59:46 -0500

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The vxge driver doesn't need anything provided by pci_hotplug.h, so remove
> the unnecessary include of it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to net-next, thanks.
