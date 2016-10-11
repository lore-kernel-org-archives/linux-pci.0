Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58331 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751098AbcJKFdT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2016 01:33:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9B5TJhm042037
        for <linux-pci@vger.kernel.org>; Tue, 11 Oct 2016 01:33:18 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
        by mx0b-001b2d01.pphosted.com with ESMTP id 260s28j8v0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 11 Oct 2016 01:33:17 -0400
Received: from localhost
        by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Tue, 11 Oct 2016 15:33:15 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
        by d23dlp02.au.ibm.com (Postfix) with ESMTP id 29FF32BB0057
        for <linux-pci@vger.kernel.org>; Tue, 11 Oct 2016 16:33:12 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u9B5XC9f10289362
        for <linux-pci@vger.kernel.org>; Tue, 11 Oct 2016 16:33:12 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u9B5XBDl006553
        for <linux-pci@vger.kernel.org>; Tue, 11 Oct 2016 16:33:11 +1100
Date: Tue, 11 Oct 2016 16:33:53 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        bhelgaas@google.com, benh@au1.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, clsoto@us.ibm.com
Subject: Re: [PATCH v2 1/2] pci: Call pcibios_sriov_enable() before IOV BARs
 are enabled
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1475192870-7763-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475192870-7763-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <20161011053353.GA5123@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 30, 2016 at 09:47:49AM +1000, Gavin Shan wrote:
>In current implementation, pcibios_sriov_enable() is used by PPC
>PowerNV platform only. In PowerNV specific pcibios_sriov_enable(),
>PF's IOV BARs might be updated (shifted) by pci_update_resource().
>It means the IOV BARs aren't ready for decoding incoming memory
>address until pcibios_sriov_enable() returns.
>
>This calls pcibios_sriov_enable() earlier before the IOV BARs are
>enabled. As the result, the IOV BARs have been configured correctly
>when they are enabled.
>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Tested-by: Carol Soto <clsoto@us.ibm.com>

Bjorn, is there any chance to put those two patches to 4.9? :)

Thanks,
Gavin

>---
> drivers/pci/iov.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index 2194b44..f1343f0 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -303,13 +303,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> 			return rc;
> 	}
>
>-	pci_iov_set_numvfs(dev, nr_virtfn);
>-	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
>-	pci_cfg_access_lock(dev);
>-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>-	msleep(100);
>-	pci_cfg_access_unlock(dev);
>-
> 	iov->initial_VFs = initial;
> 	if (nr_virtfn < initial)
> 		initial = nr_virtfn;
>@@ -320,6 +313,13 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> 		goto err_pcibios;
> 	}
>
>+	pci_iov_set_numvfs(dev, nr_virtfn);
>+	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
>+	pci_cfg_access_lock(dev);
>+	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>+	msleep(100);
>+	pci_cfg_access_unlock(dev);
>+
> 	for (i = 0; i < initial; i++) {
> 		rc = pci_iov_add_virtfn(dev, i, 0);
> 		if (rc)
>-- 
>2.1.0
>

