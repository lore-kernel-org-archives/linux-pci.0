Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A1A47F77E
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468005; cv=none; b=rjqV6S0JvmC1Ox+CiDpBkWBXbBiAk3bhxve1jXhDV89GfGQRewWVZcuaodP7Wk7pxB5DW673gGyoi/spvS8/e/XxLNIxFLEW2WhaasNdunz9FtbEE6HgDqhkTQo8uXO0dyJyjHeZHUu2z7vMscusIrHBJEvP1iEbKKE54fNxS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468005; c=relaxed/simple;
	bh=zaYufR9QlUv7eYaLQ+at5yvHX5e6ve5UNDk2t2c25Zo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPX4gN2jQQSNJMC9Rozp94vkv+fMfcLxRH3X4ahwvXIQdyCV92rDl91V1jutNMRY0IYXNIh8O3CZ0SstuizSMMIm4TBnoHpebwoQbAG4qhFUXPg+Oe0AXCpZYsGlcph5B2IRjgiyy7zaDLYwRgj/hgN4xKygn9RbE8rpqHtuaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S+4W/IJ+; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S+4W/IJ+"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so1896837f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789468001; x=1790072801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f86HyW2q5YFv3zSNeYSruMbybkqwMyCIyR1SdKDqPuk=;
        b=S+4W/IJ+ueLWsifWIhuuIsVDGcdb5ruvp69ypR4FJSvUe3tnHyKuvpsOSFfn7lPGrm
         5XZJEyxCLIPt6aSM7vTVXvnhk4MEC35C0YE01cUT1U94FyLJY+ho/TUVsdQnHtzK2IZ2
         xDnCFpNrqMq3y0AvRTuc61wVMS+5e04rhYDWmccJYO5ydqBI7bgHkOavKSBOi+Kmy4vw
         FjC10JKSm40W+AQ7NlL2+aASKQUSAwVl0puGc1/0Kck4AoXOT1i/ZvIPwHSrVhRl55ke
         eKIXY2WETyjO4ZrZonNPzRGs+finlRWPPRNaU+TtW87ZpWOrapOAmK6CazwwbW7n+frg
         9b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789468001; x=1790072801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f86HyW2q5YFv3zSNeYSruMbybkqwMyCIyR1SdKDqPuk=;
        b=lspZTsrqHmvSFzEYjW+KRRbMxEkIC8Tv6wP2fBtHMYYKCiZ5oCsC3ee1WFW5hUZ7vP
         lr2hQs7msUP82NJZLpPnCZZzZN6zrufhGGj1ytlRr5oL0G0VBZKLf9whCOAM1sA4LrE2
         zS8Xsl+L9XxNlFCBCALpQWnrsoh3uf7pi8VEOsnH57IjWsT0MwnhVBl2sbue6pvxhe5r
         LT0JhN3TosEeK7h7CGQW7d55xw9AbfGF95qlRqzVUdDGudecQltx98CvMxj20xy4mGeq
         PED9nGO6/gzHc3/EdvsQyorrBGkOcpPVIY6inPzdrRzsyKanaf/E30OJBnSAzQnKQJvD
         4Q9g==
X-Forwarded-Encrypted: i=1; AKwUvBxwSDn4agXA+zDYxjPP4eCAMUsJw/pb/Wcz4s7VlRWwKJUjfeYlr4ZECABwPH5WGnH2WAzIcbEtVPM=@vger.kernel.org
X-Gm-Message-State: AFuF++m9BsA0f2EzCrk3gpQiObFCUjDElrgXVh3Oftnon689duTpG8RC
	1d+uA14w/yjt+IpYwf+6zEvQH21hMeLRCGI60QUMlIfAj/Nt0cLsQvRnKyNGJnWdZfE=
X-Gm-Gg: AYBFou21fZ9F+UkhDYBUm0iXb3/0afepBTdmomyakbhE6lPf2EgPo9vBUvjdJFMdkeI
	4VM77lYK5a/HWp7UGtRl0egEH4EaLHItQNLEg1KbjdPf8t6HCsLaNA9YUobUq8PIYff/p8CQg6e
	N2RwIAt8h2HKC9k+FIa2CoahWfumo6GqcHbuMar6dphOY+/TFBq3nQIcEH7zePnNe9px5vJjozJ
	SdfIjouj1LsIGCnk/Q8+fvNjWF2Mf/GjBhohq+sYWFOzd1WgQfevWMcbbS0ue4lszvlbBM37bZc
	7U6KZxWPSACN4J6nKlJOBFGKdK4K84QuESD6YgywK7FS0hMeYE72OiZzGvgXfubiFI8OTZXVXVV
	FqGarmkZGIkQoYL1GMKqdbIqGRhMfbwOTPh6emuUKcCcSH5OBvsEoeHN6mWxQk9L7uCJt/YvV0z
	faDqxZLhRS5ITdB/btwzuqfqMwmCrua86OZrXxq3DKJLoLYAx8Q6cHaenv7su9jeBM7lU=
X-Received: by 2002:a05:6000:41c3:b0:484:3310:710c with SMTP id ffacd0b85a97d-48702b30ad7mr16669938f8f.24.1789468001189;
        Tue, 15 Sep 2026 03:26:41 -0700 (PDT)
Received: from localhost ([82.145.119.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34e4b5sm33243901f8f.22.2026.09.15.03.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:26:40 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 15 Sep 2026 12:30:17 +0200
To: Angel J <iamanaws@httpd.dev>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid
 bridge configuration
Message-ID: <aqkeOfsmjJlfTGmn@apocalypse>
References: <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev>
 <cFJoUZ6c5g5YbFCrwUnx6RlitHRl-0cS2fadDSFJNf9SgLreKutrmZj1r56hFh8ZUAbzvuCqBG4w9ZYAE8xAWP9HnLwbjMOBzac-iMnMMZc=@httpd.dev>
 <aqfgUUkZYZg6ZABF@apocalypse>
 <B6jXhRRiVu4TfgjwfVOLgxbh1xIciImKFVMmjkMRoDt5SO7WpM2M3gBqsjtnh3VhYobWdcNfqFrmlCdhqZBqUakSNkTeVNZYJnXLTx55kRI=@httpd.dev>
 <VaPKN3QbW3sGj8wePAvI_xD3twp_MQE4-4xeSbvgoQPVUnKDWKz0EWT_JiLehpmc6WOsCAoFOPs412Xhtthes_ZtvrgsKB4QB6QPz-XvRb4=@httpd.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VaPKN3QbW3sGj8wePAvI_xD3twp_MQE4-4xeSbvgoQPVUnKDWKz0EWT_JiLehpmc6WOsCAoFOPs412Xhtthes_ZtvrgsKB4QB6QPz-XvRb4=@httpd.dev>

Hi Angel,

On 23:28 Mon 14 Sep     , Angel J wrote:
> Ok, here it is...
> 
> I tested this quirk on Linux 6.18.44 with CONFIG_PCI_DYNAMIC_OF_NODES=y,
> and it boots without either OF fix. The diff below omits the test logging.
> 
> PCI_FIXUP_HEADER runs after the resources have been parsed using the
> original header type, and changing hdr_type also affects configuration
> restore. I don't know enough about this part of PCI to judge whether
> that's safe, so I'll wait for your advice before submitting it as a patch.

Thanks you for your submission!

LGTM. Maybe you can play, if you don't already, with pci=realloc,assign-busses
kernel cmdline options and writing in remove/rescan under /sys/bus/pci/*
(watch out: this could kill your system). But better to ask for opinions
from PCI experts.

Thanks,
Andrea

> 
> Thanks,
> Angel J
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda..57df88a38 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -291,6 +291,22 @@ static int __init pci_apply_final_quirks(void)
>  }
>  fs_initcall_sync(pci_apply_final_quirks);
>  
> 
> +/*
> + * On the Dell XPS 8940, 8086:4c43 reports a PCI-to-PCI bridge but has no
> + * downstream bus. Use host-bridge class and a normal header so that
> + * pci_is_bridge() does not send it through bridge scanning.
> + */
> +static void quirk_intel_4c43_host_bridge(struct pci_dev *dev)
> +{
> +	if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI ||
> +	    dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> +		return;
> +
> +	dev->class = (PCI_CLASS_BRIDGE_HOST << 8) | (dev->class & 0xff);
> +	dev->hdr_type = PCI_HEADER_TYPE_NORMAL;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4c43, quirk_intel_4c43_host_bridge);
> +
>  /*
>   * Decoding should be disabled for a PCI device during BAR sizing to avoid
>   * conflict. But doing so may cause problems on host bridge and perhaps other



