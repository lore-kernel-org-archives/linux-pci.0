Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 21 Jun 2016 10:03:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: wangyijing <wangyijing@huawei.com>
Subject: Re: [PATCH v1 00/25] PCI: Request host bridge window resources
Message-ID: <20160621150352.GB31917@localhost>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160618180735.GB20504@localhost> <57692BD0.6030609@huawei.com>
MIME-Version: 1.0
In-Reply-To: <57692BD0.6030609@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jason Cooper <jason@lakedaemon.net>, Scott Branden <sbranden@broadcom.com>,
 Jingoo Han <jingoohan1@gmail.com>, Jon Mason <jonmason@broadcom.com>,
 linux-pci@vger.kernel.org, Pratyush Anand <pratyush.anand@gmail.com>,
 linux-kernel@vger.kernel.org, rfi@lists.rocketboards.org,
 linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
 Simon Horman <horms@verge.net.au>, Thierry Reding <thierry.reding@gmail.com>,
 Tanmay Inamdar <tinamdar@apm.com>, Ray Jui <rjui@broadcom.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ley Foon Tan <lftan@altera.com>,
 Michal Simek <michal.simek@xilinx.com>,
 =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 21, 2016 at 07:58:08PM +0800, wangyijing wrote:
> Hi Bjorn, use devm_request_resource() for host bridge resource is cool,
> what about do the similar change for x86, now we request host bridge resource
> in pci_acpi_root_add_resources() in x86, and we would release the host bridge
> resource when host bridge device refcount reach 0. This logic may introduce issue,
> E.g.
> If we try to remove a pci host bridge, but there is a child pci device which refcount
> cannot decrease to 0 after remove the device, in this case, its parent pci_bus and
> parent device, all their refcount cannot reach to 0, the result is pci host bridge
> refcount can not reach 0, so its .release_fn() won't be called, and host bridge
> resouces can not release. If we want to add the pci host bridge again, all pci devices
> can not work because the resource is conflict with the old.
> 
> devm resource would be released when the driver detach, this is better than what we do now, I think.

I'm not going to convert pci_root.c to use devm right now.  That might
be a good thing, but this current series is mostly trivial.  I think
changing pci_root.c would not be trivial, so that looks like a project
all by itself.

I don't quite follow the example of removing a host bridge while a
child PCI device refcount is non-zero.  That sounds like an invalid
scenario regardless of whether the resources are released by a
.release_fn() or by devm.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
