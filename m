Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 8 Aug 2017 15:20:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH v3 5/6] PCI: mediatek: Add new generation controller
 support
Message-ID: <20170808202022.GK16580@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1501846816.git.honghui.zhang@mediatek.com>
 <2adcb5f915eb8bd5817592ea32974eb25da02e4f.1501846816.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <2adcb5f915eb8bd5817592ea32974eb25da02e4f.1501846816.git.honghui.zhang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, yong.wu@mediatek.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 robh@kerenl.org, linux-mediatek@lists.infradead.org, xinping.qian@mediatek.com,
 bhelgaas@google.com, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 04, 2017 at 08:06:41PM +0800, honghui.zhang@mediatek.com wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> MediaTek's PCIe host controller has two generation HWs, the new
> generation HW has two root ports, it shares most probing flow with the
> legacy controller. But the read/write config space logical is different
> from the legacy controller. The per-port register must be touched for
> read/write config space, And the per-port register base are in separate
> address space.

Can you also include the new controller IDs ("MT7622/MT2712"?) in the
subject line of this patch?

> Add support for new Gen2 controller which can be found on MT7622/MT2712.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
