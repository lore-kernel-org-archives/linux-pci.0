Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:4977 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753323AbeDPTth (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2018 15:49:37 -0400
From: <Alex_Gagniuc@Dellteam.com>
To: <scott.bauer@intel.com>
CC: <keith.busch@intel.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <mr.nuke.me@gmail.com>
Subject: RE: [PATCH 0/4] PCI/AER: Use-after-free fix
Date: Mon, 16 Apr 2018 19:49:34 +0000
Message-ID: <9816175e5bbe4bd0b911b42aedabba1a@ausx13mps321.AMER.DELL.COM>
References: <20180409220444.6632-1-keith.busch@intel.com>
 <a97b5921e5cf4855b5e76110a7984fdf@ausx13mps321.AMER.DELL.COM>
 <20180412164709.spesry7skaa3x5hf@sbauer-Z170X-UD5>
In-Reply-To: <20180412164709.spesry7skaa3x5hf@sbauer-Z170X-UD5>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Scott Bauer [mailto:scott.bauer@intel.com]=20
On Thu, Apr 12, 2018 at 05:06:05PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> From: Keith Busch [mailto:keith.busch@intel.com]
>=20
> > AER error handling walks the PCI topology below a root port, saving poi=
nters of the pci_dev structs affected by the error along the way.
>=20
> Hi Keith,
>=20
> I've been trying to do an ABA test to confirm that your change eliminates=
 the use-after-free issue we've seen. The race seems to be quite elusive, s=
o I can't reliably reproduce it. Your changes have not been forgotten; I ha=
ve them staged for further testing.
>=20
> Alex


> If you need help triggering the race you can add a sleep/microsleep here:

Tested-by: Alexandru Gagniuc
