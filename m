Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:32820 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934204AbdCXQFu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Mar 2017 12:05:50 -0400
MIME-Version: 1.0
In-Reply-To: <a1b17c98858efd323fcd91a1e0898e8f0e45f442.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org> <a1b17c98858efd323fcd91a1e0898e8f0e45f442.1490188942.git.dwmw2@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 24 Mar 2017 17:05:48 +0100
Message-ID: <CAK8P3a2R_EXSp4bmBWDmyCYnaW1rOjsTUjwGwg1eEJ4psAb7sw@mail.gmail.com>
Subject: Re: [PATCH 03/17] pci: Only allow WC mmap on prefetchable resources
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 22, 2017 at 2:25 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> The /proc/bus/pci mmap interface allows the user to specify whether they
> want WC or not. Don't let them do so on non-prefetchable BARs.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Cc: stable@vger.kernel.org

Can you explain this a little more? I understand that we usually want to use
WC mappings on prefetchable BARs, and uncached non-WC on
non-prefetchable, but why do we have to force an error here?

Couldn't there be some hardware that allows write-combining access
but no prefetches?

       Arnd
