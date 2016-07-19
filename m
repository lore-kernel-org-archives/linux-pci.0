Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56138 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143AbcGSWCm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Jul 2016 18:02:42 -0400
Date: Tue, 19 Jul 2016 17:02:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Amir Levy <amir.jer.levy@intel.com>
Cc: andreas.noever@gmail.com, gregkh@linuxfoundation.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	thunderbolt-linux@intel.com, mika.westerberg@intel.com,
	tomas.winkler@intel.com
Subject: Re: [PATCH v4 0/7] thunderbolt: Introducing Thunderbolt(TM)
 networking
Message-ID: <20160719220236.GC18635@localhost>
References: <1468836040-28043-1-git-send-email-amir.jer.levy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468836040-28043-1-git-send-email-amir.jer.levy@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 18, 2016 at 01:00:33PM +0300, Amir Levy wrote:
> This is version 4 of Thunderbolt(TM) driver for non-Apple hardware.
> 
> Changes since v3:
>  - Moved new Thunderbolt device IDs from pci_ids.h to icm_nhi.h.
>  - Cleanup and added some comments in code.
> 
> These patches were pushed to GitHub where they can be reviewed more
> comfortably with green/red highlighting:
> 	https://github.com/01org/thunderbolt-software-kernel-tree
> 
> Daemon code:
> 	https://github.com/01org/thunderbolt-software-daemon
> 
> For reference, here's a link to version 3:
> [v3]:	https://lkml.org/lkml/2016/7/14/311
> 
> Amir Levy (7):
>   thunderbolt: Macro rename
>   thunderbolt: Updating the register definitions
>   thunderbolt: Kconfig for Thunderbolt(TM) networking
>   thunderbolt: Communication with the ICM (firmware)
>   thunderbolt: Networking state machine
>   thunderbolt: Networking transmit and receive
>   thunderbolt: Networking doc
> 
>  Documentation/00-INDEX                   |    2 +
>  Documentation/thunderbolt-networking.txt |  135 ++
>  drivers/thunderbolt/Kconfig              |   25 +-
>  drivers/thunderbolt/Makefile             |    3 +-
>  drivers/thunderbolt/icm/Makefile         |   28 +
>  drivers/thunderbolt/icm/icm_nhi.c        | 1642 +++++++++++++++++++++
>  drivers/thunderbolt/icm/icm_nhi.h        |   93 ++
>  drivers/thunderbolt/icm/net.c            | 2276 ++++++++++++++++++++++++++++++
>  drivers/thunderbolt/icm/net.h            |  274 ++++
>  drivers/thunderbolt/nhi_regs.h           |  115 +-
>  10 files changed, 4585 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/thunderbolt-networking.txt
>  create mode 100644 drivers/thunderbolt/icm/Makefile
>  create mode 100644 drivers/thunderbolt/icm/icm_nhi.c
>  create mode 100644 drivers/thunderbolt/icm/icm_nhi.h
>  create mode 100644 drivers/thunderbolt/icm/net.c
>  create mode 100644 drivers/thunderbolt/icm/net.h

Andreas, I assume you'll handle this.
