Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:47685 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab3AaRPY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 12:15:24 -0500
Received: by mail-vc0-f169.google.com with SMTP id n10so1884489vcn.14
        for <linux-pci@vger.kernel.org>; Thu, 31 Jan 2013 09:15:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1358944146-28884-1-git-send-email-wangyijing@huawei.com>
References: <1358944146-28884-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 31 Jan 2013 10:15:03 -0700
Message-ID: <CAErSpo4DrTBPxOr9va8TCknu-HgC2zKyOGRP7w02_-_W8s2KmQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Document PCI Hotplug resource reservation parameters
To: Yijing Wang <wangyijing@huawei.com>
Cc: Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 23, 2013 at 5:29 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Document pci hotplug resource reservation parameters hpiosize
> and hpmemsize into Documentation/kernel-parameters.txt.
> The two parameters can override default hotplug io size(256 bytes)
> and default mem size(2M).
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  Documentation/kernel-parameters.txt |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 1fb269b..46eff3d 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2263,6 +2263,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>                                 the default.
>                                 off: Turn ECRC off
>                                 on: Turn ECRC on.
> +               hpiosize=nn[KMG]        The fixed amount of bus space which is
> +                               reserved for hotplug bridge's IO window.
> +                               Default size is 256 bytes.
> +               hpmemsize=nn[KMG]       The fixed amount of bus space which is
> +                               reserved for hotplug bridge's memory window.
> +                               Default size is 2 megabytes.
>                 realloc=        Enable/disable reallocating PCI bridge resources
>                                 if allocations done by BIOS are too small to
>                                 accommodate resources required by all child
> --
> 1.7.1
>
>

Added to pci/misc for v3.9.  Thanks!
