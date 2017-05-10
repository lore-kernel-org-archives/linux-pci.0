Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:1071 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751267AbdEJNKw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 May 2017 09:10:52 -0400
Date: Wed, 10 May 2017 09:17:29 -0400
From: Keith Busch <keith.busch@intel.com>
To: Wei Zhang <wzhang@fb.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Wesley Yung <wesley.yung@microsemi.com>,
        Sammy Hui <sammy.hui@intel.com>,
        Joseph Gruher <joseph.r.gruher@intel.com>,
        Krishna Dhulipala <krishnad@fb.com>
Subject: Re: [PATCH 1/2] pcie/dpc: Skip DPC event if device is not present
Message-ID: <20170510131729.GD2572@localhost.localdomain>
References: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
 <1493395369-20225-2-git-send-email-keith.busch@intel.com>
 <862590BB-8E84-4F2D-B5F9-A665000AA9CB@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <862590BB-8E84-4F2D-B5F9-A665000AA9CB@fb.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 10, 2017 at 03:39:27AM +0000, Wei Zhang wrote:
>  Hi Keith and Wes,
> 
> I wonder if getting an All 1’s read on the DPC status register is a
> valid scenario.   The DPC register is on the switch, why would the
> status register returns All 1’s even if the device is removed?

Ah, this isn't about the downstream device precense. This is about
the DPC switch device itself, like if you pull the cable out of the
enclosure. Reading anything off the DSPs in it will see all 1's.
