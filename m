Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1lp0144.outbound.protection.outlook.com ([207.46.163.144]:29036
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751549AbaHFUjm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 16:39:42 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: Gerhard Sittig <gsi@denx.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jon Mason <jon.mason@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Detlev Zundel <dzu@denx.de>,
	"rajatxjain@gmail.com" <rajatxjain@gmail.com>
Subject: RE: [PATCH RFC v1 0/4] PCI NTB: prepare for more hardware support
Date: Wed, 6 Aug 2014 20:23:49 +0000
Message-ID: <6711167537394013bf58b9132d2a63fe@DM2PR05MB671.namprd05.prod.outlook.com>
References: <1407336835-30586-1-git-send-email-gsi@denx.de>
In-Reply-To: <1407336835-30586-1-git-send-email-gsi@denx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Gerhard,

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Gerhard Sittig
> Sent: Wednesday, August 06, 2014 7:54 AM
> To: linux-pci@vger.kernel.org; Jon Mason
> Cc: Bjorn Helgaas; Detlev Zundel; Gerhard Sittig
> Subject: [PATCH RFC v1 0/4] PCI NTB: prepare for more hardware support
> 
> The current implementation of the PCI non-transparent bridge support
> exclusively supports Intel hardware.  This series prepares for the introduction
> of other vendor's hardware support, by separating the generic 'data
> transport' driver from the specific 'hardware support' driver.

Thanks for this effort. I also have a PLX NT bridge that I was exploring to add support for. This will definitely make it easier.

Just curious, do you have any kind of NT bridge hardware that you want to add support for?

Thanks,

Rajat


> 
> The current implementation has a circular dependency, where the data
> transport uses hardware specific routines for its communication, while the
> hardware driver calls into the data transport layer to have the data link
> established upon probe.  In addition, existing documentation suggests that
> out-of-tree drivers may use the hardware driver's routines, working in
> parallel to the in-tree data transport and the network interface on top if it.
> 
> This series "puts the data transport first", to provide routines to register
> hardware drivers with the transport and to have the transport become
> available as hardware is found.  While several hardware drivers may
> implement the common "hw" API, and one of those drivers gets probed at
> runtime and then is used for the data transport.  The relation of exactly one
> hardware driver to one transport instance is kept, as is the NTB driver's API
> within the kernel.  No new hardware support gets introduced by this series.
> It's "mere refactoring".
> 
> 
> Unfortunately I don't have Intel hardware to exercise runtime tests for the
> series.  It has only been compile-tested for bisectability and with several
> combinations of the tristate options, and the series is checkpatch clean
> including --strict.
> Testers who have access to hardware are cordially invited. :)
> 
> 
> BTW was I surprised to find the NTB driver under drivers/ntb/, and not
> underneath the PCI subsystem.  I hope I got the list of recipients correct for
> the series.
> 
> 
> Gerhard Sittig (4):
>   ntb: split Intel specifics out of the "NTB hardware" interface
>   ntb: header file nits (multiple inclusion, explicit entries)
>   ntb: prepare to build the 'data transport' as a separate module
>   ntb: de-couple data transport from hardware support
> 
>  drivers/ntb/Kconfig                          |   45 ++++--
>  drivers/ntb/Makefile                         |    5 +-
>  drivers/ntb/ntb_hw.h                         |  101 +++++++------
>  drivers/ntb/{ntb_hw.c => ntb_hw_intel.c}     |   83 +++++++----
>  drivers/ntb/ntb_hw_intel.h                   |   73 ++++++++++
>  drivers/ntb/{ntb_regs.h => ntb_regs_intel.h} |    0
>  drivers/ntb/ntb_transport.c                  |  196
> ++++++++++++++++++++++++++
>  include/linux/ntb.h                          |    7 +
>  8 files changed, 426 insertions(+), 84 deletions(-)  rename
> drivers/ntb/{ntb_hw.c => ntb_hw_intel.c} (94%)  create mode 100644
> drivers/ntb/ntb_hw_intel.h  rename drivers/ntb/{ntb_regs.h =>
> ntb_regs_intel.h} (100%)
> 
> --
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
