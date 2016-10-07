Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0086.outbound.protection.outlook.com ([104.47.2.86]:50816
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936228AbcJGRUP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 13:20:15 -0400
From: Roy Zang <roy.zang@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        "Roy Zang" <tie-fei.zang@freescale.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/7] PCI: layerscape: Name private struct pointer "ls"
 consistently
Date: Fri, 7 Oct 2016 17:05:05 +0000
Message-ID: <HE1PR0402MB27481312F256EBB295800F878BC60@HE1PR0402MB2748.eurprd04.prod.outlook.com>
References: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/07/2016 11:42 AM, Bjorn Helgaas wrote:=0A=
> Use a device-specific name, "ls", for struct ls_pcie pointers=0A=
> to hint that this is device-specific information.  No functional change=
=0A=
> intended.=0A=
how about ls_pcie  instead of ls ?=0A=
Roy=0A=
