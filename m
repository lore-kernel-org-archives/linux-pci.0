Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513EF3C13E9
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269270; cv=none; b=cjoJEcbJqJh7L4v8A0rL/ZSFFLqA55Aj/mgwWiXw/LGr0fch0rKt1Sr5mfRUONcY/6EUBSaVElB3Gz5B9gKgstMTcjBwMHH1jL/3tlVTrnH8euzYNYN75mlqQRb4ssfPuQmItqCy5O5Ypi9FRsqzUFqoR8AeqfrBBCkhe2gjR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269270; c=relaxed/simple;
	bh=cqcKGoxGxtGWXpqUGB19b7cxo39gytYLyy/dKTEdc5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WU1LvDGhEBPRdtYY2QLVYgY01HVNs8Miy4C9YnTj8sHia2SOkhzmj+nNn0+GI1krVLeRUHsKhiTA1xsWOAalulOK9XMH5TwrhyTwSW6z2ofNo0GLXv8BAowK5OAy6GHqOjbikh0mK5tFQ9WFqfHANxFLh4sWFtuokKx4cBBTeuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so87054946d6.2
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 02:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779269262; x=1779874062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSg8CcmcyzhUpjDW73nfoHFxPOMVgUx5GEZqNXk4ccg=;
        b=HVSDYAkB8A+BgIw3Z2pQIDkj187mVD5zogSQz1ru7vUB0AT0wDu+MAy0g3ZZeXPxIM
         mzJ+tz99C0UJNsSgRBwhUL+cSyNlKsWEjDFJeNv+nFjE/BogkNV7kRUG0N2baTRTXdxj
         +JlJj+7+fUbgiHne/K4pHv6kbxnoXz4jAgnfiS2vzsPlXfl6OyOEgJTb6nw8wCjimXuB
         kzig0W1IKIaVdJjT8LpU8LStTxWgLZTnG3CxKf/pR0wddxlkhNQhzdNJT6+XdRo3jVyo
         /fIWYHY0BWoh0JkOO2oiDLyTuNsmGphimOhiZ9tv4EmK653empu7axfJT/JswCaX8pFW
         5QEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cYbxQAgefQ472SM76UMTfwaozN1xs77GmdV+lvYC0SxUCyuPRlN9Z0OmWgZJo7X4a6Uc1TusjaiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8RgMrwuQF4UkhMdnowemrGyr38UmlLQSwiUBl5YKrYTZsNuG1
	GjVnVSlo6XxA4mXwAdUp2IeSQj23HWdvVuPvlNZZkIPlwVlbl1lSqGpOlXtaGCDiuhw=
X-Gm-Gg: Acq92OH5aasTnnNUMjxE0KzCfRrzXk/dgdiq85PHhKTiE4sPST2pZoy6iQIaz9G75Dn
	zYFS/ZC0VfNGpLuPQfH19FqoNkd2UXssiU55EQoUVicGp+VBYzatkvGCyalipq1fSBNiTj35mIN
	X6hPWSPGqt1YwqFr3mZpfTEsB/5+KfZxCWhpSTJyZpioFSkwxJ8z8OYC2JmIUJtu+NQo/0SVEyN
	bhRCnZMdUrA6bu5vuDQsHxIBfo5y+W4SwvEPJV2qfFIaJSdrFD3OxDUGycAYpu0RIM8FlEJAkHt
	ZkCcjjsO5+0xWsVU7hKsp5GrJA8shcbW1krdkZrY5YR/vvPmcH5TfoztNeObTSPSGvh074AnBoS
	23DVuyyvqr7Lx84uLEYyqcQFaJfiITNwXluu/xZAc3eelwTS3YTb5gU2Bj4UuCXtaMBqecfBafj
	8du2/yl6pn6mwv431pcjBxLn0PBLEjZViz9q68jyjpR/LdXB1Q7CwKD145UcKv
X-Received: by 2002:a0c:f010:0:b0:899:efbf:9292 with SMTP id 6a1803df08f44-8ca0f6ddb66mr333428186d6.43.1779269262303;
        Wed, 20 May 2026 02:27:42 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3619a384sm117601456d6.35.2026.05.20.02.27.41
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 02:27:41 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso81367046d6.3
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 02:27:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8v9p43VhvIf5weGMmCU1Vk1dDL8IUY7zeK04YBdN2mJdJNwNI7GiYv9GoVs9pAKGmScenhb/h04TQ=@vger.kernel.org
X-Received: by 2002:a05:6102:3e1a:b0:631:28c1:154e with SMTP id
 ada2fe7eead31-63a3ea83841mr14744535137.16.1779268834569; Wed, 20 May 2026
 02:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520091111.67666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260520091111.67666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 May 2026 11:20:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUpa_R0C70eJjS6urpSx3jtcVnbjZ8K0OvhO25Bx1-u4g@mail.gmail.com>
X-Gm-Features: AVHnY4KsTghlnywZI5vA1H9Z8FXzfT5cshnAIjblbGSvrCdV0vTaYH8EOrOdrQA
Message-ID: <CAMuHMdUpa_R0C70eJjS6urpSx3jtcVnbjZ8K0OvhO25Bx1-u4g@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-host: Remove unused LIST_HEAD(res)
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Wed, 20 May 2026 at 11:11, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Remove the unused LIST_HEAD(res) declaration from
> rcar_pcie_hw_enable().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -346,7 +346,6 @@ static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
>         struct rcar_pcie *pcie = &host->pcie;
>         struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
>         struct resource_entry *win;
> -       LIST_HEAD(res);
>         int i = 0;
>
>         /* Try setting 5 GT/s link speed */

Indeed, this was never used since its introduction in commit
ce351636c67f75a9 ("PCI: rcar: Add suspend/resume").

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Since this does not seem to cause a warning, even with W=2 (TBH,
I had expected some shadowing warning), no Fixes-tag is needed?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
