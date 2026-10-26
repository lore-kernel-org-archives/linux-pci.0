Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040200;
	b=n3X742wnjiGUAa3j5bRgsUvnGnpqkEfwxCU+K34tkdZ1jrARm0Moaj1sCP+wWmo0IlQh
	 eeiRO03BEiqCiWIqRsKAkAE2pnwpRE8PUQ6mtfSBwlLyx+dcpL2ld4+exPKwYrbl62unw
	 9Y2ljd+wq7fVbzGtLv4kF5Qpo23CHizPjpilEUYTj2GE0MRVOE+cuaZXlzX1mHm9YNTMC
	 HUpTKvBNFBkxRldGQeGGi7BMy9UCi4izjsKAlHZ3lt1dGfZDUFgTqZkF9F9tlKziOKDmM
	 B5RVDPHEZMrJfEqZXuZ7mTMxHQIVuHuXxbuMR/9LKm3qXuQCZ8f2zh60RQ+DuCixdqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZWci1OY37Q98PjNDa+DsqfD5q79/im0Ez6T5Vupv1s4=;
	b=L5wrCQ9uQGeNVpsbXOrXNm4pOfH7HwKl+9YBUmK0vOVrSlwqqqQchILYfhsc+MilXRFg
	 Ka1l9Wzi0rmAXdG6WgErSNuSj81ypx4QYdduyDAc1/CKebHnSO72+iTPTaO3EO77Pt19t
	 UZTtKj5AfV8RM3+n4Ai69G1lc5sgCO5KYC7VrBydIE4+OI0pJh6LrFa4mB6ZuHpMZhyux
	 RVi8MIqjjlPbxA1syYBK6BjC5kYZzlnS/2bOzE9Cep5DjFreRK8/LRrXFVBYypL772Vk4
	 94riTimoeBdrMtmvEhIr7oPWwsCUn5e2JSq0eOGjuBbX7B26PiGpiyxhy65S2L6DTBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5B606A31D
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 18:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37C5B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c63449320so9859866d6.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793040194; x=1793644994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZWci1OY37Q98PjNDa+DsqfD5q79/im0Ez6T5Vupv1s4=;
        b=azZPsctqXRKqpOwzOSUanbXvvxd+v2oxaACaz4naHK4U/NBQWTZSH1+8VRwPrLVwY0
         DocnyrGmPyv8LQRxTMk4K4sAlQVJBR98rqP+2aWoEAiU0n2xJtP2lXe11PdsBX9zw7zH
         rykKuo4jE8Sw3g1ZHf1cUaz2vGbXwYAs98RHcsf375OaxpJvYYqyPF71AEMIeOtk1CIf
         vDE/ajmi0uLVqaMusVBTVkVR8NUGi0AybkTdqBwAenvqpPLeBFRcUdif9SgXW44+UVBP
         XcslWkg4kCuQnmXySZ0RwdZ8wSe243a/pyuPpY5dxc6Pr/hlCqlSwaLgYcUdwFY6ZPLq
         p4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793040194; x=1793644994;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZWci1OY37Q98PjNDa+DsqfD5q79/im0Ez6T5Vupv1s4=;
        b=hqOVvdpJfAXdigH04gY+SGF0Fpg5xhfK/phhsW5u2XJ6JGKXJomMC94i3OKzVDd/cO
         JA/VKZf3XBBFG34dYCn6vNj80w+o407hzR/5SvJxsaWgIyRUTa/3etTo8ViqLPoqVp/l
         7o4BoWHg/G+fFtLZTUi5Z/5Fzs9QZwl/7I2t1TWl5Lov/ZnrAAB8untwk8Nae8sQd72e
         VVQr9kiOdOWjWA6IqFWdFFDLSC1DircLrcGv5yQuxAXQgy+U912IHzNGv5kQ7Z0PvgJG
         hc3zUCdN4eA+v5wt+uuoNxUKgan1DnxixGPMk9bzPpC3Qir0Hr2t06CxTn4oPg6K4eSz
         +ZTw==
X-Forwarded-Encrypted: i=1; AKwUvBywAZm/DPPl7JR6UJndVJBvDGFU7ItC6LS65EyHYWj80F07zjYhWs6TGL4ElWxBa5Vls1Bnobt0kmA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYfRovCuIV4VMdBbE5gL01ynK9bDEDrPs+QbbxiPCyfAUt4jg2
	mzXcr3eSvYMOXHLRQRytRdafej6rg58uagB5BsK22jMWEdgIxs6+QmE+zswF/eLqj6c=
X-Gm-Gg: AYBFou0vUJGcomevE/s0p74HVI87ybPqwYekaR5VsTzkUQjdtbtpKgZtHh5IE87s3DL
	gYh+pRw8oYjuOPVnBAUiVCvfuAjD7v2yatxQZ98lKpPBAFSeTJCSJQ6pQTHUOaxhkM8BHqj0+Om
	7HI0fvih92gN8ehm9XDtq2ENbLjobbs0Is9Mm/BEDV/D/qKKSxDaVFq4xsR6Lnx7YiWws3yVbWS
	uSthcNhu1foiywy+1A/GCpQGkvjHpylsV+YPIcBAay7Akay5dNGoHa+nODp3uRPJ9VVAaHy7yXs
	P5XCls331an5UaWpcnQapvbnI583midOMTjIm3Or48AIeOtvu1qEdeQP2MipdjDQIcJeyc+qQIj
	uUrNrRbkCjB6TJvqTxCsz4+TR93kpiH453dsfLzbV7ol0HEehGwlmUzJPljU7SJym5wcisYTfFV
	ksr/A5r/mO19acGL95bCEvHrBIARBRsZJasIFuCT1lj6Nr295aRR2YcrcskPJKMy96qPK4V+1MC
	zHc/CEYN/vrJvJh85dQWA7e9bcI7ssG9DwID/XqY+kXm8ZBolEpYPyPDd74t/lvoHPU17n89ND+
	4qq0YL2U37hUtCURC/hBXLLXUjj+7pfoP+BuuoapdaiwX+2Sett4MabiZbAz6c6Ufp4umzdXYx/
	PudDhMqaXCtE=
X-Received: by 2002:a05:620a:172a:b0:939:6c31:2318 with SMTP id af79cd13be357-940ef8d8389mr1233127985a.34.1793040193950;
        Mon, 26 Oct 2026 11:43:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f067c879sm758709385a.16.2026.10.26.11.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:43:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLPf6-00000007foP-2hO4;
	Mon, 26 Oct 2026 15:43:12 -0300
Date: Mon, 26 Oct 2026 15:43:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Bradley Morgan <brads@mainlining.org>,
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Thierry Reding <thierry.reding@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261026184312.GA1685504@ziepe.ca>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <20261026122243.GA28851@unreal>
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
In-Reply-To: <20261026122243.GA28851@unreal>

On Mon, Oct 26, 2026 at 02:22:43PM +0200, Leon Romanovsky wrote:

> This is needed for two reasons: to save hardware and software resources
> when creating a large number of VFs, and to allow the PCI config space to
> be configured *before* the driver starts using it.
> 
> There is no in-kernel alternative.

Having userspace involved in driver binding has also always been the
plan for confidential computing needs. We cannot have a device driver
bound across some of the HW transitions like TDISP shared/private, so
there has always been an expectation of bind/unbind.

For this case the existing sysf drivers_probe is good enough for bind,
but we must have taint-free unbind for PCI devices too.

I think this patch should be reverted ASAP, it is a pretty major
regression for a lot of users.

Jason
