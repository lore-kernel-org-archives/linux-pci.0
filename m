Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 25 May 2018 17:10:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V2] PCI/portdrv: do not disable device on reboot/shutdown
Message-ID: <20180525221024.GC92995@bhelgaas-glaptop.roam.corp.google.com>
References: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
 <20180523213249.GD150632@bhelgaas-glaptop.roam.corp.google.com>
 <61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org>
 <20180524183502.GB85822@bhelgaas-glaptop.roam.corp.google.com>
 <984b9734-244d-04e9-946f-7524f148ff7c@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <984b9734-244d-04e9-946f-7524f148ff7c@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: ryan@finnie.org, Kate Stewart <kstewart@linuxfoundation.org>,
 linux-scsi@vger.kernel.org, Frederick Lawler <fred@fredlawl.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 esc.storagedev@microsemi.com, open list <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Don Brace <don.brace@microsemi.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 25, 2018 at 09:30:59AM -0400, Sinan Kaya wrote:
> On 5/24/2018 2:35 PM, Bjorn Helgaas wrote:
> > That sounds like a reasonable idea, and it is definitely another can
> > of worms.  I looked briefly at some of the .shutdown() cases:
> 
> should we throw it into 4.18 and see what happens?

It wouldn't solve this particular problem because hpsa *does* have a
.shutdown() method.  The problem is that it doesn't work -- it's
supposed to stop DMA and interrupts but it apparently doesn't.

I think we need to fix hpsa first.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
