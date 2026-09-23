Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871533993
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 03:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134529; cv=pass; b=NRZGvaySmQIYM9+XeW+nS3PGr144PEsfkW6sae6QcBdVD8BtpvtEQzLQy72WHlM4RMy1DNS44ciXEzBdGQm9WZCnoeV22Q59gxvzzViJy154ge/FexI72iyFV3BwoXACkSLCFb5ggroJbFcpSzSGAuk6KsVz3gkYQYgawnAVI7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134529; c=relaxed/simple;
	bh=d2Qu26JxNz4DdK7KNZRSYHH9xu3oRYAJPIgmwuU8THo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZszCMx1Ngvc3a7kxwkCzc0O63JLaEJUIki4keES1JwbMaVqubGQSifHvCRelRDQE2JpiaVc6UjKXnfR081rxp3JcB9dPg3IgZU2+lYT7DXCm7N3skPx/E3jzfa911zYhpgelXtXK+kLJ41Q2ZJIbdQeW8TrmfgMy1RY30oitpL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCqknjAh; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCqknjAh"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43f9b11bso6787217b3.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 20:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790134526; cv=none;
        d=google.com; s=arc-20260327;
        b=W3Ri0mGAoVFcEf/PvAeQXOVwmgkGERjAmtUBIVdDgag/6m2wFLdgWZX5Wx5NAuSSlw
         z6wuGFULvWdcg6apw8NAJ5raQClRy0Goegr+sJEp2ZUZQ9x9IZuysYlrjfj471AepBIB
         6AS6jU8qx46jnYyfs/7jPG+TnCFboDDhE5sVhiIlGZQZULSUF5B2FcNjLEg0272276Dx
         sa4maQ++LIo5RQZTyx0qEBwFC0jgHrlIvdTt2ZGLDBpLAaow9iTl1fnQVIaCJz5cfX4n
         wejwqYOeAdiviT0Je1WvomfjdgZNLE177wSo/ctpaGvVZTIXe0JoIPLFLQlS+PXG2CIt
         fg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XYEEoMGteHxFV1awOkLk45oTIa6yiwyLCwRO6PLmYiQ=;
        fh=t2VbnN5mMU6ttz+1yBftFMhv5EAC3nrslI0Zr0YJi0o=;
        b=K0D5jNiFJd5V/mG9W0OTHLzSxf30TjLIjL99DJWlSJixxCaQFNlRXkYUtzHzVnAHD4
         3+1YNuICUU54NmyoZRYBwSLYigIteToJ6dJZRuxQzeJVjg5I2HeL7EEtYrBstWOUuj2s
         AzDXCBkqC+1kgB0ugMMpfx8HcWKXKJDFwv6RKYh0aCvKaHrvNOUceA4xvbFmnCzDzyxg
         W4U6jofeqc4l6OnXW9VOMNHnyi0PzmXeLUxV2ioFQoGRxBaBK5OIXkpGjQQzS+1M3d36
         RHShxBNJCPGxwHLd4ISQQoN8wPvpHcKDTEajmn9FFxKmzm5nnBXI98/XxH9in/vPZWkt
         dCzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790134526; x=1790739326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XYEEoMGteHxFV1awOkLk45oTIa6yiwyLCwRO6PLmYiQ=;
        b=cCqknjAhHY7uGg8YfgJS23lyStKf/VDDOkxl05oAKXwP/iMFEbV/90ajZUPwRgGX1y
         O2bm2ivicfv7G3YtzOqCODZvopzKNJ5gRUhq++g9Romu7tlZZQI1fVkqyCJnT1coL9qj
         8EVcVFfDij2BFa0mwSvoi/o3Jihg5fnqQkOXBNGrwmNtj8mFpXEc9yIsSTeojCBS7rC2
         plDdLuVPA6jHula1CkoU0CsCrKvBJ2bzwfGZ2IgwEdq1KhdHAoE9kb+KJGJQMEwchAZU
         fq2llQiQ6UZG3XN+P5Ak/sf8IFaq20uNpqUmaKbhqdk7kOlaZvIQdhJ9KQ1uXLZkluke
         rF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790134526; x=1790739326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XYEEoMGteHxFV1awOkLk45oTIa6yiwyLCwRO6PLmYiQ=;
        b=uwwqHSB/Q8/DDCi8jOjTR+OUfiWpoJG5tT+L8/d+hxWYh1hACvR8hKcG6MS1pFMSA6
         I5AF7YIJDOu3gD+TAEe7IQiWM1pwJW9VEq7G7HxdQtEe2d9o3GbuF2x8BPB9pd6BLxXJ
         zKnqVokE4qlJ8sYKg3s8INc4xkIBdFlcfXUgdPIJFM9JCzEN53eIrGNOWgIVX+psKAPH
         OeNfoK/VT8WjX58peQ4on0P8C1pvUmLd3zMwV1Js/m6v2XX4u1bFANEuXQhPtbiuusYz
         QeiQ6hUePJEGiKrgUJfFN2J2r6mpE6A0xRjyWHXG0jAUalfcnPP5NrnT4jEuEPSWbn+h
         FbNA==
X-Gm-Message-State: AFuF++nydMFZiMy/BXrep3TpAsFCXDfMf8qs6slZxg7lnjTxaH9aJzgE
	oc1tCeWcfbWnHTnpG7ir7OGvE4WZpb6T0yVIM4el54lqmF4gC2uIpbEctRpXhJv16bcEH19UE3p
	hZcWR7Esg4OpsV2NI2oyMQ5BPoz83fJk=
X-Gm-Gg: AYBFou2gcfuhB+ZlcPZvS6SvrXOLQSs0Wuakd4i8O+Lw/nZ/IdyoTYhCJ1E6ZIXkOrS
	97uEUR2uesV0LgDl0IDQE1JStYy3brdOg8ygd2jN0CRPTTej/w3uwlmBXJgG5pQsN0PI9Aca0e5
	HFbZ7mkjLs/gvKS5m1etz4JRPBKAONcwUdf+V9IzieZYVjDoPyvENz6mtmq+4cl6MRbW0iV3NPp
	YYC+7K62isjLxplONfngS9ixzz5UD7m9AatqojN8j+OzQUISX5FZeHk7arJdKMNFDE3gP8ezDym
	K2RDkZpDB7tkVDMKIqjqfHCl/zcEsMSS2Ym3zMmNlXkF1cWc41aPIoYrNHcqslEOw8ncHUbV7XN
	F43oB43KY8A9uWTvAL6q9JXxCJ7MqHqb9t+w/dX4p6q8=
X-Received: by 2002:a05:690c:a694:b0:89a:63da:fa98 with SMTP id
 00721157ae682-8a45bd920eemr4667137b3.83.1790134526646; Tue, 22 Sep 2026
 20:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809045946.15638-1-kartikey406@gmail.com>
In-Reply-To: <20260809045946.15638-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 23 Sep 2026 09:05:15 +0530
X-Gm-Features: AcwNN1Vk4FtYBJd1sRBl8b5Y953BCfjbdBpM-mBy7PTV6woNSctxmWWAgsZFKB8
Message-ID: <CADhLXY7008e4JA35T2wE8TnJnR_r82RCpfSd=aLBmDh5xAQ02A@mail.gmail.com>
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
Please let me know the status of this patch.

Thanks

Deepanshu
