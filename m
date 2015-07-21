Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Jul 2015 16:26:44 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v4 04/19] PCI/MSI: Add hooks to populate the msi_domain
 field
Message-ID: <20150721212644.GB3691@google.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
 <1436962613-17359-5-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436962613-17359-5-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 15, 2015 at 01:16:38PM +0100, Marc Zyngier wrote:
> In order to be able to populate the device msi_domain field,
> add the necesary hooks to propagate the host bridge msi_domain
> across secondary busses to devices.
> 
> So far, nobody populates the initial msi_domain.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/pci/probe.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index cefd636..376f6fa 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -661,6 +661,20 @@ static void pci_set_bus_speed(struct pci_bus *bus)
>  	}
>  }
>  
> +void __weak pcibios_set_host_bridge_msi_domain(struct pci_bus *bus)
> +{
> +}

I don't think there's anything in this series that requires this to be a
weak function, is there?  This is the only definition I see.
