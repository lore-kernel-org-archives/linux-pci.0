Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6434FF45
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841688; cv=none; b=qtqOeSQzrMiaH3yBjD2K8m6HKFaghscU4aEQgqz7PIKw2tBinTRjbBIuteio8m7UKXM8PN2xzLF+5fEy8v09v3xB0tX0nqwgxdbpuFoA3eZmG59EUGfjXKAhGZITH8YB+6MG/mGlZVm9Buq6sa/8/Ns3hTnyfBMWwvx960PXmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841688; c=relaxed/simple;
	bh=qmklrboQIpSfdlDZ2hHPRPuP8NQIz98sLqpsBfIp1xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpoTaz9DfwcL9rWjx2E73PRXXhugJipo4SHlvnVCzoFTDJ29ax9a8HhSb7HIZ27IEgCBf1VB4hBIlDoWjdVCe+I+yu9MXw/vgLY+G2fAeGkT9XoEthjM3wQSdchlQ755bcL+TisqDPuBkmcHap6broj0hejAlha1w9wbHqFCr/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5663724e4daso4086306e0c.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 02:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841686; x=1772446486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYufON41haCPAAlB17VyKfqSryTL2wR1KeTBsoMTWuQ=;
        b=Gwb4AyvCOfQ4Cj5UIWCPaDY8veXpGTSkPKHVexswAAWOg6adc9Gb+YtpB1372NC1V4
         b5el1oW3rn+3F8hSXhsK0vNE8P0Bg0GUndBX94WYFYO7Bhd69qpbPScd08AL4REgKsmT
         hbLNlZvkl5TSXyOOTtonSWOM49+9tf2paq6gabhVOoKPuizAjZF2y122hQikeeSppvGB
         asAnG/7dMmTbR9VC97TCKb9uRsPMEakVrPf/ugZF2XnIjpt//tpld+17xf2/YN10Xzj2
         EModKyjch9T9xj36McILWSLP9rnMdhSfqkuPmsznd+hqqNMszd2JhbMm72H8xVs/QViN
         /AxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF2Cwv/P+KB4GuEgE6MxMY/1A8sPahAyTxFbC8LlKulWUNv7KvjMS54icRRZZW5e6VKcQ3MZX1/Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9J2iedUg1vJlCpDWu87NIZCNicJbiNMVlF+Ttsoaw+JVdCsej
	taXSVHgTI+zhvq2NnBaX1b05qItto58HuW2nBAJHUxlkEapYYwJkrmv46DangHs9
X-Gm-Gg: AZuq6aLnXpxqWQaMtVQ2o0yq6Mn9o3NlGSF4gWmyR/Cq/nJ0msmrSP20nDEMufwcuJp
	wdWNku49ULwNAzibQ+xx36LEFM0oeej8v76CAqGb5nclCUlzXCMB4MKeY7eINpDAfyyPNcTmh34
	9dH4iauGVRu1xjSjXnOrqNWrLOkKnxWZAfkGk9Ms0rCGhIYApII/tJ44Ekcs9iG5QWVtSoJIu8w
	VA2UdcQ2g/v5yeLfeTS1LUcUDc9Tmf8hHgrsnp9uvwKIStCRJpk5VL43HcvskNfghKKYmIe+lhx
	y5Jeq9yqFPNFjGusQ+P9P2DJJbw+H1oiltxyO9eh8oAa7MHG7olVlNdhr6noXdowyDECZG74S4r
	We2tZ8CCb7LfEXjzz8bSkXjvHb9/bjiVzGdX9gVAloSbs5el3vfJ7iIFQ3nLZ4HsHsdDJHWDdNg
	Np1GK2GbZG9HkUFlK7r4eKsxSE99iOTNzl8+Kbw54kc0Ie8QS4nDlFm3YHQl0qHQoD
X-Received: by 2002:a05:6122:1d0f:b0:537:3e57:6bdc with SMTP id 71dfb90a1353d-568e48681efmr3428059e0c.12.1771841686411;
        Mon, 23 Feb 2026 02:14:46 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-568e57d42fbsm8036995e0c.6.2026.02.23.02.14.45
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 02:14:45 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56739adfa1aso3049786e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 02:14:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVffOCQFffrPQcxdMnByshjRKdSBqFVcolMV1rcXCGZrNygR6MBnwxXv/H/38GDqHMJvdoKxJi/RwM=@vger.kernel.org
X-Received: by 2002:a05:6102:38d3:b0:5fd:8175:2eb7 with SMTP id
 ada2fe7eead31-5feb30db471mr4509289137.34.1771841684922; Mon, 23 Feb 2026
 02:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217212707.2450423-11-cassel@kernel.org> <20260217212707.2450423-12-cassel@kernel.org>
 <aZTkLiUaMTC7H1kB@lizhi-Precision-Tower-5810> <81af7f88-b9c1-457f-9a21-a7b15a13d374@nvidia.com>
In-Reply-To: <81af7f88-b9c1-457f-9a21-a7b15a13d374@nvidia.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Feb 2026 11:14:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVTY=tV_3qq3gDuAHPjXnexT0Qq9SK39V-U2ACbvLRsaw@mail.gmail.com>
X-Gm-Features: AaiRm52HvurLndDwor1bgpbfCcI9wH1Ckd1tYC4oQp0RsW6za3e41CkVlZ_fe6s
Message-ID: <CAMuHMdVTY=tV_3qq3gDuAHPjXnexT0Qq9SK39V-U2ACbvLRsaw@mail.gmail.com>
Subject: Re: [PATCH 1/9] PCI: endpoint: Introduce pci_epc_bar_type BAR_64BIT_UPPER
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Frank Li <Frank.li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Srikanth Thokala <srikanth.thokala@intel.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Koichiro Den <den@valinux.co.jp>, 
	Damien Le Moal <dlemoal@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Manikanta,

On Mon, 23 Feb 2026 at 04:57, Manikanta Maddireddy
<mmaddireddy@nvidia.com> wrote:
> On 18/02/26 3:27 am, Frank Li wrote:
>
> On Tue, Feb 17, 2026 at 10:27:07PM +0100, Niklas Cassel wrote:
>
> Add a pci_epc_bar_type BAR_64BIT_UPPER to more clearly differentiate
> BAR_64BIT_UPPER from BAR_RESERVED.
>
> This BAR type will only be used for a BAR following a "only_64bit" BAR.
>
> This makes the BAR description more clear, and the reader does no longer
> need to check the BAR type for the preceding BAR to know how to interpret
> the BAR type.
>
> No functional changes.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Tested by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

[...]

Please do not send HTML emails to the list, as they are rejected.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
