Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15049 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbcHMAsN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 12 Aug 2016 20:48:13 -0400
Date: Fri, 12 Aug 2016 20:58:12 -0400
From: Keith Busch <keith.busch@intel.com>
To: "Sean O. Stalley" <sean.stalley@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] pci: add option to ignore slot capabilities
Message-ID: <20160813005811.GA10684@localhost.localdomain>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
 <20160813000358.GA20474@sean.stalley.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160813000358.GA20474@sean.stalley.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 12, 2016 at 05:03:58PM -0700, Sean O. Stalley wrote:
> I think we should clear these bits after the ctrl_info() below.
> If we clear it immediately, the ctrl_info() will report these bits as cleared,
> even though they may be set in hardware.
> 
> I don't think we want to put a value into the log that differs from what hardware reports.

Maybe, I didn't think of it that way. I thought if a user saw the
capabilities in the kernel message, she could reasonably expect what
the pciehp driver is going to do, even though the driver masked off
that behavior.

'lspci' would still show the hardware capabilities if that's okay for
a user. Had I my way, the hardware wouldn't advertise this capability
at all.
