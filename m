Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 21 Dec 2017 21:15:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Honghui Zhang <honghui.zhang@mediatek.com>
Subject: Re: [PATCH v2 2/2] PCI: mediatek: Fixup class type for MT7622
Message-ID: <20171222031546.GF30595@bhelgaas-glaptop.roam.corp.google.com>
References: <1513822277-18329-1-git-send-email-honghui.zhang@mediatek.com>
 <1513822277-18329-3-git-send-email-honghui.zhang@mediatek.com>
 <1513838476.23174.3.camel@mhfsdcap03>
 <1513839672.25872.13.camel@mhfsdcap03>
 <20171222002712.GE30595@bhelgaas-glaptop.roam.corp.google.com>
 <1513904194.25872.23.camel@mhfsdcap03>
MIME-Version: 1.0
In-Reply-To: <1513904194.25872.23.camel@mhfsdcap03>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, yu.yu@mediatek.com,
 linux-pci@vger.kernel.org, sean.wang@mediatek.com,
 linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 lorenzo.pieralisi@arm.com, linux-mediatek@lists.infradead.org,
 xinping.qian@mediatek.com, yt.shen@mediatek.com, yingjoe.chen@mediatek.com,
 eddie.huang@mediatek.com, bhelgaas@google.com, Yong Wu <yong.wu@mediatek.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 22, 2017 at 08:56:34AM +0800, Honghui Zhang wrote:
> There's an internal control register that control the Vendor ID and
> device ID values, our designer leave the default value un-touched. I
> will set these values in that way for the next version of fix.

Then there's no problem.  The mtk_pcie driver is a platform driver
that claims the host controller based on an of_device_id from a device
tree.

Apparently the bridge is also materialized in PCI config space, which
is typical for x86 host bridges, and makes the bridge appear in
"lspci".  But drivers generally don't claim bridges that way.

You can just program the Vendor and Device IDs by writing the internal
control registers somewhere in the mtk_pci_probe() path.

Then you can set the class code the same way, using an internal
control register (if that's possible), or using a quirk with the
correct Mediatek Vendor ID (if there is no internal writable
register).

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
