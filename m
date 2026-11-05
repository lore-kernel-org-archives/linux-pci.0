Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887594;
	b=dwfO6OCJl0wSL0a0DwfPO7dQOAu+5tOIY6Sm8vptX8of9WAeVEpzfHo0zdk6i4ExBuhB
	 kqqxd2uiRmsBwxgEp4rLHs9/zIOMZIry+BB7L8pYZUloTw/rmQ30lyvOGCfHln7+dgMK0
	 2CcIUqAzxOLLXzPMFo8FST0bpRPcODTWg/PnOdZHbybaqm9MT/l+7M4fvbvMwcO8uVCbe
	 I1sjUIfO87xjJ46OfzBSP8lJ/E5A5CdjeEhCtFJYxKIqm/Z6IAWDPxVGnD7F+hF1/a/vg
	 +WOb5qFVxxaPhVx44WhkbM/E7bpdMm7aEc/ugrOP31RGiGx8JUJ2QTifx/uuRXRRJZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
	b=q3TXeUNUOJR50AdnqbGJbD51BG2fsjXbDYMbBeR64xG7sXZSLQhZA3SojSofFuw0rByL
	 lMP2G648q4Ft2oMjhi3h1t9vDwrbpmI/soD0R7vk1Q6OtHE6A/SIYBvZxgP4FDsorP3HZ
	 0jAK3CpZs7w+n/9YQ+G/KgbtxQBifQ8/BskE01TYuGGkU/mJAc/aJO5duRirMcF8LvCnC
	 cTvlhHtyYyoX/v6vWHwRh2ok76wkBnxmsAN6cAIdvE4FSjei/ASaJA9sdg7sddxA2aoUv
	 2HpihnalTYeHZlhjxcKTc5BdqqtTxa7HeI9o8kH2VaKlK6kOrMCt94zjt+LpQYY8z7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RnR9WnLw;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B942606D801
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B942606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RnR9WnLw
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eabf243d05so731332e0c.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 06:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793887593; x=1794492393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
        b=RnR9WnLw6ZCMoaFK9OfD+Z3SyEdhvj+uf0rMG8hHCJ508GqyJ6ANwZoUk4+aGiOUw2
         /BkiFTe3GFbXdlDhgGNTyo1p8KbFcLTeuViDrXT0G8rPqBzVVo12Ao+p4Nr1qmRZcl61
         4eaArBRyBLbC70PWW9D8DSwCjUpFcwxnrtfrVG8awSc3G2DLBl7ue9/tyD5BZlfo0PwR
         zdxT7MPa5WtJxCqrk+LMM1B4PGIKPha9YDx2d3ZgVPNqHnLfPw9K0SbdoIeozyBU6kJV
         fXJaMOJT5b2NTv+4F4NS5Cw1swAwWPhfu1r6zxddYwAc/lzTbX1ed12Z3pRWm4FFq8m7
         OBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887593; x=1794492393;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
        b=iYyYVujXsG1xpM6DaB5NqOMrbcOTYpNhA/CHFg3AjhWUUJynSTb5Ki9VySHZNl2qkG
         XD3EXBn6HSJUZgMBrhIc0ArWxNcDSz/NzjGWUQKpwQHJkVzIitqiwh3m5p8CFRgzaKqP
         bvW43/f8lYczAsTNp+tlbgswDBgERJtvLB7C9KduLyrAMRM60jz9VpDnJdHk3WGcwRuw
         Z+tthj23W/mUHsOpGGqhEQBgV+2euGOixdCVyFw9MVTC/gavtS2in02kid91pk0lO5Fa
         ghn/TLnCJhjtX9B4BzFeXgRU9pespfhRtQXc5kqLSddK8f8qHqrB01wUIiEV64ylzzNP
         t08g==
X-Forwarded-Encrypted: i=1; AKwUvBwxBj25/rFW0aYz4eeNfAXw8EPgfDBhPxNGG//WdY0WBlD+Wk1aFIzbZ29FT+JJywEELatzXzKv1wo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bcnS/R/ebgN3FkKUM+a4fs5t6ru/pqyn+5sUUUO4CMAkqruyZ
	4bd3PyKfTSsLAHfY+4M/2XtrBU0anFlYG1yPajCm3JZCjao3SiMSo0CUS3Ip/B4OYYI=
X-Gm-Gg: AYBFou3iPpScInmc7fJsFMjYzIHidTxB/8qZyslAIGZGDZJdYgGp+FM0SY5Ob7MZtJ7
	gepno95QhObthQqkPuiScxsrx3vYQRaLlPSJMvzwXdacNMODHWAFTD+8JAaAvZhOCAB85jE6LMO
	YRy7g+Ba24G68PVa4KYCTzOOlypBB9HRoP4SjPsHPvz+z9zvxV7kgpwFyGV8ketJKZgIjX1p83g
	rlVClaX1+Qd6ky5UVrsZlJryJbR8FqGJXvwy8plHsOnI4p7qf6v6CP2DqA3ERl91ulL1w1okw3w
	ku/Gh7f61rxh4YA2WrvsPP/bdnvvjevHZ09UW9tjxo6Y/KmD4UP2CEB6dghzmWo88RiwZIXDH/8
	QD4eRNuFkblKSV6kATOsDA5n39bwEtSdUgqOhZEcUM3O2OsA/7QlpnvncLUXfICboXarYrUlkuS
	4O9efEuKJmlC/bKEvrS/JOyON1rBwf0BZuLWCjNYjPy+wpKy4o3fOfuuAlBaon0gYIRpyzPmPXL
	PQ4ybWCBiRlYMFWIT4EwGfP4mkNANNRk6sXKNnC4IPoLSJtvljc7+zqTAoUis7FY5c6s0WNgjoL
	ZZmzoZABy/C4DA3s9IG2E/rYtPTSMUsS/X47F23C5KlvPqKQsVBHIwYTSXRjYqvkM2nza5fF7rt
	z31IEEuLozA==
X-Received: by 2002:a05:6122:4f9f:b0:5ea:389c:51fe with SMTP id 71dfb90a1353d-5ec68949c50mr9274698e0c.17.1793887592873;
        Thu, 05 Nov 2026 06:06:32 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm4161881e0c.8.2026.11.05.06.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:06:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOy6p-00000002ezu-00ao;
	Thu, 05 Nov 2026 10:06:31 -0400
Date: Thu, 5 Nov 2026 10:06:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105140630.GG3889730@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
 <2026110514-bunkhouse-handset-6a3a@gregkh>
 <20261105132729.GB8298@unreal>
 <2026110535-engulf-precut-cf10@gregkh>
 <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>
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
In-Reply-To: <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>

On Thu, Nov 05, 2026 at 01:59:20PM +0000, Robin Murphy wrote:
> Yup, and that's true even in the PCI TDISP case - there's a major amount of
> "communication" and "configuration" involved in that. The principle which
> should (hopefully) generalise is that a bus/host controller driver can
> always interrogate its child device to perform whatever attestation and
> general configuration is appropriate, but we won't hand off any _control_ of
> that device to a specific device driver (nor enable potentially-impactful
> bus-level features like DMA, interrupts, etc. if relevant) without the
> requisite agreement between the bus code and the user.

+1, I think that captures the idea very well.

Jason
