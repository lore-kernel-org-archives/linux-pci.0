Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:62074 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734Ab3JWCC6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Oct 2013 22:02:58 -0400
Received: by mail-wg0-f43.google.com with SMTP id b13so140869wgh.10
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2013 19:02:57 -0700 (PDT)
MIME-Version: 1.0
From: wubo <wuborush@gmail.com>
Date: Wed, 23 Oct 2013 10:02:37 +0800
Message-ID: <CAAV3jMxpNg2+ABE5AD8cOg5ZrYc1hL0-YbtHkVYFbPnSif9eeA@mail.gmail.com>
Subject: A question of msix feature
To: linux-pci@vger.kernel.org
Cc: agordeev@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, all

Sorry for troubling you.
We are developing msix feature on our product, unfortunately it will
lead kernel to crash
on a server PC whose cpu is Intel(R) Xeon(R) CPU E5645, and we are
sure that our driver is good
on common personal PC.

A piece code in our driver like that:
for (i = 0; i < msix_num; i++) {
msix = &pcie->msix_entries[i];
msix->entry = i;
}
ret = pci_enable_msix(XX);
for (i = 0; i < msix_num; i++) {
msix = &pcie->msix_entries[i];
ret = request_irq(msix->vector, XX);
}

BTW, the kernel crash info is as follows:
[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 32993
[Hardware Error]: APEI generic hardware error status
[Hardware Error]: severity: 1, fatal
[Hardware Error]: section: 0, severity: 1, fatal
[Hardware Error]: flags: 0x01
[Hardware Error]: primary
[Hardware Error]: section_type: PCIe error
[Hardware Error]: port_type: 0, PCIe end point
[Hardware Error]: version: 1.0
[Hardware Error]: command: 0x0407, status: 0x0010
[Hardware Error]: device_id: 0000:04:00.0
[Hardware Error]: slot: 2
[Hardware Error]: secondary_bus: 0x00
[Hardware Error]: vendor_id: 0x1c5f, device_id: 0x0530
[Hardware Error]: class_code: 008001

Do I miss something important?? Can anybody give me some hints?

-- 
Thanks,
Wubo
