Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39526 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeB0QND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 11:13:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180227100231.22561-1-embedded24@evers-fischer.de>
References: <20180227100231.22561-1-embedded24@evers-fischer.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2018 18:13:02 +0200
Message-ID: <CAHp75Vfbv-BpFS39jeN0ZapP1dg=4HfEOL75cQ11QR5iRpqFpA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pci: endpoint: Fix double free in pci_epf_create()
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 27, 2018 at 12:02 PM, Rolf Evers-Fischer
<embedded24@evers-fischer.de> wrote:
> This is version 3 of a patchset to avoid double free in function
> 'pci_epf_create()'.
>
> When I accidentally created a new endpoint device with an empty name,
> the kernel warned about "attempted to be registered with empty name!"
> and crashed afterwards.
>
> It turned out that the crash was not caused by the 'device_add()'
> function itself, but by a double kfree of 'epf->name' and 'epf'.
>
> The first patch just simplifies the code, while the second patch
> fixes the problem.
>

After addressing Bjorn's comments, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Changes in v3:
> - Matched to other pending pci endpoint commits (thanks, Bjorn!)
> - Added "Fixes" tag in patch 2 (thanks, Andy!)
>
> Changes in v2:
> - Based on feedback from Lorenzo, Andy and Kishon (thanks!)
> - Change IDs removed
> - First patch completely reworked in order to eliminate the
>   need for the second 'kstrdup' allocation and the 'kfree' of
>   the first allocation.
>   It was tested with name="pci_epf_test.0" and name="pci_epb":
>   The 'epf->name' was "pci_epf_test" or "pci_epb" (=unchanged).
>
> Rolf Evers-Fischer (2):
>   pci: endpoint: Simplify name allocation for epf device
>   pci: endpoint: Fix kernel panic after put_device()
>
>  drivers/pci/endpoint/pci-epf-core.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
>
> --
> 2.16.2
>



-- 
With Best Regards,
Andy Shevchenko
