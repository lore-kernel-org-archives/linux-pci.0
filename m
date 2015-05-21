Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1432198475.21715.137.camel@x220>
Subject: Re: [PATCH 06/16] NTB Pingpong Client
From: Paul Bolle <pebolle@tiscali.nl>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>
Date: Thu, 21 May 2015 10:54:35 +0200
In-Reply-To: <c708a1b50b8137556fb327c313184855aeaf54e3.1432135632.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
	 <c708a1b50b8137556fb327c313184855aeaf54e3.1432135632.git.Allen.Hubbe@emc.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Similar nit as for 2/6.

On Wed, 2015-05-20 at 11:41 -0400, Allen Hubbe wrote:
> --- a/drivers/ntb/Kconfig
> +++ b/drivers/ntb/Kconfig
> @@ -14,6 +14,8 @@ if NTB
>  
>  source "drivers/ntb/hw/Kconfig"
>  
> +source "drivers/ntb/test/Kconfig"
> +
>  config NTB_TRANSPORT

> --- /dev/null
> +++ b/drivers/ntb/test/Kconfig

> +config NTB_PINGPONG
> +       tristate "NTB Simple Ping Pong Client"
> +       depends on NTB

Again, superfluous dependency.

> +       help
> +        This is a simple ping pong driver that exercises the scratchpads and
> +        doorbells of the ntb hardware.  This driver may be used to test that
> +        your ntb hardware and drivers are functioning at a basic level.
> +
> +        If unsure, say N.

Thanks,


Paul Bolle

