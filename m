Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 26 Sep 2017 23:04:35 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Ravi Shankar Jonnalagadda <venkata.ravi.jonnalagadda@xilinx.com>
Subject: Re: [PATCH v2 4/5] dmaengine: zynqmp_ps_pcie: Adding PS PCIe
 platform DMA driver
Message-ID: <20170926173435.GS30097@localhost>
References: <1504873388-29195-1-git-send-email-vjonnal@xilinx.com>
 <1504873388-29195-6-git-send-email-vjonnal@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <1504873388-29195-6-git-send-email-vjonnal@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 dmaengine@vger.kernel.org, bharat.kumar.gogada@xilinx.com,
 linux-pci@vger.kernel.org, michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org, vjonnal@xilinx.com, robh+dt@kernel.org,
 rgummal@xilinx.com, linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
 dan.j.williams@intel.com, soren.brinkmann@xilinx.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 08, 2017 at 05:53:07PM +0530, Ravi Shankar Jonnalagadda wrote:
> Platform driver handles transactions for PCIe EP DMA and Root DMA
> 
> Signed-off-by: Ravi Shankar Jonnalagadda <vjonnal@xilinx.com>
> Signed-off-by: RaviKiran Gummaluri <rgummal@xilinx.com>
> ---
>  drivers/dma/xilinx/ps_pcie_platform.c | 3055 +++++++++++++++++++++++++++++++++

I dont want to loose my sanity trying to review a 3k patch. If you don't put
an effort to make your code easier to review, I dont want to see this...

Nacked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
