Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:40868 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470Ab3DLUyz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2013 16:54:55 -0400
Received: by mail-ob0-f180.google.com with SMTP id un3so2672046obb.25
        for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2013 13:54:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1362993428-14823-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1362993428-14823-5-git-send-email-andriy.shevchenko@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 12 Apr 2013 14:54:34 -0600
Message-ID: <CAErSpo7b6CvQgo44oRi+iREq1zduHMLTvw0r_7McroLc38r97A@mail.gmail.com>
Subject: Re: [PATCHv2 5/5] ACPI / pcie: suppress compiler warning in portdrv_acpi.c
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 11, 2013 at 3:17 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> This patch fixes following compiler warning when build via make W=1:
>
> drivers/pci/pcie/portdrv_acpi.c:34:5: warning: no previous prototype for ‘pcie_port_acpi_setup’ [-Wmissing-prototypes]
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

I applied this and several similar patches to my pci/cleanup branch
for v3.10.  Thanks!

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/cleanup

Bjorn

> ---
>  drivers/pci/pcie/portdrv_acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
> index a86b56e..b4d2894 100644
> --- a/drivers/pci/pcie/portdrv_acpi.c
> +++ b/drivers/pci/pcie/portdrv_acpi.c
> @@ -17,6 +17,7 @@
>
>  #include "aer/aerdrv.h"
>  #include "../pci.h"
> +#include "portdrv.h"
>
>  /**
>   * pcie_port_acpi_setup - Request the BIOS to release control of PCIe services.
> --
> 1.8.2.rc0.22.gb3600c3
>
