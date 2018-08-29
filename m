Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 28 Aug 2018 19:37:22 -0500
From: Rob Herring <robh@kernel.org>
To: Hanjie Lin <hanjie.lin@amlogic.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add DT bindings for Amlogic
 Meson PCIe Phy controller
Message-ID: <20180829003722.GA25763@bogus>
References: <1535096006-152091-1-git-send-email-hanjie.lin@amlogic.com>
 <1535096006-152091-2-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
In-Reply-To: <1535096006-152091-2-git-send-email-hanjie.lin@amlogic.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Hanjie Lin <hanjie.lin@amlogic.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, linux-pci@vger.kernel.org,
 Yixun Lan <yixun.lan@amlogic.com>, Yue Wang <yue.wang@amlogic.com>,
 Qiufang Dai <qiufang.dai@amlogic.com>, Liang Yang <liang.yang@amlogic.com>,
 Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Kishon Vijay Abraham I <kishon@ti.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 24 Aug 2018 15:33:25 +0800, Hanjie Lin wrote:
> From: Yue Wang <yue.wang@amlogic.com>
> 
> The Meson-PCIE-PHY controller supports the 5-Gbps data rate
> of the PCI Express Gen 2 specification and is backward compatible
> with the 2.5-Gbps Gen 1.1 specification with only
> inferred idle detection supported on Amlogic SoCs.
> 
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> ---
>  .../bindings/phy/amlogic,meson-pcie-phy.txt         | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
