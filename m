Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:59903 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab2D0GRh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2012 02:17:37 -0400
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 277473EE0C3
	for <linux-pci@vger.kernel.org>; Fri, 27 Apr 2012 15:17:36 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0364145DEBA
	for <linux-pci@vger.kernel.org>; Fri, 27 Apr 2012 15:17:36 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id C88A645DEB8
	for <linux-pci@vger.kernel.org>; Fri, 27 Apr 2012 15:17:35 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A9278E08002
	for <linux-pci@vger.kernel.org>; Fri, 27 Apr 2012 15:17:35 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com [10.240.81.136])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2C1CC1DB803E
	for <linux-pci@vger.kernel.org>; Fri, 27 Apr 2012 15:17:35 +0900 (JST)
Date: Fri, 27 Apr 2012 15:17:26 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Keping Chen <chenkeping@huawei.com>, ddutile@redhat.com,
	greg.pearson@hp.com
Subject: Re: [PATCH 6/6] PCI, x86: change the way to add MMCFG region on x86
Message-Id: <20120427151726.870d6966.izumi.taku@jp.fujitsu.com>
In-Reply-To: <4F996401.5010609@gmail.com>
References: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
	<20120426194254.3679abe0.izumi.taku@jp.fujitsu.com>
	<4F996401.5010609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Jian, Yinghai,

 Thank you your comment and review.

On Thu, 26 Apr 2012 23:04:33 +0800
Jiang Liu <liuj97@gmail.com> wrote:

> Hi Taku,
> 	Thanks for following this up. Please refer to inline comments below.
> I feel there are still some concerns from Don about the change proposed by
> Bjorn. And I haven't found a solution to address Don's concerns yet. So it
> would be better for us to hold on this for a while.
> 
> 	BTW, is it OK to split the task into two steps? 

   Sure.

> 1) enhance mmcfg to support host bridge hotplug.
> 2) refine the mmcfg setup logic.
> Seems it's more realistic for us to reach an agreement for task 1 in a short time,
> but there is still much work ahead for task 2.

  I agree with you.
  To achive task 1, your V4 should is good enough, but
  I found a problem in your patchset.

  When a hotpluggable hostbridge is found at boot time, its MCFG information should be 
  provided via _CBA method, and will added at the following timing:

         arch_acpi_pci_root_add()
            + pci_mmconfig_insert()
              + insert_resource()

  But at boot time, all entries in pci_mmcfg_list collection will added at the following timing:

        late_initcall
           + pci_mmcfg_late_insert_resources()
             + pci_mmcfg_insert_resources()
               + insert_resource()

  So, MCFG information of hotpluggable hostbridges which exist at boot time will fail to 
  add at this timing.

+int __devinit pci_mmconfig_insert(int segment, int start, int end, u64 addr)
+{
+	int rc = -EINVAL;
+	struct pci_mmcfg_region *cfg = NULL;
+
+	if (segment < 0 || segment > USHRT_MAX ||
+	    start < 0 || start > 255 || end < start || end > 255)
+		return rc;
+
+	mutex_lock(&pci_mmcfg_lock);
+	cfg = pci_mmconfig_lookup(segment, start);
+	if (cfg) {
+		if (cfg->start_bus <= start && cfg->end_bus >= end) {
+			rc = -EEXIST;
+		} else {
+			printk(KERN_WARNING PREFIX
+			       "MMCONFIG for domain %04x [bus %02x-%02x] "
+			       "conflicts with domain %04x [bus %02x-%02x]\n",
+			       segment, start, end,
+			       cfg->segment, cfg->start_bus, cfg->end_bus);
+		}
+		goto out;
+	}
+	if (!addr)
+		goto out;
+
+	cfg = pci_mmconfig_alloc(segment, start, end, addr);
+	if (cfg == NULL) {
+		rc = -ENOMEM;
+	} else if (!pci_mmcfg_check_reserved(cfg, 0)) {
+		printk(KERN_WARNING PREFIX
+		       "MMCONFIG for domain %04x [bus %02x-%02x] "
+		       "isn't reserved\n", segment, start, end);
+	} else if (insert_resource(&iomem_resource, &cfg->res)) {

          I think the following is better.

          else if (pci_mmcfg_resources_inserted &&
                   insert_resource(&iomem_resource, &cfg->res)) {


+		rc = -EBUSY;
+		printk(KERN_WARNING PREFIX
+		       "failed to insert resource for domain "
+		       "%04x [bus %02x-%02x]\n", segment, start, end);
+	} else if (pci_mmcfg_arch_map(cfg)) {
+		rc = -EBUSY;


  Could you please fix this?


Best regards,
Taku Izumi

