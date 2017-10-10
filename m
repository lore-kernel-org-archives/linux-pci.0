Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755907AbdJJLD4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Oct 2017 07:03:56 -0400
Date: Tue, 10 Oct 2017 06:03:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alan Cox <alan@linux.intel.com>
Cc: "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] mmc: sdhci-pci: Remove D3 delays for Intel BYT-related
 host controllers
Message-ID: <20171010110351.GU25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1507294259-20438-1-git-send-email-adrian.hunter@intel.com>
 <20171006162048.GC25517@bhelgaas-glaptop.roam.corp.google.com>
 <ada41e9b-6fb3-82ab-e458-af4942adba2d@intel.com>
 <20171009134154.GJ25517@bhelgaas-glaptop.roam.corp.google.com>
 <363DA0ED52042842948283D2FC38E4649BF3590E@IRSMSX106.ger.corp.intel.com>
 <20171009202502.GN25517@bhelgaas-glaptop.roam.corp.google.com>
 <1507626095.26339.5.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1507626095.26339.5.camel@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 10, 2017 at 10:01:35AM +0100, Alan Cox wrote:
> > Your concern was that a quirk would require a long list of device IDs
> > and we'd have to add new ones.  I share that concern,
> 
> I'm not sure I do. The bus topology tells you what is on die, and the
> id of the root bridge tells you if it's one of the parts you can do
> this.

Your a49d25364dfb ("staging/atomisp: Add support for the Intel IPU
v2") added the most generic version (pci_d3_delay_fixup() uses

  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_d3_delay_fixup);

so there's no list of device IDs.  If this is really a property of the
family (BYT/CHT/etc), it makes sense to me to do it that way, but if
you think it's better to have a list, that's OK too.

The more interesting question to me is whether the quirk should be in
an optional driver or in the always-present arch code.  My assumption
is that putting it in the driver means that if the driver isn't
enabled, we're doing unnecessary delays.

Bjorn
