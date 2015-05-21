Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lb3-smtp-cloud6.xs4all.net ([194.109.24.31]:35981 "EHLO
	lb3-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753997AbbEUIwA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2015 04:52:00 -0400
Message-ID: <1432198316.21715.135.camel@x220>
Subject: Re: [PATCH 02/16] NTB Abstraction Layer
From: Paul Bolle <pebolle@tiscali.nl>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>
Date: Thu, 21 May 2015 10:51:56 +0200
In-Reply-To: <d653819e0ebc03241fe073c9239be36a52f5e265.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
	 <d653819e0ebc03241fe073c9239be36a52f5e265.1432135631.git.Allen.Hubbe@emc.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-05-20 at 11:41 -0400, Allen Hubbe wrote:
>  Documentation/ntb.txt               |   58 +
>  MAINTAINERS                         |   14 +-
>  drivers/net/ntb_netdev.c            |   58 +-
>  drivers/ntb/Kconfig                 |   20 +-
>  drivers/ntb/Makefile                |    4 +-
>  drivers/ntb/hw/Kconfig              |    1 +
>  drivers/ntb/hw/Makefile             |    1 +
>  drivers/ntb/hw/intel/Kconfig        |    8 +
>  drivers/ntb/hw/intel/Makefile       |    1 +
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 3108 +++++++++++++++++++----------------
>  drivers/ntb/hw/intel/ntb_hw_intel.h |  591 +++----
>  drivers/ntb/ntb.c                   |  251 +++
>  drivers/ntb/ntb_transport.c         |  927 ++++++-----
>  include/linux/ntb.h                 |  983 +++++++++++
>  include/linux/ntb_transport.h       |   25 +-
>  15 files changed, 3873 insertions(+), 2177 deletions(-)
>  create mode 100644 Documentation/ntb.txt
>  create mode 100644 drivers/ntb/hw/Kconfig
>  create mode 100644 drivers/ntb/hw/Makefile
>  create mode 100644 drivers/ntb/hw/intel/Kconfig
>  create mode 100644 drivers/ntb/hw/intel/Makefile
>  create mode 100644 drivers/ntb/ntb.c
>  create mode 100644 include/linux/ntb.h

(My mailer tells me this message is over 200KB in size. Did you consider
offering bribes to get people to review this patch?)

I just spotted two nits.

> --- a/drivers/ntb/Kconfig
> +++ b/drivers/ntb/Kconfig
>  
> +if NTB
> +
> +source "drivers/ntb/hw/Kconfig"
> +
> +config NTB_TRANSPORT
> +       tristate "NTB Transport Client"
> +       depends on NTB

Superfluous dependency.

> +       help
> +        This is a transport driver that enables connected systems to exchange
> +        messages over the ntb hardware.  The transport exposes a queue pair api
> +        to client drivers.
> +
> +        If unsure, say N.
> +
> +endif # NTB

> --- /dev/null
> +++ b/drivers/ntb/hw/intel/Kconfig

> +config NTB_INTEL
> +       tristate "Intel Non-Transparent Bridge support"
> +       depends on NTB

Ditto.

> +       depends on X86
> +       help
> +        This driver supports Intel NTB on capable Xeon and Atom hardware.
> +
> +        If unsure, say N.

Thanks,


Paul Bolle

