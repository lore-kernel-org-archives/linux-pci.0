Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0053.outbound.protection.outlook.com ([104.47.2.53]:49632
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751346AbcKFTw2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Nov 2016 14:52:28 -0500
From: Ilya Lesokhin <ilyal@mellanox.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Shouldn't VFIO virtualize the ATS capability?
Date: Sun, 6 Nov 2016 11:13:09 +0000
Message-ID: <VI1PR0502MB295799E38EEC9E1F939B68B5D4A40@VI1PR0502MB2957.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi=20
I've noticed that VFIO doesn't virtualize the ATS capability.
It seems to me that translation caching and Smallest Translation Unit is so=
mething you would want to control on the host. Am I wrong?

Thanks,
Ilya
