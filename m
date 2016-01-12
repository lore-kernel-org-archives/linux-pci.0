Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Fwd: [PATCH 2/2] drivers:pci Add pcie/Kconfig to pci/Kconfig
From: sasa bogicevic <brutallesale@gmail.com>
Date: Tue, 12 Jan 2016 15:23:57 +0100
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <67919054-C4BB-44DD-BB29-E74E303EC56C@gmail.com>
References: <1452608397-32072-1-git-send-email-brutallesale@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I accidentally sent patch as a series instead of individual one. I resent it again.

Thanks, Sasa
{
	name: Bogicevic Sasa
	phone: +381606006200
}



> Begin forwarded message:
> 
> From: Bogicevic Sasa <brutallesale@gmail.com>
> Subject: [PATCH 2/2] drivers:pci Add pcie/Kconfig to pci/Kconfig
> Date: January 12, 2016 at 15:19:57 GMT+1
> To: bhelgaas@google.com
> Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Bogicevic Sasa <brutallesale@gmail.com>
> 
> Architectures currently have to include both
> drivers/pci/Kconfig and drivers/pci/pcie/Kconfig.
> They should include only drivers/pci/Kconfig, and
> that should handle PCIe as well.
> 
> Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
> ---
> drivers/pci/Kconfig | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 73de4ef..005dd7d 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -119,3 +119,5 @@ config PCI_LABEL
> 	select NLS
> 
> source "drivers/pci/host/Kconfig"
> +
> +source "drivers/pci/pcie/Kconfig"
> -- 
> 2.5.0
> 
