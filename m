Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 9 Jun 2015 11:53:28 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 02/18] NTB: Add NTB hardware abstraction layer
Message-ID: <20150609165328.GH23119@google.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
 <21347a93355f40d945cf9f565f95e790d9b3bda5.1433838377.git.Allen.Hubbe@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <21347a93355f40d945cf9f565f95e790d9b3bda5.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 09, 2015 at 05:44:29AM -0400, Allen Hubbe wrote:
> Abstract the ntb device behind a programming interface, so that it can
> support different hardware.  Change the intel hardware driver to fit the
> abstraction.
> 
> Expose the ntb hardware api to client drivers instead of tying it to
> ntb_transport.  Make ntb_transport a client of the ntb hardware api.
> 
> Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
> ---
> 
> It was pointed out in v1 that this one patch is over 200KB.  Please
> accept my appologies for not breaking this down further.  The affected
> components in this patch had interdependencies, which makes it difficult
> to contain the changes.  This change separates the components, so future
> changes can be better contained.
>
>  Documentation/ntb.txt               |   58 +
>  MAINTAINERS                         |   14 +-
>  drivers/net/ntb_netdev.c            |   58 +-
>  drivers/ntb/Kconfig                 |   37 +-
>  drivers/ntb/Makefile                |    4 +-
>  drivers/ntb/hw/Kconfig              |    1 +
>  drivers/ntb/hw/Makefile             |    1 +
>  drivers/ntb/hw/intel/Kconfig        |    7 +
>  drivers/ntb/hw/intel/Makefile       |    1 +
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 3077 +++++++++++++++++++----------------
>  drivers/ntb/hw/intel/ntb_hw_intel.h |  607 ++++---
>  drivers/ntb/ntb.c                   |  251 +++
>  drivers/ntb/ntb_transport.c         |  944 ++++++-----
>  include/linux/ntb.h                 |  984 +++++++++++
>  include/linux/ntb_transport.h       |   25 +-
>  15 files changed, 3870 insertions(+), 2199 deletions(-)
>  create mode 100644 Documentation/ntb.txt
>  create mode 100644 drivers/ntb/hw/Kconfig
>  create mode 100644 drivers/ntb/hw/Makefile
>  create mode 100644 drivers/ntb/hw/intel/Kconfig
>  create mode 100644 drivers/ntb/hw/intel/Makefile
>  create mode 100644 drivers/ntb/ntb.c
>  create mode 100644 include/linux/ntb.h

I'm not really a reviewer (I'm only commenting on obvious English and
spelling issues), so maybe the real reviewers can handle this.  But if I
were reviewing the code, this patch would be far too large for me to make
sense of.

And it makes bisection and reversion significantly less useful.

Bjorn
