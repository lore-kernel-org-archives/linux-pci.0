Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52682 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbcG0SX2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2016 14:23:28 -0400
To: Bjorn Helgaas <bhelgaas@google.com>
From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [Regression][3.18-rc1 -> mainline] PCI: Configure *all* devices, not
 just hot-added ones
Cc: Yinghai Lu <yinghai@kernel.or>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, john_mazzie@dell.com,
	Mark Wenning <mark.wenning@canonical.com>
Message-ID: <5798FC1C.40405@canonical.com>
Date: Wed, 27 Jul 2016 14:23:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

A kernel bug report was opened against Ubuntu [0].  After a kernel
bisect, it was found that reverting the following commit resolved this bug:

commit 1302fcf0d03e6ea74846c7fee14736306ab2ce4b
Author: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat Aug 30 07:23:01 2014 -0600

    PCI: Configure *all* devices, not just hot-added ones

The regression was introduced as of v3.18-rc1 and the bug still exists
in current mainline.

I was hoping to get your feedback, since you are the patch author.  Do
you think gathering any additional data will help diagnose this issue,
or would it be best to submit a revert request?

    
Thanks,

Joe

[0] http://pad.lv/1571798

