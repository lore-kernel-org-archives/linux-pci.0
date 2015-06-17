Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from yes.iam.tj ([109.74.197.121]:38666 "EHLO iam.tj"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753216AbbFQSQa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Jun 2015 14:16:30 -0400
Received: from hephaestion.lan.eddie.tj (jeeves.iam.tj [82.71.24.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by iam.tj (Postfix) with ESMTPSA id CEA6134106
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2015 19:11:28 +0100 (BST)
Message-ID: <5581B850.4010406@iam.tj>
Date: Wed, 17 Jun 2015 19:11:28 +0100
From: TJ <linux@iam.tj>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Regression: bug #81431 (v3.15..V3.16) pci=realloc fails to modify
 bridge windows, causing devices to fail BAR allocation
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've finally had the opportunity to bisect this regession down to:

  PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources

commit 5b28541552ef5eeffc41d6936105f38c2508e566
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Mon May 19 17:01:55 2014 -0600

The patch is quite involved so could someone with familiarity with the allocation strategies take a look please?

https://bugzilla.kernel.org/show_bug.cgi?id=81431
