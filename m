Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Roy Zang <roy.zang@nxp.com>
To: Jingoo Han <jingoohan1@gmail.com>, Po Liu <po.liu@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] arm64:pci: fix the IOV device access config space
 valid condition
Date: Tue, 30 Aug 2016 15:54:43 +0000
Message-ID: <HE1PR0402MB2748F7A71F8A0073644EE3568BE00@HE1PR0402MB2748.eurprd04.prod.outlook.com>
References: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
 <1472455618-17892-1-git-send-email-po.liu@nxp.com>
 <000a01d202d5$3f86e3a0$be94aae0$@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "soren.brinkmann@xilinx.com" <soren.brinkmann@xilinx.com>, 'Arnd
 Bergmann' <arnd@arndb.de>,
 "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
 Stuart Yoder <stuart.yoder@nxp.com>, Yang-Leo Li <leoyang.li@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 'Bjorn Helgaas' <bhelgaas@google.com>, "lftan@altera.com" <lftan@altera.com>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 08/30/2016 10:43 AM, Jingoo Han wrote:
> I really don't like to modify host driver stuffs.
> But, if there is no alternatives, this patch looks good.

I do not see other good place to fix the bug.

Roy Zang <roy.zang@nxp.com>

Roy


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
