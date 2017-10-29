Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0045.outbound.protection.outlook.com ([104.47.2.45]:39340
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750928AbdJ2H4z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Oct 2017 03:56:55 -0400
From: Ilya Lesokhin <ilyal@mellanox.com>
To: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Devices behind a non-ACS switch are assigned different iommu-groups
Date: Sun, 29 Oct 2017 07:56:52 +0000
Message-ID: <AM4PR0501MB2723EC01DCA37976AE4EABA4D4580@AM4PR0501MB2723.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
I was testing devices assignment behind a non-ACS switch and to my surprise=
,
Devices connected to different ports were assigned different iommu-groups.

The reason for this behavior is that pci_acs_enabled(...) considers the swi=
tch=20
Upstream port to have ACS enabled.
http://elixir.free-electrons.com/linux/v4.13.1/source/drivers/pci/pci.c#L29=
14
(the upstream port is not a multifunction device).

I'm not sure what the correct solution is but I believe, the upstream port
Shouldn't be considered in pci_acs_path_enable(...).

Thanks,
Ilya
