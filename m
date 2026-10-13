Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6AF394EA6
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900337; cv=pass; b=rQBxLC+lj5th17zwG0b3L5g4o/+e87PVnctXG+rhNbhF/aEb5i+G2cEWOJBoc0w9D6G+x7YZTOMX0imkPpiw67InCj1MSvzObJRCEJCoY+lLmhXFM8D6vIcZrhpR0iC8Inv4oBoFbJ8QpzfgKICtEwZZO81Skki6DEKCABjII5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900337; c=relaxed/simple;
	bh=ed/N2xFdUqvz8nCJZcFZgWxLj6i4+huAHshNYesy2DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoE+vUdgUAuS9ZhdsZRraLFQHCwFz/FRHnXJdAZmouELWvVnv/YYi3EdlzYmLMZtDGEaAoPqHI2Tm1xAH5GXxT0IB0xm8Zmr9PIbWevU+y27qyaggTF4yN0hC9RaVkrkRQKS47BnJQWC0XCKZ/HSB5Gha5/+96Dqew/WpRg4xZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWC/RRiK; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWC/RRiK"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a76ac0bdafso41242721fa.1
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 07:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791900334; cv=none;
        d=google.com; s=arc-20260327;
        b=Fs7jekYJPqCNEtG6OSki+TOhRnuL+b2655JEcOeIjjWhXR0Bf4rok8Mqi3lnDhFJKp
         z+90t0GklNMIqHpC62sKtN2iALjYiKLobfHVC4Yp20i46qtLj/1CmCaQOHyyVr4hfuL/
         v8yI/mWAH3Hdr9uBxtdjGFmJzi+Zs8DHhx5eRkbsxSSDtAQxsa3DaVB7RqbVAbLohbrK
         hiQH9dcXWT6v7tsWbHhQpZmU2yhf4j5/WuQ/dkBPhs/htLq8dX3LTTBc/ZQ8SvC039gj
         zUf7SZ3wniBPJxz3VyT/gWK5RyUyX+hRq7Fmj5dhH9fjHPlBKER7Gi04ZUd/Y/NiIwvx
         dOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ed/N2xFdUqvz8nCJZcFZgWxLj6i4+huAHshNYesy2DU=;
        fh=cgTaMPnsVyST4x30YW2dizbS8hIKYt4M2HSO2wuIsN4=;
        b=R1W0c5yKHkRovetQYFhOAVKbwPDDIrBzwnYqgO3rWxR3+neWIGdRf/mU6PRuSqwxuq
         rUwFHLdctwNaG3eHo/amPZg+wdioUJyAARPNesMJ1RChFs6v+jiqvqVA0ac33rbKinDP
         sTpAYqrJ3BTwdv/mrBSsLPJGLGCZYUJPs9FTy2ttvyGQB+rmJYvF72HM1nQbcNrKr/rS
         DBAW7sCaaNswWH1RkKP2kpeS+Kk2+1VqfxXp7dCpASdP5tg5+HiTvXIqxdE7VuI9nj2P
         4ZCWqWWkGGfm/m5cG4UFTalF2l8KKWjMhpEPU4Tv/zJVcxGA6E62MclXTW2FAFbvjjgR
         wLxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900334; x=1792505134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ed/N2xFdUqvz8nCJZcFZgWxLj6i4+huAHshNYesy2DU=;
        b=gWC/RRiK3XSy/RBiHcqO5qCNdVluUp8YFoij0XGNbpAAr5UAcI0S9LD9KHbVk9jDwQ
         JibuL/gigS9yYYjEOTJP8xNKd8p1h+v0RnaHgCwfof7XllJM8ThaA4FqIg3DCuR4a9mc
         i4N52JQR4bIbd7IoEP9NG7GAbcEtpmCyIgfbvkaJXAp8WZ10cCxGFcVFY6d/J1wjdEY2
         LIDuTMIdP4mudKatP8V3RA9aM2WvLTktMxsyvS6noUuKv7Wj9P0LZ2owWvwCDv5CEujJ
         akrQcEPSr9aDT06OTiTwkNwEebj72HFyU4AekJuL57pbG6qvcLzozoAgmssy01rrW1qA
         Kmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900334; x=1792505134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ed/N2xFdUqvz8nCJZcFZgWxLj6i4+huAHshNYesy2DU=;
        b=xKSB2sBUn14hKuayY0Pb+x2SRgeoR/en+V2CGhK6orOdyhzUA7WWeQHBteUh7uzHno
         j/Bto17pT7V6TOSOz4tOQt/wDTryav28M2RKklPwgilLbMCAFuQMNn1BNbfe91A0s8r+
         3PogtChOa8ne9ZDzgG9ZhE9/gME4MBpGBYybDVCp9v3OvqmGRV3AWI+aXqMVA9lIxG/O
         zGwM7iIicAYgNGIx7PbEfXt8NnF5dhi0AX1eHMQRAYlKJi404jEf/Xq8bYk0qTUsn2UA
         d7ttMGbBnP10Eqw7mJDitULYjL4/+RMqZXem6csAO+D/cPiAJhYyZd2byaR343ULtzdq
         jAtQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+el5ajVdv/Hc+HAPUmeVes4VAkdeO1gg4YpT3bsV8NDxlUEtH8KbiD3/RzcW260EhL3CnDZXxFzw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWC8KOEkGXBwmLbcriVQlR8l2ePuH+OEnmVqn89Y/ndimNFDo2
	qvA3vc5i8Dyut3lu0JbawGv61NOYoNKpU2/qYyGROhHlsoGM9nenKqjjQJNa1OtMiKdfEvrNhzQ
	gfXroOFvCFsdyrDZntKkbbfGx1DEPkHI=
X-Gm-Gg: AYBFou1QDwVOeNtcjKFQhbHeeoVAUbEsX+rciLxia46rUIf78Ct+RscVIkKM66Ab/kM
	YJmrWsnhuVTVexmjJiRx7iUCSsaD56CgCoCga1UhQdgPipP93/2yL6ym4T6EZkIihTUywSxH3cA
	X8kX3NO2J5Kp1BgBE3w6acyfYuZh3efHHjdwWveFQq/rVWFVMFVnMiAroOgUdLQGpza76AgdIKp
	Qtg27Q6N0seLbxAt8P7W5NwE+G8LP1bsa95xFUzbNNV6nbxyozdxSNZuLmpNamJq6u/DQztK1Pl
	0pE3w4ajQ9rmi1KArAYrVIFOCu3bTo6g2/meDdltJeHWmr750xCJy29+edy3rTiD8+oIMK/d/pn
	7/mj0GB/mxOuEFtgIZTaZDs02zUoop46/M/nxhcnnSehYqTUK9yovPC8=
X-Received: by 2002:a05:651c:19a5:b0:3a7:64cc:1a25 with SMTP id
 38308e7fff4ca-3a9c4ebccaemr28657931fa.2.1791900334227; Tue, 13 Oct 2026
 07:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009125154.266435-1-festevam@gmail.com> <20261011083213.1486acaa.michal.pecio@gmail.com>
In-Reply-To: <20261011083213.1486acaa.michal.pecio@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Oct 2026 11:05:22 -0300
X-Gm-Features: AclHuK8nY-5t1j9xNJKObEZJmJAKXbcMCglGOgF53Mzkc0EVV19cWoVGf2_AYx8
Message-ID: <CAOMZO5ALdAyQvPf+40=EnTDndSijkQvZw8r3jbiiwHATyfZN6A@mail.gmail.com>
Subject: Re: [PATCH v3] usb: xhci-pci: Add TUSB73x0 definitions
To: Michal Pecio <michal.pecio@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, bhelgaas@google.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Babu Moger <babu.moger@oracle.com>, 
	Babu Moger <babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 3:32=E2=80=AFAM Michal Pecio <michal.pecio@gmail.co=
m> wrote:

> You mentioned working with TUSB7340 before. Was there any board
> firmware involved which made use of this chip before the OS?

I used a TUSB7320 on an i.MX95-based board, and used the TUSB7320 only
in Linux, not in the bootloader.
