Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:40426 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab3J2WM6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 18:12:58 -0400
Received: by mail-ie0-f177.google.com with SMTP id e14so862796iej.8
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2013 15:12:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1382346403-29576-2-git-send-email-sachin.kamat@linaro.org>
References: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org> <1382346403-29576-2-git-send-email-sachin.kamat@linaro.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 29 Oct 2013 16:12:37 -0600
Message-ID: <CAErSpo6n4F1zREyYXuwq9LCRLCD+yZ9o8j==ANamiAZesFz=EA@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: mvebu: Remove redeundant of_match_ptr
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jason]

On Mon, Oct 21, 2013 at 3:06 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> mvebu_pcie_of_match_table is always compiled in. Hence of_match_ptr is
> not required.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Jason, I assume you'll merge this if you want it.

> ---
>  drivers/pci/host/pci-mvebu.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 20c470c..7adae6e 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -1016,8 +1016,7 @@ static struct platform_driver mvebu_pcie_driver = {
>         .driver = {
>                 .owner = THIS_MODULE,
>                 .name = "mvebu-pcie",
> -               .of_match_table =
> -                  of_match_ptr(mvebu_pcie_of_match_table),
> +               .of_match_table = mvebu_pcie_of_match_table,
>                 /* driver unloading/unbinding currently not supported */
>                 .suppress_bind_attrs = true,
>         },
> --
> 1.7.9.5
>
