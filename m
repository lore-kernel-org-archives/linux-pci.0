Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011130;
	b=MluasYRQU87j2IDR5lFmItgAcwJNyLRwrBO70sABP28PbwqUj+g7WVqXbM0Tb9On3ZaZ
	 38Zwz+4QvP7xFYVh9S9WZD4NH/8+DkZeYZApS9RVjahD4xGFRsEim8eZ2ks4/v9O2t2Zt
	 2Anx7v1Vv45llWYH+BzofoEih7Yy0A0C7oqWRNOWTKGuXoyL+IJI5ougc6aI9oVHHJHDI
	 hXiWActOGZ1qgVcXIc7Ds5wb0r9JUnZ3qyaAyBEiVIxjpydUAxU391M0DdPyaC2yfrMh4
	 pgYq3kBEvi6eUnjMoQ9ZulCW6qOQc0KtG1L1XTxQ+xN6ZIVFk5p0jeDCtzycWhE3Bgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8+oQ1HV3e9R+CSE12Qaoq1BXQEmnqEm37qYpcdR4cOY=;
	b=vFExxoVcUuI6PVxwbFZBywrnTiqYglli1UUUmJiq1xXYLg7z5YD5CAeoMHTD/uRrpC9Y
	 ahgSAKVXSxNtUop4aMA6MrLH0cusdgWXq9FQ1imMLggsG4vuAzjuUQLhhoOOebtaNTaMC
	 P5GaVLIzOH839/5G8HZUBMBQxqfCZBVe4p1l7MBjyyxAct5wNVECdawxw/EyHlNwE/54H
	 po+vZG+qLZNYagYuukE6c6bYgcheTgG1WjaOqUIaqpgPJ8xFuOfPLEb95CDPWqILl4PdP
	 carnB8IhO9iahnMlptoOFIDnwjiJMH3V+e8kMwc6vj1U1GMU0gkNO6Dwzru7venxy2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=X+Du2E5H;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA3606A33D
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 14:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CEA3606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=X+Du2E5H
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so381295f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 06:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795011126; x=1795615926; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8+oQ1HV3e9R+CSE12Qaoq1BXQEmnqEm37qYpcdR4cOY=;
        b=X+Du2E5HeDdGwpJtkkybS4mRnYIN76epeyKOe0BAKNzk2aIzSHPLlFW1sPj87xh6QD
         r8+27iMo40fH3/Dfjz/gjFCrVzVzwYvkUZD9TFz9bTM2Tc3FHcMsL2SxK0ysirMwspZ6
         bFZaHoYqXkDu1jjng6iK63CdgKssDdTzOvbzGkeu4BC33Kqb/OL0JZe3/FnqX3w7/Q09
         CoxzHRaFuCZM5DNQ+HEpaMLG+idiYekrYrYyjwysV7ldZqI8eqFfS9p9yDN77C27r4nd
         aQWcGYi1pHhF3PATB+2bvKGeW6ek3lSjSwjVlq1jIHKFJ/2km/fmms3HIkfrJRTOi6Bb
         ot/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795011126; x=1795615926;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+oQ1HV3e9R+CSE12Qaoq1BXQEmnqEm37qYpcdR4cOY=;
        b=ZNzNwflZ0T0m9hb9ed9xQyKALfRlH9jrA5oAPiXlqeSxGoSSVDI6SCBbBQlGZRU5Ad
         zkq4SYR9bYUHH04/BQJ7ZQBS9Ohj8W4GN/CnT2U19bDEwMmmQxuNy6dyndyCdIg5wRK1
         faPdJX5Hg94tLjeApuvAsJmP7h9N6san+oFABtzBM/3iie01IV1gRADVZLII7O54Dza9
         j88X9lPXqAbG2mwT4YEdI5k08kjYmPIsrPLW7lfhe+DVidDduoiLqhWOlLrg7pTH8Br5
         9PIrr6KanJRuAawJ1g1JSI4gskB+e3SfpZhBSHLrSw2Z9Kl96q2PU2OoMhSakEPiu41P
         3ITA==
X-Forwarded-Encrypted: i=1; AL+hErGwfYQVn6BRhWW5ZujSjlyydpKPSzHCWRCN334cO84hD5OzzePvORoic5oer3vMeJWUlkwFFJgtmn4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9R/OfhO9GOAi22IFN00yCoB7/ejdFFSYBR6SuzTzEwkEPodU/6
	5KChjLHWRydfWCJNfyEO3N71NhtAkZ8JlKlzoBZAzsMG/dr0nGS+UFY4J4n9mUONbic=
X-Gm-Gg: AZFdTZfCRSFcLyeIosc7V2mYIfagbR2rVJMXgrDwWR/YO0lNkCiH99Kwmb0pmbpxX/U
	qei71dFE38QLROiyMYIN8f3+GjbtEszxFHk/hG/3l30XzgeZv6lRlvSpAz+/WsX909oH66z7PKT
	WB8P87a0qHTHVIKvcyMbhDtbsL/+7/Bq/qybyql8/LKMlzXeYqKImKE+Ttw2MM30eATCFaHBqOL
	BY+02UbpYCOAYPe+4yP2c6elTYQnUAAb+/qBxv+32MvePPuew8t/xt/UI3cqVUYXlzmNlCMdwIA
	zlRL/TaP/DOZDcFWOCD3wRCT4DQanjxs3TtrDpLCnfHHqVc/w4vi7uTO5885cByDJWcoMOmdOyD
	/G3wnSyCcZDyscl/+MQFCgPl2snX/HJON7IWeBnTEIEluNXneSiSyYeHN3B9UiZUh6PEkd59FaB
	ONFir5dPi/ddVoOPee4rnClSqPHLL7OJ2F9s7nEPDwdVDdNCpO1xfYH1iYDVQmE/1APD+47DPCX
	WTYfGZRxQnZ54yV3IRQ/55PjRGwcFyFsNZ5UdsfXTSRuS31wQXVzQYL+maCkHgla0Jn092GkFZW
	lV2Y27XQgYxy0eQhXKptrgBCfxVuaQOC1VbzFnMIWOtAhaeH
X-Received: by 2002:a05:6000:186b:b0:48e:88e2:fe6a with SMTP id ffacd0b85a97d-4a63f4623d2mr6222883f8f.49.1795011126108;
        Wed, 18 Nov 2026 06:12:06 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a650d2ecd0sm5590663f8f.8.2026.11.18.06.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:12:05 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: Update UltraRISC driver maintainers
From: Jerome Brunet <jbrunet@baylibre.com>
To: Xincheng Ji <jixincheng@ultrarisc.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Linus Walleij <linusw@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 linux-pci@vger.kernel.org, linux-clk@vger.kernel.org, 
 netdev@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Fei Chen <chenfei@ultrarisc.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20261116-ultrarisc-maintainer-v1-1-f58706ae438c@ultrarisc.com>
References: <20261116-ultrarisc-maintainer-v1-1-f58706ae438c@ultrarisc.com>
Date: Wed, 18 Nov 2026 15:12:02 +0100
Message-Id: <179501112283.639563.5233054429317576626.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=vlDn3aALOXByZVs7mEqRvuJC3A1ctnxY975yMiaHYv8=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFl/N5nknC99zPPvkMAeEz+LJ/rb3O42SObtqLnBOZNhY
 rKGh3pmRykLgxgXg6yYIksNd7X4O0mtL7Om69yGmcPKBDKEgYtTACbyv5rhf+pRtSNHwkU+xf62
 3H1MSnpnB/t0htMrxT57Xp29uUlbppLhf/BEnSWNU72uGOXvU9VP+/jowUV9g7UhNjMfXXfY/J3
 3GgMA
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

> Jia Wang and Xincheng Zhang have left UltraRISC and are no longer
> maintaining its drivers. Jia's listed company email address is
> no longer available.
> 
> Replace Jia Wang with Xincheng Ji and add Fei Chen as a co-maintainer
> for the DP1000 PCIe, clock, DWMAC and pinctrl drivers. Remove
> Xincheng Zhang from the PCIe maintainer entry.
> 
> Having two maintainers provides continuity for maintenance and
> patch review when either maintainer is unavailable, as suggested
> by Conor Dooley during the UltraRISC maintenance handover.
> 
> Link: https://lore.kernel.org/all/20261112-legend-outcast-c2226b5e02a1@spud/
> 
> Signed-off-by: Xincheng Ji <jixincheng@ultrarisc.com>
> ---
> Hi all,
> 
> Jia Wang and Xincheng Zhang have left UltraRISC and no longer
> maintain these drivers. Jia's listed company email address is
> no longer available.

Maintenance is not necessarily tied to an employer.
It would be better if the people removed could Ack the change, and let
the community know they don't plan on being involved anymore.

If they do not reply within a reasonable timeframe (a cycle maybe?) I guess
you can remove them anyway.

That does not prevent you from adding yourself in the meantime.

I suppose this would go through a starfive/riscv tree ?

For the clock:
Acked-by: Jerome Brunet <jbrunet@baylibre.com>

-- 
Jerome

