Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Thu, 14 Jun 2018 06:33:41 -0400
From: okaya@codeaurora.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: Requirement to get BAR pci_bus_address in user space
In-Reply-To: <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
 <20180614102001.GA20836@lst.de>
 <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
Message-ID: <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci-owner@vger.kernel.org, Abhishek Shah <abhishek.shah@broadcom.com>,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Vikram Prakash <vikram.prakash@broadcom.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-06-14 06:29, Srinath Mannam wrote:
> ++ Alex Williamson, kvm,
> 
> Hi Christoph,
> 
> Thank you for quick reply.
> 
> If we want to add this in vfio then I think we need to do the same in
> uio case also.
> 
> As I mentioned in previous mail, in the current implementation
> resource information (address and size) is gathering from resource
> named file created in /sys directory.
> So I expect it would be better to have similar method as existing in 
> sysfs.
> 

Can you give some info on why you need the actual bar address value?

> 
> Regards,
> Srinath.
> 
> On Thu, Jun 14, 2018 at 3:50 PM, Christoph Hellwig <hch@lst.de> wrote:
>> The only safe way to use PCI(e) devices in userspace is through vfio.
>> I think that is where you need to take your inquiries.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
