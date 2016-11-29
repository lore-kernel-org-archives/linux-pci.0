Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161129182415.7618.99129.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129182415.7618.99129.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 Nov 2016 21:56:43 +0100
Message-ID: <CAJZ5v0jQYfifkpp1nubH1uMumUnq0zSVW+-5y-XW+7E2U+Jomw@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: Ignore Consumer/Producer for QWord/DWord/Word
 Address Space
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tue, Nov 29, 2016 at 7:43 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Per spec, the Consumer/Producer bit is defined only for Extended
> Address Space descriptors and should be ignored for QWord/DWord/Word
> Address Space descriptors.  My understanding is that this is because
> x86 BIOSes didn't use the bit consistently, so it couldn't be relied
> upon.  The Extended descriptors were added later and are presumably
> more reliable.
>
> Linux currently looks at Consumer/Producer for all Address Space
> descriptors, although we don't use the result very much.  The x86 and
> ia64 host bridge driver code doesn't use Consumer/Producer to identify
> windows; it assumes all descriptors are windows.
>
> We do currently use Consumer/Producer to decide whether to apply _TRA.
> The change in these patches is to ignore Consumer/Producer for
> QWord/DWord/Word, so we'll apply _TRA from Consumer descriptors where
> we didn't before.  Per spec, that should be safe because _TRA is
> required to be zero for Consumer resources.
>
> If we want to describe host bridge register space and ECAM space
> directly in the PNP0A03 device on ARM64 (and I guess potentially even
> on x86 & ia64), I think we need changes like this so the arch code can
> use IORESOURCE_WINDOW to tell which descriptors are windows and which
> are registers.

It would be good to copy/move the above paragraph to the changelog of
patch [2/2].

The reason for that change is quite unclear otherwise.

> This is a subtle area, so please take a look and let me know what you
> think.
>
> These patches are based on v4.9-rc1.  It's getting pretty late in the
> cycle, but I think we'd really like to get the ARM64 ACPI PCI story
> sorted out for the v4.10 merge window.

So it is better if changes of this sort spend a few weeks in
linux-next before they get merged, just in case they trigger some
obscure issue and need to be rethought.

I'm not against these changes, but I won't be entirely comfortable
with them going straight into the mainline.

Thanks,
Rafael
