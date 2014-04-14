Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:37193 "EHLO
	e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbaDNJDq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Apr 2014 05:03:46 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <sebott@linux.vnet.ibm.com>;
	Mon, 14 Apr 2014 10:03:45 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 12EF21B08072
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2014 10:03:45 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com [9.149.37.250])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3E93h8O63242258
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2014 09:03:43 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3E93hFZ023647
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2014 03:03:43 -0600
Date: Mon, 14 Apr 2014 11:03:42 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org
Subject: [Resend] pcibios_add_platform_entries usage
In-Reply-To: <alpine.LFD.2.11.1403281931410.1516@denkbrett>
Message-ID: <alpine.LFD.2.11.1404141101500.1529@denkbrett>
References: <alpine.LFD.2.11.1403281931410.1516@denkbrett>
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

