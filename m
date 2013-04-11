Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:65049 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab3DKXoa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2013 19:44:30 -0400
Received: by mail-ia0-f180.google.com with SMTP id l29so1891418iag.39
        for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2013 16:44:29 -0700 (PDT)
Date: Thu, 11 Apr 2013 17:44:26 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Andrew Murray <Andrew.Murray@arm.com>
Cc: linux-pci@vger.kernel.org,
	"thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	"jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>,
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pci: Remove unnecessary dependency between PME and ACPI.
Message-ID: <20130411234426.GA10196@google.com>
References: <20130221155329.GA26729@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130221155329.GA26729@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 21, 2013 at 03:53:29PM +0000, Andrew Murray wrote:
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> ---
>  drivers/pci/pcie/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 6c8bc58..4cccd8c 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -82,4 +82,4 @@ endchoice
>  
>  config PCIE_PME
>  	def_bool y
> -	depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL && ACPI
> +	depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL

I think we can go even further and remove the ACPI-related #includes
as in the patch below.  Any objections to this?


commit 8bde83b5f5519b630e7630fb735f76c184c74289
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Apr 11 17:36:50 2013 -0600

    PCI: Remove unnecessary dependencies between PME and ACPI
    
    PCIe PME doesn't depend on ACPI, so remove the #includes and
    Kconfig dependency.
    
    Based-on-patch-by: Andrew Murray <Andrew.Murray@arm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index fde4a32..569f82f 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -82,4 +82,4 @@ endchoice
 
 config PCIE_PME
 	def_bool y
-	depends on PCIEPORTBUS && PM_RUNTIME && ACPI
+	depends on PCIEPORTBUS && PM_RUNTIME
diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 9ca0dc9..795db1f 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -19,8 +19,6 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/pcieport_if.h>
-#include <linux/acpi.h>
-#include <linux/pci-acpi.h>
 #include <linux/pm_runtime.h>
 
 #include "../pci.h"
