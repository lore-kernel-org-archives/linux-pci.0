Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V4 4/7] PCI: Unify try slot and bus reset API
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
 <1530214274-21139-4-git-send-email-okaya@codeaurora.org>
 <CAHp75VcYbeRTiggEiQnEV6DKR=F47RxNR0FZ+E-XKPpq8VNpqw@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9674e845-765c-cc16-654e-21036038f2d5@codeaurora.org>
Date: Mon, 2 Jul 2018 16:40:10 -0400
MIME-Version: 1.0
In-Reply-To: <CAHp75VcYbeRTiggEiQnEV6DKR=F47RxNR0FZ+E-XKPpq8VNpqw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
 "open list:VFIO DRIVER" <kvm@vger.kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-pci@vger.kernel.org,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 open list <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Doug Ledford <dledford@redhat.com>, Zhenyu Wang <zhenyuw@linux.intel.com>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 6/29/2018 5:43 PM, Andy Shevchenko wrote:
>> +int pci_try_reset_bus(struct pci_dev *pdev)
>> +{
>> +       bool slot = false;
>> +
>> +       if (!pci_probe_reset_slot(pdev->slot))
>> +               slot = true;
>> +
>> +       return slot ? __pci_try_reset_slot(pdev->slot) :
>> +                       __pci_try_reset_bus(pdev->bus);
> This can be as simple as
> 
>   return pci_probe_reset_slot(pdev->slot) ?
>     __pci_try_reset_bus(pdev->slot) : __pci_try_reset_slot(pdev->bus);
> 
> 

done

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
