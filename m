Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620236;
	b=PqQiMZu6kyi9hi0iSAPrLxtulBKHHNqG2VBNv2ddU3reTdXY+3+cCPIzW+H/uEhAryeK
	 XuiS/xYBkHDMzgewA7AOCn4iBCgFexLMxCWUjgfgDeOClZrI+hG9jE1EsJKXcDKx2Ievi
	 bR88nsE27VbCrgEYJDGyVrswgydluYG4lYm8RwNi3jItHpPVvSPG+Sv7KJLYjAi5B9anO
	 zjTC1U1sgQkVNbfEfp9HfxZbzW0dPyCKL4WYWxwZuRPQ9hWk77G7exZI8hPHDWgwdHFFi
	 hbtFppcoeCPQMQSAaerMe9mU9CytX6uLpZqd4kAawylGxm5X+No+aonG4xa9dRP/QVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6EawhG+KLo0QFi1RDOt/xFrv1BkUvSlbwXPxTKgA5RU=;
	b=xFQ7xK9JNCzUl+CttvyWEzTqb7sZ+3HwAqg+wI5PtV1FzD0FwfDaJWFRlKOy6Sx/sqwR
	 yQrrgKVSlOgEa7/7mhEffTGZDqKejzr6BsG+XXYDHIbr+0W2b5kpZn/qcmPWRk89VAk5E
	 D2OdSTgikj11vZ9xtp2lzuH7zJkIKCXI23Xn+rzV8+5lpzGWEZV1+2f/+3Rdx4yxFumCg
	 mFYxHDTD8p0+GfC42LELujfQh+gc+6B2GLKohCk4G+NaR5QiSTtM+7WPxnvZC9wuNdNVd
	 Mduax1jkDXmA2etGsozG8jX/YnKZlqkhjAb/b0b4Ld3+b18rFfMHzB9LXE/Pw+qt/YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HV59Go/c";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992A9606A6B3
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 15:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 992A9606A6B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HV59Go/c
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a68f888a41so5409285e9.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 07:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620234; x=1796225034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6EawhG+KLo0QFi1RDOt/xFrv1BkUvSlbwXPxTKgA5RU=;
        b=HV59Go/cpYxcL5WAtD+1Xny/BMhy0t9/kE+xSUBeIAXT2ybiCQLIyTQ4h3HkOSA2iq
         gNyH9I8G/McXyIPTXuzl14x+pjVZ87BluZhtNOeTcSGH4nzsaFp3M6hxc1PnlWFzuXK3
         QNdVzw/Aejc2xEcOcciscKn5TAVulJgU5L99QIYaUJPpzsS92Cd0hVkaEzdBtnIwti4U
         pxmm7IGW1a67oLYNGiSKwli/TzIA8SRprYd/iw9Ry8YwYmozZZAGEDyTU/xj6VEZn/be
         2S4/cgN4xMsLbNse50VLvxG0hag43J4BvpXXIFgacs9GnWPvyHuoy1fRcnJxLdGbM6vr
         erGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620234; x=1796225034;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EawhG+KLo0QFi1RDOt/xFrv1BkUvSlbwXPxTKgA5RU=;
        b=OLWl83a8OFmxDexRdJ7hkbU8YkXTr5YtW7iDhhGUkdqlQ4mZ6uddxXDtK1P75AaluQ
         YPJ4DCAVdJraBPjJT3oLoBqHOgohmej6Yzmp/YnfM6PMWVQZV12BylsgOL7mDtTRwspc
         4hShzLvLhllXB3nYNfML5HSL8P197bIK5m01G/DBCztMC7t1wlJ6f2l47+PKBrisRSVV
         Brzao7zl5bEPkZWFuXvbht+LH4CpUtSg4HlcX5vy+UU9JTVeyeeuDEdeVIn15PYs1aft
         OsuWcMb5ELCztgOb2bbhDh0IUgidXNNprXxXliuK6UPvRRZtKxttru2dKzUxvCUdKWhI
         d+eA==
X-Forwarded-Encrypted: i=1; AL+hErGBtzhbL+a+58yrCNOLoYrKpFLdx7QpRX+wQTMpFuvW01fzJBu3JNVlhnKmJJcyG6U1M7lRJTm6Fdw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pR6/pWtcDKmfkX5ialqdLeVggTRb9BrHAdKhmuLgQmytUnbdI
	/iPMblItljZMyutrTsg4AYUB4DjRzyptf5glJsZ71KxsZTBDgGJRB1XC
X-Gm-Gg: AZFdTZe0U/b8EE+Uq0Wo6t2kKXZRi206Xk7Fq1tKXlYmHP9Fk4WrkYeG7upXsN//T+E
	elo/P4y7rRkhu8z/in/gSVBI0aHePteYh6QFgWa+RieJJz8otJ+qh5Z1LTO/Y48Q5D1nPFwjc4r
	FuK2JzbeArNnpIK2MfTJ8eFJp9G6kySPe08jQNioZfGYQPjqttV/3dEVirhjPAWNNbSYL2z6csg
	r2HBra+xeIVxtLnRBaGWteHbPDnNlVZyrwugchB/YBnbCEF34ZYbSd+AbFJPZ2VQ5E3zjAbl4Yz
	9vNRWYZlO4UQZAC3DPHikdR0BHVw2hjLXeptQ72LzObZUPPaBR6Rv1Ncywyi0mjOMifnizXa6Ht
	X+kZolrmZDx88OJ7qOWv7aDBFl6TqoGXxybcWWGQadgwA+QpTaTG0DfS+rI9VSSfqMimX3DUdYb
	po6vkAvqPHRD2Z6zU8ZARtV/Z1JflSFACdYny854qoT82ajUiUYjT5s91Fl8KRGdO76N0/c6qYf
	BBmcIRTn9q1ykWvQaGHFzFw2cYFmeM5E0YNh+0pYBHJonTB+JW6VOlDzxlVZuWN4SmJbAP/71MA
	OdkFiDhGN2ajalZ9KAzl
X-Received: by 2002:a05:600c:8210:b0:4bb:7ad8:99f2 with SMTP id 5b1f17b1804b1-4bb88785da4mr344398855e9.0.1795620233772;
        Wed, 25 Nov 2026 07:23:53 -0800 (PST)
Received: from skbuf ([2a02:2f04:d401:2601:d3cc:6bc:a861:f9da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906635c7sm316515815e9.2.2026.11.25.07.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:23:53 -0800 (PST)
Date: Wed, 25 Nov 2026 17:23:50 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Aksh Garg <a-garg7@ti.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rhys Tumelty <rhys@tumelty.co.uk>, 
	Manikandan K Pillai <mpillai@cadence.com>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Hans Zhang <18255117159@163.com>, Yao Zi <me@ziyao.cc>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 7/8] PCI: cadence: Use phy bulk data api to simplifiy
 the logic
Message-ID: <awb9XRze_e8xt9tA@skbuf>
References: <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-8-inochiama@gmail.com>
 <20261125043639.249525-8-inochiama@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125043639.249525-8-inochiama@gmail.com>
 <20261125043639.249525-8-inochiama@gmail.com>

On Wed, Nov 25, 2026 at 12:36:38PM +0800, Inochi Amaoto wrote:
> According the document of cadence PCI controller, it use multiple
> phys for multi-lane setup, so replace the loop of phy operation
> with phy bulk apis.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---

Minor nitpick in commit title: s/simplifiy/simplify/

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
