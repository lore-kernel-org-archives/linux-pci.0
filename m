Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A236657E
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105153; cv=none; b=p7cdAOMJX76eV/3GDYgJpBRrStphmfLLq8c9lClaOthfQaGscSEDvrYl6DRI2k4bVaW/dSgKzytCz+0zY/I2QR5AElCvO8Hr78fj+g0LHf1Gmf5SMP8p5hZuO7/hOudeLbt9VY5TUvBGF7Ihs+Bs975MRtpQ9lItpn43q4rDsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105153; c=relaxed/simple;
	bh=X7aGML1SMAsWeqcVjsSBRTgitUAtQY7ToN2QOukGVTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHJAop1Qcfd9hQFtmSZd+tv/9QzR3Ibv4GjDIqSAlSHtOxv5ao0wEHjTVt6uyDMP3cu+q/x8hErGIoyzW2Wlbb2nds2MJWEZHKkJp1pCwKCylri2sJunrZCiazpkVwfWy2UAP0dD+7dziCzwxQTLGxhLwHrjsD3hyV4ysA2gk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cm2LCEH5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cm2LCEH5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48371119eacso8715935e9.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 03:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772105150; x=1772709950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/CkoirfCooP2OVGzq7jy6w3vIPwFS3mfXfxd2A0Wk0=;
        b=cm2LCEH5bDqmlGU1CFDcEAYlfPhu+07QiJwdYpWhaCkEjylib10qs4pthcQnTl5lja
         btNP9gFWUEHDH3Kqlr/qE/suHXKqs15KvhT0X5hpMsCFhSo3dIzfBk+eekuFuEk7Yhw6
         iwTq4ZVt0H8nMYS/pzbbdP/aXYkQLAPQa9Xdhu5+z2+1IoboS7miq+2ainNYtCpuxw4P
         EqPlCsAEl6P5vflaR0gMFIviAmXlGSrK4C7PtW6srUdYI66nHVDdyThZa60LXXUiVXQD
         aKxd3AI+iZMJ9BIU0wRJWgBoeplr2SN455enou1+4SYdX3yKGqNT0Y3GJw5AIw0oQMSB
         xH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772105150; x=1772709950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/CkoirfCooP2OVGzq7jy6w3vIPwFS3mfXfxd2A0Wk0=;
        b=cmBWUG8erVMYPpxWcvSpx5Ydi64koqzuUtvfIrlFNjSePcumcNL4/q3PJ+7s6D5NqE
         IdWSRizBvLDSIbR6LUu/oIoLlbY9QWrasvTFBCewUedL1RlFWD6vbV+BGZ4mfBx0KRe2
         ZwvMeGRYAuwWrQDLBgPTzqWl2uvn0/+Zz0Rsae6Cz3hb3srYDeekPV3AhTI1yahI62BA
         ofgEtrkGX0y92USqwKjVKsw+EuKib3MHLaWezUfiWZaybO0W/Q/yJtbPg+ZNocL7I0cd
         ABt7h94wVuOogVo3KPt+tfwe2W/LYVNV+rj5O1mA4E3wpa+2uLOC2jlDHk/Od3sZaNU+
         bqhA==
X-Forwarded-Encrypted: i=1; AJvYcCWxzjVW8zP5Rw7cMcZKRAuY59DxlnouKmmTd+ZlpXQZ4sKDnTLYuKbk7+Ee5/qmqepog5ciuHNYyTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1u1O5h/pBuz8eS+ac4QFFRkWNK0BlpXxH4YGueSZ6IXT7VtvE
	ZOghiVtnY0fv6Zc5Tx7RiinV7x+LsNr484MA/W8WnZBtVDINOb4N6sK1C9dhyAf8m4o=
X-Gm-Gg: ATEYQzxK/h3aMPnoCwJ+EmL6pC2wVVTvwyMSOiR+au5D4m0UJZ0Ga0OkM0lpRAfEj1Z
	BUV31uRUP7RL0999virVj+yr3CheJVW2giWsmhN5DAoBZUjpTGkPneJtU3A7FW0gu6TiJoampFq
	6Wlbg94ywq+MNl83UCCIziXxi6CnaSuEcd6IzHieC8Veagb/rTW0tX/nyPwpVaSE6KEnrRFNuZI
	2fWFv6R1PIoN6199fbhJZvmeqlxaOZdelP6SMiBPFp+0Yy4/ev0KuzUK4K7k6KmcNYVYOPOcbtY
	LBq7aoWETobzjVcKMLJc6OCR315QRFEUsgq/0yIkkI6iuyGvyxcTJtPWhcq7ubFfdql/iMmBsKZ
	p047dfxS9gIQlUeDK8bqG3nsmsGwPhY87TXvcWKHvtjel8mmrsLPcrBob/teMDz69AGzfUGWSG1
	eLl1Af1L2u5sqNDWqpHv4jLQPUKkLJpw==
X-Received: by 2002:a05:600c:1d1d:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-483c3deae7cmr28250235e9.26.1772105150104;
        Thu, 26 Feb 2026 03:25:50 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df9fsm148537245e9.13.2026.02.26.03.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 03:25:49 -0800 (PST)
Message-ID: <b8705677-67ee-450f-b0d5-8e79280c854c@tuxon.dev>
Date: Thu, 26 Feb 2026 13:25:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/16] PCI: rzg3s-host: Add SoC-specific configuration
 and initialization callbacks
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260219223542.6364-1-john.madieu.xa@bp.renesas.com>
 <20260219223542.6364-11-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260219223542.6364-11-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 2/20/26 00:35, John Madieu wrote:
> Add optional cfg_pre_init, cfg_post_init, and cfg_deinit callbacks
> to handle SoC-specific configuration methods. While RZ/G3S uses the Linux
> reset framework with dedicated reset lines, other SoC variants like RZ/G3E
> control configuration resets through PCIe AXI registers.
> 
> As Linux reset bulk API gracefully handles optional NULL reset lines
> (num_cfg_resets = 0 for RZ/G3E), the driver continues to use the standard
> reset framework when reset lines are available, while custom callbacks
> are only invoked when provided.
> 
> This provides a balanced pattern where:
> - RZ/G3S: Uses reset framework only, no callbacks needed

Some callbacks are implemented for RZ/G3S as well but they fall back to the 
reset framework. Could you please adjust this line?

> - RZ/G3E: Sets num_cfg_resets=0, provides cfg_pre_init/cfg_post_init/cfg_deinit

There is a checkpatch warning on this line as follows:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#19:
- RZ/G3E: Sets num_cfg_resets=0, provides cfg_pre_init/cfg_post_init/cfg_deinit

Thank you,
Claudiu
