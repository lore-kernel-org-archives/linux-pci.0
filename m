Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 28 Jun 2017 07:32:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Build failure in -next due to 'PCI: versatile: Convert PCI scan
 API to pci_scan_root_bus_bridge()'
Message-ID: <20170628123212.GP17844@bhelgaas-glaptop.roam.corp.google.com>
References: <113c3ec2-152d-de17-e05e-ade4fe76b7d8@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <113c3ec2-152d-de17-e05e-ade4fe76b7d8@roeck-us.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 27, 2017 at 07:30:38PM -0700, Guenter Roeck wrote:
> drivers/pci/host/pci-versatile.c: In function 'versatile_pci_probe':
> drivers/pci/host/pci-versatile.c:131:38: error: 'dev' undeclared
>   bridge = devm_pci_alloc_host_bridge(dev, 0);

We fixed this yesterday, but I haven't put it into -next yet (I wanted
the autobuilder to have a crack at it first):

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-versatile&id=7a530532567f059f87671cae798c5cd9f32865ed

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
