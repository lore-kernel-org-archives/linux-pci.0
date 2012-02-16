Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:45127 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab2BPFPV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2012 00:15:21 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 1/4] PCI: quirk related clean up
Date: Wed, 15 Feb 2012 21:14:52 -0800
Message-Id: <1329369296-4255-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After commit:
| commit 3209874a1da2c51c7325e601d9634189ee178ad6
| Author: Arjan van de Ven <arjan@infradead.org>
| Date:   Mon Jan 30 20:52:07 2012 -0800
|
|    PCI: Annotate PCI quirks in initcall_debug style

will have lots of print out for quirks when initcall_debug is specified.

It turns out most of them are not really called for the devices because
quirks itself will check class id and bail out early.

Try to class into quirk declaration. So we could avoid dip into these quirks.

[PATCH 1/4] PCI: Add class support in quirk handling
[PATCH 2/4] PCI: Specify class for quirk entry with PCI_ANY_ID
[PATCH 3/4] PCI: Move out pci reassigndev resource alignment out of quirk
[PATCH 4/4] PCI: quirk print dev name with duration

Thanks

Yinghai
