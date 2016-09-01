Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1472455618-17892-1-git-send-email-po.liu@nxp.com>
References: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
 <1472455618-17892-1-git-send-email-po.liu@nxp.com>
From: Ley Foon Tan <lftan@altera.com>
Date: Thu, 1 Sep 2016 08:58:42 +0800
Message-ID: <CAFiDJ5__WC=GeeA2Hg8LSG5xbQGc7frP6KfHfF_QhBm0=-w9Jw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64:pci: fix the IOV device access config space
 valid condition
To: Po Liu <po.liu@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci <linux-pci@vger.kernel.org>,
 Pratyush Anand Thakur <pratyush.anand@gmail.com>,
 Stuart Yoder <stuart.yoder@nxp.com>, Yang-Leo Li <leoyang.li@nxp.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Michal Simek <michal.simek@xilinx.com>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 29, 2016 at 3:26 PM, Po Liu <po.liu@nxp.com> wrote:
> When echo a number to /sys/bus/pci/devices/xxx/sriov_numvfs to enable the
> VF devices. A crash log occurred. This found to be access the IOV devices
> config space failure issue.
>
> The read/write config space from host would judge the pcie device plugin
> or not by(Designware platform as example):
>
> if (bus->primary == pp->root_bus_nr && dev > 0)
>     return 0;
>
> Although all PCIe devices for dev(coming from the device and function
> number) is zero. But the dev is not zero for VF devices. So remove the
> condition.
>
> These PCI hosts were changed: designware, altera, xilinx.
>
> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---

For pcie-altera.c:
Acked-by: Ley Foon Tan <lftan@altera.com>

Thanks.

Regards
Ley Foon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
