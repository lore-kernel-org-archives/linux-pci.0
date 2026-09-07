Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC951354E
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797158; cv=none; b=fi472o2bLXWicpGaMwk3/1kly+h2HpiFtXp7juN8/doKwlZYVDWVJGfWM87G3Ry5YiOn4vwRfQxMXzjSZ1jLXWNyfNkZVbzx9fj6hw2KZd5FK5jxzkyNf8xO0RbROt07uDx5O5rUFeDsNF1pArqVEuNYytXkDv0J8qTU8hv5/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797158; c=relaxed/simple;
	bh=hU7eRYQ2L+6W3KSv4c0PzkTILRIgPmu556oNrVZACTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkYcQ83442REmFjR4aXDb9k+EA21ar4kXDcXipYFo8aQzsiz5bwvild9LrzKI4Auk6KiAA0XAxBCahGofbRWvxSg27TckMOoYFd6VLPy22lNrEf5t7ZjkTGBakVmISxNHt8GGCH2qFl+J6K+dJfBX0k7Bfg3SsUumJYZkEnUiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c7afda4515so2154802e0c.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 09:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788797153; x=1789401953;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9kwN9YV2UIWR9vTDW/+7DxPdDKrz03iqFaixNrlJ+1U=;
        b=OlxPDHtg14TGSruujjNmuJmGCguH+KLteBy8Mli7HcbraTmtY2TY2G4B9ls8Q0RQcH
         L0ssutrd4ClIj2JQK5VueWwrCNLu7xfn1736fDOiSWR3wonWtNkwS1nZByOWnGhnacFm
         lw1Um0qFINjsR0+nB27b0tKkwaNdpPd2tdeD2cdWtcNVkgI7GE+Q3FynapAZjwa4JgEs
         3Fo/8VGVbFU1xbACPcbxKmNjoaUhdNfuzkNQy4qfL73J6sj58OWMo+cDYk9UDoOHaFUQ
         GZCHd8h2WPTZkMfsA8ILSKHGIOiUH8HAG7Ct6O+qmVsO7GZnOzR/VrJUgvDgUn1rKQ6y
         Jf5w==
X-Gm-Message-State: AFuF++le3jJB9LTVxCvH+AIi/cW30xlhrpvn+FVwYAT5VS/WG95/QuXm
	g3TAxM3py50/onHIn9JqXYvpImBW3/IRhOpG0JZdG1EVSa/zKobQbLsDOLjEFdNs
X-Gm-Gg: AYBFou2No0xKzPPgciDi8ZPP4GQtgWUPCZORq5a55OppKiw1BAd/C8u/8IC6JbRrsX4
	x4AlPb1OeRuLZVZymuSuDV1z2TKYz1hIqP4R9ZZ85ZQs1wXJcgVw+oHyaif+ZlEUGsCPXUjHOIV
	zEmUOBkWyj2TiLadShKuOfiN5DPZjI5bVPT6USdN9GvYIY7vae4+kzZk6y6H5yA2LkIssoGhcrm
	d+qX4q4MbxGHAt9QiB2JG9nhpglOjyz2bR6wJxzcy23koQV0NYX7XQncBAqmKmShYizjwlWOerF
	TcFjtbBn2rywpeudKlow1zu7+Jxr1LaJWC/oE4YlpsKEdr/Kkjzp0RRJAhSEOgptd79e0FfREqs
	17b3DxCB18LAGNPXpzyAYam5YZgoSOi1CbOrB1TNAENdSWwT72lq1FqwyN+7CGt8j7a0HyOZOgU
	Ksh4JIeitSIPZ7Y8yuLp/U0B+dk7qvY+QBcdV0acjOHa3O61/5GmSLp8epbwlRgZchIH1QQXDvf
	PTXMaTWCcTQrzOokwYwnhk1o43enA==
X-Received: by 2002:a05:6122:4f82:b0:5c2:ac92:eb18 with SMTP id 71dfb90a1353d-5c7ed3f6d2bmr6283845e0c.7.1788797153069;
        Mon, 07 Sep 2026 09:05:53 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee1c0cdsm7608151241.8.2026.09.07.09.05.52
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 09:05:52 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c7afda4515so2154793e0c.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 09:05:52 -0700 (PDT)
X-Received: by 2002:a05:6123:67:b0:5bf:b500:c4f4 with SMTP id
 71dfb90a1353d-5c7ed285aefmr10980239e0c.2.1788797151556; Mon, 07 Sep 2026
 09:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907153711.653861-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260907153711.653861-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Sep 2026 18:05:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUxPf41iwq15WSMqWiTgi9XM3CXJeH_-e+FS0T3kDMz3Q@mail.gmail.com>
X-Gm-Features: AcwNN1Wm8DHsL2a0zy-uAEM1hkCTVJZKfNb68aES8fX2T4VBPEpycd5vofPPqGA
Message-ID: <CAMuHMdUxPf41iwq15WSMqWiTgi9XM3CXJeH_-e+FS0T3kDMz3Q@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: rcar-gen4: Add missing PM ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Koichiro Den <den@valinux.co.jp>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Sept 2026 at 17:37, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The R-Car Gen4 PCIe controller is part of a power domain. On R-Car S4
> and V4H, this is an always-on power domain which is not shut down in
> suspend. On R-Car V4M, this is a dedicated A2PCIPHY power domain,
> which is shut down during suspend, and the controller loses state,
> which prevents the PCIe from working after resume.
>
> Fix this by adding generic suspend/resume noirq ops for the controller,
> which tear the link down on suspend, and restart it on resume. Use the
> same PM ops on all of R-Car Gen4 to gracefully suspend and resume the
> PCIe link on V4H and S4 too.
>
> Test case which demonstrates the problem on R-Car V4M:
> "
> $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/pre
> $ echo s2idle > /sys/power/mem_sleep
> $ echo platform > /sys/power/pm_test
> $ echo mem > /sys/power/state
> $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/post
> $ diff -Naru /tmp/pre /tmp/post
> ...
> -00000000  12 19 32 00 07 05 10 00  00 00 04 06 00 00 01 00
> +00000000  12 19 32 00 07 05 10 00  00 00 00 ff 00 00 80 00
>                                           ^^^^^
>                                     Class 0604->00ff
> "
>
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> V2: - Add TB from Geert for RC mode
>     - Use pm_sleep_ptr()
>     - Call HOST suspend/resume ops only in case the controller is in RC mode

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
