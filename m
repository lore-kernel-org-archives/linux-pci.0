Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51B27B352
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177862; cv=none; b=Z2X8G2tveJj+1N5zoSNNgB9jZD85V0JL7BpczWUpxYR0hpHfMsVeBOkE0qyv1GiMcLJqHpWctN2WCGrT9MSGnTsZc1/Gfg3LfmoPfZS4JDV2gsy1SmVQkhhGu3pqgjBISmlIgSzLnxqbQq8MmkzgmnJTjEzNzO3gD5/91sKuCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177862; c=relaxed/simple;
	bh=r9HsTXgn1GaeqU1gNHwX8oVvaVI1l0Q1W0dpN3P42O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQZsMs51ipWo/NFa5q8eZZ9IWx98ihR6f9n3EiIRlRjpSKggFAGYwTO/58ASUf7Kh+PThbtU3wsy6TETezYKqH6MKDHsJBhyjnvCdbnkEzmQVIwUedjI78qnHKZXRlOOFiedxG7kQR0fanGJszxHrPEzrdTpieeJsBxuTtxcZ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5663601fe8bso1778400e0c.1
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 06:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769177860; x=1769782660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLnfjU65RvqkFmzX5x5XUooORBFON/JkVFQYLPFc2VI=;
        b=HXcCWFSNiE29CVHNRdh0WG6dZicXeOy6JgJKrUoxFgpvrYBeCkjMSwukX9TUA793nN
         dkUIluXtt4zrocUZsbCKSJLp7JKwkg4siE/hoV5ucKZdmCEtCv4Q9L1dYMHJoWAYcxgv
         kepOvFbnctNSCaQxvlqtnrh7pmSf0/ZFL3FmZsGezTojUg7HLtMhC7Ya5GtBL87RGyS+
         kiChvuljACTYqx/A/0VYUY73mKngO7Tfe9NQleCUsvg7HCOjSoXfn5Ohrx4PxBimqpzS
         vqUjogEDaP3r38SCJkpvA/JagR4bAP0YS/YJ7O10xXTRfeTFEpJqzdmkKHCDGKGpRtMN
         8yMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB3mg7XTVw0VAskUH4TEz0TPeMT1gsqtEEXLUpfbfW0KCIloKh6FJJ5+R6OcRXUWu8NDSFPpekYes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYgNxYyhfMGEw0n7FbRj+RIHT9luUHgYTMu7bJSuelUqM0nec0
	sUSfLwjWBjMb4ZHJgilq0nZA/jRKamJqd9PuxWYuAGLoQ13bif+H0F6sZiL5QGaW
X-Gm-Gg: AZuq6aIMsrnlZosNMRz/NZ9sXRhlMA+uZfgvLi4yV4WdDtLhrDU8TL5ZI/KamBYaJu8
	eGgm8uCG5f7+8zNdZ4H2NFs3dXjcIwdY4JJIi93SruDPZXDxl3F/qU8LNXz4A2bhOj7LaNk82Gn
	HlyXnyd61sOLSqD/XZ5j01Ebup7GJV2YMveHD1+AJyPmp/MGvVGWb9Jai9GJEYX88hIjSLcr/Hk
	7xI2Ksp+h/jmtFKTNY+6isNKGmjfX5RTjNtmh2XYZAuuiezf0VKmj+LxKNcyXb8VpOFTqsptHoU
	nX00acWhMZWms4j/uKrxCMHw8GlbqLSbmCG/XQ6GtaF421XkBO09BRnf19n3RXNThHm9eKiY2YM
	OQP6zC1gjeTMaHNwOZz5vLFDqo8JkTWdJFJTuR/tppGX1SZDHwE9aFJT3B/3gYTdsTDcru74lkd
	qFk4ot7gwoRwkPzxfng5gOV2yNUbXfz3yByh25A9ZUJ5xbjhx0EV1q
X-Received: by 2002:a05:6122:1799:b0:54a:992c:815e with SMTP id 71dfb90a1353d-5663eaa47acmr835252e0c.8.1769177860262;
        Fri, 23 Jan 2026 06:17:40 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5663fa82a3dsm503862e0c.8.2026.01.23.06.17.39
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 06:17:39 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5663601fe8bso1778382e0c.1
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 06:17:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfV20V1qblbtiMqkI7HdSIhFYdoU90EKSql1PG2FOgU6YWzt8YyOBAy04A/sREsg1Srk+sR8PZ/TY=@vger.kernel.org
X-Received: by 2002:a05:6102:3f0f:b0:5db:1fbc:4462 with SMTP id
 ada2fe7eead31-5f54bcc01d2mr1080831137.31.1769177859213; Fri, 23 Jan 2026
 06:17:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123140031.94752-1-john.madieu.xa@bp.renesas.com> <20260123140031.94752-6-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260123140031.94752-6-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Jan 2026 15:17:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWxNbJaDhpOsJRCkDWvqqu4e63Z+cMRndFA6F+McdbuRg@mail.gmail.com>
X-Gm-Features: AZwV_QiB25G7U1c5HmJJDzyb95Uh8yyZZslQ3E5dHn2oE_aXz9DOubj9nIVp0gs
Message-ID: <CAMuHMdWxNbJaDhpOsJRCkDWvqqu4e63Z+cMRndFA6F+McdbuRg@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix
 typo in interrupt-names
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, john.madieu@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Fri, 23 Jan 2026 at 15:01, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> Fix a typo in the interrupt-names property description: "ser_cor"
> should be "serr_cor" (System Error Correctable).
>
> Fixes: e7534e790557 ("dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC")
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> @@ -42,7 +42,7 @@ properties:
>    interrupt-names:
>      items:
>        - description: serr
> -      - description: ser_cor
> +      - description: serr_cor
>        - description: serr_nonfatal
>        - description: serr_fatal
>        - description: axi_err

Nice catch!

Looks like the DTS is actually correct. So why wasn't this caught
before by "make dtbs_check"?

<dramatical silence>

Because "description" should have been "const".
The same is true for clock-names and reset-names.
So please fix all of these, together with the typo.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
