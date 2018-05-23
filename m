Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI/portdrv: do not disable device on remove()
To: Lukas Wunner <lukas@wunner.de>
References: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
 <20180523022431.GA15069@wunner.de>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <8c91a923-1a3a-55fb-e812-62dd69d99975@codeaurora.org>
Date: Tue, 22 May 2018 22:40:16 -0400
MIME-Version: 1.0
In-Reply-To: <20180523022431.GA15069@wunner.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: ryan@finnie.org, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Frederick Lawler <fred@fredlawl.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 Keith Busch <keith.busch@intel.com>, Dongdong Liu <liudongdong3@huawei.com>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 5/22/2018 10:24 PM, Lukas Wunner wrote:
> On Tue, May 22, 2018 at 01:58:00PM -0400, Sinan Kaya wrote:
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -409,7 +409,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
>>  {
>>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>>  	pci_free_irq_vectors(dev);
>> -	pci_disable_device(dev);
>>  }
> 
> Shutdown aside, pci_disable_device() is also not called in the ->remove
> path with this patch, right?  Seems wrong.  E.g. when unbinding the driver
> from the root port device, or when unplugging a port (happens all the time
> with Thunderbolt).

Agreed. I'll spin another version where I skip disable on shutdown path only.

> 
> Thanks,
> 
> Lukas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
