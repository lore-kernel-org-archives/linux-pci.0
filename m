Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516788;
	b=lhDZvfm9QSLBtvEY5yPMYgyyhgw4qlg0RG+RFa/P0/tPn9mA5u4zQ4Sre+rZCCdNMdMi
	 B9e1I8s0WAZ4mOxbAXvmtL/1zq9rLvjKd0ehRagqdQvhq2kZw5iPxeNfoDFyg4oKiAlyR
	 Pv4lFvQ3aSyZvfl3fpNHIWNRkJWNYfq0hOTEsETFKHGUeHdzYZS2L5RZH3cuEKTGPOlNU
	 ectzzpU+URumOKV3axJ/J7xVJH+kvjwHfCW7nYEF5BH6i3BWKoQ5lxfGOi1+XqFkwUpvp
	 zCG/tbFZdR4fwkIyxvWBk03Qmdm07PUMP/orWD+Fr6fmfqvoWh0RSj3QLswwpb2jvjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
	b=5Ut8q2EbeGF3abgjlmNdkXUf2edft+AFxuf6w5L8wD7xycKxmZfrw6JjxraHy4YcBIMM
	 8zJ0ks1FWLBjToct5qeoaUK4kig5PGhYQ8Si309d73OrOjvtgFdSTqKkFKxzFeMTfpZKh
	 xcfVT6PepR+qGrlmgl2GLDBzjy3ZqkYgQUwAlDDyDdUt+/gpnLksqmoho70xnB+akJUcj
	 dS5jvoLXuG40ll3unPdns9fO0dR/FnSZlAhGDNjaeyak3db5ocWyRIEMe7Ju+3wG/nMn0
	 aVjqn52XzGon/HqHljzvxvraHr0S4uOvh4XjXajNiFVX0kexbV++YzQYoiHnsGvj6SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KjiX7YWe;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D5606A322
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 10:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 208D5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KjiX7YWe
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb61185057so28148715e9.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 02:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795516786; x=1796121586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
        b=KjiX7YWeSkA9Dw0WA5xjWaOqnyEHCedD00sUzMhE3sKEAvQ2TPIHmIyS+enWPn9hqU
         UHnNtz+vsI9HdnLLJLRNEHpW3n0qDPjDGGb+MMmUEkY4+DtknEToZAEEAwd6ErlDRM4U
         sl6ks9V8P+KgBQBXge6XtIwqjU1IX32GeqDZpfsQ5053CJLA98ICyRMFUcjrF7GwSx6y
         mLBhDMnek6X1+TiwUBOkVQB80sS1Z2oue9zDTiR4H+wlMmpVb+6EJ+EZoBBfGsOtxa1G
         85CHt1w3B0RFKCYDolOV20zywTKINPHyMkeAAvRZwyufXjasNY7vVq1oJTMaEgpAJPJ9
         588Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795516786; x=1796121586;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
        b=Oaf4wCvPFdIwXZ1LUqQhz6T6GQvL/5j01No0CVRxqAZaNPApcBxq8EOKSg/sTTnJLi
         lS7Ouy+7EbReCBIgXi/OPlH7u1AVa8P0/ODjTr12ho8qNQ2dOj5ZTNR571/IjTQecSIe
         /r7RywwNclaWJEMp01CbFY9QFUwaGdLCZDUSCULl4yvoNoNU+LgSbS/MZ2QDr7ug0dl6
         VlJv7S4vQ5USsUtLfvKJFvwkwpxWato0eRl1VX8IcbKqRW7skOjpX/lWEsS/kX6kgUWj
         /UbvU41cPAc7rMA+qj07iM57r6XwJdgSW0u/ufJysjHszUNzNAqAeVWAuIDv2q+fk0Q+
         I3HA==
X-Forwarded-Encrypted: i=1; AL+hErGpSla5ZxnbXp0z0gDPt/sFqVYRy3XZNyuj++tyJ1jq0VLTSBWDqSb3dGmB79olmSS1TOK5CaJ0fAQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pTHQRZ3AC7aK8P6OE2IxMX1L+j6Tng/ccms9RD5zWw/XrRbbu
	17tr14vBE0wFnSSDmk2cr1EC4fJ0VTE5Lh1PExeo05Mi3/3lZsszfirFDSUAObE/hO0=
X-Gm-Gg: AZFdTZekWnXuSbmkhs6PCyZ23i4K3nh5ffaG1C7jofeFemrQMZpqi/f++S2vUE9vU57
	qYYzrEWzQP8+ekV/KzUJzfuRpJDy4YM73pTMnwLh8fzB5676pJkkpSok3R/ZTdWz3fi1eLwyZ+D
	KYza3+RZMC1Yg3p4CxkYWQMOFguY/rijsNtbiE0GEK6eABIqa2qePotmsYWUEizQiI9lffbiSHv
	6etM6wbyKDih0LpZqVHgEfoSdMn0Kr5aDatLFvbTeX8KvohD708IwhdNBz9MzGDN8YKki4orjrm
	NeOG/RSyvSfHg5w1hmZO7e324FZyxx7cLaxThy/6t++DUY/C2elS1Grdav6lvgeTgZb6cgn8CT7
	LlPvgiajUcXLlxLTh8x/gNRTOI4vQlaWtwki60i4cgTWbBCKJ+5xb6oO73G6eh9DsncXAkwxn2o
	RbT7cBctKJQ+E7LZy+E5AE/n6qVOgWjWwQwPtMnW8tXlDduRVNksUxAVX4U+i8vOSIcu3yCiwQ5
	qyMlRz+h7PNbIq3f/RDeho4YcIGbp2eql26dYlNL30TpdU+O2x0qpieNTUK1UWC1tfwTOvRzx6a
	VHISQWmMGF/KIX5pe7oAPrFkvOkIlqj2waaSHS2My1KoTfzBIruB7URuQ1MQB330Thh/
X-Received: by 2002:a05:600c:64c8:b0:4bb:6848:d433 with SMTP id 5b1f17b1804b1-4bb8881d141mr281064655e9.26.1795516786433;
        Tue, 24 Nov 2026 02:39:46 -0800 (PST)
Received: from ?IPV6:2001:a61:132b:a401:6cb8:7c28:11e1:499? ([2001:a61:132b:a401:6cb8:7c28:11e1:499])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm425218335e9.5.2026.11.24.02.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 02:39:46 -0800 (PST)
Message-ID: <65749362-927a-492d-8bff-573c277fe456@suse.com>
Date: Tue, 24 Nov 2026 11:39:40 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/33] Bluetooth: btusb: Fix MediaTek ISO claim locking
To: Leon Romanovsky <leon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Chris Lu <chris.lu@mediatek.com>, Mans Rullgard <mans@mansr.com>,
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
 Jeff Garzik <jeff@garzik.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Bart Van Assche <bvanassche@acm.org>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Dan Williams <djbw@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-sound@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-2-037eb0d17b1f@nvidia.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261124-device-trust-core-v4-2-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24.11.26 10:43, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> MediaTek ISO claims are performed from HCI setup work outside USB probe.
> Locking only the interface does not protect the claim against teardown
> of the parent device. Unconditionally waiting for the parent lock can
> deadlock with disconnect while it drains the setup work.
Hi,

your patch raises a question. Can usb_claim_interface() ever be
used safely outside probe() without this kind of locking?
If the answer to that is negative, should the locking be integrated into
usbcore?

	Regards
		Oliver
