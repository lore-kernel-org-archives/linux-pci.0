Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:39764 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbaKYXEG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Nov 2014 18:04:06 -0500
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 26 Nov 2014 04:34:03 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 627763940024
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2014 04:34:01 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAPN4FYg66126024
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2014 04:34:15 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAPN40gY016344
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2014 04:34:01 +0530
Date: Wed, 26 Nov 2014 10:03:59 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Refresh offset/stride after NumVFs is written
Message-ID: <20141125230359.GA11309@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1416624759-13543-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141124230108.GA8765@shangw>
 <20141125031455.GA9070@richard>
 <20141125034651.GA5646@shangw>
 <20141125091114.GA314@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141125091114.GA314@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 25, 2014 at 05:11:14PM +0800, Wei Yang wrote:
>On Tue, Nov 25, 2014 at 02:46:52PM +1100, Gavin Shan wrote:
>>On Tue, Nov 25, 2014 at 11:14:55AM +0800, Wei Yang wrote:
>>>On Tue, Nov 25, 2014 at 10:01:08AM +1100, Gavin Shan wrote:
>>>>On Sat, Nov 22, 2014 at 10:52:39AM +0800, Wei Yang wrote:
>>>>>According to SR-IOV spec sec 3.3.9, 3.3.10, the NumVFs setting change will
>>>>>affect the offset and stride. Current implementation doesn't refresh the
>>>>>offset/stride cached in pci_sriov structure.
>>>>>
>>>>>This patch introduces a wrapper pci_iov_set_numvfs(), which refresh these two
>>>>>value after NumVFs is written.
>>>>>
>>>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>>>---
>>>>> drivers/pci/iov.c |   17 +++++++++++++----
>>>>> 1 file changed, 13 insertions(+), 4 deletions(-)
>>>>>
>>>>>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>>>index 4d109c0..c7010c5 100644
>>>>>--- a/drivers/pci/iov.c
>>>>>+++ b/drivers/pci/iov.c
>>>>>@@ -31,6 +31,15 @@ static inline u8 virtfn_devfn(struct pci_dev *dev, int id)
>>>>> 		dev->sriov->stride * id) & 0xff;
>>>>> }
>>>>>
>>>>>+static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
>>>>>+{
>>>>>+	struct pci_sriov *iov = dev->sriov;
>>>>>+
>>>>>+	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn);
>>>>
>>>>I'm suspecting writing to PCI_SRIOV_NUM_VF would take some time to take
>>>>effect.
>>>>
>>>>>+	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_OFFSET, &iov->offset);
>>>>>+	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &iov->stride);
>>>>>+}
>>>>>+
>>>>> static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
>>>>> {
>>>>> 	struct pci_bus *child;
>>>>>@@ -243,7 +252,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>>>> 			return rc;
>>>>> 	}
>>>>>
>>>>>-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn);
>>>>>+	pci_iov_set_numvfs(dev, nr_virtfn);
>>>>> 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
>>>>> 	pci_cfg_access_lock(dev);
>>>>> 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>>>>>@@ -272,7 +281,7 @@ failed:
>>>>> 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>>>>> 	pci_cfg_access_lock(dev);
>>>>> 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>>>>>-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, 0);
>>>>>+	pci_iov_set_numvfs(dev, 0);
>>>>> 	ssleep(1);
>>>>
>>>>The 1 second delay here might be for waiting VFs to be ready.
>>>>
>>>
>>>Hmm... so add this ssleep() in pci_iov_set_numvfs() would be better?
>>>
>>
>>I was not suggesting to do that. I just raised the concern for you
>>to look into.
>>
>
>I looked in the SPEC sec 3.3.3.1 VF Enable. In this section, it says this:
>
>To allow components to perform internal initialization, system software must wait for at least
>100 ms after changing the VF Enable bit from a 0 to a 1, before it is permitted to issue Requests to
>the VFs which are enabled by that VF Enable bit. The Root Complex and/or system software must
>allow at least 1.0 s after Setting the VF Enable bit, before it may determine that a VF which fails to
>return a Successful Completion status for a valid Configuration Request is broken. After Setting the
>VF Enable bit, the VFs enabled by that VF Enable bit are permitted to return a CRS status to
>configuration requests up to the 1.0 s limit, if they are not ready to provide a Successful Completion
>status for a valid Configuration Request. Additionally, a VF is not permitted to return CRS after
>having previously returned a Successful Completion without an intervening VF disable or other valid
>reset condition.
>
>As my understanding, it will take 1ms or 1s after VF Enable bit is set.
>Actually I am confused with the two different time, in which case we needs to
>wait for different time? And some place we add a lock, but no lock in others.
>

Are you talking about 1ms or 100ms? I assume it's 100ms. If I
understand things correctly, 100ms delay before issuing config
read request, CRS can be returned before it reaches the timeout
(1 second).

>While from the SPEC, I don't see some description the NumVFs field will take
>some time to be effective.
>

If I'm correct, we can't change NumVFs without disabling/reanbling VFs.

Thanks,
Gavin

