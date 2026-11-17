Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953735;
	b=kI9uN/4pjivMeVFgZVoe2X6jPUJ13d3itTfJPgDkx3gZn0uPsVClAC67JTPD6o0ixqZW
	 4MWuzB0BtrYZHPdy9aQK7z6gFqv/JEsRpiY63PeP4igGai9NQfpX4IZGSa/9r6cThOHor
	 Peshssa7NIp/uuc5Z9fL0jbX4QyVHk5du9vDMK9VHwZbaZe7gJOQudUBGAJqMw7R8Q9M5
	 CWW0PR+ZgQv2w7Gl+5xrVS5uBCYjmxh8/bOxhfsGjK1VFhQL0RIunLRfU5dYibYRKGkr8
	 D+I9nVyt+oXO/7j4f4Y+VG/jP+oXIDJ9I3EhwsQITWnSnIHXDCYbJbJgeQ4OsSSoHCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AFP+oprX2JfHEH4/+I3VRIaXxkKhreRWUhH9rG04Zmo=;
	b=QmNDRd7DzZVzv8Wvfmo/y94OWteMFSTktwwpH4vbLlfpyoHmpWloCJrFtorxfBZ7WsQg
	 ypoWwluvtj8z6gGsVYF1ZbWsLN1yAaIt+zzxnqKF1LRJyTxQrWdxm0YvKcLCYQzZyUcCK
	 rLLWp7A+keAw+O5AejapsGb2gu5nSJMr3F+wf12Fv5896xsbV8pUpM4Fqrp4eUQ42p3yb
	 kMBUmkW+ijLl9Uf6N+hQuSj/ewBrT9QflavJImGjFotu0KOB5OT4CzDhW5Qv8v1K7ECnr
	 Cos/G5TAlJYrQN+iWWAoHICB4FfbLnkJogVW6g133Tiy35b5n6YyDoWdFQ0SHM4yRBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YlofpBdx;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C28606A32C
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 22:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95C28606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YlofpBdx
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so1980555e9.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 14:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794953733; x=1795558533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AFP+oprX2JfHEH4/+I3VRIaXxkKhreRWUhH9rG04Zmo=;
        b=YlofpBdxcRIXvu5cJ/kkVBkDOJ7x6iCSTMHuNVHP14QSPtUPXkfJOLBtKAG2vYvKHm
         FKWooWNn4U+Dm9hxOxobcBNiu5Ap2+m/ZIMjWDMeJ3j5+j0t2v5Q0rEpkElqlduz7tJu
         UHtZvrPa0EPYEo8OanDAubeBaOZsSK1kdZFstCfuNkA4kRzIXoowloKMC8jv+rLFj75z
         2PdwO1nVZ7+BdkzwSzG32d25RAzNVyOWkrDv61rYSZ1wn+jZu66rXIlKTo2SLm1uQLfj
         U4UNt27YC3Eh8G2ivlLGyi7lEAD9oay6fFH96Yo/J2n/MECh3a8LdAuZZNPMcKscap6e
         K4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794953733; x=1795558533;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AFP+oprX2JfHEH4/+I3VRIaXxkKhreRWUhH9rG04Zmo=;
        b=P/NKBWJ5Sw4u+uOqtgIgvZhL4KQ8TAJVI9fZBT5GTSgbVopYE6hA3M7zEALDSwqBjj
         FdkGtLXdPva/l4A00HOcavYDMZE3q8vqWOAWKLM9naGCnE/Jls8MmnObTSyrakYeDNsV
         g/SNM4MU2fRPo+ZmXr8URR4Wdaw4CNO4HN9v10W2RyPNU59wZgBWWFhipLcefN5OAuUC
         M79HGRvrZ5tV/WXPWFz0zCT8tViDPqjw6o1DG8Wkzbx1kEUuy1kdJwDj46c4HdcNpJzE
         OnHxkBdEVEl80wqsUSXaqmJ+i1yk15OpW+gOjAgNpZFEfFO5844BtAXrX1FJu5wRtjPG
         px2A==
X-Forwarded-Encrypted: i=1; AL+hErEseABVKbADyCpSaqBAfryC2VO0o7SnJDNon+ytHa13tkMUIy/3rrv2FzCEjppHIw7S91OuNb1/hoI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vfh+3wyPvsPT1oCbkrl/yfRcjEYST9Q7iZRVSLLK8bbkBSVqd
	F56aPIFapzHV+iT3E2DhP6yG5DzGbedKiI1JDsRNnFtAuEm0FM4Mof5j
X-Gm-Gg: AYBFou1/PK10AOdbwn1wsie8S9aX6KHTncQMAP/JLx1szQ9vR4+s4eIG8k/xp77VTEg
	Bq+Da8TjCCeyC43tfsfyobiclU2Z8tP4F8vZJnoWcspvyIr5oi4nG/KwWizkQ/2xaUPudEPCZun
	9C3GpoVejE1YJQbKfHYYjiCOvGb1zSJ9D47mFsO3rmmrNP9lsueBK6NH56d01YbTfsaWJ8pzkzX
	4xFIvsqjwD2vyL+ZXT5VpKFRIsov/zaWB5yOu06xzEit7W8p4rVizsYT1DJyg1o+brfiyAmG+dO
	hzkMmyHRuSX8kY2eMbjO6zDUNQnFl/bUV4fryFZmIizbcRSaTMeaE1duiFntf/VFLeATNamE5/t
	08fUd7klWjnoJWNFLkEvF3jVpDCwXFK2STTkrazxxaWZDhX9sWrz39fWTlYrtoTF5IpxJUZqn7G
	HsuBj2uu76nWxceQlAFcTDKazOFYuGQKM+C5WGTGZuvLozaPzlY3+pSEiP8of/AF3FbtZhtvS2P
	tfNZWc/wEyURv63CR1t1ukVrlgnADBekklb1nPISfM8H2/y/QsSQtDgf9ZuLMWe79NzIydj9Dqf
	QhfDE0NidhNWPRF5Atjpja02zqc3QNo/tL5wF+4K5hnVdURg6y9pDvFxnJUfiDW9/w==
X-Received: by 2002:a05:600c:698d:b0:4bb:6947:3e1d with SMTP id 5b1f17b1804b1-4bb7da2c0a2mr9913865e9.20.1794953732442;
        Tue, 17 Nov 2026 14:15:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f7eecsm171197495e9.3.2026.11.17.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:15:32 -0800 (PST)
Date: Tue, 17 Nov 2026 22:15:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>,
 <linux-pci@vger.kernel.org>, <robh@kernel.org>,
 <thierry.reding@kernel.org>, <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
 <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: tegra194: Use FIELD_*() for register fields
Message-ID: <20261117221531.26d6e0d2@pumpkin>
In-Reply-To: <20261102092238.3917883-2-mmaddireddy@nvidia.com>
References: <20261102092238.3917883-1-mmaddireddy@nvidia.com>
	<20261102092238.3917883-2-mmaddireddy@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Nov 2026 14:52:37 +0530
Manikanta Maddireddy <mmaddireddy@nvidia.com> wrote:

> Several Tegra194 APPL and DesignWare register fields are programmed
> with open-coded shifts, which makes the register programming more
> verbose than necessary.
> 
> Use FIELD_PREP(), FIELD_MODIFY() and FIELD_GET() at the Tegra call
> sites where values are shifted into fields. The LTSSM state constants
> are converted from pre-shifted register values to unshifted field
> values for FIELD_GET().
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20260515070753.3852840-2-mmaddireddy@nvidia.com
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 137 ++++++++++-----------
>  1 file changed, 67 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 26e2ac5c5869..62bbfcefe6fe 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -51,8 +51,7 @@
>  #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
>  #define APPL_CTRL_LTSSM_EN			BIT(7)
>  #define APPL_CTRL_HW_HOT_RST_EN			BIT(20)
> -#define APPL_CTRL_HW_HOT_RST_MODE_MASK		GENMASK(1, 0)
> -#define APPL_CTRL_HW_HOT_RST_MODE_SHIFT		22
> +#define APPL_CTRL_HW_HOT_RST_MODE_MASK		GENMASK(23, 22)

Changing the value of a constant without changing its name
is heading in the direction of a a recipe for disaster.
It doesn't take much (eg a partial backport) for things to go awry.

David
