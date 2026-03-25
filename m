Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9929ACFD
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774410269; cv=none; b=jJY4fQULzQaLV7E7b05jiual/cbveOzWyfLN6jbINoMAqETXIGS/uIt5B99AiUIaLE5Fj/WMSCLsZsWOaB/vAeRHV+YntMHWCChYYhZczzSlCuamNtEcLcKvXmk+JkYYb5H8CNDC2MXoKhXOGFbVh/n+5nGhYFyo4FmlW7ZuMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774410269; c=relaxed/simple;
	bh=V2hJVYd1hopJu3JYCtADEv55ezXl4TYXyI3TndNkRak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrGOKwlIp/rHnYfkMGLOUz8RIFWpOu+n04+qtNcVI6Osl+LI1o00oB9ZZ4z1zDapeWGiD2OkE6/FvNzcKGI17P2EQDqw1ZtRtKQ48qPneVF+8OhObB8cCo/+iTjPnltZATRlOZyx29jwPoYME7EjrcaE3nTGXmkeIUhWsTNk+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPZ1pNsv; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPZ1pNsv"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso445734eec.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 20:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774410268; x=1775015068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhuRCOI2Huaf5BeKcgnhFE71gyol/CkXPtMzZK978Y0=;
        b=KPZ1pNsvOeKn1z8V7+R8WCQewd8HBWft4l09uOu6owgXvSfFYxcuVNdN20xY/GOmn7
         TMor0Kci8q+12QPixvW5gTKUEdvREz06ULE17IFnR7k78INVR8dgb8wVq34FpWB5fdmT
         pUs//Uah6pWMB7dxoT4zL6gJLa8MxNk8S3qQL9QXDfzUQUKMifY67UpSPDk4UyCCkiVG
         +EjPhsOeHcok1EDdfeu1T19Kgz0WqJyBddAbb1uiHvwD6dM/CIIDrLEo8W89clqnhksq
         PS8vvNnH5aL07yYVo0ByDNLa4vXADsemiYUt8XTM8BZ1FD6gCCWi12QCPBVPz1nUiMP0
         RlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774410268; x=1775015068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhuRCOI2Huaf5BeKcgnhFE71gyol/CkXPtMzZK978Y0=;
        b=JnFJaELClfZxOC0FgEJr2EHtt5j/xiVLVfk9LsJnPHO3/dt4xRLjMhFc75HGOWUGrA
         2+iPL3FURui/W1E5RBN+/j5cPXvvkEIOzr7ji/ujD6dAKWSHYlGUixu0UiINX78PjBd5
         xlkQw7l3Tz1zRmXN6BcwZD+LFdygVonIWvwtgjkc6XcOwYSZrn/OCaxY5DJbfgghFjyr
         yd3cB3nePymEm7ZCf+ywF4e/79kvMP5dVxuxsW7RPXIvsOZkee8rLJumebP0gM0WgP10
         9czzAwwC53aNJcjCmUeG5vldxwjUz05cavkLQ75AM1VE6LTXMGEmBjsJplHYLZFbewbW
         ztNw==
X-Forwarded-Encrypted: i=1; AJvYcCVp5ksG2vR/ZSt9b2sDeWHRol0m2WEiAoWsAqGJOMqcglmUe5nLBbdyrFIyHGjr2Sl10mCU0tB+K24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYexGqxOysJARPKUGsw9U7jYsXi4alfuDdG9Rn1Sh0Vo8xXhh
	Wpv5wLok0mrGB40fMUX7WHHeNNNlqZaYFcQlLU0TyOMmdsCwwQX94Arq
X-Gm-Gg: ATEYQzzUQ1VPeuiW+sK72B8JrKxRg3Ee3WbzhDJfn04Ug+BglQP7RrreKFDt8Ersgkb
	ZpF1CFRnLloCHFj6sftuHjpQHTv5q9NelKLoKnJw+Mqkwqr7tsRGBR8KoWIVdHvA5hGXbqE0V/6
	JlvwuHEusL5r4lhwOodQa8d/THWpIeDFyqXohQRGSyphU2e4C6ehv0aodO2SUqK2EAk59wYcTD+
	2d8mztvoy5dEsGB36LVkZj0zqAYDdbh6Nw0ughhebAPGzV+/MlGYX9I+2LP5rcikQp6t4c16ASF
	tRgr6H6EFtouf5DdUTTICiVY1QJp2fo7gtuNCPEPC+Lm3EpifWCAGVbItG37PBLQDL7BXoalDxK
	UmZkcKJ/16vTmAmWQUH0RYj7Z5CjXtg7kFYOl+cEtZYKrrKo3ukzCW2ANZ6qNhRR+bsAvqDP2cO
	/Dxdxo1ZD5b5IkYlp5HfZCigjkOFEYMa/ZohgB/18fPXgptDPqARKikH4Q+xi3QOqY
X-Received: by 2002:a05:7301:2b06:b0:2be:6693:9b4d with SMTP id 5a478bee46e88-2c14b4f708amr2708211eec.9.1774410267461;
        Tue, 24 Mar 2026 20:44:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a686:fd7f:70d3:9156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cde3bsm16989603eec.20.2026.03.24.20.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 20:44:25 -0700 (PDT)
Date: Tue, 24 Mar 2026 20:44:22 -0700
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
Message-ID: <acNYJ2dyPaEzabYL@google.com>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <DGZJBMG2Y738.2MU5LXVGEDD47@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGZJBMG2Y738.2MU5LXVGEDD47@kernel.org>

On Wed, Mar 11, 2026 at 01:43:15AM +0100, Danilo Krummrich wrote:
> (Cc: Dmitry)
> 
> On Tue Mar 10, 2026 at 10:03 PM CET, Robin Murphy wrote:
> > [ +driver-core maintainers - async probe question below ]
> 
> <snip>
> 
> > I'm guessing it maybe wasn't anticipated to have bus drivers calling
> > device_initial_probe() from within async in the first place?
> 
> I think this is not limited to device_initial_probe(), device_attach() or even
> device_add() would have the same problem. I.e. the driver core simply does not
> consider whether it is already running in an async handler when it is requested
> to run probe() synchronously.
> 
> A simple workaround to this would be to check whether current_is_async() and in
> case it returns true just defer probing in an PROBE_FORCE_SYNCHRONOUS case. This
> would at least be compatible with the guarantees given by
> PROBE_FORCE_SYNCHRONOUS, but it doesn't sound quite right to me -- guess I have
> to think about it a bit more.
> 
> In any case, given that this is not a supported case, this commit seems to be
> wrong and should probably be reverted.
> 
> I think a quick workaround in the driver core as mentioned above is not a good
> idea, instead this should be properly thought through.

I think the bigger question is why PCI does something different from
every other bus? Why doesn't it rely on driver core to bind devices to
driver?

> 
> > It may not strictly be the fault of this patch - clearly 91703041697c 
> > ("PCI: Allow built-in drivers to use async initial probing") is 
> > implicated in this too - but the fact is that it *has* exposed a bug 
> > that needs fixing one way or another, it can't just be left hanging and 
> > impacting end users.
> 
> At a side note, I think device_initial_probe() was not meant to be exposed
> outside of the driver core in the first place. As the name suggests it is only
> meant to be called on the initial probe() path (i.e. the initial probe() path of
> the driver core). It seems to me that it ended up in include/linux/device.h
> instead of drivers/base/base.h by accident.

Yes, at the time when async probing was introduced driver core was the
sole caller of device_initial_probe(). 

> 
> The original commit - commit 765230b5f084 ("driver-core: add asynchronous
> probing support for drivers") - introducing the feature even mentions "manual
> binding is still synchronous" in its commit message and I think this has never
> been changed.

Yes, when users "echo" into bind/unbind sysfs attributes they expect
error codes to indicate whether operation has succeeded or not. That is
why even if driver is marked as "prefer asynchronous" in this particular
case the kernel still binds driver synchronously.

> 
> So, it seems commit 91703041697c ("PCI: Allow built-in drivers to use async
> initial probing") relies on something that might work by accident. :)
> 
> So, I wouldn't rule out any unexpected side effects entirely.

Thanks.

-- 
Dmitry
