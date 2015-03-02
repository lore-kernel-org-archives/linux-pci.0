Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:59776 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbCBGyJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2015 01:54:09 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 2 Mar 2015 16:54:06 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id C9EA93578048
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2015 17:54:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t226rtiF23396512
	for <linux-pci@vger.kernel.org>; Mon, 2 Mar 2015 17:54:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t226rTQh004126
	for <linux-pci@vger.kernel.org>; Mon, 2 Mar 2015 17:53:30 +1100
Date: Mon, 2 Mar 2015 14:53:13 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	gwshan@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v12 08/21] PCI: Add pcibios_sriov_enable() and
 pcibios_sriov_disable()
Message-ID: <20150302065313.GD21571@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083352.32124.63952.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083921.GF6220@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150224083921.GF6220@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 24, 2015 at 02:39:21AM -0600, Bjorn Helgaas wrote:
>On Tue, Feb 24, 2015 at 02:33:52AM -0600, Bjorn Helgaas wrote:
>> From: Wei Yang <weiyang@linux.vnet.ibm.com>
>> 
>> VFs are dynamically created when a driver enables them.  On some platforms,
>> like PowerNV, special resources are necessary to enable VFs.
>> 
>> Add platform hooks for enabling and disabling VFs.
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  drivers/pci/iov.c |   19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index 5643a1011e23..cc6fedf4a1b9 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -220,6 +220,11 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
>>  	pci_dev_put(dev);
>>  }
>>  
>> +int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 vf_num)
>
>I think this "vf_num" parameter should be renamed to something like
>"num_vfs" instead.  It's subtle, but "vf_num" suggests that we're talking
>about one of several VFs, e.g., VF1 or VF 2.  But here we really mean the
>total number of VFs that we're enabling.
>
>There's similar code in the powerpc implementation that should be
>renamed the same way.
>

Agree, would take this suggestion in consideration.

>> +{
>> +       return 0;
>> +}
>> +
>>  static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>  {
>>  	int rc;
>> @@ -231,6 +236,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>  	struct pci_sriov *iov = dev->sriov;
>>  	int bars = 0;
>>  	int bus;
>> +	int retval;
>>  
>>  	if (!nr_virtfn)
>>  		return 0;
>> @@ -307,6 +313,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>  	if (nr_virtfn < initial)
>>  		initial = nr_virtfn;
>>  
>> +	if ((retval = pcibios_sriov_enable(dev, initial))) {
>> +		dev_err(&dev->dev, "failure %d from pcibios_sriov_enable()\n",
>> +			retval);
>> +		return retval;
>> +	}
>> +
>>  	for (i = 0; i < initial; i++) {
>>  		rc = virtfn_add(dev, i, 0);
>>  		if (rc)
>> @@ -335,6 +347,11 @@ failed:
>>  	return rc;
>>  }
>>  
>> +int __weak pcibios_sriov_disable(struct pci_dev *pdev)
>> +{
>> +       return 0;
>> +}
>> +
>>  static void sriov_disable(struct pci_dev *dev)
>>  {
>>  	int i;
>> @@ -346,6 +363,8 @@ static void sriov_disable(struct pci_dev *dev)
>>  	for (i = 0; i < iov->num_VFs; i++)
>>  		virtfn_remove(dev, i, 0);
>>  
>> +	pcibios_sriov_disable(dev);
>> +
>>  	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>>  	pci_cfg_access_lock(dev);
>>  	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>> 
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me

