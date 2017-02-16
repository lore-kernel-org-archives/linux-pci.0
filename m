Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:38858 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752904AbdBPKH6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2017 05:07:58 -0500
Received: by mail-it0-f51.google.com with SMTP id c7so18839009itd.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2017 02:07:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a6d0bf66-d970-965d-9aae-667ec5e17fbf@windriver.com>
References: <a6d0bf66-d970-965d-9aae-667ec5e17fbf@windriver.com>
From: Ley Foon Tan <lftan.linux@gmail.com>
Date: Thu, 16 Feb 2017 18:07:57 +0800
Message-ID: <CAFiDJ5_2SWz+Oi0wr4dRgMSFDTXgLNZOc4xfaa1pqp5uXt+Pjg@mail.gmail.com>
Subject: Re: PCI: altera: Fix TLP completion status
To: yhu2 <yadi.hu@windriver.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Rocketboard Maillist <rfi@lists.rocketboards.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 16, 2017 at 5:54 PM, yhu2 <yadi.hu@windriver.com> wrote:
> PCI: altera: Fix TLP completion status
>
> 'Completion Status' value in TLP should be b15:13 while the fix is
> using b14:12
>
> Signed-off-by: Hu Yadi<yadi.hu@windriver.com>
> ---
>  drivers/pci/host/pcie-altera.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Please resubmit again with git send-email .

Thanks.

Regards
Ley Foon
