Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22494 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752519AbbCaXDo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 31 Mar 2015 19:03:44 -0400
Date: Tue, 31 Mar 2015 16:02:26 -0700
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: linux-pci@vger.kernel.org
Subject: Extended Capabilities Linked-List Parsing
Message-ID: <20150331230226.GA3571@sean.stalley.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello All,

I was looking through pci_init_capabilities().

I noticed that most of the init functions in it call pci_find_capability(),
and return early if they can't find the capability in the list.

It seemed odd to me that each init function made a separate call into pci_find_capability().

Wouldn't it be better to walk the list once (in pci_init_capabilities()),
find all of the capability entries, and only call the init functions for entries that exist?

Thanks,
Sean O. Stalley
