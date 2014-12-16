Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:60176 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbaLPRvK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Dec 2014 12:51:10 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so7452138igi.6
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2014 09:51:09 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 16 Dec 2014 23:21:09 +0530
Message-ID: <CAGZFCEG-J=Qore8nWvWLe6m-bm59Mx+M=HdcaOBVNODm9beokQ@mail.gmail.com>
Subject: sysfs-pci remove
From: ratheesh kannoth <ratheesh.ksz@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi list,

https://www.kernel.org/doc/Documentation/filesystems/sysfs-pci.txt
talks about "remove" entry.
The 'remove' file is used to remove the PCI device, by writing a non-zero
integer to the file.  if i remove the device , will the bar resource
map still appear on /proc/iomem ?


-Ratheesh
