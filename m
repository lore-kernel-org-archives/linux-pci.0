Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 12 Oct 2016 11:00:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] PCI: aardvark: Cleanup
Message-ID: <20161012160021.GA4308@localhost>
References: <20161012123001.22186.4053.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20161012123001.22186.4053.stgit@bhelgaas-glaptop2.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 07:36:21AM -0500, Bjorn Helgaas wrote:
> Add local "dev" pointers to reduce repetition of things like "&pdev->dev"
> and remove unused drvdata.
> 
> Changes from v1:
>   I dropped the following because they added a lot of churn for
>   questionable benefit:
>     PCI: aardvark: Name private struct pointer "advk" consistently
>     PCI: aardvark: Reorder accessor functions
>     PCI: aardvark: Swap order of advk_write() reg/val arguments
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: aardvark: Add local struct device pointers
>       PCI: aardvark: Remove unused platform data

I applied these to pci/host-aardvark for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
