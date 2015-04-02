Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:40672 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbbDBFtx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2015 01:49:53 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Fam Zheng <famz@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>
References: <1427641227-7574-1-git-send-email-mst@redhat.com>
	<1427641227-7574-3-git-send-email-mst@redhat.com>
	<20150402033827.GE15412@fam-t430.nay.redhat.com>
Date: Thu, 02 Apr 2015 00:45:53 -0500
In-Reply-To: <20150402033827.GE15412@fam-t430.nay.redhat.com> (Fam Zheng's
	message of "Thu, 2 Apr 2015 11:38:27 +0800")
Message-ID: <87lhibt75a.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v5 02/10] pci: move pci_msi_init_pci_dev to probe.c
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fam Zheng <famz@redhat.com> writes:

> On Sun, 03/29 17:04, Michael S. Tsirkin wrote:
>> commit d5dea7d95c48d7bc951cee4910a7fd9c0cd26fb0
>>     "PCI: msi: Disable msi interrupts when we initialize a pci device"
>> fixes kexec when the booting kernel does not enable msi interupts.
>> 
>> Unfortunately the relevant functionality is in msi.c so it isn't
>> compiled in when CONFIG_PCI_MSI is off, which means such configurations
>> would still get interrupt storms.
>> 
>> Fix by moving part of the functionality probe.c, and compiling it
>> unconditionally.
>
> Reviewed-by: Fam Zheng <famz@redhat.com>

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I am a little surprised that there are systems that compile out MSI
support, but I do remember the problem being a limitation of the code
when wrote it and given how nasty screaming irqs are during boot up
it seems well worth it to have a little extra code to turn them off.

Eric

>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  drivers/pci/msi.c   | 12 ------------
>>  drivers/pci/probe.c | 16 ++++++++++++++++
>>  2 files changed, 16 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 9942f68..f66be86 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -1041,18 +1041,6 @@ EXPORT_SYMBOL(pci_msi_enabled);
>>  void pci_msi_init_pci_dev(struct pci_dev *dev)
>>  {
>>  	INIT_LIST_HEAD(&dev->msi_list);
>> -
>> -	/* Disable the msi hardware to avoid screaming interrupts
>> -	 * during boot.  This is the power on reset default so
>> -	 * usually this should be a noop.
>> -	 */
>> -	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
>> -	if (dev->msi_cap)
>> -		pci_msi_set_enable(dev, 0);
>> -
>> -	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
>> -	if (dev->msix_cap)
>> -		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
>>  }
>>  
>>  /**
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 8d2f400..50dd934 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1483,10 +1483,26 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>>  	return dev;
>>  }
>>  
>> +static void pci_msi_setup_pci_dev(struct pci_dev *dev)
>> +{
>> +	/* Disable the msi hardware to avoid screaming interrupts
>> +	 * during boot.  This is the power on reset default so
>> +	 * usually this should be a noop.
>> +	 */
>> +	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
>> +	if (dev->msi_cap)
>> +		pci_msi_set_enable(dev, 0);
>> +
>> +	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
>> +	if (dev->msix_cap)
>> +		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
>> +}
>> +
>>  static void pci_init_capabilities(struct pci_dev *dev)
>>  {
>>  	/* MSI/MSI-X list */
>>  	pci_msi_init_pci_dev(dev);
>> +	pci_msi_setup_pci_dev(dev);
>>  
>>  	/* Buffers for saving PCIe and PCI-X capabilities */
>>  	pci_allocate_cap_save_buffers(dev);
>> -- 
>> MST
>> 
