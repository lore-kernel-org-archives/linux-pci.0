Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:32915 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdDLVrX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2017 17:47:23 -0400
MIME-Version: 1.0
In-Reply-To: <109e9ddbde4334d0da34f331797236309d789353.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org> <109e9ddbde4334d0da34f331797236309d789353.1491999859.git.dwmw2@infradead.org>
From: Tony Luck <tony.luck@gmail.com>
Date: Wed, 12 Apr 2017 14:47:21 -0700
Message-ID: <CA+8MBbKwN=pBN17Msm-g=x-iEgvy6KNFkutKsw_pDboBHgMifA@mail.gmail.com>
Subject: Re: [PATCH v2 25/27] ia64: Use generic pci_mmap_resource_range()
To: David Woodhouse <dwmw2@infradead.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 12, 2017 at 5:26 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Now that we eliminated the different behaviour in separately-reviewable
> commits, we can switch IA64 to the generic implementation.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Well it builds and boots on my last remaining ia64 machine. No warnings
or weird stuff in the console log.  So you can mark the three ia64 patches

Tested-by: Tony Luck <tony.luck@intel.com>

and bundle them with the others rather than through the ia64 tree.

-Tony
