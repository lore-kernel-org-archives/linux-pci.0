Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 16 Jul 2018 16:06:06 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 0/8] Fix PCI I/O space page leaks
Message-ID: <20180716150606.GA19945@red-moon>
References: <3e862a05-084a-d732-3060-6e2b234e9718@cogentembedded.com>
MIME-Version: 1.0
In-Reply-To: <3e862a05-084a-d732-3060-6e2b234e9718@cogentembedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Rob Herring <robh@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>,
 linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-renesas-soc@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, linux-mediatek@lists.infradead.org,
 Tanmay Inamdar <tinamdar@apm.com>, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 15, 2018 at 07:00:21PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> Here's a set of 8 patches against the 'pci/controller-fixes' branch of Lorenzo
> Pieralisi's 'pci.git' repo. They are the fixes for the PCI I/O space page leaks
> (and the kernel BUG caused by them on deferred probe); those were 1st found
> testing the R-Car PCIe driver. The patches are in the chronological order
> (considering the date/time of the commits specified in the Fixes: tag), patches
> #2..#8 depend on the patch #1 in order to build/work as it introduces the managed
> device API that they all use...
> 
> [1/8] PCI: xgene: Fix I/O space page leak
> [2/8] PCI: of: Fix I/O space page leak
> [3/8] PCI: versatile: Fix I/O space page leak
> [4/8] PCI: designware: Fix I/O space page leak
> [5/8] PCI: aardvark: Fix I/O space page leak
> [6/8] PCI: faraday: Fix I/O space page leak
> [7/8] PCI: mediatek: Fix I/O space page leak
> [8/8] PCI: v3-semi: Fix I/O space page leak
> 
> MBR, Sergei

Hi Sergei,

I reshuffled the series, rewrote commit logs and move the devm_
API to commit 2 which is the one you tested AFAIK.

I pushed them out to my pci/controller-fixes branch which I hope
we can still aim for an -rc, please do have a look and let me know
what you think, I have not asked Bjorn to pull it yet.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
