Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 25 Apr 2017 06:14:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
Message-ID: <20170425131432.GA4714@infradead.org>
References: <1492706123-22913-1-git-send-email-haiyangz@exchange.microsoft.com>
 <CAErSpo4iFS05Kk3Km54fFmpMf11XCoaPmGxSzqE3QuA5P=T6=Q@mail.gmail.com>
 <BLUPR03MB1412F7A0A693B67685D5FE9FCA1B0@BLUPR03MB1412.namprd03.prod.outlook.com>
 <8ff72ec3-d61e-07d9-8c9d-92951195b67d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8ff72ec3-d61e-07d9-8c9d-92951195b67d@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi John,

please fix your quoting of the previous mails, thanks!


What ACPI defines does not matter at all.  Linux uses 32-bit domains
IDs, and on x86 specifily uses those for non-ACPI enumarated domains
(e.g. VMD).

You've also not demontrated any issue with any Linux driver yet.

> Also...it would be nice if we could use Haiyang's patch as at least a
> temporary fix, because distros are just today releasing the previous code,
> and HyperV will start breaking "occasionally", depending on whether the
> 32-bit virtual (fake) PCI domain fits within 16 bits. (If not, then we can
> rush out a driver update to fix it, but there will be a window of time with
> some breakage there.)

Just send the fix to whatever driver is broken to the driver maintainer.
But I can't find a single broken driver in the tree, and as you know
nothing else matters for Linux anyway.
