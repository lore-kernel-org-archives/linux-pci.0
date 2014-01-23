Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:51620 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbaAWSmt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2014 13:42:49 -0500
Received: by mail-ie0-f182.google.com with SMTP id lx4so1624050iec.41
        for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2014 10:42:49 -0800 (PST)
Date: Thu, 23 Jan 2014 11:42:46 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org
Subject: [scan-admin@coverity.com: New Defects reported by Coverity Scan for
 Linux]
Message-ID: <20140123184246.GA7461@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

FYI.  I think the first two (related to "name") are valid.  I haven't
figured out the "msi_attrs" one yet.

I think these are related to 1c51b50c2995 ("PCI/MSI: Export MSI mode using
attributes, not kobjects").

Bjorn

----- Forwarded message from scan-admin@coverity.com -----

Date: Thu, 23 Jan 2014 04:23:21 -0800
From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for Linux

Please find the latest report on new defect(s) introduced to Linux found with Coverity Scan.

...

** CID 1163315:  Dereference null return value  (NULL_RETURNS)
/drivers/pci/msi.c: 551 in populate_msi_sysfs()

** CID 1163316:  Resource leak  (RESOURCE_LEAK)
/drivers/pci/msi.c: 550 in populate_msi_sysfs()

** CID 1163317:  Resource leak  (RESOURCE_LEAK)
/drivers/pci/msi.c: 592 in populate_msi_sysfs()

...
________________________________________________________________________________________________________
*** CID 1163315:  Dereference null return value  (NULL_RETURNS)
/drivers/pci/msi.c: 551 in populate_msi_sysfs()
545     		return -ENOMEM;
546     	list_for_each_entry(entry, &pdev->msi_list, list) {
547     		char *name = kmalloc(20, GFP_KERNEL);
548     		msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
549     		if (!msi_dev_attr)
550     			goto error_attrs;
>>>     CID 1163315:  Dereference null return value  (NULL_RETURNS)
>>>     Dereferencing a pointer that might be null "name" when calling "sprintf(char *, char const *, ...)".
551     		sprintf(name, "%d", entry->irq);
552     		sysfs_attr_init(&msi_dev_attr->attr);
553     		msi_dev_attr->attr.name = name;
554     		msi_dev_attr->attr.mode = S_IRUGO;
555     		msi_dev_attr->show = msi_mode_show;
556     		msi_attrs[count] = &msi_dev_attr->attr;

________________________________________________________________________________________________________
*** CID 1163316:  Resource leak  (RESOURCE_LEAK)
/drivers/pci/msi.c: 550 in populate_msi_sysfs()
544     	if (!msi_attrs)
545     		return -ENOMEM;
546     	list_for_each_entry(entry, &pdev->msi_list, list) {
547     		char *name = kmalloc(20, GFP_KERNEL);
548     		msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
549     		if (!msi_dev_attr)
>>>     CID 1163316:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "name" going out of scope leaks the storage it points to.
550     			goto error_attrs;
551     		sprintf(name, "%d", entry->irq);
552     		sysfs_attr_init(&msi_dev_attr->attr);
553     		msi_dev_attr->attr.name = name;
554     		msi_dev_attr->attr.mode = S_IRUGO;
555     		msi_dev_attr->show = msi_mode_show;

________________________________________________________________________________________________________
*** CID 1163317:  Resource leak  (RESOURCE_LEAK)
/drivers/pci/msi.c: 592 in populate_msi_sysfs()
586     		msi_dev_attr = container_of(msi_attr, struct device_attribute, attr);
587     		kfree(msi_attr->name);
588     		kfree(msi_dev_attr);
589     		++count;
590     		msi_attr = msi_attrs[count];
591     	}
>>>     CID 1163317:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "msi_attrs" going out of scope leaks the storage it points to.
592     	return ret;
593     }
594     
595     /**
596      * msi_capability_init - configure device's MSI capability structure
597      * @dev: pointer to the pci_dev data structure of MSI device function

...

To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/128?tab=Overview

----- End forwarded message -----
