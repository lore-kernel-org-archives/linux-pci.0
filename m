Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 28 Jun 2017 14:50:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH 0/3] change powerup logic for MediaTek PCIe controller
Message-ID: <20170628195049.GQ17844@bhelgaas-glaptop.roam.corp.google.com>
References: <1497866400-41844-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1497866400-41844-1-git-send-email-ryder.lee@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 19, 2017 at 05:59:57PM +0800, Ryder Lee wrote:
> Hi Bjorn,
> 
> This patch series does some modifications to powerup logic to avoid unbalanced
> PM warnings, and turns off host power if no link is detected.
> 
> I also make some properties(eg, PHY/reset/..) optional to gain more flexibility
> just in case future SoCs don't have it.
> 
> Could you also fold this patch series into pci/host-mediatek for v4.13?
> Thanks!
> 
> Ryder Lee (3):
>   PCI: mediatek: modify controller powerup logic
>   PCI: mediatek: turn off subsys power if no link up detected
>   PCI: mediatek: make some properties optioanl
> 
>  drivers/pci/host/pcie-mediatek.c | 110 +++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 52 deletions(-)

I folded these into the initial driver commit on pci/host-mediatek
for v4.13, thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
