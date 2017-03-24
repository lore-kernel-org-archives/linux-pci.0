Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 24 Mar 2017 17:20:01 +0100
Message-ID: <CAK8P3a0+JKL_JixTdT+tRj-iNq3uJPTC9xwEsX2iM8pf97O9Mw@mail.gmail.com>
Subject: Re: [PATCH 00/17] PCI resource mmap cleanup
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 22, 2017 at 2:25 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> This started out as a fairly trivial "add pci_mmap_page_range() for
> ARM64" patch. But pci_mmap_page_range() is a vile interface, taking
> "user visible" resource addresses converted with pci_resource_to_user()
> on those platforms unlucky enough to use that... and even in the *sane*
> sysfs-based mmap method, we convert through user addresses to call the
> platform-specific method.
>
> In most cases there's just no need for any of this crap. We can migrate
> most architectures to a generic implementation without much thought,
> and the few that aren't converted in this series can probably be added
> fairly easily too but need a little more arch-specific attention.
>
> Utterly untested for now; I'll do some testing while I deal with the
> inevitable bikeshedding.

Looks good to me overall, I have replied with one request for
clarification, and would like the bikeshed in patch 17 in a different
colour.

      Arnd
