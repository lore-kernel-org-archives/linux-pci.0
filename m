Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2122 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbeHCLbT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Aug 2018 07:31:19 -0400
Message-ID: <77e207877f5bf500a180cfdd7f23fe45669b27ea.camel@linux.intel.com>
Subject: Re: Problem with 4cec16861a40 ("PCI/ASPM: Convert to use
 match_string() helper")
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Fri, 03 Aug 2018 12:35:48 +0300
In-Reply-To: <56e85d14-786d-02b9-b816-7e8c6cecc254@gmail.com>
References: <56e85d14-786d-02b9-b816-7e8c6cecc254@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-08-02 at 20:13 +0200, Heiner Kallweit wrote:
> I wondered why my system gets warmer than usual and eventually found
> that
> every write to /sys/module/pcie_aspm/parameters/policy returns EINVAL.

Thanks for spotting this!
My bad.

> 
> Reason is mentioned change, using match_string() is wrong when used
> with
> sysfs because sysfs strings have a trailing newline.

Not always, but you are right, it has to be \n-aware.

>  Seems like the patch
> wasn't tested.
> __sysfs_match_string() has to be used instead. I checked and this
> fixes
> the issue. 

Yes, it should be sysfs variant.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
