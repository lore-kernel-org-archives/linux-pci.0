Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:34577 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbbKCCSU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2015 21:18:20 -0500
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 3 Nov 2015 07:48:18 +0530
Date: Tue, 3 Nov 2015 10:18:13 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Duyck <aduyck@mirantis.com>,
	linux-pci@vger.kernel.org, Ethan Zhao <ethan.zhao@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] PCI: Set NumVFs before computing how many buses
 VFs require
Message-ID: <20151103021813.GC1763@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151029222336.11908.66193.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151030052249.GF5119@richards-mbp.cn.ibm.com>
 <563394EA.7050603@gmail.com>
 <20151102082721.GB1120@richards-mbp.cn.ibm.com>
 <563783C4.4000204@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <563783C4.4000204@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 02, 2015 at 07:39:48AM -0800, Alexander Duyck wrote:
>On 11/02/2015 12:27 AM, Wei Yang wrote:
>>On Fri, Oct 30, 2015 at 09:03:54AM -0700, Alexander Duyck wrote:
>>>On 10/29/2015 10:22 PM, Wei Yang wrote:
>>>>On Thu, Oct 29, 2015 at 05:23:36PM -0500, Bjorn Helgaas wrote:
>>>>>From: Alexander Duyck <aduyck@mirantis.com>
>>>>>
>>>>>VF bus numbers depend on the First VF Offset and VF Stride, and per
>>>>>sections 3.3.9 and 3.3.10 of the SR-IOV spec r1.1, these depend on the
>>>>>NumVF value.
>>>>>
>>>>>Wait until after we set NumVFs to compute and validate the bus number of
>>>>>the last VF.
>>>>>
>>>>>[bhelgaas: changelog, add spec reference, split to separate patch for
>>>>>reviewability]
>>>>>Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>>>>>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>>---
>>>>>drivers/pci/iov.c |   18 ++++++++++--------
>>>>>1 file changed, 10 insertions(+), 8 deletions(-)
>>>>>
>>>>>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>>>index bd1c4fa..9d29712 100644
>>>>>--- a/drivers/pci/iov.c
>>>>>+++ b/drivers/pci/iov.c
>>>>>@@ -274,13 +274,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>>>>		return -ENOMEM;
>>>>>	}
>>>>>
>>>>>-	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
>>>>>-	if (bus > dev->bus->busn_res.end) {
>>>>>-		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
>>>>>-			nr_virtfn, bus, &dev->bus->busn_res);
>>>>>-		return -ENOMEM;
>>>>>-	}
>>>>>-
>>>>>	if (pci_enable_resources(dev, bars)) {
>>>>>		dev_err(&dev->dev, "SR-IOV: IOV BARS not allocated\n");
>>>>>		return -ENOMEM;
>>>>>@@ -304,6 +297,15 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>>>>	}
>>>>>
>>>>>	pci_iov_set_numvfs(dev, nr_virtfn);
>>>>How about move it up?
>>>
>>>The idea with moving the write down is to keep the pollution of the SR-IOV
>>>capability to a minimum.  Basically we have addressed all of the possible
>>>software issues at this point so all that remains is possible hardware
>>>complications.  In addition by moving this code down we only have to modify
>>>this code instead of adding "rc=X; goto foo;" in places where "return X;" was
>>>used.
>>>
>>
>>I think your logic is clear, while it is not easy to classify the software
>>issue and hardware complications. For example, at the beginning of
>>sriov_enable(), the hardware value initial VFs number is checked.
>>
>>And in my mind, this is reasonable to check the hardware issue before software
>>issue.
>>
>>For your comment, adding "rc=X; goto foo;", I don't see this would happen.
>>The code in my mind would like this:
>>
>>
>>+	pci_iov_set_numvfs(dev, nr_virtfn);
>>  	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
>>  	if (bus > dev->bus->busn_res.end) {
>>  		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
>>  			nr_virtfn, bus, &dev->bus->busn_res);
>>  		return -ENOMEM;
>>  	}
>>
>>	if (pci_enable_resources(dev, bars)) {
>>		dev_err(&dev->dev, "SR-IOV: IOV BARS not allocated\n");
>>		return -ENOMEM;
>>
>>Do I missed something?
>
>The problem is that pci_iov_set_numvfs has side effects visible to the user
>since they can read NumVFs lspci and via sysfs.  As such we want to keep the
>two in sync, and if you get the bus error here that is not the case.
>
>That is why you must call pci_iov_set_numvfs(dev, 0) if this fails.
>

That's the reason. Thanks for letting me know :-)

>- Alex

-- 
Richard Yang
Help you, Help me

