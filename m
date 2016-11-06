Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from basicbox7.server-home.net ([195.137.212.29]:48349 "EHLO
        basicbox7.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbcKFNnh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Nov 2016 08:43:37 -0500
Subject: Re: [PATCH v3 1/1] x86/platform/intel-mid: Retrofit
 pci_platform_pm_ops ->get_state hook
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Lukas Wunner <lukas@wunner.de>
References: <cover.1477221514.git.lukas@wunner.de>
 <7c1567d4c49303a4aada94ba16275cbf56b8976b.1477221514.git.lukas@wunner.de>
 <1477226275.2932.54.camel@nexus-software.ie>
 <20161023145757.GA4909@wunner.de> <1477300505.6423.41.camel@linux.intel.com>
 <20161024100940.GB5144@wunner.de> <1477307145.6423.48.camel@linux.intel.com>
 <20161025061934.GB5630@wunner.de>
 <1477490807.25812.20.camel@nexus-software.ie>
 <1477494063.5295.12.camel@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <92ac10c1-84e4-0e73-a12d-69e66aac9c45@leemhuis.info>
Date: Sun, 6 Nov 2016 14:43:33 +0100
MIME-Version: 1.0
In-Reply-To: <1477494063.5295.12.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi! On 26.10.2016 17:01, Andy Shevchenko wrote:
> On Wed, 2016-10-26 at 15:06 +0100, Bryan O'Donoghue wrote:
>> On Tue, 2016-10-25 at 08:19 +0200, Lukas Wunner wrote:
>
>> So the conclusion is to apply this patch now and go and look further @
>> locking in a separate series right ? There's not much point in leaving
>> Edison not booting as is the case with tip-of-tree right now.
> That's what I think is a summary of the discussion.

Did anything happen after that conclusion? Just wondering, because this
bug is on the list of regressions for 4.9 and I think the proposed fix
hasn't reached mainline yet (or did I miss it?)

Ciao, Thorsten (regression tracker for 4.9)

