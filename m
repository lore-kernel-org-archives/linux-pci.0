Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345929;
	b=l8VeLFFXJHujN+X2/Cr+b6l9/9HdPWYg+T9TywEEL2jE3/TQQp7j0V+p/LsiZq3zE606
	 4tIqFq7vN8rYFMC6ZQ5JP2zT+qfg2UcYbVTuqS/GA/eVxGD8exmGpTrKCh5Y1PdH7WurG
	 +0GtRuiknobkuPxkX7+lnVcUVYYKQGIflX6ZOx7OSSggKB6xtGavWCNeeU5twQf+wE2ip
	 Ii2EHWNzuPJ0wkihum/E3WH+u9v4QeexuuJQMHgvhkgXJGOP2sNcJPnFqGyLFfdZPQwKP
	 FkQgA/cOuZaEdALujgT6qOU8fG3DEMQFeugSicxo2DeJJNMBBLawE57eeIGOUh+TXJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GPeUEpbxZgN6b6poMbqb4po1OzKA7uw1ryiUgB0GJGA=;
	b=ffkk+Pv8GkbPOhK7ZUEuvyAFwCMBTTxChmpWHaYrE0xeCJUFrdbfFNmw1fHkH+nclEhS
	 HSTAc0BqpJtOpvW6goiF7/hHxeJEMw9WEJ4mSqpMg2gDubTuLUykitnHC0XH1oRL8JXZW
	 +MwSQpwllbtPc7Q1MDDhK+U42Xy8IFIdvqbyCrSdVByfCyotwDrY+9rAQKtaQnqyMI6aE
	 25U6oKnyhIMKSPEQkPs51j9pPTgDyz5ywDzLcKL2cUbqGMMYxBA7kZjTaLcsndax0Wzp4
	 Oque372teOFckBm14GIhzmCbiHo5oy0KgkmIMCdZZcgRqhbBsBslbK1/ewBVMdWms6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jccq4jcX;
	arc=none smtp.remote-ip=74.125.231.195
Received: from mail-oi2-f3.google.com (mail-oi2-f3.google.com [74.125.231.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C7606A320
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 21:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D4C7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jccq4jcX
Received: by mail-oi2-f3.google.com with SMTP id 5614622812f47-4af85d1cb34so265898b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 13:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794345928; x=1794950728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GPeUEpbxZgN6b6poMbqb4po1OzKA7uw1ryiUgB0GJGA=;
        b=jccq4jcXeMUlb9kNFMg4bmgySVVsmX5UsetGhRhR+64XWvTXdLN95EixkElbZjvhHE
         W2Mx71diUc+jVyHhbA9OE3M/B0EmdPmaNlknxxSr+hbNZZgxDri4FgRCajHMgOI8ZXZQ
         kRT7PO7iWV4cF6tMLtElZkMM1xZ3LTJ//nT1adfehGSs8hwTfJ80puGlSZnsooPNDDbc
         nnT+zrQElAtdpL8WB6+7BldhmhWm/wZcTtrovggk2cW08mkutPMTKaVC0f0s3a5KgF48
         gQBa8pMdrkpRlxkngfl2OJMoJorjC9OtPiglvccnie7kRLanUD4CDTF3JyFUcFjpgphV
         U4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794345928; x=1794950728;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GPeUEpbxZgN6b6poMbqb4po1OzKA7uw1ryiUgB0GJGA=;
        b=C5V/69QV8Ehc+LMaL/M9GDyMhGgfLe+ouRBK0Gw2cGiAAGqOr1P52amBnTSg0xLe02
         ly+4JNOJBxE7FlW9Mb+7vqH3UFPTAhTmxIv3DQkMhZaHK9c24iTx86e+5G96CH2xJbDD
         buybSaeHSot55Ks3qTO7KLUwiGAyzbWXz/zMVLsg0jmuRhOBts6UJ41p7vt/J8cFLZUX
         tpjo5irtmJM+JQouARVocEwc5XOSbrtxdE3fIkc7RcJVsy0gsMMmp9S4pnYjErWeJEAZ
         uGq83cHY+1s83RwP5d9CBRmC75fkQDkU4QsqW2GiF5jcJVPUreeYCuFDT4fr1CKY3Skk
         GtOQ==
X-Forwarded-Encrypted: i=1; AL+hErFYIWWy6C6hNTXgjEhXWbj1B8v+yjXiDIKvyu7Akt/Dti6ILBY9+wHmItoEbkr+GRIbZYzoFkKGBBY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tIQYmxaIUt5N+WmFHQjoS72L1Xuqri4aYfLY9Ng4GzzF/9tKK
	G40gYtjQ0mmggukCYPFZpucNS8/twa/eo7x6O1/laPW6PcNuue4sGaNJ
X-Gm-Gg: AYBFou3cZZBGm0c/2S7d6lq4kOWByJEjeBq8KZFJ0jNLHeTrzLC1dcBz9jjKczrxiLm
	yFgF5egRmSFnKbPhsLCyw0qNIWTI+8otzzNNNb6S8dAtRXpz0vrjMSVnlbCAwH5Tl7oOHdqHtXp
	/F5KsZ+M86lZZ8Kgaw9llzpnB5hs9vT7OGu0G1lItbuLORTrH56iTnPcQPrQKPOGH9p+PDoWvaC
	dOoR+DctNVdRmaNuOmh4y1JzMq/XsmHbpuHU01T5zc8PERVjYJ62RYw8qup6qt7JM3U+v39DdyQ
	0pN3dXfFtXVaBM1f56CDv1yk/nEyl3QUmFOXMGiA9k++o20Lu8+sNhxpnIa0c5k5OqEiggOK/0n
	JPDoOS7CJ7nfi8cONa7iFulbSu7kQPafcfwV4Z+4OH8oa5x6burjwvVG9VR8ems/0D7XUcKIbyz
	rpFYg+EhT9Bg97/avTZ3C6sXxjt47YqL4fCdkUh171ydvviuSg3mwFPULvfEQbp4fGjxWOwjbXR
	fiVCyFJZzh9jSjUCH9TeA0DO47nE7yXfm5i1QIV3GLfkeo7xuihnbkAi0eq5mgvisD/lmfDiWgo
	nFAGt+t2825/QD30DWuQazihNB11MctsZIMPsPY83X/ZjXbrxoS/F5TvZYLKZFhayaU=
X-Received: by 2002:a05:6808:15a5:b0:4b3:3e1:499b with SMTP id 5614622812f47-56b96294badmr126559b6e.6.1794345928215;
        Tue, 10 Nov 2026 13:25:28 -0800 (PST)
Received: from ?IPV6:2600:8804:5716:d800::f01a? ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504c276sm3233400b6e.4.2026.11.10.13.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 13:25:26 -0800 (PST)
Message-ID: <01f512c1-84ea-4443-99c5-f6c30242d4bb@gmail.com>
Date: Tue, 10 Nov 2026 15:25:25 -0600
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] pci: Add broken-GPE quirk for some Lenovo Legions with
 Nvidia GPUs
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Timur Tabi <ttabi@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Lyude Paul <lyude@redhat.com>
References: <20261110-broken-gpe-legion-v4-1-c672bb1c4d91@gmail.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261110-broken-gpe-legion-v4-1-c672bb1c4d91@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

So sorry all, I accidentally double-sent with b4. Please disregard this 
duplicate.
