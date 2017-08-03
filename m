Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 3 Aug 2017 14:10:45 -0500
From: Rob Herring <robh@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH v2 3/5] dt-bindings: PCI: rename and cleanup MediaTek
 binding text
Message-ID: <20170803191045.k6xqbm3ekqbnorzd@rob-hp-laptop>
References: <cover.1501122135.git.honghui.zhang@mediatek.com>
 <309532ded49d3452a609116d1c421d820bea74e4.1501122135.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <309532ded49d3452a609116d1c421d820bea74e4.1501122135.git.honghui.zhang@mediatek.com>
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

On Thu, Jul 27, 2017 at 10:58:37AM +0800, honghui.zhang@mediatek.com wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> In order to accommodate other SoC generations, this patch updates filename
> to make it more generic, regroups specific properties by SoCs, and removes
> redundant descriptions.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  ...{mediatek,mt7623-pcie.txt => mediatek-pcie.txt} | 29 +++++++++++-----------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>  rename Documentation/devicetree/bindings/pci/{mediatek,mt7623-pcie.txt => mediatek-pcie.txt} (91%)

Acked-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
