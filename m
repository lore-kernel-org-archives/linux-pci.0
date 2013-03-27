Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:51580 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab3C0R2B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 13:28:01 -0400
Received: by mail-ob0-f177.google.com with SMTP id eh20so8257098obb.8
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 10:28:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363665251-14377-1-git-send-email-linfeng@cn.fujitsu.com>
References: <CAE9FiQUrt11A0YAOLgvv3uTAWtTvVg3Mho9eD53orbxW6Jd8Vg@mail.gmail.com>
 <1363665251-14377-1-git-send-email-linfeng@cn.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 27 Mar 2013 11:27:41 -0600
Message-ID: <CAErSpo6DWfHii8d8rGPJ1dLj5TVzsgU7QGDoAvBM5Fb_N5=mtw@mail.gmail.com>
Subject: Re: [PATCH] kernel/range.c: subtract_range: fix the broken phrase
 issued by printk
To: Lin Feng <linfeng@cn.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 18, 2013 at 9:54 PM, Lin Feng <linfeng@cn.fujitsu.com> wrote:
> Also replace deprecated printk(KERN_ERR...) with pr_err() as suggested
> by Yinghai, attaching the function name to provide plenty info.
>
> Cc: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Lin Feng <linfeng@cn.fujitsu.com>
> ---
>  kernel/range.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/range.c b/kernel/range.c
> index 9b8ae2d..071b0ab 100644
> --- a/kernel/range.c
> +++ b/kernel/range.c
> @@ -97,7 +97,8 @@ void subtract_range(struct range *range, int az, u64 start, u64 end)
>                                 range[i].end = range[j].end;
>                                 range[i].start = end;
>                         } else {
> -                               printk(KERN_ERR "run of slot in ranges\n");
> +                               pr_err("%s: run out of slot in ranges\n",
> +                                       __func__);
>                         }
>                         range[j].end = start;
>                         continue;

So now the user might see:

    subtract_range: run out of slot in ranges

What is the user supposed to do when he sees that?  If he happens to
mention it on LKML, what are we going to do about it?  If he attaches
the complete dmesg log, is there enough information to do something?

IMHO, that message is still totally useless.
