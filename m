Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Roy Zang <roy.zang@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "Minghuan Lian" <minghuan.Lian@freescale.com>, Mingkai Hu
 <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH] PCI: layerscape: Fix kernel panic on accessing NULL
 pointer
Date: Mon, 17 Oct 2016 21:58:19 +0000
Message-ID: <HE1PR0402MB2748D72F81AE2193AD2197A98BD00@HE1PR0402MB2748.eurprd04.prod.outlook.com>
References: <1476740647-11155-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Stuart Yoder <stuart.yoder@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 10/17/2016 04:50 PM, Li Yang wrote:
> Commit fefe6733e added reference to the pcie->drvdata before it is
> initialized which causes a kernel panic.  Fix the problem by
> initializing the pcie->drvdata earlier before it is used.
>
> Reported-by: Stuart Yoder <stuart.yoder@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---

 Acked-by:  Roy Zang <roy.zang@nxp.com>

Roy


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
