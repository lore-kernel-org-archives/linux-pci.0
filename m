Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752561AbcK2E4d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2016 23:56:33 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAT4s62r106465
        for <linux-pci@vger.kernel.org>; Mon, 28 Nov 2016 23:56:33 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
        by mx0b-001b2d01.pphosted.com with ESMTP id 271158h8jd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Mon, 28 Nov 2016 23:56:32 -0500
Received: from localhost
        by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Tue, 29 Nov 2016 14:56:30 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
        by d23dlp01.au.ibm.com (Postfix) with ESMTP id 867382CE8056
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2016 15:56:27 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id uAT4uRxH50135220
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2016 15:56:27 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id uAT4uQGT025561
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2016 15:56:27 +1100
Date: Tue, 29 Nov 2016 15:57:47 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, clsoto@us.ibm.com,
        benh@kernel.crashing.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v4 4/7] PCI: Don't update VF BARs while VF memory space
 is enabled
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129041521.21453.33146.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161129041521.21453.33146.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20161129045747.GA22347@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 28, 2016 at 10:15:21PM -0600, Bjorn Helgaas wrote:
>If we update a VF BAR while it's enabled, there are two potential problems:
>
>  1) Any driver that's using the VF has a cached BAR value that is stale
>     after the update, and
>
>  2) We can't update 64-bit BARs atomically, so the intermediate state
>     (new lower dword with old upper dword) may conflict with another
>     device, and an access by a driver unrelated to the VF may cause a bus
>     error.
>
>Warn about attempts to update VF BARs while they are enabled.  This is a
>programming error, so use dev_WARN() to get a backtrace.
>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> drivers/pci/iov.c |    8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index d00ed5c..a800ba2 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -584,6 +584,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno)
> 	struct resource *res = dev->resource + resno;
> 	int vf_bar = resno - PCI_IOV_RESOURCES;
> 	struct pci_bus_region region;
>+	u16 cmd;
> 	u32 new;
> 	int reg;
>
>@@ -595,6 +596,13 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno)
> 	if (!iov)
> 		return;
>
>+	pci_read_config_word(dev, iov->pos + PCI_SRIOV_CTRL, &cmd);
>+	if ((cmd & PCI_SRIOV_CTRL_VFE) && (cmd & PCI_SRIOV_CTRL_MSE)) {
>+		dev_WARN(&dev->dev, "can't update enabled VF BAR%d %pR\n",
>+			 vf_bar, res);
>+		return;
>+	}
>+
> 	/*
> 	 * Ignore unimplemented BARs, unused resource slots for 64-bit
> 	 * BARs, and non-movable resources, e.g., those described via
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

