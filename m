Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F434E745
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 01:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276807; cv=pass; b=ptKXe15+oTGkiM7yiLdJ2muc4bbY/yEo1tjZrqIyB7LXrPBDlqUEK0XECRVD/j8EqilOWQTOstOntMkhZWltQju2X26IFY8i4IFkiKghTK8CPF/dUjGlaEuC6fgwUHaYd5wOxLowqMJOL9YPt2j+8mQdbXHAapfwp64BTocDxGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276807; c=relaxed/simple;
	bh=4lkqgof84TLP8w7Gwh1Y286GyA+IchGWkTwUHyVRmKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/1TtIuvCUWh22+KhAJW9Nhkgi26xyGMaocsxk0mwxMs6Vu10/ZFmwaONBjhejXBtGRFwk6zBWGryM8K8YjoaDzN4duxaA0Ws8qc6QF/H7aQ6jYVZcElTh6BujH8U2BK49kNkWwIsWNxQEm5dMZxyB275WKK5bPkatiIUVvNQBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stx5Y7jm; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stx5Y7jm"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66c8e41f703so573555d50.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 18:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787276805; cv=none;
        d=google.com; s=arc-20260327;
        b=H4/daN2KFs1r+3egicwHeWV8CiItWqs0/FDa+M8Gy2VwadZswZP15u06MP43zjqJQ1
         UnoxtE30S6BXmeypbjbJMQy19hq/9aoFAvyW+Ul9zN8lBdVj6Nr4e8u++4VloLxc1J0r
         b33dgjG3H0zBi2Ib02WnC6VSwUjf64asHHAs7yLairvW8x94A81R21BWqC7peVJZFlIR
         rejgn6ZiGataRR8tZbbguNyKNdQ/rOF2n45vB0Wv7tP/iaA2JneP2mD3lPfhe0DRwu/c
         p7Zgq71ECukVymus8VeF7iOCMbNT0zL2du6GdI6lIApEpC8ZwDhpNGbgSFdIdDgefZmF
         1kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aSbzDExTNSXb8I3gIkoDLqSPLLMW8//EIXDUhQfZOl4=;
        fh=t2VbnN5mMU6ttz+1yBftFMhv5EAC3nrslI0Zr0YJi0o=;
        b=m9G+SUvsMmRLjDcMqXUnsJ6Ef4BFj3oIfjFPdejxA1xN2eLqxWdGDHJRBZinJxQZ0X
         2ksuJ78Ku1SNANQii/Mm+bIp7cZtIbUKzX4QOF7ng3jT+BoRDhr57Kpb27+pvXbOMxBn
         LPs66zhfdwReiFD3cl4xaymVamihMDT0iShX+/u/CfsiEj36Wtue4qh4RwzYsdmugMtf
         uSvbiq6R5sgThrzMagNTLSsgrfIPrkHrOi21vj/kn22LNggiCAReAqV8DESF9kYfnQZG
         I7V8XUOUlqWXSv/9HC47VLjzmVSCFK6+TSYdF4YSPXqn34HyG0aKO14eU5nP1DlsoaDO
         beXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787276805; x=1787881605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSbzDExTNSXb8I3gIkoDLqSPLLMW8//EIXDUhQfZOl4=;
        b=stx5Y7jmUS+6yFvRlE7yTq14MsaI6v81mgGQqlpUCRPAa528v6krd1ZWV1bC5BKZv6
         +LbqTBDQvZ8bwnlqnNDEDnPVHg6ruVoG8rZCSw4Op1Ysekm/0j5FDiUTQJMyl3JjT+Fs
         7QOkZjRiUoMYVHq15Kbfa5qzIKp43KuPu7B3AL++O1NppMMA3ByecXTZpz9iT3vvypF8
         cArDSM6UygSTCoIJvxstL0c1yW119l4C5gtDrZPWusS+Ithk6BpvgP997bcr47/yLWqw
         vxAernn8clGOpqOifWH7kr29EZM7xD1kx+BTVnZNjug2Z3XVaQLtUQRLaTPm1QHB9Swp
         Qksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787276805; x=1787881605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSbzDExTNSXb8I3gIkoDLqSPLLMW8//EIXDUhQfZOl4=;
        b=suw9KZ2jN0KTbfi6m1wjRAVofJDMj+krtjBTUzyLODxlAd0wUT1GzDGo1Z98dllCdX
         fOL47ILmEoME4CdO1qqrDO/5yHJR+q3qdQVboYfJn7UoQXggIcegI82GtFnX8QJLOF8k
         vpPmWxLiwACPy9puAJDlbqExp9bQCZU0syMCZEhqFXUcSyAm23clEekucNDNR4tQ57Sg
         Gwh7M4fwiXKuvusG9VyUAViktYkn2mzJA+eWUSIBUjC4lwT3D7cfuPyopDJzgnscDwIn
         +KfmIpGKshc9SJptEv+yPp1YD/zf/cMi50OIDPnk28vLQ06mMsJTU+MxeUnrFIOc7ZZ2
         w4Jw==
X-Gm-Message-State: AFuF++lXwLVn4R/QIAvgYgGMI4kRsPWuXHGeQCfEdcVhp6p2s2LJckoK
	hbtaT9GbhXQ5iVucbTsLg7u6R0ZQxPOAXcQP+aYuZbodBZdH3HUDspoWJ2AEEeryC9Ppwtv2ZC1
	Z/6A/A9T+5uzrTgYZ3bUKcjqCBQk0j38=
X-Gm-Gg: AR+sD11RwIXlPrDEv6WgrySIpbQ7lcmAvQLtQflprHZCiJeAubad6rETSmOAci6ileT
	aRscXgr0zYwM5GiZlag11cryzR8F/WgbZuA7o0tHJZ4vZ1HXfP6ac2jyHwuhzBNU3DZvxVH3R5c
	wTBZVcGjq1e5eTTDpqblTZJYnkjylkcX0AZnp+biZHDmL4BLiPA25RJbsLomy2wLDEBCvUh3hy/
	cNYU76PGapZc5qqlht3ktG+gUJxQ3ZZocWdFY/EwHbcfbkU+Y5NeTUj9jnRb6+u8SukHiULPJaz
	fhgX0daVv5AotlMBxeFfs5knB0SZibueDTpsOa1aCUmvgkh6CFwX18XemcN5B05Zd5zFhXSJMEK
	aKcql4XgAqPKlz24Legh87Ppd4fUjdd/Azbc=
X-Received: by 2002:a53:b841:0:b0:668:8b09:bd13 with SMTP id
 956f58d0204a3-66ce4a1b110mr948661d50.18.1787276804863; Thu, 20 Aug 2026
 18:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809045946.15638-1-kartikey406@gmail.com>
In-Reply-To: <20260809045946.15638-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 21 Aug 2026 07:16:32 +0530
X-Gm-Features: AcwNN1UfFssZZAW8LQxuunODF_Lm6-tOCTRu87MFImXNEFysj-L-ixg6k1s4xWM
Message-ID: <CADhLXY4KGiDs3CGYs22aGF0H2LZEzD6Vkjf-yAjr+xTkpZQrmg@mail.gmail.com>
Subject: Re: [PATCH] PCI: sysfs: Reject unaligned resource I/O port accesses
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 10:29=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> pci_resource_io() validates that off+count stays within the BAR's
> range but never checks that the resulting port is aligned to the
> access size. A pwrite64()/pread64() on a resourceN file with an odd
> offset and count=3D2 or count=3D4 reaches outw()/outl() with a misaligned
> address. On arm64 this becomes a store/load to a Device-memory
> mapping (PCI_IOBASE + port), which architecturally requires natural
> alignment, causing an alignment fault and kernel oops.
>
> Reject misaligned accesses before they reach the low-level accessor.
>
> Reported-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7134530b25073b4ef373
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/pci/pci-sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5ec0b245a69b..72f0404a34e9 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1175,6 +1175,9 @@ static ssize_t pci_resource_io(struct file *filp, s=
truct kobject *kobj,
>         if (port + count - 1 > pci_resource_end(pdev, bar))
>                 return -EINVAL;
>
> +       if (!IS_ALIGNED(port, count))
> +               return -EINVAL;
> +
>         switch (count) {
>         case 1:
>                 if (write)
> --
> 2.43.0
>

Gentle Reminder. Please let me know the status of this patch

Thanks

Deepanshu
