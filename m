Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6174 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751790AbcJZPBy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 11:01:54 -0400
Message-ID: <1477494063.5295.12.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/1] x86/platform/intel-mid: Retrofit
 pci_platform_pm_ops ->get_state hook
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Lukas Wunner <lukas@wunner.de>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 26 Oct 2016 18:01:03 +0300
In-Reply-To: <1477490807.25812.20.camel@nexus-software.ie>
References: <cover.1477221514.git.lukas@wunner.de>
         <7c1567d4c49303a4aada94ba16275cbf56b8976b.1477221514.git.lukas@wunner.de>
         <1477226275.2932.54.camel@nexus-software.ie>
         <20161023145757.GA4909@wunner.de>
         <1477300505.6423.41.camel@linux.intel.com>
         <20161024100940.GB5144@wunner.de>
         <1477307145.6423.48.camel@linux.intel.com>
         <20161025061934.GB5630@wunner.de>
         <1477490807.25812.20.camel@nexus-software.ie>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-10-26 at 15:06 +0100, Bryan O'Donoghue wrote:
> On Tue, 2016-10-25 at 08:19 +0200, Lukas Wunner wrote:

> 
> So the conclusion is to apply this patch now and go and look further @
> locking in a separate series right ? There's not much point in leaving
> Edison not booting as is the case with tip-of-tree right now.

That's what I think is a summary of the discussion.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
