Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730376;
	b=j5lNdmSDg/6Nu6uBti841SwGcJnqOI1g9lGe0ZGDW53tqZEhLlwHFLnKQsPSpeKVf1YS
	 Clif4Iomn0xcX8Mqu+T541jJi9cN5KfMxJHP0HfH4Uw4rUcEpuxQ6bFFqqw1K3qq+TiKv
	 CHfxYbKk+Ln1mzuD1aMlWZlX0/DZs5pYZV+2oresy0uVuK3cnU0DSj4hVsro4v/4lRJfy
	 i3zKLlvTf15FYnENsHmJDoeHVOhwsRBax3rALw4ktczm64nKrnvSMrZR3wxxKuYkBe2wk
	 8BloXq4Y8IgRXje+iodESZTcmSltc0+B+c0pGDUtSPhIvWAG7i42zgCJbwvaFvYNPSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730376;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZRppD9OxFTQrDLzs0ul59kAjNCk+1Ysz55cHvNhUocY=;
	b=Jt+QlQn0WvscTnQnxApkdfuJiNJqa9NY+R2FL9Zp/Acu1b5bZa1PxcOuInGEIDf9mody
	 y3h+lF+6SmeS3pknY78UQz8MnXN6i8m+csEqB3nP0Q9XVqdY/EM46fT9DclF/5xZpvugk
	 KjC8WQXGiog4EtMyhnOGSrf5pyX4Q2f2F+qRNvD561ntFWObIF2Bhn2qifUDO8m15NsUD
	 1ijOissCoDfr1poRn0do+hOivbsOTt3HPDmM5Gx03Vc59bJlo8ocRHI9UPTWm5EvCEM0d
	 cPlTGOeKKJqxOzBoERNnY7O5p6ahQGvqjZS0MByNF8zNzgMSbRrv7XN7LzL62tyjfyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yqlob1Km;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25C606A31B;
	Tue,  3 Nov 2026 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yqlob1Km
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A28F1F000C1;
	Tue,  3 Nov 2026 18:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730375;
	bh=ZRppD9OxFTQrDLzs0ul59kAjNCk+1Ysz55cHvNhUocY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Yqlob1KmpQ7I9IB/+ct3LOVq6E8U+2Sqi9sezVViDabvRDwvhwqQmNTePlNfO2035
	 2G3rEN12q+pPfbj3DKmhuhfa6Zvd8630cCw3gaED1tTfhi41IEQhd105El2edcNdyN
	 UW46rx4jcSHjjJ5EdbSwy+JlPBIQedybcA0zNnFyknpw/m4SrsOxFpD/PcfKTGRJue
	 aGzzWc0XfssPQkd66c1aQ9rd+zPiBZfXn5XJALIXkAk9GjWmGHOQaXruy7y4mxkl4I
	 4PCOgKZ+EIVvWRrZmirAm2XmrI3I3ZukgvlSjFae4tOro1OMxL+rdQJEC8bOBDg3/m
	 49E6ndVhBn31w==
Date: Tue, 3 Nov 2026 12:26:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Francisco =?utf-8?B?QmVsdHLDoW4gTWlsbGFsw6lu?= <fbeltranmillalen@gmail.com>
Cc: mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
	westeri@kernel.org, YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de,
	d@rrell.co
Subject: Re: [PATCH v4] thunderbolt: Call SXFP() on Apple systems with Alpine
 Ridge when suspending
Message-ID: <20261103182614.GA1121552@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103115104.13845-1-fbeltranmillalen@gmail.com>

On Tue, Nov 03, 2026 at 08:51:04AM -0300, Francisco Beltrán Millalén wrote:
> On Apple systems with Alpine Ridge, suspending to RAM with a device
> connected to a Type-C port leaves the PCIe link to the upstream port of
> the controller down on resume, and the ports are lost until reboot.
> Calling the SXFP(0) ACPI method under the NHI before entering sleep
> avoids that.

The subject line basically restates the C code, which doesn't really
motivate the change.  Is there something we can say about why we do
this or what problem it solves?
