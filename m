Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33482 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbcJKIht (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2016 04:37:49 -0400
Received: by mail-lf0-f65.google.com with SMTP id l131so2424162lfl.0
        for <linux-pci@vger.kernel.org>; Tue, 11 Oct 2016 01:37:48 -0700 (PDT)
Date: Tue, 11 Oct 2016 10:37:44 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
 ->get_state hook
Message-ID: <20161011083744.GA7577@gmail.com>
References: <63b7393731a5708dbbf107055e3fd9801c3c00b3.1476007467.git.lukas@wunner.de>
 <1476025280.11323.355.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1476025280.11323.355.camel@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, 2016-10-09 at 14:46 +0200, Lukas Wunner wrote:
> > Commit cc7cc02bada8 ("PCI: Query platform firmware for device power
> > state") augmented struct pci_platform_pm_ops with a ->get_state hook
> > and
> > implemented it for acpi_pci_platform_pm, the only pci_platform_pm_ops
> > existing till v4.7.
> > 
> > However v4.8 introduced another pci_platform_pm_ops for Intel Mobile
> > Internet Devices with commit 5823d0893ec2 ("x86/platform/intel-mid:
> > Add
> > Power Management Unit driver").  It is missing the ->get_state hook,
> > which is fatal since pci_set_platform_pm() enforces its presence.
> > 
> > Retrofit mid_pci_platform_pm with the missing callback to fix the
> > breakage.
> > 
> 
> +Ingo.
> 
> I guess it should go via tip/x86/urgent tree.

Can do, if Bjorn is fine with it as well - the patch is touching 
drivers/pci/pci-mid.c.

Thanks,

	Ingo
