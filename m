Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49233 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752871AbdFLVEW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2017 17:04:22 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mario Limonciello <mario_limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans De Goede <hdegoede@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2 0/8] ACPI / PM: Suspend-to-idle rework to deal with spurious ACPI wakeups
Date: Mon, 12 Jun 2017 22:46:47 +0200
Message-ID: <1615075.mBkoKApGGc@aspire.rjw.lan>
In-Reply-To: <8918199.uo13RZ8hZk@aspire.rjw.lan>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

On Thursday, June 08, 2017 02:00:40 AM Rafael J. Wysocki wrote:
> Hi All,
> 
> This series is a replacement for commit eed4d47efe95 (ACPI / sleep: Ignore
> spurious SCI wakeups from suspend-to-idle) which is still there in 4.12-rc4 but
> will be reverted shortly, because it triggered issues on quite a few systems.
> 
> The last patch in the series is a counterpart of the above commit with a few
> modifications, mostly to avoid affecting suspend-to-RAM and to reorder messages
> printed to kernel logs to make them somewhat less confusing.

Here's a v2 which is very similar to the previous one, except for 3 things:
- There are few build fixes in the last patch.
- The patch from Hans mentioned previously is included now (as [7/8]).
- There is an additional PCI change related to config space saving/restoring
  and PME.

If anyone has any objections or concerns regarding this, please speak up now,
as I'm going to put it into linux-next shortly to allow it to receive some more
testing than commit eed4d47efe95 had had before it went it.

Thanks,
Rafael
