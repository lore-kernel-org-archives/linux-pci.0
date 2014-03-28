Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114]:43503 "EHLO
	e06smtp18.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbaC1SlP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Mar 2014 14:41:15 -0400
Received: from /spool/local
	by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <sebott@linux.vnet.ibm.com>;
	Fri, 28 Mar 2014 18:41:13 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7F62617D8047
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2014 18:41:59 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2SIf0XH64815324
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2014 18:41:00 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2SIfB7n007641
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2014 12:41:11 -0600
Date: Fri, 28 Mar 2014 19:41:09 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org
Subject: pcibios_add_platform_entries usage
Message-ID: <alpine.LFD.2.11.1403281931410.1516@denkbrett>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

for pci on s390 we currently use pcibios_add_platform_entries to add
some arch specific attributes to pdevs. This has 2 downsides - it will
race with userspace which is triggered by udev events and expecting
these attributes (but that's a theoretical issue). More important to
me is that one cannot use attribute_groups with this. Both issues could
be addressed by using pdev->dev.groups and let the driver core handle
attribute creation.

So would it be ok if we set pdev->dev.groups in pcibios_add_device?
(It should be since it's not used by pci common code which uses bus_type,
dev_type, and class groups).

Regards,
Sebastian

