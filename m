Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 16 Jan 2017 07:51:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 16/37] PCI: endpoint: Introduce configfs entry for
 configuring EP functions
Message-ID: <20170116155110.GA13495@infradead.org>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-17-git-send-email-kishon@ti.com>
 <20170113180602.GA30346@infradead.org> <587C61B3.3070107@ti.com>
MIME-Version: 1.0
In-Reply-To: <587C61B3.3070107@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 Christoph Hellwig <hch@infradead.org>, linux-samsung-soc@vger.kernel.org,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 16, 2017 at 11:31:23AM +0530, Kishon Vijay Abraham I wrote:
> Actually not all devices have hardcoded headers. E.g the platform I'm using
> doesn't have hardcoded headers and it can be configured based on the function
> the user would like to use. If the devices are hardcoded, then using configfs
> can be skipped altogether. In such cases, APIs like pci_epf_create() can
> directly be used by the drivers instead of going via configfs.

That's exactly what I meant - the IDs need to be set by the driver for
the implemented PCI device, and it's not up to the gadget core to configur
e them, it's up to the implementation of the PCIe device which PCI it
exposes.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
