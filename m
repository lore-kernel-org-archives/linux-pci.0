Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Mar 2017 11:14:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH v2 08/22] PCI: dwc: designware: Add EP mode support
Message-ID: <20170308191419.GA12085@infradead.org>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-9-git-send-email-kishon@ti.com>
 <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com>
 <58BE42B2.20305@ti.com>
 <02461be2-268d-485a-2bc4-3b148726d37d@synopsys.com>
 <aa9835a7-07f4-d042-d04a-b0d9cc0ea3de@synopsys.com>
 <58BFEC7D.3090608@ti.com>
 <35d539ba-956f-330e-c28d-b67c3d414578@synopsys.com>
 <58C00798.1030302@ti.com>
 <650c53fc-482c-feab-faa3-c30689d3d128@synopsys.com>
MIME-Version: 1.0
In-Reply-To: <650c53fc-482c-feab-faa3-c30689d3d128@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 Jingoo Han <jingoohan1@gmail.com>, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 08, 2017 at 03:32:03PM +0000, Joao Pinto wrote:
> #define PCIE_GET_ATU_INB_UNR_REG_ADDR(region, register)		\
> 					((0x3 << 20) | (region << 9) |	\
> 					(0x1 << 8)

Can you turn this and any similar macro into inline functions?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
