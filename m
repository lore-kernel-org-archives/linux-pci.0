Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835249;
	b=aBD0S1SciWo8OB+d3n2wiEK575U3Zrg7qphOnhpvBD4QJjM7pR1U1Kue2Mr1dK89HEh+
	 pkQVtN2gCz9Qu3I6+0k8jb38D3IEYgttaHXix1o21y0zGnWUmbh3GC/IZY+28GTrPVV0o
	 BDfil0bTpxHhV7JZyqxTLqaRgU6ZMULblBNnl4GAbSm7UvmJHdxJ2KtUFo7EmYKafY6pU
	 nysvrv+fLcvezbkgl0Zrqm4+ooP6Z1CdzclqCjzp6N4WeIZDf0/D/oD+0iNAquhaA0NIi
	 tXAxKLXgkEBjoba1mHbwkRR/Yi6GP8/dcO9FmF39mAq/lGJuvU9LP7PBaa9o4bOlJtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pW6Ljdl+VPjn0HqbJ5aXeG19kylCTPtUMbKY6fBA+PE=;
	b=BiSBgW4PmKYplNb1bbIf25Bx2m+ZYBnYMDliJLa7S9KkzD64d3hOxQ07yA2/NuQ2JM9r
	 NVm3IXDdP6rL1zAiIJf/vA7O5LGVkXYGdElX4qpcrIMmWr2Q6PJ6OnPqyr24rprvqhmAu
	 WFmMAPDk/qNQ685GGBRIqjfRRPlnYi1Q0CjM+FlRL++j3rpA29D0F6m2Xp2Nc2XYPdQ20
	 FOHIo7kJe3EHxP+H9qmBqpsXbVfjjxS3I4vcWCiff+C6HLkve6SLVNYiekMf6yTqly5l8
	 N6opTBwzIOu882WDvOoK+F/kPomLmhIi7p//66/NhxFo4cM6Or379JAlTShgFaeo5lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=F00eXo5h;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07D606A323
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 13:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F07D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=F00eXo5h
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91f23ddf32fso23834706d6.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 05:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794835248; x=1795440048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pW6Ljdl+VPjn0HqbJ5aXeG19kylCTPtUMbKY6fBA+PE=;
        b=F00eXo5hK7MhiGIzcy2xEZvXaOlU++0SsxWdg8F2eYgLj0IP/wqxNHSj70WYC1UCbD
         vmKPyn8zqLHpLHOvxkTPyXLn/laMAvSaSbXM05SN4tjv6Cx+GcVaR0GxUXpMgXzGykx3
         FokKvpAfMx6w/qg4Q5h79shuv6MexzGsY/vmut+9b8A8pQsaE0GfSqy0kYc2aGWEaEae
         3xYzyobXgBsc03sh3wdT6H/0kLtFYOlPUaVehm8clJUf4d9zj9Hfn5kvjyTiGQDD3sEC
         6wk4kHeXw7a4jDhfFMIm7aNEb1ZQhwAt5xztT2KrBS1HRA1ERCFKDcAKt5g1NH70HZ/q
         daJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794835248; x=1795440048;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pW6Ljdl+VPjn0HqbJ5aXeG19kylCTPtUMbKY6fBA+PE=;
        b=W9LIRNuXl/sxDmbh8Y3UUkG85HfWaVYDAb/cUVdzu73maxLioYe/CLtuGTEHVZiRD1
         fhr+CoQs2QjCizMm8QNyBaM0Q3Rl0n8N0waQ3CTaRJ8zq8NzmbuRc1jhpgFMdDlE/PHE
         bdnV0DBmLn0l7lLGvEj1wlU78XXtIf0Af91XzqksW0kbiCSHQZ7TYc6Q94uBtvatYYW6
         4LghY0lLIoa7iYe4jRMqUMJUqMb872abqpYJK+UyOJ+fTbV2JfEptfM48Uin74m7ECII
         oAX2Cz9uk7e7nJsx4VnJx+EzusXFfQa5DZCLFPmff0SccAv1fYtSzEZ0bWsgjNOgaokY
         2r+w==
X-Forwarded-Encrypted: i=1; AL+hErHS7R7bzzzXWREBRFDhP+LuCF7UuJMkOaJbmnSBRqe4IaAZiGZu98T76m6WcJwJ93Apo5G0EWqJpGQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z81XL21w/RQp2Dvb0Vgbf9JNXVudqANqI0rk/cdj9CEA06nZd+H
	o3WFo+uXnzuIXu9CEhnSUEDNu21PSMp+MfAQZRAtghuDl7biDV9dj6+b5xtplIbOQck=
X-Gm-Gg: AZFdTZev7F+6zRLo4pNfH2qvXfbQS8OBINAHVQTMQE8HjoGmgOcIZTMpqyNMkKRinE5
	4onJlIMQatN2dzMWGPJ4et5cH189xqjCRZuNJwmCkS4aVubxgSfxfC4LqTxZs0VizDVOJ59fvl5
	nm2stvNAPq4DubVU38cXx07qYH6FrNVzLdDh5w4GTQLlFznkzE4qsPMUu/WXCebfmy9GCvzL3Sw
	OAhxJXbKXw8ZSc4qTdEmrs9d2drIUIdbCIp1fDP5Z8bEbjSWgC/BxOLkJgnQyOtiyKA9dHUZL8F
	BrvOeG2rgjVLmZYyEasbDbJX7ZQWrNw2emVwzYiZZPvtG7g7QfuWTBgjClySsX5Qnse18zeBKuk
	3uYe98zOjhUNlPyCJlyW5BY5/LC8/P8eYKipzWtHzZl2oNEPVCHFoklQ33oIRH46k5VIB5gor+j
	T/64UqmxspUk29CV4jr7cJvNM5ZI3eUP/r54RuCW8zSas5+oErSF2J46xuM4CQEZqJJ4cp47to+
	y5nr+wdX2lkY4PFUONDdKkjzHLTsgz7uBvD3LAR70ETCTRh6sGxp6p+BQ/SpUfaqQQrfbqmIxWj
	Iu9I+w==
X-Received: by 2002:ad4:5744:0:b0:91f:3230:2a4 with SMTP id 6a1803df08f44-91f32300351mr126741416d6.53.1794835247815;
        Mon, 16 Nov 2026 05:20:47 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm85758876d6.28.2026.11.16.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:20:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSwda-00000009KhK-1awf;
	Mon, 16 Nov 2026 09:20:46 -0400
Date: Mon, 16 Nov 2026 09:20:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261116132046.GI2532299@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
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
In-Reply-To: <yq5amrr8yldi.fsf@kernel.org>

On Mon, Nov 16, 2026 at 06:38:25PM +0530, Aneesh Kumar K.V wrote:
> > +static inline bool
> > +pci_dev_default_is_restricted(const struct pci_dev *pdev)
> > +{
> > +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
> > +
> > +	return policy == DEVICE_TRUST_POLICY_DISABLED ||
> > +	       policy == DEVICE_TRUST_POLICY_ADVERSARY;
> > +}
> > +
> 
> Could you clarify how this series will work alongside device acceptance
> and private-memory access?
> 
> In particular, what should callers of device_cc_accepted() use under
> this model?

Who is calling device_cc_accepted? I thought we were keeping that
internal to the DMA PI?

> My understanding is that trust describes the operating
> policy, not TDISP acceptance or DMA access to private memory.

Right.

> Therefore,
> neither FULL nor ADVERSARY alone indicates whether a device can access
> private memory?

Right.

Once you turn on TDISP you effectively activate DMA, just like turning
on the IOMMU.

Userspace then gets to choose how the rest of the system behavess. You
can still run a strict viommu with an adversarial driver even if you
enabled TDISP and can DMA to all memory.

I don't know if many people would choose that combination, but it is
there.

> You also mention that once a trust level other than DISABLED is set, it
> cannot be changed during the device's lifetime. If a device initially
> operates in ADVERSARY mode and later attestation justifies FULL
> operation, is that transition intentionally unsupported for the existing
> device object? As documented, unbind/rebind and reset preserve the
> committed level.

I think it should only be for the duration of a bound driver?

> It would help to describe how the trust framework fits together with
> those separate mechanisms, including which pieces are left for follow-up
> series.

The main thing it brings is the pause to allow userspace to measure
the device and put it into RUN if it so chooses before any driver is
bound.

It doesn't change how any of the DMA or TDSIP flows work.

Jason
