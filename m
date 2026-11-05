Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890796;
	b=H+QZTmVbKhrGWkj16XnJSMGrGka2ivWVhMzuzQQlICysPPpQ0cJZU3j0FgNR60CovJJs
	 RHn+ACJtXUOxr0RURy2QZ76yd19v0aP0PFklv3O0VvOgWvTAfoOF6E8eTjnMqTPYWxUEp
	 3IlzyG3/xokVW3+tzyt0hSQFLlh9GOSSS8tchcpgDWIx8ZOwVbsaq/SeP7WBC12zNCXb5
	 WJNLqK4ztoLBtIIb6b+DJBEQYCzEUx+AT4fRd3k2dIOqzx3rHKwZT1DwQte14ZdpsBPV/
	 DhSggCgXyH/YNYYg7O/8rMUecQ5qzgyWk9kfu0e9xWolCnaBkb42dN1lWTpY5CkrSrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
	b=NKQN3ib4vMoAUAOETwskjm6l4M491fDeyeKR1P5KeG5BtG+8NDV1D9iOT9wjquHlvTyc
	 CWJmsWZUDF4PKAIMZzJzyNlraFyIZjGlItb/cByypyvosHD14qQ7uYzqNMT14mN72/sT5
	 RRdGz4+9b/34kUAEn8RpUe0evqiDKnMcjMbFkPqiRc2UEPs31Fie5NCKx+2djcqw8es6E
	 SzQIMuLfCdpWg6XUr+ii02GCQXEZ9gM14BYZjA6J0z78YFT7t7hCMJLjOzJ2jBvJ34P1a
	 w5DI8/pPYo1YdS7ji4BLSgBs+XWnQr6+eqm0czrho9exfa9gfPwe92noK9dfi5y7Heg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bpBlGkKK;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B4606D806
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 14:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF6B4606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bpBlGkKK
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so745676e0c.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793890795; x=1794495595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
        b=bpBlGkKKYmX68RAsE9EkcMc+aPwep+Jt4D7c/OZg3kVQeHpZyfmkntRrTHho6EP8wd
         Ydil1svNY3g9CpIhj2GHYQ7d434gL/SpPpSr+DXV/upiAZMCvC9nreTgfts3zuhMwCcm
         Qskdy4s4owr7KaU/9VifToG4uoaZc2rkAAcVF19z0f6dAbM64dHUzvDPxywg/TCQt9WF
         2ooxRy05KElc/DdqHagH2RzabKyRAsKGjv0e7Kqhd2EeSxnmqf8lncs0n6nLDm8+XKat
         ++mZs0G+SfgC2WTprHf/u2SbYhDe7xP1yG7Q6zYRZWtdxX3hRx/GELgc/Kk/Jaz7fcIZ
         8CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890795; x=1794495595;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
        b=y2jRFWWWDgjfJudMucip9Ia0SO+roRBGf8fntf11Ge2K4AAquCL4zlfx8tnSdbSpCD
         Bm0uyfi3wgFdu+B3LTePO65M0yA6Veo1gdxzpGh64LyDUU7khwt4JA6Th5AOZiJBVZ4k
         NxX2dH8E16daj8O2f1Y4e2YWD9HDe5ftgeTyyw5Y46pvzPrS2/mkH1CLsng3+A93jAjA
         xvLWNJZ35fcIYfIYPuBG0NC9DSN/ToJIQ/JTICPdP3hh6uXYXBzVRctzOAqA3to/yas3
         vWlgQBTEfS3vwdRX7kA9/XToyfLZAfOZY3BefbizHqTyhtX8ufTjMlCiLtIttVjZzSDG
         +eLA==
X-Forwarded-Encrypted: i=1; AKwUvBwfaI8yByrEk4zpapSWTAZJvQ0Tt7QhXiZiYw3nrMIsF+t+IrOiR7239eK0LqUVx8xjMCB/qwgBf1Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wAI6AuDH+9cDsHYWT5bmzLdX2QcofGEgxFg+5MCpEEyOUtEck
	zchQPabP0HJNpulIKBo6KPATHWOvybpJGG39WEOcbmcSaVS944VS5UclNzqyRK7VhOM=
X-Gm-Gg: AYBFou2lX3A119Ra3dXEwE4v5ylWlh31AxSISCJP6mErGYL3fhJ8PuNmCCiTIIZXOw4
	ag/YjFs2hpIzgl7LL8djgNZVbwX9AL6jIGlD6aHM3rA0UxnAGDKlF0oGMQ6zOIXQaGMROwdT4k8
	b52B+2Ig58BaTg7sEwGxJLHQp5MNgEvenGucnTgGzjYTHeFHFVkUbnEaUzfkw8DDG20zfpuRx3x
	+9r2qMcv9UeF0d94LfoShlTSoEpnqNJNdGdTS/8Q+YzPsbU3ara1OrZv0sjAoN7KiUmn37ICGuy
	003OEKcjLLPpdXvGCXtS060GtKxr2r1CIN01IUgLqDEfhC3DZBDnyjunT+LcbLki/sw2BrmNC8Q
	pqflWEVXqHnWwvuDRXjy2TZfq1AFzVh+xBkLPg3mQhBgKS1UV6D3ai2WzUWPhblmpUD/wlG1M87
	vae86AuJIEQRR5TGdS9OUaD1ooZ68Uuvdb1pcT7LEeK9hrR3raPM47rvst0lh0bFrpxrarpaYH9
	zSM+iFQDG/nfs5m4M7dAIapmpgbLrDH30eq8IKaROWMonFx7Pot2Ymgu/eGlPaZNdH/QP8FzVPi
	o9Y+alS9o97Ig64DcA/1991pzu/6liCOHqn2CQt68yRQ43Xj+2bCwQsfrbikMCNd/ilI4+b2YOz
	NZt6pvyzPp30=
X-Received: by 2002:a05:6122:6c0a:b0:5d9:302a:8243 with SMTP id 71dfb90a1353d-5ecb429571cmr1423011e0c.12.1793890794801;
        Thu, 05 Nov 2026 06:59:54 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8df2a38sm4234612e0c.16.2026.11.05.06.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:59:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOywS-00000002o7b-2oaN;
	Thu, 05 Nov 2026 10:59:52 -0400
Date: Thu, 5 Nov 2026 10:59:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Message-ID: <20261105145952.GA663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
 <2026110514-bunkhouse-handset-6a3a@gregkh>
 <20261105132729.GB8298@unreal>
 <2026110535-engulf-precut-cf10@gregkh>
 <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>
 <54c9476c-9f76-4ea1-a73a-c9937d6b463c@lunn.ch>
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
In-Reply-To: <54c9476c-9f76-4ea1-a73a-c9937d6b463c@lunn.ch>

On Thu, Nov 05, 2026 at 03:43:53PM +0100, Andrew Lunn wrote:
> > Yup, and that's true even in the PCI TDISP case - there's a major amount of
> > "communication" and "configuration" involved in that. The principle which
> > should (hopefully) generalise is that a bus/host controller driver can
> > always interrogate its child device to perform whatever attestation and
> > general configuration is appropriate, but we won't hand off any _control_ of
> > that device to a specific device driver (nor enable potentially-impactful
> > bus-level features like DMA, interrupts, etc. if relevant) without the
> > requisite agreement between the bus code and the user.
> 
> Maybe it would be good to list subsystems which the bus driver can
> use, and cannot use.
> 
> You list interrupts as potentially being dangerous. What about reset
> controllers, GPIOs, regulators? At least in the embedded world, the
> bus driver might need to enable power, set a clock ticking, and take
> the device out of reset via a GPIO, before the device pops into
> existence and will enumerate on the bus.
>
> I don't see why interrupts are dangerous, which makes it hard for me
> to determine if GPIOs and clocks, and regulators are also dangerous?

IMHO we shouldn't try to over think this.

The overall point is to give the userspace a place to inject policy.

Bus drivers should try as hard as they can to contain their child
devices. Like PCIE should activate the iommu, disable ATS. USB should
limit the messages it exchanges, and so on.

When userspace accepts the bus driver it also accepts its containment
capability. So if it accepts one that uses gpio, etc then that's fine.

We are not the point of trying to describe what threat models various
kernel drivers can support. Userspace has to figure that out on their
own.

Jason
