Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 13 Jul 2017 18:52:13 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Joao Pinto <Joao.Pinto@synopsys.com>, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC] PCI: dwc: designware: allow customize unroll registers'
 readl/writel
Message-ID: <20170713185213.0b04a4fc@xhacker>
In-Reply-To: <20170713184837.541ccf26@xhacker>
References: <20170713184837.541ccf26@xhacker>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 13 Jul 2017 18:48:37 +0800 Jisheng Zhang wrote:

> Hi Joao, Jingoo,
> 
> Now, the PCIE_GET_ATU_OUTB_UNR_REG_OFFSET macro is defined as:
> 
> /* Register address builder */
> #define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)        \
>                         ((0x3 << 20) | ((region) << 9))
> 
> I have one question: where does the (0x3 << 20) come from? 2MB space, a bit

sorry, typo. (0x3 << 20) should be 3MB.

> large. And I didn't find it in the databook. Is it platform specific?
> If yes, I want to cook one patch to customize unroll registers' readl/writel.
> 
> And how does (0x3 << 20) enable DBI2 access?
> 
> Thanks in advance,
> Jisheng


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
