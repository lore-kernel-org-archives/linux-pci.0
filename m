Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:4273 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752294AbdFPNxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2017 09:53:18 -0400
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
To: "'Logan Gunthorpe'" <logang@deltatee.com>,
        <linux-ntb@googlegroups.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: "'Jon Mason'" <jdmason@kudzu.us>,
        "'Dave Jiang'" <dave.jiang@intel.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Kurt Schwemmer'" <kurt.schwemmer@microsemi.com>,
        "'Stephen Bates'" <sbates@raithlin.com>,
        "'Serge Semin'" <fancer.lancer@gmail.com>,
        <Sergey.Semin@t-platforms.ru>
References: <20170615203729.9009-1-logang@deltatee.com>
In-Reply-To: <20170615203729.9009-1-logang@deltatee.com>
Subject: RE: [RFC PATCH 00/13] Switchtec NTB Support
Date: Fri, 16 Jun 2017 09:53:01 -0400
Message-ID: <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Logan Gunthorpe
> Hi,
>=20
> This patchset implements Non-Transparent Bridge (NTB) support for the
> Microsemi Switchtec series of switches. We're looking for some
> review from the community at this point but hope to get it upstreamed
> for v4.14.
>=20
> Switchtec NTB support is configured over the same function and bar
> as the management endpoint. Thus, the new driver hooks into the
> management driver which we had merged in v4.12. We use the class
> interface API to register an NTB device for every switchtec device
> which supports NTB (not all do).
>=20
> The Switchtec hardware supports doorbells, memory windows and =
messages.
> Seeing there is no native scratchpad support, 128 spads are emulated
> through the use of a pre-setup memory window. The switch has 64
> doorbells which are shared between the two partitions and a
> configurable set of memory windows. While the hardware supports more
> than 2 partitions, this driver only supports the first two seeing
> the current NTB API only supports two hosts.

See what is staged in https://github.com/jonmason/ntb.git ntb-next, with =
the addition of multi-peer support by Serge.  It would be good at this =
stage to understand whether the api changes there would also support the =
Switchtec driver, and what if anything must change, or be planned to =
change, to support the Switchtec driver.

Thanks for providing the patch set for the Switchtec driver.  My first =
impression is that it is a good patch set.  Only to be included, it =
needs to be reconciled with the api changes in ntb-next.  I will follow =
up with a more detailed review of patches in this series, but sending =
this now as I don't want to delay your review of ntb-next.

>=20
> The driver has been tested with ntb_netdev and fully passes the
> ntb_test script.
>=20
> This patchset is based off of v4.12-rc5 and can be found in this
> git repo:
>=20
> https://github.com/sbates130272/linux-p2pmem.git switchtec_ntb
>=20
> Thanks,
>=20
> Logan
>=20
>=20
> Logan Gunthorpe (13):
>   switchtec: move structure definitions into a common header
>   switchtec: export class symbol for use in upper layer driver
>   switchtec: add ntb hardware register definitions
>   switchtec: add link event notifier block
>   switchtec_ntb: introduce initial ntb driver
>   switchtec_ntb: initialize hardware for memory windows
>   switchtec_ntb: initialize hardware for doorbells and messages
>   switchtec_ntb: add skeleton ntb driver
>   switchtec_ntb: add link management
>   switchtec_ntb: implement doorbell registers
>   switchtec_ntb: implement scratchpad registers
>   switchtec_ntb: add memory window support
>   switchtec_ntb: update switchtec documentation with notes for ntb
>=20
>  Documentation/switchtec.txt         |   12 +
>  MAINTAINERS                         |    2 +
>  drivers/ntb/hw/Kconfig              |    1 +
>  drivers/ntb/hw/Makefile             |    1 +
>  drivers/ntb/hw/mscc/Kconfig         |    9 +
>  drivers/ntb/hw/mscc/Makefile        |    1 +
>  drivers/ntb/hw/mscc/switchtec_ntb.c | 1144 =
+++++++++++++++++++++++++++++++++++
>  drivers/pci/switch/switchtec.c      |  319 ++--------
>  include/linux/ntb.h                 |    3 +
>  include/linux/switchtec.h           |  365 +++++++++++
>  10 files changed, 1601 insertions(+), 256 deletions(-)
>  create mode 100644 drivers/ntb/hw/mscc/Kconfig
>  create mode 100644 drivers/ntb/hw/mscc/Makefile
>  create mode 100644 drivers/ntb/hw/mscc/switchtec_ntb.c
>  create mode 100644 include/linux/switchtec.h
>=20
> --
> 2.11.0
