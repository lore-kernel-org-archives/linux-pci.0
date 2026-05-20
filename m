Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C53E7BC6
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286741; cv=none; b=EoyS0fIyS8mnnSqrX5ZyegZb6EZqCdNIsYmyJxb54f6CHihjh15bwwNn5J/cacpwNLT9EnPmFTEmVWFCmnVNx2K7/ymu9rLE5e4rKjNzyDZqSX+O/dL9Zf+/h3IPDFS6Ph8SMi3cAr/cKOgBsaX1OgS/8HNe775gYFqlg2hiVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286741; c=relaxed/simple;
	bh=SVbGfRf42/YpRtOvkubvp4anUHrMvLtMBHhgTtWQnfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3SNrXYd0HrAOFsI2tAtrBc+vcA33KyRcGE+uLm/5ThByRFcFZRO01JbffhNSvCB0ntYNdj52Hwf7JsM1UISHh5NTx+rtOCL8RNXYjQna96Cgh6hBC3eYV6zQI1Lmnfu8c4uM0UdxqWIwEZ6rZlwnGW98t1LkAirnNjM7PKJHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSkLvI7b; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSkLvI7b"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f0ad52830cso6247850eec.1
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286731; x=1779891531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vyw5z+cwPwEeTdxGP1e0+U+3uquisZZyqDCM4ankidw=;
        b=DSkLvI7b6i2vq92PSx5mKBVTl8Bw01nseMkFEzZBH0bQG3nBoP/mJ+FmhlUJGQcuGc
         LsjTwrT7XJfof/GCQQ5inuAJ5/XkEvS0aqmr5mf7Cyzy6NV/8BpR5cb5/xvHlIedMG6G
         GkzRPFh93zmlpW/w5bML8E9OPpgU17+HBN0a4otD9x8LMIe/WBJgRLhyCTt65p+YYTsb
         uCQ2bz6bEepWi6iUcdakskDhjCj0OVFtZhOfODcp9I1QObK7GvXN0Vl+czerxIPQoE6w
         xJPqUSX7Su2kFY2/O/Fdqqh32uISEAe9J+fnoJkoxKg7ZvlwemkZJuQ13JmR8d/vjoqC
         7GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286731; x=1779891531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vyw5z+cwPwEeTdxGP1e0+U+3uquisZZyqDCM4ankidw=;
        b=L0d3B69YOEEZtpqE1LsKa/k3ZUk2XNs5sqFPPHDBcakEW53gjfKS5v0jYz1SfbSvUF
         N43SwQbKfi6Y9dT8SR/0I8nSLr0UE7ZNgYRyfvds9vkIomDzsW9b2QIojHfc2I9UZv84
         cw1YWSSCFpK1IBOOMNh0Z/WOXvENHsurBEsc9ZDilxgI5KoZ8ilgSPnao+k5Ao88Munc
         OhgcJXUztTRK+R09VyrMbjlKf8EIoFmUS+qlPXGh3+y33r1ldC1hDetiB4JlaqakUNLS
         J4PD4IrVLgmy7ZBYVg0c87sVP053nceahjUHvuAMhUk3PoLrHVMBguJhRhJL760nj6bO
         3kag==
X-Forwarded-Encrypted: i=1; AFNElJ+IDUlPC5TukhaZB2CJ/YAJaKPKPeGIe2oh1pvUdBJZFxDfhqCSTUfixwOdphGB/2yakQwYPeHr3TE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4zTFgHynQY1m+XuGpcf/2XkFa1hcO6+t8AuMRWQKBmaXzL7E+
	dR25j9cMfPtu39POynxqAKurJsyenr4UZnR45iQPk4Vcoxhhw7gcTcQC
X-Gm-Gg: Acq92OE+OZrxnkthiK/RyOqjYSPAd9Vu3YnK43Wq2S29Q1tLoDUc1GqvAYU2kx1xVje
	Q3/Wm9p+e2OcmhplTfFGJXEYPjsyOaxpFqf/nnnh6c83ubnD94NR479iAEv/0V07moOKMLSvAf9
	XUOBLf9Jfn6GQfK8E69K/KjEzKxvpYPguUA0HAPvCFTInj7PrdE4fISukhWkhFHRkthm1+Tl59Q
	2pNXkc0wHa6rPOy/7GJR70Ymvm6thGJPh569UxTX+sjeNUSIg0pwoJzmSiHpE82umurJItm2Pxv
	TxNG8SVMoiipwUi0sr5uYdfGsKxlGaUbvJOIPfty2qdGFGMNBlhFjpw4peW6WFRAUUGzeVovFSi
	IEZ360joJI3PgfBi39FyoLbVdZuDqpPgxlgOX6qrnyKQJkFjxjpgkXefRV8jIHydEA3hQB6131O
	HshgipwkaU13h2emLxbZaaZKUIOVrXNFQvzo1f
X-Received: by 2002:a05:7300:a94b:b0:2ed:a64:a457 with SMTP id 5a478bee46e88-303986552f6mr11202553eec.20.1779286731120;
        Wed, 20 May 2026 07:18:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6adsm21432427eec.15.2026.05.20.07.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:18:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 May 2026 07:18:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jihong Min <hurryman2212@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	Mario Limonciello <superm1@kernel.org>,
	Yaroslav Isakov <yaroslav.isakov@gmail.com>,
	linux-usb@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
Message-ID: <06236462-6c4f-413d-8324-537fb8f743d9@roeck-us.net>
References: <20260519000732.2334711-1-hurryman2212@gmail.com>
 <20260519000732.2334711-2-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519000732.2334711-2-hurryman2212@gmail.com>

On Tue, May 19, 2026 at 09:07:31AM +0900, Jihong Min wrote:
> AMD Promontory 21 (PROM21) xHCI PCI functions use the common xhci-pci
> core for USB operation, but also expose controller-specific sensor data.
> Add a small PROM21 PCI glue driver for AMD 1022:43fc and 1022:43fd
> controllers.
> 
> The glue delegates USB host operation to the common xhci-pci core and
> publishes a "hwmon" auxiliary device with parent-provided MMIO data.
> Auxiliary device creation failure is logged but does not fail the xHCI
> probe.
> 
> Make the PROM21 glue a hidden Kconfig tristate driven by the user-visible
> SENSORS_PROM21_XHCI option. If sensor support is disabled, generic
> xhci-pci binds PROM21 controllers normally. If sensor support is enabled,
> the glue follows USB_XHCI_PCI.
> 
> This keeps the auxiliary device available for a modular sensor driver while
> avoiding a built-in xhci-pci core handing PROM21 controllers to a glue
> driver that is only available as a module during initramfs.
> 
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Tested-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

The two patches should be applied together. For now I will assume that
they will both be applied through a usb tree since this patch touches
common usb code.

Thanks,
Guenter
