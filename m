Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 3 Aug 2017 14:12:16 -0500
From: Rob Herring <robh@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH v2 5/5] dt-bindings: PCI: add support for new generation
 controller
Message-ID: <20170803191216.sox2avhvxyharbst@rob-hp-laptop>
References: <cover.1501125202.git.honghui.zhang@mediatek.com>
 <54392579509fd9b9b4635559c1c4e32be63d9781.1501125202.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <54392579509fd9b9b4635559c1c4e32be63d9781.1501125202.git.honghui.zhang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 robh@kerenl.org, linux-mediatek@lists.infradead.org, yong.wu@mediatek.com,
 bhelgaas@google.com, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 27, 2017 at 11:14:21AM +0800, honghui.zhang@mediatek.com wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> Add support for MediaTek new generation controller and update related
> properities.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  .../devicetree/bindings/pci/mediatek-pcie.txt      | 168 ++++++++++++++++++++-
>  1 file changed, 161 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
