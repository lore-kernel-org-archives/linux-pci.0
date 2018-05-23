Return-Path: <SRS0=35VJ=IK=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=35VJ=IK=deltatee.com=logang@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Doug Meyer <dmeyer@gigaio.com>, kurt.schwemmer@microsemi.com,
 linux-pci@vger.kernel.org, linux-ntb <linux-ntb@googlegroups.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
 "Jiang, Dave" <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
 <20180517134521.GC19955@bhelgaas-glaptop.roam.corp.google.com>
 <9dd68ac0-5b9e-b257-49d2-20327c2ab282@deltatee.com>
 <CA+GK6en+g+T9H0sOMdVXv-_aD3rRcuzZ1JdfK0moEoTuuJnrqQ@mail.gmail.com>
 <20180522215126.GA22385@bhelgaas-glaptop.roam.corp.google.com>
 <598f5880-22b2-bbb4-4a37-5a60bae2348b@deltatee.com>
 <20180523133321.GA150632@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <55fd5f21-2e9c-19a9-117c-e368deaf939e@deltatee.com>
Date: Wed, 23 May 2018 14:21:59 -0600
MIME-Version: 1.0
In-Reply-To: <20180523133321.GA150632@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality
 with IOMMU On
List-ID: <linux-pci.vger.kernel.org>



On 23/05/18 07:33 AM, Bjorn Helgaas wrote:
> This (and Alex's) analysis is very useful and I'd like to capture it
> somehow, perhaps by expanding the poor pci_add_dma_alias() function
> comment I added with f0af9593372a ("PCI: Add pci_add_dma_alias() to
> abstract implementation").
> 
> The admonition to "call early" without any details about *how* early
> or *why* it needs to be called early is not really very useful.
> 
> If we added your analysis, it would be a great help to anybody who
> reworks IOMMU groups in the future.

Sure, I'll work up a patch and send it on shortly.

Logan
