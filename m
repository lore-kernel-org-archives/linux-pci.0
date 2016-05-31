Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Tue, 31 May 2016 12:40:51 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, Peter Wu <peter@lekensteyn.nl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] PCI: Wait for 50ms after bridge is powered up
Message-ID: <20160531104051.GA13958@wunner.de>
References: <20160524162833.GA30762@localhost>
 <20160526104557.GA6816@wunner.de>
 <20160526110308.GX1789@lahna.fi.intel.com>
 <1576190.gfFb6HhZV6@vostro.rjw.lan>
 <20160530093326.GH1789@lahna.fi.intel.com>
 <20160530144445.GC1743@lahna.fi.intel.com>
 <CAMxnaaXhapETZYMVe6EUoBGaMtxL_fP+uzc30SQpM+6EqPF3CQ@mail.gmail.com>
 <20160531083349.GG1743@lahna.fi.intel.com>
 <20160531085805.GI1743@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160531085805.GI1743@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 31, 2016 at 11:58:05AM +0300, Mika Westerberg wrote:
> To summarize the next steps. I will send new version of the
> PCI PM patches with following changes.
> 
>   - Drop this 50ms patch, we should have the PCIe 100ms delay already
>     covered.
> 
>   - Increase runtime PM autosuspend time from 10ms to 500ms (or whatever
>     is the prefered default).

I did some tests, turns out the autosuspend delay need not be increased
to prevent the Thunderbolt hotplug ports from suspending between
"enabling device" and loading the pciehp driver, however the following
is needed:

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 7860ab3..1d1fb1c 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -238,6 +238,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 		pm_runtime_set_autosuspend_delay(&dev->dev, 10);
 		pm_runtime_use_autosuspend(&dev->dev);
 		pm_runtime_put_autosuspend(&dev->dev);
+		pm_runtime_mark_last_busy(&dev->dev);
 		pm_runtime_allow(&dev->dev);
 	}
 

With this small change things look much better (with the 10 ms delay
we have now):

[    2.353643] pcieport 0000:06:03.0: enabling device (0000 -> 0002)
[    2.353789] pcieport 0000:06:03.0: rpm_idle
[    2.353825] pcieport 0000:06:04.0: enabling device (0000 -> 0003)
[    2.353855] pcieport 0000:06:03.0: rpm_idle
[    2.353994] pcieport 0000:06:04.0: rpm_idle
[    2.354017] pcieport 0000:06:04.0: rpm_idle
[    2.354042] pcieport 0000:06:05.0: enabling device (0000 -> 0003)
[    2.354186] pcieport 0000:06:05.0: rpm_idle
[    2.354213] pcieport 0000:06:06.0: enabling device (0000 -> 0002)
[    2.354362] pcieport 0000:06:06.0: rpm_idle
[    2.354407] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.354441] pciehp 0000:06:03.0:pcie204: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    2.354524] pciehp 0000:06:03.0:pcie204: service driver pciehp loaded
[    2.354533] pciehp 0000:06:04.0:pcie204: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    2.354609] pciehp 0000:06:04.0:pcie204: service driver pciehp loaded
[    2.354617] pciehp 0000:06:05.0:pcie204: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    2.354690] pciehp 0000:06:05.0:pcie204: service driver pciehp loaded
[    2.354698] pciehp 0000:06:06.0:pcie204: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    2.354772] pciehp 0000:06:06.0:pcie204: service driver pciehp loaded
[    2.354777] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.354827] intel_idle: MWAIT substates: 0x21120
[    2.354829] intel_idle: v0.4.1 model 0x3A
[    2.355122] intel_idle: lapic_timer_reliable_states 0xffffffff
[    2.355152] GHES: HEST is not enabled!
[    2.355216] pcieport 0000:06:05.0: rpm_idle
[    2.355235] pcieport 0000:06:06.0: rpm_idle
[    2.355238] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.355277] pcieport 0000:06:03.0: rpm_idle
[    2.355301] pcieport 0000:06:04.0: rpm_idle
[    2.355659] Linux agpgart interface v0.103
[    2.355739] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    2.355764] AMD IOMMUv2 functionality not available on this system
[    2.356396] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    2.364794] pcieport 0000:06:06.0: rpm_suspend
[    2.366112] pcieport 0000:06:05.0: rpm_suspend
[    2.367402] pcieport 0000:06:04.0: rpm_suspend
[    2.368671] pcieport 0000:06:03.0: rpm_suspend

Thanks,

Lukas
