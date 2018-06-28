Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V3 5/6] PCI: Rename pci_try_reset_bus() to pci_reset_bus()
To: linux-pci@vger.kernel.org
References: <1530210507-9287-1-git-send-email-okaya@codeaurora.org>
 <1530210507-9287-5-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <006d7041-6d5c-af10-6252-005978bdc203@codeaurora.org>
Date: Thu, 28 Jun 2018 15:17:45 -0400
MIME-Version: 1.0
In-Reply-To: <1530210507-9287-5-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
 "open list:VFIO DRIVER" <kvm@vger.kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arm-msm@vger.kernel.org,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 open list <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Doug Ledford <dledford@redhat.com>, Zhenyu Wang <zhenyuw@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 6/28/2018 2:28 PM, Sinan Kaya wrote:
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -905,7 +905,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
>  	 * delay after a reset is required.  Per spec requirements,
>  	 * the link is either working or not after that point.
>  	 */
> -	return pci_try_reset_bus(dev->bus);
> +	return pci_reset_bus(dev->bus);
>  }
>  

This should have been 

return pci_reset_bus(dev);

I'll wait until I hear more feedback.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
