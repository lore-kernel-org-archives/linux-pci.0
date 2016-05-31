Return-Path: <yhlu.kernel@gmail.com>
Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <574D03F9.6050201@intel.com>
References: <1464604404-11257-1-git-send-email-yu.c.chen@intel.com>
	<20160530213305.GA21322@localhost>
	<574D03F9.6050201@intel.com>
Date: Tue, 31 May 2016 00:00:48 -0700
Message-ID: <CAE9FiQV_Mc9VuyBvCB7hL_0pgj+-wW1_jupzhbTHij+VQeLF-A@mail.gmail.com>
Subject: Re: [PATCH][RFC] PCI: Workaround to enable poweroff on Mac Pro 11
From: Yinghai Lu <yinghai@kernel.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 8:24 PM, Chen Yu <yu.c.chen@intel.com> wrote:

> and then in pcibios_assign_resources, 0000:00:1c.0 tries to allocate minimal
> resource window and then update related base/limit registers:
>
> [    0.865342] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus
> 02] add_size 1000
> [    0.865343] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff
> 64bit pref] to [bus 02] add_size 200000 add_align 100000
> [    0.865344] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff]
> to [bus 02] add_size 200000 add_align 100000
>

That is for hotplug bridge, then we could use following instead.

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ee72ebe..d3ec833 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2775,6 +2775,13 @@ static void quirk_hotplug_bridge(struct pci_dev *dev)

 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);

+static void quirk_hotplug_bridge_skip(struct pci_dev *dev)
+{
+       dev->is_hotplug_bridge = 0;
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10,
quirk_hotplug_bridge_skip);
+
 /*
  * This is a quirk for the Ricoh MMC controller found as a part of
  * some mulifunction chips.
