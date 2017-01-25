Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 31/37] misc: Add host side pci driver for pci test
 function device
To: Christoph Hellwig <hch@infradead.org>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-32-git-send-email-kishon@ti.com>
 <20170124160224.GA23528@infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58883A65.8020306@ti.com>
Date: Wed, 25 Jan 2017 11:10:53 +0530
MIME-Version: 1.0
In-Reply-To: <20170124160224.GA23528@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
 Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
 nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 24 January 2017 09:32 PM, Christoph Hellwig wrote:
> On Thu, Jan 12, 2017 at 03:56:20PM +0530, Kishon Vijay Abraham I wrote:
>> Add PCI endpoint test driver that can verify base address
>> register, legacy interrupt/MSI interrupt and read/write/copy
>> buffers between host and device. The corresponding pci-epf-test
>> function driver should be used on the EP side.
> 
> Just curious:  what would you think of a text based (e.g. debugfs)
> interface to avoid the need for a userspace tool here?

I felt having a userspace tool gives the flexibility to add more tests
(iterations, sizes etc..) while the driver can just focus on performing simple
tests. Say we'd like to perform infinite read/write tests, it's better if the
userspace tool invokes read/write tests repeatedly instead of that being
implemented in the driver.
> 
>> +static const struct pci_device_id pci_endpoint_test_tbl[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_ANY_ID) },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
> 
> Also this looks really odd, and dangerous.  Probing for any
> TI device will bind to all kinds of legit devices.  It would
> be good if you could squeeze out a single id for this device

There is actually an id for the device, but I think we'll need an id for every
function right?

Having said that the id for the device is better than PCI_ANY_ID. Will fix it
in my next revision.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
