Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621185;
	b=MVNhLonxrC/SIveWZdZ389QqFSTVUJo/9R97u0PCigbJiXz2ShIIlj+MZmqxfV3lAYd5
	 VvdUbyPiDhLEOod/rSrp4SM6ALTbHQqKK58d01j6DqogsDZcRrV1RoAdX1ws9CewTvlkE
	 LhF4oHrz+aLozij5t3DBTL/ULZCjQMXL7O2MmG4uFj0NrIf1MyLf2E/4PgRaGOtl29NCs
	 6jNdcCnnVECPl6DVNlSqIxhxWIelQwSZ5a4FwrdoEJE33c3+ey7MpxqgfhlHT2HreL1CT
	 FNs4EWDo8oyqyo+2jVSqTbGWrC/iCLqkjAV+m/0YG9C+gwaxOQFyOTfIRXL6XYKJSlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=03OK5Wux5qBQjFwf+S+X4PZ6SO+iKxNmDWiFlrnb6so=;
	b=2q4eR+3IOI4IiipJTB3WjgMfDVLQi7cN6mPZZ0uS7KRr9BYJd5Fvl60ODp2mp0g2qUmh
	 YSQ0g8rqj5vWUhIqDNR80sC6Pnh5Gzm388XlUlpS+8bo23knznjDLsF5YHY1kuuD1Hz36
	 IoiifaRPSX6eVifEkKwEdhe9zsVtoCjFG+1dDy4CXKe6NkBXCUmQfZp0L3mbdodRcsC2A
	 uTCaS0vUVqHFaIGuYJHRGVUt4c0/dAnED+27LkG+kxpo2H5uPnCI7/Qa+K5otOb4p8F7H
	 vn9/M8Sai7ETgXxzA5a7E3yvj75PlrQFz/W1nSC2UPEVPuqsN45GQmTiiSD2O3bnrNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hZQkKpXf;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0843606A684
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 15:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0843606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hZQkKpXf
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso13424315e9.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 07:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795621183; x=1796225983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03OK5Wux5qBQjFwf+S+X4PZ6SO+iKxNmDWiFlrnb6so=;
        b=hZQkKpXfoPCNOyIPGt3na6gHRDhBZ+SSP/SQA3rJHJZdqSm7Rqn+twjMd52AxubyQy
         vFD0Pnc3F4zWRaYn9vD46oH+u3j/NCE+HNKmR1h2U/ppARV1FO/vO2BXMGPp/imJBe7u
         CvqNLaHed8HmgawaaW54JlJPeoQuqrxdGP/0oHfFzObIHwATnPXumKuRH8eMi2ZyEhZ6
         qP0qxR9hxQZg2cwbh3S5OEBOng0kR2oEwMCPDOam3vgu64CMxGn4YxodQgsb4zQSAWWB
         wr6OLfgnXVJ2zeJLop02n0YA29iRtXdPDVrr2CDA9IG/r8zn0oKNfI/MqSZEr7K/Errl
         bQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795621183; x=1796225983;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03OK5Wux5qBQjFwf+S+X4PZ6SO+iKxNmDWiFlrnb6so=;
        b=T3iSotkxMP5Dl7yidXVWatPowVrlrWyTaUYw1fXgQLxgE1jgu4QPoSfT/61uBh6hRQ
         tchY+WebpLpqd8tN0RwfIEzDiSnv8CwoigNXuIJDFHobBg8cLcIdkzkv+4GWrVv294EW
         YUmW/e/cCKm0UrVihPWjLkCntW9lxGg3ZIE0DjnbiHREsfKLFIO+AGExfh+OeoIPQezX
         2PH96DbZBA165hAPT1o/gUKMXB0e2SIjDWnLis+4w2E2VV7g7IxPkSP4DbQIiznx52Xa
         HwUjwuTYQA7AZYQ8MDBi2CFPi1kUP1XTSMPpbHAymTaW1ZBdJo7/LgxWLIeSq4+oMMvo
         YvMw==
X-Forwarded-Encrypted: i=1; AL+hErGQGE2nnVxdPI/0/TcEsRfgVgLnY5uBIwT23T7V4+onM6ns2aqSdOQOs2/x14aR5FYyy1CGpOnvi0g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8O5NGYGZlfKz/MCtnimi/ImE/Fhj9R8KU5GjvYyLBhckMx4dbg
	7GwWcrHdf0iAmWMG55b3+d9+bdL25lOSe613TAcR0LcmeVoPNpxVseWa
X-Gm-Gg: AZFdTZd+RZfAzjGHxcGjwdIfylcrK6blXq7CJyOpllmVxOLbh7UNuoG4PlPP7yCvF3S
	yrEDRn7jEaAPbps7CedUw4x7Th4I3qokpXGTuX7pfoyljQhsUJ2hfWpQ+aZg3queGXfhLZgiLCO
	MDZR6mwYP719h3ivjoiRdHRxtZ2K/dCYdxgj602VLMslFGJ+o11SMawwbXpJ0IPjOr8R5p2cv2V
	py56Ehc/ty3KJ4QlKjsAY5gfbRuJo8yoWfnaJm02rhEm3iF6gzIJNnU6Thiau65/ZvrcLej0CsB
	4UnDkhHdOWjKW2Pqy4nkMSsxnUlGID+3Msj14ZlZ1WzVgfhyUSfthlQrwkJhGtwmcjRKnAUtSap
	6xqLAYuXUv6/A/yS1FKCL73/Uf9oOQfZZ6V3J058+URabncbAg6mNNW3SBSj9ihNxwNizX4TjEl
	/ixn5XdZLFegpsLtFynOF9GTYiPoZ6g8pOMGI716PYnFhO6LE+mRMjFtkiphUpU5fhgzTHwXCTI
	lsAtVfmDDp685ZnLrkNtNVXazE7a2rfuj8ob40XYVNNPFjjhrJEPOr6GPi5waFw9G/N205vYiS8
	Oa02GGmXCAtLBB+KLJ9V5w3Ymok=
X-Received: by 2002:a05:600c:828e:b0:4bb:7ad9:2f22 with SMTP id 5b1f17b1804b1-4bb887853e1mr340731425e9.0.1795621183256;
        Wed, 25 Nov 2026 07:39:43 -0800 (PST)
Received: from skbuf ([2a02:2f04:d401:2601:d3cc:6bc:a861:f9da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm474497565e9.9.2026.11.25.07.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:39:41 -0800 (PST)
Date: Wed, 25 Nov 2026 17:39:38 +0200
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
Subject: Re: [PATCH v5 8/8] ata: ahci_imx: Use bulk PHY APIs for calibration
 PHYs
Message-ID: <awcBID5pfFm2FadY@skbuf>
References: <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-9-inochiama@gmail.com>
 <20261125043639.249525-9-inochiama@gmail.com>
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
In-Reply-To: <20261125043639.249525-9-inochiama@gmail.com>
 <20261125043639.249525-9-inochiama@gmail.com>

On Wed, Nov 25, 2026 at 12:36:39PM +0800, Inochi Amaoto wrote:
> The i.MX8QM SATA PHY relies on the first two HSIO lanes for shared
> impedance calibration. Store these calibration PHYs in a bulk array
> and acquire them by name with devm_phy_bulk_get().
> 
> Initialize both calibration PHYs before powering them on in lane order,
> then keep the SATA PHY initialization, mode selection and power-on
> separate. Use the bulk helpers to release the calibration PHYs after
> SATA startup and to unwind failures without repeating power-off after
> a failed bulk power-on.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
