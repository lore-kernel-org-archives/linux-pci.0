Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956527;
	b=rGddsunn4LU7iAGS7D09IkVx6dvjFQ5WuDjBYzEc6jlq/yvBHvC1ImfxAO0RVK6zZCIU
	 6VKErPV0fjFpllTcyZcsR1XToYxUxkaRCo9uOfTYQpgFUOHk3rRN8mKYbwYHF6Lx3xLo5
	 MGl2Nog3ZFNfRzbNp2ARllCyR61fXfpN54TttePuopcVTKgsejDHunuL468laQlU5c9vA
	 iEWOHWa4NnmnosHgi8mugIEv7MP9aJzHZgVWoSWN7545eqYGh4EB4H3Th3AWzgpoX7XZM
	 c3xMfG5SHMfErWN1OtkG1hBj7AhOhevC0HN4WkZ/e1uHH5Iaw1VpUVNPi7UuB3uE2aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZoF+arBWk9nIrqmILMC/g3drcspiC3u5ktWITZiT+Hs=;
	b=Q46Oew8vfA6NSIwheE7ieUK8IOehOHFM1l1gw5WTdJQRbD6I3sElSYXYfdkGhRdm43Ij
	 jjXlQnxfHMCt5M9VFo3p4cmDiaYy5cjkVA/CxaoutFcU9SF3QSem4nP79VDmhmNv7idKi
	 I5uoqMXl+pwnGR56a7OwunMwrSn1+Dlg9EoD2FNxK28zpH+ybBOj5GTcDZZ8ML2gk60o0
	 ennNyjQ3g43T9iYQ5Vk4qeRtpkH5Tehord4D9VYc62yEGW4T3gf4CFbdfpd1YMneIb1GU
	 34HDZ6XjwgI6lhXNgsBNfSKzuLANg7gde9R7of5OSVU1BY0CyuSw/wrBd2ZGHXDxWvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bzYymmFN;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E82606A31C
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 23:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9E82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bzYymmFN
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ee254f6eefso27365ad.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 15:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794956526; x=1795561326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZoF+arBWk9nIrqmILMC/g3drcspiC3u5ktWITZiT+Hs=;
        b=bzYymmFNaVKjp7L9MQq9R//EKsOqfeAxHD+Ud1myIbc/mUrQ6wb5lXhu3/WkgmWQn3
         EXHUPh7xD6fpYWAIw9tcXYbRSP1jKIBmu/8V9vI33uRR++ojmr3asblhLlGzBLFtyPx7
         ff2ZxZEeAB066nvX99j3cKIcpUFVReBClcK80H5KOhAG5qPc2761CNjaa/sjn4yV5WxT
         H6PDKZXK/BCoq/JmXesRCdRxLuxLd3peE2U/PoB+23vz90lcSiFVW6a70gUP4IVHz2z3
         4QlucaplFmn2oPbIs6geQaH7vQwJDNh/YVTvIpDyVHOimPH0KJ69NVyru48ymakX7UXR
         MvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794956526; x=1795561326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZoF+arBWk9nIrqmILMC/g3drcspiC3u5ktWITZiT+Hs=;
        b=Q93ceHHKcUYY87RWkMdj47ngaRDl1yUK+CXnhOh87wJ+NTierAWJrf3Vj/GXHG/VcU
         68saEWisHT/DSF8ccb7drUULRoQ3oUxdfSHYFHeqgSxIOKGEVC38anjWJKkpHScpXF+L
         3rsbq68LVWvOoEcLHP436sgBbeq5Fz93Y3bNax37+S1H90dw7y34tHUG58R3Szh2FEvm
         Sz0BW1I4MA4X4IDPj8xrqEDTo8jC5QeKmm2x5lqFXtNp2zo+u2WEqTZ9SOUm1hwBGSqy
         EOmIy2Eo26Y76MwClDnSiF1uC3eu09qgn8bzotRGDrZ9/VfTXeHd8ZCpchdUjxqkVRJG
         Q9hA==
X-Forwarded-Encrypted: i=1; AL+hErGItfScC0GmxwGOqOVD+9o9JUievHUqR0t02f/JUuDvhlyLBksDaI6EZXQ1bZksmGHIZnYUwm+rqlQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8V0mW1RcBXQxVVsh1tl+McRnOoEPx1JaUH8wmQ7c8RRwuRhk+i
	h0ZXc/9qtm26FMwmrV8SrPUf0QuCO/X1ydFMY7g5DnM5PktGXX51omlKWWsVhDT+3w==
X-Gm-Gg: AZFdTZd+T1P1dCsXWGkp6vllBoLLJymm7rMCUMgurAeXOyIDrjvIQ65wJPNfGqI7Xsj
	jxjVyP7uZx5uVFgn8aCClFaLH7juQQpvPZ0Ai1rCCCBHvAPT61Qk627roSK23dattNF7ZimUAzp
	a6Feh19s/E4Kb+wRQNO4aaPkC5fkXb66kah2Hs+wEICdEmQEovr1S78dt8SwlnX3DK9PxP43jNR
	s5Uh60um+fpfpoHxo+NMJCWoFzwYlJbkusJfMdTd83NDKtCvq4Lj0KI/8PbgqRpweUsT1HisFqh
	pWlQ4LL1Z/HfcK6g4MJQn7Za6Kfif73rlxdiXMW/37iDqvPOFwWzfSHWB+lN9W/XrwEPKlbHde5
	37q2H7RdOeIZRyziiVkuM3Jt9gXGcAgsVmoQlCHfvNzJ2wij+b5ApDRrnhv8FElhQh2W6bGtZNb
	Op/UDML5dWMDrCNxKx6d34WM20RAsjY7IwlB9BwrPuGifslIKtPU6zWF1+V0QGf4Jgx00NM3QSx
	YqT+N3AuBCUSkP2J5cPsW+0urBwUB5SycDslFhia4juTzs3WaqHSCuP5YQoYJjvi3WH3EV9Oq45
	4WNSL1OcuaaJ2xPIyeDYtL1DbcuTSSbL/o3zB2qi/kxw7fAeVHtS5rPck8JvZChU+QU=
X-Received: by 2002:a17:903:324e:b0:2cf:9ec1:ea6e with SMTP id d9443c01a7336-2eff98d2120mr941545ad.8.1794956525618;
        Tue, 17 Nov 2026 15:02:05 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac29a846sm5891026a91.9.2026.11.17.15.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:02:04 -0800 (PST)
Date: Tue, 17 Nov 2026 15:02:00 -0800
From: Vipin Sharma <vipinsh@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, kvm <kvm@vger.kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] PCI/vfio-pci: Guard resets against active SR-IOV
 VFs
Message-ID: <20261117225559.GB2250529.vipinsh@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <an0BOyexLcOjFJw9@google.com>
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
In-Reply-To: <an0BOyexLcOjFJw9@google.com>

On Thu, Aug 13, 2026 at 10:30:45PM +0000, Samiullah Khawaja wrote:
> On Tue, Aug 11, 2026 at 10:53:18PM -0600, Alex Williamson wrote:
> > It's recently been found[1] that vfio-pci doesn't restrict resets on PFs
> > while SR-IOV is enabled.  This can not only result in an uncoordinated
> > disruption of the use of the associated VFs, but the ongoing use of and
> > access to the VF has the potential to result in machine checks.
> > 
> > This series proposes that this gap is largely an oversight of
> > pci_reset_function() to recognize that a PF reset affecting SR-IOV VFs
> > violates the scope boundary of the pci_reset_function() API.
> 
> Hi Alex,
> 
> Thanks for sending out the RFC to fix this issue. I cherry-picked it
> into my environment to verify that whether it fixes the issue I was
> experiencing and it does fix it. I will continue to do more testing, but
> when you send this as a formal v1, you can add:
> 
> Tested-by: Samiullah Khawaja <skhawaja@google.com>
> Reported-by: Samiullah Khawaja <skhawaja@google.com>
> 

Hi Alex,

Is this series still on your radar for formal v1?

If this is the direction we are going in I can use it for liveupdate work
  https://lore.kernel.org/all/auzftbPFO_6XBYVw%40google.com/

Thanks
Vipin
