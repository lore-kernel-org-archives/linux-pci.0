Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:38942 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbFCBjr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2015 21:39:47 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 3 Jun 2015 11:39:45 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8B90C2BB0040
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2015 11:39:42 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t531dYiX48103460
	for <linux-pci@vger.kernel.org>; Wed, 3 Jun 2015 11:39:42 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t531d9IV023810
	for <linux-pci@vger.kernel.org>; Wed, 3 Jun 2015 11:39:10 +1000
Date: Wed, 3 Jun 2015 09:38:52 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 01/10] PCI/IOV: Rename and export
 virtfn_add/virtfn_remove
Message-ID: <20150603013852.GB7387@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150602171907.GI3631@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150602171907.GI3631@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 02, 2015 at 12:19:07PM -0500, Bjorn Helgaas wrote:
>On Tue, May 19, 2015 at 06:50:03PM +0800, Wei Yang wrote:
>> During EEH recovery, hotplug is applied to the devices which don't
>> have drivers or their drivers don't support EEH. However, the hotplug,
>> which was implemented based on PCI bus, can't be applied to VF directly.
>> 
>> The patch renames virtn_{add,remove}() and exports them so that they
>> can be used in PCI hotplug during EEH recovery.
>> 
>> [gwshan: changelog]
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
>I assume you'll merge this along with the rest of this series via the
>powerpc tree.
>

Thanks, I think so.

>> ---
>>  drivers/pci/iov.c   |   10 +++++-----
>>  include/linux/pci.h |    8 ++++++++
>>  2 files changed, 13 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index ee0ebff..cc941dd 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -108,7 +108,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
>>  	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
>>  }
>>  
>> -static int virtfn_add(struct pci_dev *dev, int id, int reset)
>> +int pci_iov_virtfn_add(struct pci_dev *dev, int id, int reset)
>>  {
>>  	int i;
>>  	int rc = -ENOMEM;
>> @@ -183,7 +183,7 @@ failed:
>>  	return rc;
>>  }
>>  
>> -static void virtfn_remove(struct pci_dev *dev, int id, int reset)
>> +void pci_iov_virtfn_remove(struct pci_dev *dev, int id, int reset)
>>  {
>>  	char buf[VIRTFN_ID_LEN];
>>  	struct pci_dev *virtfn;
>> @@ -320,7 +320,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>  	}
>>  
>>  	for (i = 0; i < initial; i++) {
>> -		rc = virtfn_add(dev, i, 0);
>> +		rc = pci_iov_virtfn_add(dev, i, 0);
>>  		if (rc)
>>  			goto failed;
>>  	}
>> @@ -332,7 +332,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>  
>>  failed:
>>  	for (j = 0; j < i; j++)
>> -		virtfn_remove(dev, j, 0);
>> +		pci_iov_virtfn_remove(dev, j, 0);
>>  
>>  	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>>  	pci_cfg_access_lock(dev);
>> @@ -361,7 +361,7 @@ static void sriov_disable(struct pci_dev *dev)
>>  		return;
>>  
>>  	for (i = 0; i < iov->num_VFs; i++)
>> -		virtfn_remove(dev, i, 0);
>> +		pci_iov_virtfn_remove(dev, i, 0);
>>  
>>  	pcibios_sriov_disable(dev);
>>  
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 353db8d..06aa5dd 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1679,6 +1679,8 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
>>  
>>  int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
>>  void pci_disable_sriov(struct pci_dev *dev);
>> +int pci_iov_virtfn_add(struct pci_dev *dev, int id, int reset);
>> +void pci_iov_virtfn_remove(struct pci_dev *dev, int id, int reset);
>>  int pci_num_vf(struct pci_dev *dev);
>>  int pci_vfs_assigned(struct pci_dev *dev);
>>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>> @@ -1696,6 +1698,12 @@ static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
>>  static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
>>  { return -ENODEV; }
>>  static inline void pci_disable_sriov(struct pci_dev *dev) { }
>> +static inline int pci_iov_virtfn_add(struct pci_dev *dev, int id, int reset)
>> +{
>> +	return -ENOSYS;
>> +}
>> +static inline void pci_iov_virtfn_remove(struct pci_dev *dev, int id, int reset)
>> +{ }
>>  static inline int pci_num_vf(struct pci_dev *dev) { return 0; }
>>  static inline int pci_vfs_assigned(struct pci_dev *dev)
>>  { return 0; }
>> -- 
>> 1.7.9.5
>> 

-- 
Richard Yang
Help you, Help me

