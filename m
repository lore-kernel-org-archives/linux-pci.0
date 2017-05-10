Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12707 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751760AbdEJQhp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 May 2017 12:37:45 -0400
Date: Wed, 10 May 2017 12:44:53 -0400
From: Keith Busch <keith.busch@intel.com>
To: Wei Zhang <wzhang@fb.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Wesley Yung <wesley.yung@microsemi.com>,
        Sammy Hui <sammy.hui@intel.com>,
        Joseph Gruher <joseph.r.gruher@intel.com>,
        Krishna Dhulipala <krishnad@fb.com>
Subject: Re: [PATCH 1/2] pcie/dpc: Skip DPC event if device is not present
Message-ID: <20170510164452.GE2572@localhost.localdomain>
References: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
 <1493395369-20225-2-git-send-email-keith.busch@intel.com>
 <862590BB-8E84-4F2D-B5F9-A665000AA9CB@fb.com>
 <20170510131729.GD2572@localhost.localdomain>
 <9D9314D9-2EA5-45C1-AC60-54F7658FD4BC@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9D9314D9-2EA5-45C1-AC60-54F7658FD4BC@fb.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 10, 2017 at 04:35:06PM +0000, Wei Zhang wrote:
> Hi Keith,
> 
> I see.  I thought the current CPU root complex does not support such a use case, ie removing the DPC switch device itself and might result in kernel panic.  But I agree this will make the code future-proof when CPU does support such a case in the future.

What do you mean in the future? I do this today (hotplug enclosures),
but I need this fix in place otherwise we get a use-after-free when
the DPC work queue runs after the hotplug code freed the topology that
includes the DPC parts.
