Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37635 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbcARJE3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jan 2016 04:04:29 -0500
Received: by mail-wm0-f50.google.com with SMTP id n5so52637503wmn.0
        for <linux-pci@vger.kernel.org>; Mon, 18 Jan 2016 01:04:28 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Fwd: [PATCH] drivers:pci Add pcie/Kconfig to pci/Kconfig
From: sasa bogicevic <brutallesale@gmail.com>
Date: Mon, 18 Jan 2016 10:04:27 +0100
Cc: linux-pci@vger.kernel.org
Message-Id: <A33B6ECF-25E6-4247-99C7-523EE02D7EA9@gmail.com>
References: <1452608511-32188-1-git-send-email-brutallesale@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
I sent this through some time ago but I am suspicious since this seams like too simple for the right solution :)
Remember you wanted to add pcie foder to be compiled together with pci folder and not like separate option in config.
I just sourced the pcie folder in pci Kconfig and removed the source line form arch/x86 and it compiled just fine. i don't know is this what you had in mind.

Thanks, Sasa
{
	name: Bogicevic Sasa
	phone: +381606006200
}



> Begin forwarded message:
> 
> From: Bogicevic Sasa <brutallesale@gmail.com>
> Subject: [PATCH] drivers:pci Add pcie/Kconfig to pci/Kconfig
> Date: January 12, 2016 at 15:21:51 GMT+1
> To: brutallesale@gmail.com
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

