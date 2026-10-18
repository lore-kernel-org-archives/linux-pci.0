Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E52196C7C
	for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2026 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792321234; cv=pass; b=pYDM/9YlIgVJhwx4hR2qA/w8EHUHG5qZb0K83mhDBBsAhx6jYbVDFVvvskeHLulcUpXBdJkZ3YWtjWi1pnAli6valgDM+CqVOHReeDW1+oyiIOzYSjZkSdWyqm613Xq4KqoTUEpRIcrv8bCjdzw/zwAU1oH2HiueTGUOLrTZ8go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792321234; c=relaxed/simple;
	bh=qIlt2ykkkdLl+dmoEHTQ6tI7nBNgRtj5wAg78i1d958=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPmzpqaR3vrj4SqyslMou9hOtzyPk7/W2l7XDFqNkeoNBU/yqrVNXq5a0hEwyyOn+TAZx307oR25wFaxPcn1Pi8Y7V1iWvFgA42Ohl6SCM8Td7s5TvB6UNroa94+pxe75LBPrQqdOO40TapZhsQpnTkSMcp6z5KTj1zFifmHwjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8vmoPlH; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8vmoPlH"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-677af43eed4so1063998d50.0
        for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2026 04:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792321232; cv=none;
        d=google.com; s=arc-20260327;
        b=kTshq2ufodzrvYOF4UHjHJzqYBkpF24MkmifC4sq5n+3Lho6EnKEp1lhRX5IF7gRDQ
         zcmSAqFC7BAk9BuYQ9c05HgQFN+G7kaVj6Svjq7mHjJH1pgqeO7ccuGiel8X0qD+4Q4i
         3QLQfdcq06sARCmqklqkJp4A6RSyqCWmPQormQOt+CDNqv5yvWMK3wML5QTaj4+TQBRR
         5rqa0slfAu96jWvx2IN0wUf2EK+MxOGA4BLU7fx1kQnVCBWifwfHl6fdwvP0RyzRHUcx
         XJkO1dpXr8ORPp8KhzaG+Sn+Amg8GV4X1zlP1wMNSBlq0pnZhS6o4sFDHuwVkQVT87Gb
         a8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KXioS6FbEBQDu7wrrnD4IMizIwgIPHAZuwC+6H4Y3ow=;
        fh=dnGaRNg1Vk10kkNIyZyl0NhovdXyjsYIRpOTvVvSEfo=;
        b=OvKCwuYwKGbOf7FuWWp80R3ehtafSZHtC0zUuXmBR1PnGjQ5W8PLma09p98eDExa1q
         nkz3pgL0/D9Ad2gYdHqHszZKt97OLHoC9mSrpRwfPXU96+DkcRI2oDYaYJ03y+fsrFay
         D/9ONu4NC3kot6rr4JYMdGxO2s7PFuZHqhqoJllfocNp4m1wm6f9mks6XHdwrhGPe3QE
         5XFyW0yqACEjDl1C3bIMSYNo4IbWOArK7l28DlAf8DFfw2pG47KHqc2HTI0HRozFXS5k
         RaxJD/Xf/jhZlrB4o4ob3Nw5S5UvOhJ8RjeFgRQraJOHXcvO50+Coau7vqrTeb7natN1
         TMhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792321232; x=1792926032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KXioS6FbEBQDu7wrrnD4IMizIwgIPHAZuwC+6H4Y3ow=;
        b=J8vmoPlHFCB+EuljSL6ZmhVQNeG7AXutWQF2exhgtbyA7FX5DMHIwvvOp0aFO8gGtL
         48JnOarC1kFwAQXuhWy4tFM3en46lEuV+e6Fw7dXesSkaXZQL0JdnaIZRsRB2D/hsPGn
         +Vvo6zAwbn0pynP7p5qXwZ+Bw/llcPOuhVD1M2EScjKjPpf5aV2pJgVCBv+Lx9jdu5AC
         UdbRqMbXCDpUTWao/vuo+IpQNW1DkYIwAt8y49tkwHoPtUvNPp0WyABZAisnxoQ3wXfy
         L80lJDuVLyNB50rDQTq+d/B5k7d5J3Oir7faXVmnSrvdI8KAsG3GjDsu3pxfNnYyjgib
         bmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792321232; x=1792926032;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KXioS6FbEBQDu7wrrnD4IMizIwgIPHAZuwC+6H4Y3ow=;
        b=KPmTLjsy90Hqy/OYjM5rXKRIkGGxazEHlnHU8jQgfIZhDYiK9cEUWwW2iZCJeqtLSu
         rfILuCCoMl7t/Ds2UMYWlNNCba568PwK41emlND65gqaPH6AqUwmB2yeGCwlQOIlFcbZ
         aqiWWriZrbCOoh+Z9ZeU0g0/pabP6qXxWP4ZF0ysucNZilAjScHLa82R0eB4MF3h5OKC
         76kEdhhFvsZ+iInYXOcdFB1u8hr5yfNNw0UfAPR3mP0WkJlng/z3ylrh+CWGXrp2gQ31
         5zb4Euiw3Az1zWbhDdR89w72/2j4qKwO6I+qVE4nPIphjHSUCe48hM+NXjUOWp/XNc8c
         nBig==
X-Gm-Message-State: AFq9FYK53TZVc3CXAuq8MDSqsSq0j8awrfKg7NDnoGpImYADCGJHXDIP
	xeItDOIBIVn/6+eZ/hedZsR7ot3F5rwzFvXSDZGStaxRGkYV7YQv028jhUGXw3hKX4B3ZWC78zN
	LmJzaSnEFot9e05qSv3KN3CBs3Sve4PY=
X-Gm-Gg: AYBFou2xIDzSOKFIeG9vfD0CyciRGw7kkGpqKiIwh+tAd87TnMz7TcjKi/YsWz3jujo
	RmB4OWqsc5AmUQ6japka6fI/WDxPZOaRC8u4VXmNhFiL8/NYwyW7ydYXj/Jg+cyO4gSQjSwetoE
	gnGNy/MR372uOzmjjOg77zmYuV8gD6Hbc8mmfRPQWhbEZQSlGrD6Rg9+VA7kjxCzC+B7kXFWnfM
	DN8DiUFIpA8jT/ghf4cBy0vpvW0yQWesQU2ulbpvHeAZydg+mTnOkSLO+fcKhNNzL3VEAeWQ2gO
	+N8VsZXuCBqg4GJuyh9SaXFR36pOzKU32ssiDAbxP/DcuMZjrnRsBLfESzxtFRNRBKCSY35GFX5
	eINO3KoH3RRt3UXugw4rowEWuPWDhCnOeUz3CQ9CPYMbJ/A==
X-Received: by 2002:a05:690e:e0f:b0:675:3dfb:4181 with SMTP id
 956f58d0204a3-679ca90956emr1197419d50.100.1792321231207; Sun, 18 Oct 2026
 04:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928123036.7902-1-kartikey406@gmail.com>
In-Reply-To: <20260928123036.7902-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 18 Oct 2026 16:30:19 +0530
X-Gm-Features: AclHuK_KJR9M7A-a_H10VdZL31wdvN93Y54A56zC-z-g3fLOpMAC4sdIJ8zslV4
Message-ID: <CADhLXY6Pb9Y5f9r12RZA1bbjBS_ctXAkXHPwY8qWwn_1WOJAsA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: sysfs: Reject unaligned resource I/O port accesses
To: bhelgaas@google.com, david.laight.linux@gmail.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 6:00=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> pci_resource_io() validates that the requested port lies within the
> BAR but never checks that it is aligned to the access size. A
> pwrite64()/pread64() on a resourceN file with an odd offset and
> count=3D2 or count=3D4 reaches outw()/outl() with a misaligned address.
> On arm64 this becomes a store/load to a Device-memory mapping
> (PCI_IOBASE + port), which architecturally requires natural
> alignment, causing an alignment fault and kernel oops.
>
> Reject misaligned 2- and 4-byte accesses before they reach the
> low-level accessor. With natural alignment enforced, an access that
> starts inside the BAR cannot extend past its end, so drop the
> port + count - 1 range check.
>
> Reported-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7134530b25073b4ef373
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v2: Check alignment per access size in the case 2/case 4 branches
>     instead of using IS_ALIGNED() with a user-controlled count, and
>     drop the now-redundant port + count - 1 range check.
>     (Bjorn, David, sashiko)
> ---
>  drivers/pci/pci-sysfs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 1f21856aac8a..8118cc6b3a61 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1209,9 +1209,6 @@ static ssize_t pci_resource_io(struct file *filp, s=
truct kobject *kobj,
>         if (port > pci_resource_end(pdev, bar))
>                 return 0;
>
> -       if (port + count - 1 > pci_resource_end(pdev, bar))
> -               return -EINVAL;
> -
>         switch (count) {
>         case 1:
>                 if (write)
> @@ -1220,12 +1217,16 @@ static ssize_t pci_resource_io(struct file *filp,=
 struct kobject *kobj,
>                         *(u8 *)buf =3D inb(port);
>                 return 1;
>         case 2:
> +               if (port & 1)
> +                       return -EINVAL;
>                 if (write)
>                         outw(*(u16 *)buf, port);
>                 else
>                         *(u16 *)buf =3D inw(port);
>                 return 2;
>         case 4:
> +               if (port & 3)
> +                       return -EINVAL;
>                 if (write)
>                         outl(*(u32 *)buf, port);
>                 else
> --
> 2.43.0
>

Hi David,

Gentle Reminder. Please let me know the status of this patch.

Thanks

Deepanshu
