Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329A36EAAB
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468727; cv=none; b=sFcOJTw5QRAVVKqrm8fs6P44iJBJ0ThFenvOPzI/9HIzRes5XfV25vdqeSYvzKkuyGdXf+gsevAoX/W0w8FMdSyaRnl/hZK+S+ylzUYtqHkRACo2NYzUPvZ/zipGLMPOzB9ENxFnnwGw8cQSRaoJb1cpIeWO/LDM5zB6q0Osjfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468727; c=relaxed/simple;
	bh=w0JfEAL8UQJ6mwvoIym34kQuZstRGM9t3S3tUgFM7p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFFL9g+Wbbk/M4Zz25u2tWTZYdN/asDZ03p5KNc2uRuz5CMNF/+fsSNYIg0eUW0QyzO3Oz6cB5pv+wI/DAHho76/gFVDaE6+gxRj8KP5yxkjNDLs4HF7pD9j9P9ig7rXOWY6UC0hpuvJD9u6R802MenA8skssFZWGU3BlcePYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NybzX7s7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NybzX7s7"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b9b1900bso691370f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 08:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772468724; x=1773073524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zsRF/yJZ5HdWuSiQ8L7Xgp4L8TnqAkrXaWtbBnRsnSw=;
        b=NybzX7s7FTuQY3g/l0A65lOcwxaR2inYaNu8p9A3zaC0tf9hayJC6WzIb88ea8wx6I
         WJnkyovdWgzi8cdVZHSNLuErCv/hiAT+gmPVz1AvOxxUbADQ+44TWD+whbw/xiYgWcYk
         CrS+l47SQid4pDb/4GFAahuIcZqojAsT7rHc/GPNeRiJpbzrDY9GuH6hNW/RZiHd46/+
         8mv74ZI8ZEz5Gol6HjzoxqVDA3jO4O8DC0UzEp5iHXLO2isiIDvzZG7/xwS1o6ICPVzY
         gE69PrqTHuFPhzTU+Gb9drGfmMSS8eb8EhusyvkIDwxOP5JHn0x4in5ZQiFrhYjGfwO6
         f/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468724; x=1773073524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsRF/yJZ5HdWuSiQ8L7Xgp4L8TnqAkrXaWtbBnRsnSw=;
        b=i7K39OHkJe6N1JxvajJFS11n/xpAqDpUW8u4PH+93IwIJqTzPuld09w1Ps9nDQx8O4
         7sBgExmjGTADYstqJ/035u1/c+w70UliTdFnBWipBleB1LlGyxgN5RFM9uaNnzPlKZzx
         ucRx7yW/+8Md/LL/KJ+pw3FUF+DjP2s/8BjyNrjJkmdB+XOTI4+3kHYbshhzptkuwMI+
         C4v+LHTXiH8QLTxITjPnKsYHCBZiVOJUg/K8KxoVCsuUbmbE3Eohkt3H9MqaRjdn5AgL
         QntlKS4j4CRblMLzKFEuhmyOdOkh3uxsjqPXPtiCvfY9Xx19SIZdNvLRb/DiF3EdLBmY
         tqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO7lYtiUKTX23k8RQE98NJ/OiOy7GShQMKmeSfPp0Y034bQcVPzDqxyLVanztL+Et3qDLuCK41GYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EoZs4GFzwRyQPRIpwnrckkKPBnVWlAQFnw56aj9xH4+kyf45
	tgUTBobGf8QPMVozN7vtyyXGF0uHiSEHHI1B1EGOLgeEQPTPVqBS5VjG3/85gkzUtMg=
X-Gm-Gg: ATEYQzwKMr4H0HOjd21cM9qGcvXVp4xkQc3e+XwHearixKw3RfMt6Z4MaDbabRF5fut
	SJGt/bLK/+rkEN2vLnC2W756MfB4maBz1L5eIrabrfk94paGAH8oDKo/fplybGcVTZvdHjKEvIQ
	HZHY8T1C3VYn57O2QMkN1vc6wBiEYLjH8Gee6Gohl/8O0NETUg676XKL4Mdq4Rymzf2MtWWTq80
	GHWr9ZV+yVLNVPrPNy9wogeDBLfz1YDXH+YinnqrGc9ukNG27E1Vc6fA0/EZfnImSejN1TxRJIc
	fgt9FqgWNz6cGkiAbNlMRQCGewP5f9MoV2PLTnut58yL6odrQZLv7rsC+zVnd7o1oMfPXwOE7YU
	5TbMEBg9TDJM5j4Dfr5y8n5ofAxsg8x/i7bR8duD7kTe92JYMHf96zP7MfIYMvWA1r9+X5ugRjy
	sveAUcJiCi7ssUW86Lw3SnX+6VOaX2PUyRqd2eKMSlAnRIeL0=
X-Received: by 2002:a05:6000:1acb:b0:437:6629:9b82 with SMTP id ffacd0b85a97d-4399de3aacfmr21667465f8f.52.1772468724121;
        Mon, 02 Mar 2026 08:25:24 -0800 (PST)
Received: from [172.19.170.194] ([213.233.104.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a5970sm5477752f8f.33.2026.03.02.08.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 08:25:23 -0800 (PST)
Message-ID: <3b30df38-3a68-4d1b-9e61-77a80d3fe8a2@tuxon.dev>
Date: Mon, 2 Mar 2026 18:25:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/15] PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link
 speed support
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260227153236.55988-1-john.madieu.xa@bp.renesas.com>
 <20260227153236.55988-12-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260227153236.55988-12-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

Something got wrong with the patch description for this version. See below.

On 2/27/26 17:32, John Madieu wrote:
> Extend the link speed configuration to support Gen3 (8.0 GT/s) in
> additionvto Gen2 (5.0 GT/s). This is required for RZ/G3E PCIe host

s/additionvto/addition to

> support, which is Gen3 capable.
> 
> Instead of relying on DT max-link-speed for configuration, read the
> hardware capabilities from the PCI_EXP_LNKCAP register to determine the
> maximumvsupported speed. The DT max-link-speed property is now only used

s/maximumvsupported/maximum supported

> as anvoptional limit when explicitly specified, which aligns with PCIe

s/anvoptional/an optional

> subsystemvexpectations.

s/subsystemvexpectations/subsystem expectations

Thank you,
Claudiu

> 
> Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
