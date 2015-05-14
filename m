Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:46284 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbbENMbB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2015 08:31:01 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 14 May 2015 18:00:59 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9946A3940048
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2015 18:00:55 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4ECUsXB64356432
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2015 18:00:54 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4ECUrTp005490
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2015 18:00:53 +0530
Date: Thu, 14 May 2015 22:30:49 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V3 9/9] powerpc/eeh: handle VF PE properly
Message-ID: <20150514123048.GB12847@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-10-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150513011630.GA8973@gwshan>
 <20150514100250.GB12847@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150514100250.GB12847@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 14, 2015 at 06:02:50PM +0800, Wei Yang wrote:
>On Wed, May 13, 2015 at 11:16:30AM +1000, Gavin Shan wrote:
>>> 	 * Actually, we should remove the PCI bridges as well.
>>>@@ -416,7 +450,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
>>> 	driver = eeh_pcid_get(dev);
>>> 	if (driver) {
>>> 		eeh_pcid_put(dev);
>>>-		if (driver->err_handler)
>>>+		if (removed && driver->err_handler)
>>> 			return NULL;
>>> 	}
>>>
>>>@@ -425,11 +459,21 @@ static void *eeh_rmv_device(void *data, void *userdata)
>>> 		 pci_name(dev));
>>> 	edev->bus = dev->bus;
>>> 	edev->mode |= EEH_DEV_DISCONNECTED;
>>>-	(*removed)++;
>>>-
>>>-	pci_lock_rescan_remove();
>>>-	pci_stop_and_remove_bus_device(dev);
>>>-	pci_unlock_rescan_remove();
>>>+	if (removed)
>>>+		(*removed)++;
>>>+
>>>+#ifdef CONFIG_PCI_IOV
>>>+	if (edev->mode & EEH_DEV_VF) {
>>>+		pci_iov_virtfn_remove(edev->physfn, pdn->vf_index, 0);
>>>+		edev->pdev = NULL;
>>>+		pdn->pe_number = IODA_INVALID_PE;
>>
>>Setting the PE number to invalid one seems not correct because the PE
>>is still consumed by the VF's RID.
>>
>
>In commit 781a868f3136, we introduce the check of pdn->pe_number in
>pnv_pci_dma_dev_setup(). Since VFs are create/released dynamically, we need to
>delay the bind between PE and the device. Then to avoid rebind it, we check
>the pdn->pe_number. The WARN_ON() is what you suggested.
>
>So if don't clear the pe_number here, we break that rule.
>

Ok. You choose one of the following two options:

- Remove WARN_ON() in pnv_pci_dma_dev_setup(). Actually, I don't think
  it's quite correct to update PE# to VF's pdn at this function. Instead,
  it would have been done at the SRIOV enablement backend. But it's not
  related to this patchset. You may improve it later.
- Keep the code you had: set the PE# to invalid one, and put some comments
  here as below.

  /*
   * We have to set the VF PE number to invalid one, which is required
   * to plug the VF successfully.
   */

Thanks,
Gavin
 

