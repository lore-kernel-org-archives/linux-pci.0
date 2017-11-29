Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 29 Nov 2017 09:36:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V2 1/7] PCI: protect restore with device lock to be
 consistent
Message-ID: <20171129173621.GB27742@infradead.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
 <1511763628-11856-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1511763628-11856-2-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 open list <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 27, 2017 at 01:20:22AM -0500, Sinan Kaya wrote:
> Commit b014e96d1abb ("PCI: Protect pci_error_handlers->reset_notify() usage
> with device_lock()") added protection around pci_dev_restore() function so
> that device specific remove callback does not cause a race condition
> against hotplug.
> 
> pci_dev_lock() usage has been forgotten in two different places in the
> code. Adding locks for pci_slot_restore() and moving pci_dev_restore()
> inside the locks for pci_try_reset_function().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
