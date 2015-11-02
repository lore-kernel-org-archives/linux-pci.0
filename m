Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:51800 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbbKBIeA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2015 03:34:00 -0500
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 2 Nov 2015 14:03:57 +0530
Date: Mon, 2 Nov 2015 16:33:34 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: ethan zhao <ethan.zhao@oracle.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Duyck <aduyck@mirantis.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] PCI: Wait 1 second between disabling VFs and
 clearing NumVFs
Message-ID: <20151102083334.GC1120@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151029222322.11908.13738.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151030051458.GD5119@richards-mbp.cn.ibm.com>
 <56330771.90509@oracle.com>
 <5633935D.10807@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5633935D.10807@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 08:57:17AM -0700, Alexander Duyck wrote:
>On 10/29/2015 11:00 PM, ethan zhao wrote:
>>Wei,
>>
>>On 2015/10/30 13:14, Wei Yang wrote:
>>>On Thu, Oct 29, 2015 at 05:23:22PM -0500, Bjorn Helgaas wrote:
>>>>From: Alexander Duyck <aduyck@mirantis.com>
>>>>
>>>>Per sec 3.3.3.1 of the SR-IOV spec, r1.1, we must allow 1.0s after
>>>>clearing
>>>>VF Enable before reading any field in the SR-IOV Extended Capability.
>>>>
>>>>Wait 1 second before calling pci_iov_set_numvfs(), which reads
>>>>PCI_SRIOV_VF_OFFSET and PCI_SRIOV_VF_STRIDE after it sets
>>>>PCI_SRIOV_NUM_VF.
>>>>
>>>>[bhelgaas: split to separate patch for reviewability, add spec
>>>>reference]
>>>>Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>>>>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>---
>>>>drivers/pci/iov.c |    2 +-
>>>>1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>>index fada98d..24428d5 100644
>>>>--- a/drivers/pci/iov.c
>>>>+++ b/drivers/pci/iov.c
>>>>@@ -339,13 +339,13 @@ failed:
>>>>    iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>>>>    pci_cfg_access_lock(dev);
>>>>    pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>>>>-    pci_iov_set_numvfs(dev, 0);
>>>>    ssleep(1);
>>>>    pci_cfg_access_unlock(dev);
>>>>
>>>>    if (iov->link != dev->devfn)
>>>>        sysfs_remove_link(&dev->dev.kobj, "dep_link");
>>>>
>>>>+    pci_iov_set_numvfs(dev, 0);
>>>One small question, any specific reason put it here instead of just after
>>>sleep()?
>> Agree,  pci_iov_set_numvfs(dev, 0) should be put before
>>pci_cfg_access_unlock(dev) to avoid race,  because "NumVFs may only be
>>written while VF Enable is Clear"
>
>We are already guaranteeing that aren't we?  I'm assuming there is already
>code in place here somewhere that prevents us from both enabling and
>disabling SR-IOV from more than one thread.  Otherwise how could we hope to
>have any sort of consistent state?
>
>I'm fine with us being more explicit about it if we want to be, but if we are
>going to do it we should probably update all 3 spots where we update NumVFs
>after init instead of just this one.  Perhaps it should be a separate patch.
>

Yep, I think the statement is met, "NumVFs may only be written while VF Enable
is Clear".

While in your commit log, the purpose of this patch is to wait 1 second before
write NumVFs. So I am interesting to know why you move this out of the
pci_cfg_access_lock. Because it looks better? have better performance?

Actually, this is a question instead of a challenge :-)

>- Alex

-- 
Richard Yang
Help you, Help me

