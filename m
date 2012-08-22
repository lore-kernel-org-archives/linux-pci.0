Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48884 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933182Ab2HVRJO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Aug 2012 13:09:14 -0400
Received: by lbbgj3 with SMTP id gj3so781582lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 22 Aug 2012 10:09:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5033B052.7010506@gmail.com>
References: <1343836477-7287-1-git-send-email-jiang.liu@huawei.com>
 <CAErSpo7WoEeWayMQ__H4jiKKmMdNgyLMYdRmJ0Nf0LoEKjFRmA@mail.gmail.com>
 <50325732.3000700@gmail.com> <CAErSpo4-SGH__kE5tPNzz+VO=V-GKOMdcKCqqy6s3=5sNKgG0w@mail.gmail.com>
 <50325C18.9030207@gmail.com> <CAErSpo6t9m0xmWkXfmONtbicjqLR_z5dLsjKCLWQfcktzRKkUA@mail.gmail.com>
 <CAErSpo5=OUM9veX8890USWegTG_Fhh10soxPJbjemd80bAO0qg@mail.gmail.com> <5033B052.7010506@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 22 Aug 2012 10:08:51 -0700
Message-ID: <CAErSpo7MYETQPac-P9BGKx9dp0KnoP3TWLrjTePaNTdFVKgU3Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/32] provide interfaces to access PCIe capabilities registers
To: Jiang Liu <liuj97@gmail.com>
Cc: Hayes Wang <hayeswang@realtek.com>, Yu Zhao <yu.zhao@intel.com>,
	Dexuan Cui <dexuan.cui@intel.com>,
	Don Dutile <ddutile@redhat.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 21, 2012 at 8:59 AM, Jiang Liu <liuj97@gmail.com> wrote:
> Hi Bjorn,
>         Thanks for your help to finalize the patchset.
>         There's another suspicious issue in r8169.c, which directly writes PCI_EXP_DEVCTL_NOSNOOP_EN
> to PCI_EXP_DEVCTL. I feel it should preserve other bits when setting the NOSNOOP flag.

I think you're right.  I propose the following patch on top of your
original one:

commit 300ef7967e87467656b0fe24270edba66bce45e4
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Aug 22 10:29:42 2012 -0600

    r8169: Preserve other Device Control bits when setting NOSNOOP_EN

    Previously, when we turned on the "Enable No Snoop Bit," we cleared all
    the other Device Control bits, including error reporting enables,
    Max_Payload_Size, Max_Read_Request_Size, etc.  This patch preserves
    all the other bits.

    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/net/ethernet/realtek/r8169.c
b/drivers/net/ethernet/realtek/r8169.c
index 4104968..a7cc560 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -5385,8 +5385,8 @@ static void rtl_hw_start_8101(struct net_device *dev)

        if (tp->mac_version == RTL_GIGA_MAC_VER_13 ||
            tp->mac_version == RTL_GIGA_MAC_VER_16)
-               pcie_capability_write_word(pdev, PCI_EXP_DEVCTL,
-                                          PCI_EXP_DEVCTL_NOSNOOP_EN);
+               pcie_capability_set_word(pdev, PCI_EXP_DEVCTL,
+                                        PCI_EXP_DEVCTL_NOSNOOP_EN);

        RTL_W8(Cfg9346, Cfg9346_Unlock);
