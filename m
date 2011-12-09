Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:43719 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab1LIKEg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Dec 2011 05:04:36 -0500
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Fri, 9 Dec 2011 05:04:35 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pB9A4XZ5262182
	for <linux-pci@vger.kernel.org>; Fri, 9 Dec 2011 05:04:33 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pB9A4W0J007243
	for <linux-pci@vger.kernel.org>; Fri, 9 Dec 2011 03:04:32 -0700
Date: Fri, 9 Dec 2011 18:04:28 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>, Yinghai Lu <yinghai@kernel.org>,
	Don Dutile <ddutile@redhat.com>, linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com
Subject: [PATCH 1/1 v2]PCI: defer enablement of SRIOV BARS
Message-ID: <20111209100428.GB3763@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20111102140325.004b9dad@jbarnes-desktop>
 <20111103013014.GB393@ram-ThinkPad-T61>
 <20111106023310.GA2383@ram-ThinkPad-T61>
 <20111205103202.29faf6e1@jbarnes-desktop>
 <CAE9FiQXx_nkOFP2S=hXKyjcFHh4R4f5c+J-aCiDoYS=3Tgdmqw@mail.gmail.com>
 <20111207092531.GF19129@ram-ThinkPad-T61>
 <4EDFCB4A.60106@redhat.com>
 <CAE9FiQXOhn2HkqCh3DiSNUw7RwgAAk2Xe62z11AB=L+pcG__Qg@mail.gmail.com>
 <20111208025039.GH19129@ram-ThinkPad-T61>
 <20111208055355.19c346a8@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20111208055355.19c346a8@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

    	PCI: defer enablement of SRIOV BARS

    All the PCI BARs of a device are enabled when the device is enabled using
    pci_enable_device().  This unnecessarily enables SRIOV BARs of the device.

    On some platforms, which do not support SRIOV; as yet, the pci_enable_device()
    fails to enable the device if its SRIOV BARs are not allocated resources
    correctly.

    The following patch fixes the above problem. The SRIOV BARs are now enabled
    when IOV capability of the device is enabled in sriov_enable().

    NOTE: Note, there is subtle change in the pci_enable_device() API.  Any driver
    that depends on SRIOV BARS to be enabled in pci_enable_device() can fail.

    Changelog v2: Fixed a bug reported by Yinghai.The bug lead to ROM and
	BRIDGE BARs getting disabled.  Thanks for code snippets from Yinghai
	and Don Dutile.

   Signed-off-by: Ram Pai <linuxram@us.ibm.com

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9b4e88c..b0446dd 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -282,6 +282,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	struct resource *res;
 	struct pci_dev *pdev;
 	struct pci_sriov *iov = dev->sriov;
+	int bars = 0;
 
 	if (!nr_virtfn)
 		return 0;
@@ -306,6 +307,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		bars |= (1 << (i + PCI_IOV_RESOURCES));
 		res = dev->resource + PCI_IOV_RESOURCES + i;
 		if (res->parent)
 			nres++;
@@ -323,6 +325,11 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		return -ENOMEM;
 	}
 
+	if (pci_enable_resources(dev, bars)) {
+		dev_err(&dev->dev, "SR-IOV: IOV BARS not allocated\n");
+		return -ENOMEM;
+	}
+
 	if (iov->link != dev->devfn) {
 		pdev = pci_get_slot(dev->bus, iov->link);
 		if (!pdev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6f45a73..b548bec 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1126,9 +1126,14 @@ static int __pci_enable_device_flags(struct pci_dev *dev,
 	if (atomic_add_return(1, &dev->enable_cnt) > 1)
 		return 0;		/* already enabled */
 
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+#ifdef CONFIG_PCI_IOV
+		if ((i >=  PCI_IOV_RESOURCES) && (i <= PCI_IOV_RESOURCE_END))
+			continue; /* skip sriov related resources */
+#endif
 		if (dev->resource[i].flags & flags)
 			bars |= (1 << i);
+	}
 
 	err = do_pci_enable_device(dev, bars);
 	if (err < 0)

