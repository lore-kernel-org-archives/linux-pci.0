Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475755;
	b=jNd6p8v3qA90+41KgQzXKSEdSLVDs//agk7oNDn+bzsiOs8i0+9+pRIaZmcweiXG2P4c
	 wWZXNi+Om9tWaLYqFUOUDLfCNcaGsKXL7ViAEK1HP2Ayj3IyFg8qRjYStKBKp8QD1+y8B
	 xSUA4GdJLb/Id758cqEDz6Atevbeqt1rxKG5VoqvtPsR1OpSrDcVGgAAjTelW1pImylCO
	 Dod71s2++TwajzpXC1/oJE12W14g4Di1ZG+njDlQxltu1UNkiSKGrhVEI68joy5/Yu4Qe
	 8sIBXV7xTqHqiPZ0e39EmmoX+g9C1LVFmDyN79R4XacpoJ12rE4IzVsX88Tk3tIUYzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=/sGiRa42r1FyIucsWxDt+Wy08NdPZogFnK1cktUjeHk=;
	b=pnIPS3DnhXOwei3r9T7CFrZ9mQiUSgx6VB6JIPpDFOS7EzOBUuoqrOhcLsMqDg8vOu+G
	 Sca9NtmYd9JaerfJkzZr4wsyBLIqpFNKuT/QjxGTEMnzz9zL27J0p9idzi9ITiQD1efBV
	 UurrrUOyP6Dqt6h3WV0nGwva/Dv+MV2F3QU/ohm86fffxv6+S90+iOoqVO0R6uSRMapBH
	 9CUjn8ipj3Vrt2WxOpyr5gW1Fm40T4Oq9i53LPO8dZALLp/kfgPy6JYqNc7Ng512TxG5O
	 y2JybdaVhE0BXMyDjlA7jCSOk4E5e4vYqR3pEtYI8l68qXn8HJo08YH0ocetZ6U4g3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPVV0trp;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE5606A321
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 23:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CCE5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPVV0trp
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so33106455e9.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 15:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795475754; x=1796080554; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/sGiRa42r1FyIucsWxDt+Wy08NdPZogFnK1cktUjeHk=;
        b=wPVV0trpVGtHbB/97bjQWfk2GYqAhNe4E8Kv4EAegMEy9E7FLZuTqBdH1ZjCVch56k
         2vt1WbcahQHEbrkN2AofgMYByjZ9FZ7lQRs1JJ2us4wY3e2t+lne8Yn8U+OTSkhEvN2c
         DWPIo9V+4MCO594r/DqmBqXX6qPeHNVbl4uWNRS5lakbIJ7VahPHlvPCk5gurmHScvZo
         QzLCeW9PLmdvNUZIeC9WBXHwBfn3S4fiKQymdPRLhp2yiuSzbw243y6S3rTATicHq7/Z
         fGSUPFFfYHSt0BNmil0SceTSOBreYF9YF4VwIjsTMHL+LatSuJwxCtTdL7w1wtYrMWnH
         mY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475754; x=1796080554;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sGiRa42r1FyIucsWxDt+Wy08NdPZogFnK1cktUjeHk=;
        b=x8zL45EcLZ6c1g7C+vud7sVcw4lCw7mm6AQJx0TOX2Vs51uzcGPjAJR9jAGJ1jKf40
         Ihwbr60ZYEdLWHV+gUzV3uMM7VvZclS6zBxwNb9AyvFGZjkr2X7YsUzjc/s/ThLPebt7
         tB3HuOxrtEDfKpcWPMzk2V/90abCSeIo+oDCnYU7HfUj4Zvv6xCt9IeDZd4hM5TJGswi
         LkxF0PAOVNuY3ixzwGUpGt1CrGVnWStudxijya0loMsHjG3OeV+J9+QDx4fzpYXia4m+
         mEXdNaHxW4DbhcAFxXLfzNF6B5cVV5lXQ/X21V8QHvvgtM49JEPLuuqVaEl1wTiCK4I2
         zA+Q==
X-Forwarded-Encrypted: i=1; AL+hErGa2Jw7uZ4yyHFM75O1ffuJJterRqUjwNuLqoPT5+tSDJhPf8LfTTGQQPivTulJboI9NPoRnS320GI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Gwf/yh01Ag09sncUrC1nxIAUt5u2belwh5xgNBJmvg1LnzFif
	iBTU9nIg0+brniOPKroP8hW4IswgP0PphpboiG82Pc1D0HjRtNUtZp6T
X-Gm-Gg: AZFdTZerPd11z8OSftEQmKmRL+kW2DapKjtuSQLvv0JtqxmVCc0yBjO/vb2HlKLYyfc
	ekww5IuJ85QFqilrB1UGDi5tLolI0TW0tRwVdcd+ArHrRdI4Bb6LNPEtD3voi7nIm76LIb07GfX
	sflI5iDOJmsmfRqfNrEXk2gKiFNIHfu9YZsaRVrN2HWqHrG9v0pLGfCVkhfYa4vpVy2++RLgfGQ
	gl7P7YRSpT3DC32v8ik3+w5O1pU2bqd7Y9l6L920gwBUO8ksUvlWSul+A4xe3rSz8Beywvt8woq
	AYq5fpMeLcyG2pEuEfaaG611f5XFCLscYRTJRWX6NrqlsNhyrZJFbmfI0+xMIcyf3ti/qpwUdkR
	HiczLosEec4FPAHO3xa8E4L/GTJdBFOqQ9eFB8fxSwAKpXIoxYzncC0o2GdFjPhe+POomOSIWln
	Wap0RhSumO+Bm40waoEgPDOvHvARvoezDfQWXGCzUmyf46BJyoICOFjUcntna7WIippOJLhtsTy
	Kp+SU0H/x5dRXTEE+FgGOm2ihgCaDdjbugLJV7XyIrlFNXkszXc5KR4KthL92k2QsIWLRHB9cvn
	OHYdLTY3cVx2GT1l6Gzht7Vul1SKkFewwWMBliqRufcRc6DYYQwXpHY=
X-Received: by 2002:a05:600c:46cc:b0:4bb:6f41:399f with SMTP id 5b1f17b1804b1-4bb888236a3mr269607585e9.24.1795475753577;
        Mon, 23 Nov 2026 15:15:53 -0800 (PST)
Received: from [127.0.1.1] (ip-024-180.users.dtel.ru. [91.210.24.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm214620235e9.1.2026.11.23.15.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:15:52 -0800 (PST)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 	Stephen Boyd <sboyd@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, 	Jingoo Han <jingoohan1@gmail.com>,
 	Lorenzo Pieralisi <lpieralisi@kernel.org>,
 	Krzysztof Wilczynski <kwilczynski@kernel.org>,
 	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 	Brian Masney <bmasney+clk@redhat.com>,
 	Jerome Brunet <jbrunet+clk@baylibre.com>,
 	Neil Armstrong <neil.armstrong@linaro.org>,
 	Krzysztof Kozlowski <krzk+dt@kernel.org>,
 	Conor Dooley <conor+dt@kernel.org>, 	Philipp Zabel <p.zabel@pengutronix.de>,
 linux-pci@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, 	linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] soc: cortina: Add CS7542 PCIe control, SerDes and
  host support
Date: Mon, 23 Nov 2026 23:15:46 +0000
Message-ID: <179547574633.3.10816077515932240445@gmail.com>
In-Reply-To: <20261123225447.GA1119216@bhelgaas>
References: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
 <20261123225447.GA1119216@bhelgaas>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Understood, sorry for the rapid reroll. I will wait a few days between
PCIe revisions and collect the review before sending the next version.
I will use the meantime to address your comments and test the changes
on Almond+.

Thanks,
Fil
