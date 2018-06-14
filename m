Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 14 Jun 2018 08:42:03 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: Requirement to get BAR pci_bus_address in user space
Message-ID: <20180614144203.GA8129@localhost.localdomain>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
 <20180614102001.GA20836@lst.de>
 <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
 <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
 <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Abhishek Shah <abhishek.shah@broadcom.com>, Sinan Kaya <okaya@codeaurora.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Vikram Prakash <vikram.prakash@broadcom.com>, Christoph Hellwig <hch@lst.de>,
 linux-pci-owner@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 14, 2018 at 04:18:15PM +0530, Srinath Mannam wrote:
> The issue is, For CMB cards SQs are allocated inside device BAR memory
> which is different from normal cards.
> In Normal cards SQ memory allocated at host side.
> In both the cases physical address of CQ memory is programmed in NVMe
> controller register.
> This method works for normal cards because CQ memory is at host side.
> But in CMB cards pci bus address equivalent to CQ memory needs to program.

How do you know if the address that you can see is even the real bus
address? You could be running against a direct assigned device in a
guest where you don't get to see the actual bus address.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
