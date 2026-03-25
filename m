Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673633DD537
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452423; cv=none; b=b325Ccx4EXgC1ZN7SLCLsQTuIQfm9Vzb0dJxln9ORSiCDSM2wm2LGtUgCiYU+97TJyVZEa2ObBtO2Ww0NxKUxpiIweW2+I35XBTAuS+45ejaPCQgLT5XCBmz+0EXkgJeyhGVhjDiFeRy+d6kZaM/KmyD7SeTcMoQuq+9nx1o7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452423; c=relaxed/simple;
	bh=4zJ9kuB4IKFJzdsZpa3R5DFf2TSSq4O/xCkauElOD94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF4QKm6BkCpPJH1zQqQ+Jnf8eziJJ480qRRg4Nyr08aG11vkA7Mt+qjWzdCYRbci2KEN/Uy42Y7ScSI9bjW4fjI8GHWlFQEDpAYCMzYRDEKsa/1woTpO4WVOc66LizUP2iC0yvTmJMEjZuATQ0z+PsxCyhNzXZs8uX3yC4QS6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrfFv1ef; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrfFv1ef"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12a693cdf29so994423c88.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774452421; x=1775057221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=khgSvsFz4BGruQneZts97/YH28J+KXY7YhwPuOZLH0c=;
        b=hrfFv1efQbkszJY9FjRz0NahyeczR7P+aJZXOQpL/T9c/r0j2dNhhooXkGKVCGD7wO
         5lOH67nPFGbLz85xCwXHgK1Kqmgpa2MgbTbZKvXd2x4xrbGmbmR9nbhJOTQR8sxTGIM9
         9ObUS7qtBXT1Bg0JHNwKF06FidIuJIM5PerQQlk8SJMoIL2ymko0c6L/AWLF3qY6wfhY
         CUGDbBHJJQcmhliX/Xj/ZyTzUJj80p2yB3qque7sxYiA5mPN740WZFOa0um9bQRZAL+w
         Chrelqw57PDA+ccxFkj9hKpoSvK+Bx3NRUNP8UGujKJ+5rx1rSYtLgyQ9rnrG+syrVDo
         hF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774452421; x=1775057221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khgSvsFz4BGruQneZts97/YH28J+KXY7YhwPuOZLH0c=;
        b=cUTwhRnuPKhurEB/aUczh4AXgJy61ksehRdKfPbB1/sFlXz0K7DrWWxXeb8s4qkA9y
         rikS1UWC7WKe0VPprKN3EL8x4yiFa2xoEAmCqtAQiNjRmypEwkGxLZPYGECT1fweEHBP
         GE5/iJA9LARbcwObTpEadpRlT72eWX5TB65JTWtW3kNxYdyRjSXij+m0eEK86FZfbCE3
         OZD9mHapE02jaE2IHqOt/BBwW1RDtpw7tptVP5TdvXcK9EiJDpVg3oKMvU4sJQ+OayYI
         0S51DIMSZIc6GWiXl3pXOWalqrxP7XoDLSOGb+QpjGpvklPrfrB8WyoCIfGl1p/gJt2J
         +Tew==
X-Forwarded-Encrypted: i=1; AJvYcCVGoIdCjtfCMMMxcsGaSuFd3+lmyKLhD4ALfOmBrG3A+bhDg1+NRoqaaqILBHZBL89TsYNPnjdhI1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+ERi5Io7SilwcJ1K855U3d24XJJRfnmKgCOFKKBQURwP4x69
	l8cyxuG+7Rvlf3IeZe9pO8EEsv/X8DbB4YW/tfyvywEg4l7uNLRQGd6V
X-Gm-Gg: ATEYQzzdKqHg5vGZoG8TxzOQbOlhuGXhe+KsrC4MSpROGAx2K5e0u0SVJ1Tajutd75S
	MNqisOeBUBbNKMKKsEdOPvFlQda6DYdpemxjjQu68JUV/F79HoXhJwdPQujxoDXAk0XDtiqXqe4
	uhfXLVcaQVmv7A35+FIrpXKRtBxTLcxMgEr2d75cH+KJpW4/cwFS8+fNwNEbQIaUpN2e3WEOY1M
	kquNqvcgEpEVzcj2ZYRfkCUx0uLOwlb97XVhYb7mygVSWdHtfQ5Ck/kLFf2AqMvBTL21qQbP/kF
	KLveLGKorMRh/VrvdCRMt9hWabpg6VNTdFQNadD+qv3PiCMM1cImtxeG0yZCQH0Od73a7WcjhXF
	e1OHd8miyKPtXfWHLDf/ckMuHqZyuHN+t4Qpp6m50trlPtfUFEyKGAfN/dOG3GPgYsYq7vFDpPf
	r6FSd/mZ2XkfYkFlOovXR9Bh0SkhgjthQmunTg6vQCIIwU28E48RL5GByBurDFQpeX
X-Received: by 2002:a05:7022:220d:b0:128:cf41:d6e4 with SMTP id a92af1059eb24-12a8e1682e4mr3485083c88.21.1774452421364;
        Wed, 25 Mar 2026 08:27:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b7b4:352d:eb23:66e5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa76243desm44594c88.9.2026.03.25.08.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:27:00 -0700 (PDT)
Date: Wed, 25 Mar 2026 08:26:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, 
	Grimmauld <grimmauld@grimmauld.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, driver-core@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Message-ID: <acP9-AfUQ7zp3kMS@google.com>
References: <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>
 <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org>
 <55c28218-1638-4b90-a9cd-a177fb5abcb6@arm.com>
 <acNgUoWWMCi1oLU4@google.com>
 <DHBYL7Y262J2.263EOC2JNN4RK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHBYL7Y262J2.263EOC2JNN4RK@kernel.org>

On Wed, Mar 25, 2026 at 04:13:03PM +0100, Danilo Krummrich wrote:
> On Wed Mar 25, 2026 at 5:13 AM CET, Dmitry Torokhov wrote:
> > That means that you are kicking the majority devices (for now) into
> > deferral path. I do not think this is optimal.
> 
> That's not necessary, we'd only need to kick those into the deferral path that
> have PROBE_FORCE_SYNCHRONOUS, no?

Yes, it may limit the fallout, but as I explained in my other email
there seem to be a serious disconnect on what synchronous and
asynchronous probing mean.

I wonder, don't we get issues with phylib in other cases? Don't we ever
have a module resulting in creating a phy device triggering loading
another module on the same thread? Won't that result in a warning also?

Thanks.

-- 
Dmitry
