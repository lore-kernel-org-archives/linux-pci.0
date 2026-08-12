Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4332143D
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565690; cv=pass; b=BiLGaVbZnIZiVlVE7JX6CDW35nFBRPKgbDN+wy/Tr9QVarDhtHlWbqGIIdsG5QAzWnK5iS9YatPlLzjYretKGd01bOgRHqwKfji9WtkHO7zf+bRBGX7iVRcsf4wlYgKduI2dOPrma8HOSLm4Ze4WAZIgPMj54QFn12PPHD8wPCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565690; c=relaxed/simple;
	bh=DQUvyR0Oz2x4Ewro9s+b9fncoRmV+lm+5XVYzxnBkVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZzGotm/+YD+lwhmlKZw46tZLCLdMzrqImPOSQUnbev+BUVvZShqIwVw+6JE31Rblbwgf2Ph5RYM/hAhFkvpYXtHIGaCFQx981q5dboz0cPj0NF/xqq3MLNrdymZGHLmDbHJEKbXVZKXtwrBjmpVslE4oBNWPwD0ZfSWgaWnZCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyezPtX4; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyezPtX4"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9034b6b7674so10960926d6.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 13:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786565688; cv=none;
        d=google.com; s=arc-20260327;
        b=BLu7D1xPB8Dy6jN+5ymVFZVPbxB3wfg5CsJTkrm9vXoeQOOqhRpFs3hgoxYAUri1cz
         G9+tugqNipHtIpzkX+YNhfkeWyLCdEpKVDPa6+PNrfI8UZySSSQeKv1Iz5bO5vK4zZuN
         DZyu4GjnyiW0RjpOlAmfU1lE5qQVVljpUqVRKJu0fZ/dRh1bgSWKaBDBSN8qYGmFN436
         t4rkIoMe3o1CyTyHiV3pUSga1dE4/PBFOiSMWMTbxN2NGCTaok5p5MpF92OiF6FKIlnD
         17txVL1nZWGzjTsMapNwswZ4lp44hpOZIVY+ks/sOU96w+WuW1UUKje5Ak9WyDvSIHyw
         a5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e2oXo74f4C4pEmdYOv5bRF7Wqg/UzQG8X0qTzBl4Rmw=;
        fh=toVojAYer0Ty2+/nFsoZMGLxXT1vQXcOKYHGJoNV6WE=;
        b=ny9ruapayBS6fLWg1BLlZVj0Ku4klEYIECBHycm5e4LrJUpo0lo1S5XKX6eyOyuJpQ
         H45qsqohXEtravJJFyJeyVGcoEqsqAOVSjXmU8siu1xU/P/0LeAzES/rKp9PMFRktAhr
         M1gwSzKaN08igrAZTh9Dyv++wt7dUCibKW9ChdLD4CBv0lAftYG1fvrtjITOE8Ri4fGn
         kg/frGNKpLUWs4Ei0aa6/yFatP3Fn3sImk1ihx93aKIwIJBfBwvN7HOXWOAjLMstrxNc
         gJWs3pY4TqEk0GdzOl7J/sPqnfqieIgMv+iG7a1TLWdFMh78jeJ2x6fdqXW/Hn4Nw6zT
         9G6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786565688; x=1787170488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e2oXo74f4C4pEmdYOv5bRF7Wqg/UzQG8X0qTzBl4Rmw=;
        b=OyezPtX4ilw5m9idl1lzKjl5o0uhXnBE69HZH1jc6AN39IgnGhvyEPi0jJOhghIC97
         CMOuJ31VdDIerf1WlClujCPjRmq2IMDPR+FtqkuHUS+Vs8LJqM+o2qZSWpno5uq/trYm
         zrhUh1DQuQ+0w9wmzBcpodpF/Y8KtBN5x1b7YPC1Vh4oEqnYRK8Dqa4Ii5oHKreLh7wB
         TL5skmrgEklFyv1TVH0Jsbm9C3budr9Mi/DJdZkJJjYvPndktovuVT98R+eqMuuPLIQT
         Rr+udS8qqJkT0j12vBKxLegxkSLvITiCqH6MpMh8OFD93J6kOOMbotXsij05E9yBcsln
         zTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786565688; x=1787170488;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2oXo74f4C4pEmdYOv5bRF7Wqg/UzQG8X0qTzBl4Rmw=;
        b=PD5pIjxtthzxxPPFI8Dyam8LedpdLIMkSczn03b3SPAT+Gl1h3o9Q0KKCF0gWX7alR
         o5tCH6QIcCrvsrgsIwWGdQsiae0/f08cPimx5KkWpxvNzaeuK9kGHlBnn/gK1AbZjaT/
         EK/rwTwlX6njpBD7MYph9giwbbA7pBvozIo2lQg0ePTSoa6iXpqwPdE8waSalP5tAImF
         UD+8KbMCPUKifDFmofaqJrtAKNlupwcQrBSMAiHQxEFy1mRnRO9If3m2ZSd1exvXtttG
         8WVvDw11cURwIet4FB++FDJMGr7+K7gVrgToXFm6oPtyxhtta6q8lnbK8veK1hFyPOwu
         A5CA==
X-Forwarded-Encrypted: i=1; AHgh+RrYfMd4jXFHPF6Kbk6LPca/Ww5dX821DxnChdLKBbd/vS7BV/ualgsPMqSLH/r1I1+5qAV827kfYHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKzkAAK1u7wlE8qIkMZX0C2PO8h2EOcSQKS7p0o61/MMz/6Obf
	XaRTtL6dHKwLjmRe1BJ4DC2ta2Nbk4pw7wnH0zJ5vuouQM4yea9pGIKzoWzjRynh/borI+0PWXJ
	RXJh2GQzLNW+XcpHIpWj8E3FlxaM6ay8xLg==
X-Gm-Gg: AR+sD103DYS2IdCBwTL0Ilb33nwgtkr3LawVfTK0mKuO1ycIHTAmNK7xTJnZdIDArAW
	vKG1zi5KgpNpRwTpsz70OjC7g3dyjUDePXAaA7qSBkhGrCK8x75dIX6TQH2eSiLDRuVu3+pOHFz
	+JqH3jTjdvZ2SfEawJKzLwlbylPH2p21siNaJ9UZUXuzIXF6Oz0hA3OFjXYf3oGiQmlT9Gm51Dl
	GBnVD8d0WJQILTBv/hkNL/TfzPEV1NmMPDVwbuL8+Wp72uipqCnfL1cgzPPVq5ZL71lsnARgYgi
	3LBuATkFy84AYz8XE7uFq6YHojPhv7Yn190FFi2gpi6i
X-Received: by 2002:a05:6214:4017:b0:8cc:de2:3b5d with SMTP id
 6a1803df08f44-90a80bcf54fmr3367416d6.16.1786565687806; Wed, 12 Aug 2026
 13:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
 <anWdGzfD7HxglsOB@wunner.de> <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com>
 <anbl6j9DWiyVQLqS@wunner.de> <CAFqHKT=ZzWRdnNCixY5BeLsVE2JUhfmPSNnpw5TFjzu76AocrA@mail.gmail.com>
 <angci4oGyGFtvbSQ@wunner.de> <CAFqHKTkTYtu7U39W7epZptPWBBC0fQyfA-5mOBTi4RTA1Bb1WA@mail.gmail.com>
 <anqw0M6cQLEA0J6d@wunner.de> <anrkXZyFfPDwstin@wunner.de> <any3vMJMpxdK8Ekp@wunner.de>
In-Reply-To: <any3vMJMpxdK8Ekp@wunner.de>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Wed, 12 Aug 2026 13:14:36 -0700
X-Gm-Features: AUfX_mxY5w2xZHaKpajOw3frnRH0LSJdvf_2Eyi8UEqZZ7B7xyieidRjX7E6374
Message-ID: <CAFqHKT=X9gR2_NVmdFJz7SEgu3LutmYTQZ1CQKmKC9aOgTKwKQ@mail.gmail.com>
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:13=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> On Tue, Aug 11, 2026 at 10:59:09AM +0200, Lukas Wunner wrote:
> > So the completely untested patch below might be an upstreamable approac=
h.
>
> Sorry, I was OOO for a day and sent out the patch without compile-testing
> right before hitting the road.  I'm back now and it turns out that
> an #include statement was mising.  Rectified patch below.
>
No problem. Thanks for catching it after. I only got around to testing
today. It works well.

Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>

Thanks,
Derek

> -- >8 --
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 0274e8d07660..1a82233a30d0 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2978,8 +2978,11 @@ static int mmc_blk_alloc_parts(struct mmc_card *ca=
rd, struct mmc_blk_data *md)
>         return 0;
>  }
>
> -static void mmc_blk_remove_req(struct mmc_blk_data *md)
> +static void mmc_blk_remove_req(struct mmc_card *card, struct mmc_blk_dat=
a *md)
>  {
> +       if (mmc_card_removed(card))
> +               blk_mark_disk_dead(md->disk);
> +
>         /*
>          * Flush remaining requests and free queues. It is freeing the qu=
eue
>          * that stops new requests from being accepted.
> @@ -3006,7 +3009,7 @@ static void mmc_blk_remove_parts(struct mmc_card *c=
ard,
>         list_for_each_safe(pos, q, &md->part) {
>                 part_md =3D list_entry(pos, struct mmc_blk_data, part);
>                 list_del(pos);
> -               mmc_blk_remove_req(part_md);
> +               mmc_blk_remove_req(card, part_md);
>         }
>  }
>
> @@ -3252,7 +3255,7 @@ static int mmc_blk_probe(struct mmc_card *card)
>
>  out:
>         mmc_blk_remove_parts(card, md);
> -       mmc_blk_remove_req(md);
> +       mmc_blk_remove_req(card, md);
>  out_free:
>         destroy_workqueue(card->complete_wq);
>         return ret;
> @@ -3273,7 +3276,7 @@ static void mmc_blk_remove(struct mmc_card *card)
>         if (!mmc_card_sd_combo(card))
>                 pm_runtime_disable(&card->dev);
>         pm_runtime_put_noidle(&card->dev);
> -       mmc_blk_remove_req(md);
> +       mmc_blk_remove_req(card, md);
>         destroy_workqueue(card->complete_wq);
>  }
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index b7ce3137d452..2625d918081b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -22,6 +22,7 @@
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/slot-gpio.h>
>
> +#include "card.h"
>  #include "core.h"
>  #include "crypto.h"
>  #include "host.h"
> @@ -703,3 +704,17 @@ void mmc_free_host(struct mmc_host *host)
>  }
>
>  EXPORT_SYMBOL(mmc_free_host);
> +
> +/**
> + *     mmc_host_set_removed - declare host removed
> + *     @host: mmc host
> + *
> + *     Declare the host (and any inserted card) removed and inaccessible=
.
> + */
> +void mmc_host_set_removed(struct mmc_host *host)
> +{
> +       if (host->card)
> +               mmc_card_set_removed(host->card);
> +}
> +
> +EXPORT_SYMBOL(mmc_host_set_removed);
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pc=
i_sdmmc.c
> index 8dfbc62f165b..3f97659fba7c 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1511,6 +1511,9 @@ static void rtsx_pci_sdmmc_drv_remove(struct platfo=
rm_device *pdev)
>         pcr->slots[RTSX_SD_CARD].card_event =3D NULL;
>         mmc =3D host->mmc;
>
> +       if (pci_dev_is_disconnected(pcr->pci))
> +               mmc_host_set_removed(mmc);
> +
>         cancel_work_sync(&host->work);
>
>         mutex_lock(&host->host_mutex);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba84f02c2a10..a2403062d770 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -588,6 +588,7 @@ struct mmc_host *devm_mmc_alloc_host(struct device *d=
ev, int extra);
>  int mmc_add_host(struct mmc_host *);
>  void mmc_remove_host(struct mmc_host *);
>  void mmc_free_host(struct mmc_host *);
> +void mmc_host_set_removed(struct mmc_host *host);
>  void mmc_of_parse_clk_phase(struct device *dev,
>                             struct mmc_clk_phase_map *map);
>  int mmc_of_parse(struct mmc_host *host);
