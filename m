Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503632;
	b=doqIORROlPydjdgLKLAQEsmpjWRDDOEtfi2QIgrJw16gDtHt083N6s+GlGgu1LGfjW8c
	 0bjANvS/Mm3sHS2XtXL0vSR+DWinvhzMpjHbUTMa8BIety61W0NqlsrMOpJeffGBCwyEt
	 c/ZaAND+jM0Y0hRUo2q9++pYLuehOTkEvx0XwZN3ZDkr7itf8QiKRRpfDifKNyYbQnIl9
	 mc89ApvARNtM9FYqw8IYkk/qTIp1ZUqG5bixA37ut83wbuhTdfu8bXz16b7JjrnM6JhSC
	 I6tPKayVIlIxyaF5mv2qDC49yCjWPbpbxpkoWpyk963CitbiREk9fTlA6jhrpMna81A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Transfer-Encoding:MIME-Version:Content-Type;
	bh=bUUKY0RsjD+IVYyi5SJxAofkyIWwSJR0q+NQRX7ZwwU=;
	b=F6/MMHe5rFNpuiMMniFothnkP1NBoYwpJHdY+9T8d1fGTkYd6mVrtXoMjALydI3jAsj6
	 jeTXIenFitn6n9yGNG0htmYXaRVaGkT9RFKQFFtBQG3eOJVVI14jccwLAv/VZHDTROWRX
	 /2uk4z99jq5kVrcIzrJvhuT/9L0DKcIWyoNIxTj5HZlemj3jFo31fLxsvCsAQkCFPzvAd
	 24Kbh0XltekoAP/UqrYISyZKh4yxCIUd1PLmDaYNs/okJB9lzaVwsjjVwslgj3C01LHKZ
	 XlTqtI/FnZct134ORyIug3MN73W4EBMkPrziMuNnLzQE0Dxoclz5O2Oy/kHxPYpBjQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QVGdd82U;
	arc=none smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E80606A32E
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 07:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10E80606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QVGdd82U
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3adfed9a887so37392321fa.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 23:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795503630; x=1796108430; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bUUKY0RsjD+IVYyi5SJxAofkyIWwSJR0q+NQRX7ZwwU=;
        b=QVGdd82UruFfPdkhhDtfnYqoV6hQDoIc6LmdBLufjtmQpvNKfQQwYNlPT4YjkByGtC
         6b10N5ALfWr87MLq6fS42XMmf1oLMR0lG3tNc4la+6M161rsBCiPEePoiahvpmI08Q0Z
         aC53VISrmlWQvFm0CjvJHI1xPz0/R66Iz3+AvjcnKb1mVt0qOVT2+wIJk6LSYi4ate2X
         4S2MWMQVrYYIDvhFU0Kt9KID8whWfbFTA2VbauqgCBsy5/MTuy1exwBW+v/soVSc+irp
         EaLAxJqrZHrbGSaMGF5XpL87gVdKhgZTt3I1BMvo5spUCzG5KXRjOVvEysxZq4rlxvLm
         BBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795503630; x=1796108430;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bUUKY0RsjD+IVYyi5SJxAofkyIWwSJR0q+NQRX7ZwwU=;
        b=bCdTBj9i7/7UIIVjrAeXBEu1pbmhwrLKUa4w79H7sQi2GAbJMjK5X7QGE6NNjoadgf
         W8pAKR+mt4d/Q+3E2nLYjRBdLWwvTqBbB4NxpvYcisNyxXtpFFFLXV2tjRghwcYJdTGL
         kGt5qAJnnyfrfu9ELzUo9aKVgwygfIXq8sCsnb2TYfmvHT7pedfETGChL7dNnvBdccsq
         lwwzqYaKIF76suatCiDXMVL9XMFeJsmWJJIwHW8TZHfJWy9AwGwxmxSCvCEr7CU1dVW4
         IqjRA1EnTp2qRm6+rd87VFupDbjEILAXWVzKkbIb3roLLLh3jSj549zXgiJPdACSMjAC
         2v6g==
X-Forwarded-Encrypted: i=1; AL+hErGjv+pEmiHTTGPfvMqePERiYy2HjETy23x8s+8CM1+kGyc8MtMqBAIvzUy04+jUT7Fo+ltAIVIkvsc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8meO2Jb1zir/fn7Z5DT2t3mwAL2tB0NcSS6NC7CIaXOUHVZOsJ
	4lYNBw6SAVxcNxwXKQ6b3Ut/RQwhlzghgk2bUg5URWddqDk5sgFcSpW1
X-Gm-Gg: AZFdTZfl0l5LtxZZq/4aRkb1pzNH4QHPKmv6Fxiu2Lb/YLY0GJpUSvZ2ibFyg5kbB86
	xqSqKuappP6jx/W1UVYLMblnQj3vlaqnSVpDwXqL2U7DbaVVF9gtBQkkBuH/tFz5hjdxIVi190d
	LRkxx5WIYigyiWpUbT6JZccBEJG8aRCUDpIhqwFX4q5qxbujFF/2RhWE7aQds16KbZvsBBPUWn3
	fpmHks/f0/NrAiU5MXZLzppCkfCYEVy62m4KHKEypp/eK+Fir8xuxqDgxpIGXXUtWl6E9OOmAOZ
	JpaaCFMBCttNLRc8p6phjU6BrLgxZlIk5oMQrnjm3L3ixUZtyx9sQaOjJOmYDeJ3MlJI4dXZ+rz
	mCVOO5686jcFG5QqSNXaKHSeJMNBvrr2GbYYdNYCrqktSI6eEbn4YzMeehGtTXEGW/4gu9qYkqR
	QqzGRruAjrBrf/LmtdvGkHTjkXkmiC2ODVK13QN8gne6ZgR+jOIsMUO3U5ks6WJsZHBPOZTQ+g0
	kF6dtpZkF7J/I1HtTYqi1C07Z3CVLgdLyq+sYgd3jOkET4EdwQi+Cp6DlzOaRUbEH7MhJZuGYZQ
	7icGyzO6YHywN0NyLBK2lDrKXOmPYo4SfMg4br0BniHjUSqIYufpuS4=
X-Received: by 2002:a05:6512:12c4:b0:5c1:563f:ff23 with SMTP id 2adb3069b0e04-5c1bc84ebc3mr3803268e87.61.1795503630067;
        Mon, 23 Nov 2026 23:00:30 -0800 (PST)
Received: from [127.0.1.1] (ip-024-180.users.dtel.ru. [91.210.24.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd05e235sm3481118e87.64.2026.11.23.23.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:00:28 -0800 (PST)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/8] dt-bindings: clock: Describe CS7542 PCIe gates and resets
In-Reply-To: <831a6498-9c1a-4829-b47d-52035fe15444@kernel.org>
References: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
 <20261123-b4-cs7542-pcie-v1-2-4cde5201d404@gmail.com>
 <831a6498-9c1a-4829-b47d-52035fe15444@kernel.org>
Date: Tue, 24 Nov 2026 09:58:48 +0300
Message-ID: <179550352887.5.18085137758862458863@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

Hi Krzysztof,

Agreed. I have folded these controls into the parent global syscon in the
separately posted shared-global follow-up:

https://lore.kernel.org/all/20261124-b4-cs7542-global-controls-v1-0-12548785df2c@gmail.com/

The parent node now provides both clocks and resets directly. The prepared
PCIe revision removes this resource-less child binding/provider and uses
the parent. I will let the ongoing reviews settle before reposting the
PCIe series.

Thanks,
Fil

