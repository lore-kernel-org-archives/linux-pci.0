Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42291 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753378Ab2ERRM3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 May 2012 13:12:29 -0400
Received: by lahd3 with SMTP id d3so2236257lah.19
        for <linux-pci@vger.kernel.org>; Fri, 18 May 2012 10:12:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1336422606-4244-6-git-send-email-yinghai@kernel.org>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org> <1336422606-4244-6-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 18 May 2012 11:12:07 -0600
Message-ID: <CAErSpo71rKrZ7ptJjE5Lb6YnrqXVe1eGhn3pyF2Qjp=o8JHQmg@mail.gmail.com>
Subject: Re: [PATCH 05/21] resource: adjust_resource handle resource without parent
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 7, 2012 at 2:29 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> for no parent no siling case.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  kernel/resource.c |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 7e8ea66..51ade23 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -722,14 +722,12 @@ int adjust_resource(struct resource *res, resource_size_t start, resource_size_t
>
>        write_lock(&resource_lock);
>
> +       if (!parent)
> +               goto skip;
> +
>        if ((start < parent->start) || (end > parent->end))
>                goto out;
>
> -       for (tmp = res->child; tmp; tmp = tmp->sibling) {
> -               if ((tmp->start < start) || (tmp->end > end))
> -                       goto out;
> -       }
> -
>        if (res->sibling && (res->sibling->start <= end))
>                goto out;
>
> @@ -741,6 +739,11 @@ int adjust_resource(struct resource *res, resource_size_t start, resource_size_t
>                        goto out;
>        }
>
> +skip:
> +       for (tmp = res->child; tmp; tmp = tmp->sibling)
> +               if ((tmp->start < start) || (tmp->end > end))
> +                       goto out;
> +
>        res->start = start;
>        res->end = end;
>        result = 0;

Where does this case occur?  When do you need to adjust a resource
that has no parent?
