Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520027;
	b=M1n6ZGQd+QQ9a5lDhZThUhI14M509rDmvMXHWDv5P716ZgSi4d74Zn2Axpv1Jy3mWtO3
	 2DTVn8cYxMCFouPcvwfk4zKzwaQ4P3b0FdHtH4DhwtVgvjdUFNb/6Vp/P0qIDRvc4CjWm
	 YG3Je8zndy2GMmbvrhMQ1sDeYE5Si0+6NQ6TOe6R+O9MBcNuLKsxXNVgHN2UeBoivJk7T
	 iHnMh5vYPs9u2R5bvQneYSMIjddpGF59wlzFZbojN+2wCpqyQP+cPG77rKojoW3inU3Fg
	 oi0nhxRY/xSehwzmFY/eNVLjknDb0F/PtBWi7QN7jVmcd0ZhoGqdA8ujsD2xD8BCANw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=MRvrBEIopDqvuVb/vZ72s+DUNbn5hAJVvZTwAj02wNI=;
	b=KjoObWxQB81aWlhL1HUARcF8T1l85+kmIKk0NzNs+vIsMQw+/sCuW8HDKtdMhR+h/7ue
	 PIjqO7Ikez8KsG8VgwdJUcMwa3ozM0zQ7qAb5wS0fWyqpN/t9PEwsT1D+eN05S8Bev+cg
	 XCTUjUTjPRRVCQyRJ2c/DmZa59t+KhWzySUDZfYx4uVpZ/vVEGIyQB7UYCByNCntsgM6V
	 4kOOZFWTozHIrrF4963N9heuQNTcnhlKtM0hbiDF478+hUIGYcKjbWboI9VTAI8JyrLez
	 ahnYy0k0Q3SPvfYPD9cbXhr9c127DwKbp9wk4q0uBb0C9F7GsK9wCRZQjOJL5UTwOmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IqQicUBc;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D33606A32E
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 21:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4D33606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IqQicUBc
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso115406a91.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 13:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794520026; x=1795124826; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MRvrBEIopDqvuVb/vZ72s+DUNbn5hAJVvZTwAj02wNI=;
        b=IqQicUBcHFfASsPeC/FaWkK7/Crm2L2UYyn8/PxIFh5d3NQfwGTsj1ea0yYEQ647ZV
         /ccaegp04k9hdkyY2Ail6N4rBeUM3LACMz8nX+7douczOTVskMzZJ6rF5iaIrVQm2heW
         JeAJJRZGwbkWIX4oCdCOf9PAKsBXWkvG0Qf/0hEZ5qTZmjRSXZseI6akOjoL+PPSYmfs
         n/o355gYSqEM305OphinxwQkhxOcncDRdESkE1XHs1UYEEh7UGYPCzuqJ/L28TVUC0U6
         aJlfLAOYc0LEA5khjKc7nJefwozvr0lPgi0RdEjsCmQOzXego5h4dYanuiOcrof8EvZv
         aU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794520026; x=1795124826;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRvrBEIopDqvuVb/vZ72s+DUNbn5hAJVvZTwAj02wNI=;
        b=rNLsEJHuX+1heEOuG8hZc3vLU1lHkxwl8GUgSRCAMMRBhdnXDmdAsTFxfnkqvBotiQ
         WZgcwp2vOSncpzXJ3ivloX2yV7Q1kpEB4iC9nZXkBsktB20zVplsjfoQ1yFlfn5u/TSD
         5F24MDTDXhrLx5UatB9mnxMNhKzucsKvBbODw5z9jtLIFDuGpcDeJ75aJu6pr03kppvS
         0103ZYm7n9GVsqGQE5IkFDO2qdnsgR/ALOjysxoAYVFUYVsdhA3O+RnKdauQK+FpS6WX
         6XbvH5kTP9v647gpnjjgllcNrEFSFPglD0fGUefuDI8Xt3/ohye8LgY0MKuSnO01Mlqm
         EPZA==
X-Forwarded-Encrypted: i=1; AL+hErE/DsmYpO3bTXBmB8v9dZXXNMoT/gLT2tHNbIC0uYnq/G+m/ansomq5j/OInIs4LcqnM/fyOHj9pB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+J/L5Ehou3HdaFz7WNWeTqlR4fEFMhJwliud5umWxh5W7+hFhi
	WYTbU07iu/zWhq1IwdxABLp8AIrGOIp4whxrv1UNwD6YGZMp5l0rlrAlbO6CJRcN8A==
X-Gm-Gg: AYBFou042irFYRgFgtXKwuKqhkYA9Ocvogw24qxI19pq9PlaUt+/DnDSMx/auvClRRc
	hdA+IHAGK6PcbqHImEOjmCedjWhZACEjjlXmk+TexPppy/wSmpldlN6BnN6OrpM3Zd+glxYWFic
	yNPRMPEUEqWrsyQPOVHnccuAuqf6aUrqoYSHdsU+ffieGGbUwj1OZ5iywf231QEL904kpzPZIkW
	Z90y5vGvoviqLvEgLPaShnPteRbaCU0XwDrtpn5GtLRlxu9ZP1EOmlxaDxtF/zpuEGBiDwHCXJ8
	huEp9lpwDr5xzxfr0i3G0WBKCyyhqwY1BHRZAuFIKPMJLBBY/IGwdg+lJs3InlxM56YWuUzcAun
	x3bKjlWtogGUkRr8Sy7oYxHB1GWFuX5Z30gybWj8b5gL3dOLykf9562/T5q73CJoXQ0OCIIZ8Y+
	Dhyx3B5TXD9tNN37Zj8WDjkn55vi7uGBRy3TlCfo8lGp3DJdS5GrLi9pF+hCgEe9jmhlk4wqCSM
	goxCn9sZnvehpw4TiEUi/MrUVFk2ceGPmj4tcTX0H+TWxrkRqS6Hpjeq9w4WhdftKA41TZNibmp
	gfQ2dRdpmMLHh3hgTpkGIG3Ql3AX8tkGAQTwNVQsFC+46yh+mT1fI2PdiLXSxfpyCpmvtCqlNVk
	VAlDtIxHyew==
X-Received: by 2002:a17:90b:30e:b0:3b0:97b8:d6bc with SMTP id 98e67ed59e1d1-3b1b0a0e889mr278699a91.16.1794520025137;
        Thu, 12 Nov 2026 13:47:05 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d257a0sm6493095a91.11.2026.11.12.13.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 13:47:04 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 13:47:03 -0800
Message-Id: <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
Cc: <dri-devel@lists.freedesktop.org>, <iommu@lists.linux.dev>,
 <kvm@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Josh Hilke" <jrhilke@google.com>, "Kevin
 Tian" <kevin.tian@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, "Matt Evans" <mattev@meta.com>, "Matt
 Evans" <matt@ozlabs.org>, "Mina Almasry" <almasrymina@google.com>,
 "Samiullah Khawaja" <skhawaja@google.com>, "Shuah Khan" <shuah@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, "Vipin Sharma"
 <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
From: "David Matlack" <dmatlack@google.com>
To: "Alex Mastro" <amastro@fb.com>, "David Matlack" <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
In-Reply-To: <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>

On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
> Hey David,
>
> On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
> =20
>>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
>>     uAPI behavior? VFIO_DEVICE_RESET (and runtime PM transitions) on the
>>     target device also bracket the reset with
>>     vfio_pci_dma_buf_move(vdev, true) and vfio_pci_dma_buf_move(vdev,
>>     false), tearing down any active IOMMU_IOAS_MAP_FILE mapping of that
>>     device's BAR even though PCI_COMMAND_MEMORY remains enabled when
>>     VFIO_DEVICE_RESET returns.
>
> There was some discussion about this in the thread below. My understandin=
g of
> Jason's point is that the current behavior, and differences between what
> revoking and move-capable importers see in regards to vfio-exported dma-b=
uf is
> somewhat incidental and not necessarily desirable.

Thanks, I will read through that thread. It seemed like a surprising
uAPI.

>
> https://lore.kernel.org/all/arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com/
>
>>   - Physical target devices and P2P topology checks: mem_bar_descs[]
>>     currently only matches QEMU's pci-testdev, and
>>     vfio_pci_has_p2p_path() does not yet check PCI topology or ACS to
>>     verify that P2P traffic can flow between two physical endpoints.
>>=20
>>     Suggestions on physical target BARs to add to mem_bar_descs[] and on
>>     checking P2P reachability from userspace are welcome.
>
> FWIW, you can also exercise the "P2P" path with just a single device if y=
ou
> IOMMU map a device's BAR into it's own IOAS, and have the device DMA itse=
lf. For
> eventually validating aspects of Live Update, maybe you don't necessarily=
 care
> if an actual peer device is being DMA'd?

The way I designed the P2P selftest support requires 2 things:

 (A) initiator: A device that has a VFIO selftests driver.
 (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_bar(=
)).

So far I haven't found a single device that can do both. But you are
right that theoretically a single device could satisfy both
requirements.

I can relax vfio_pci_has_p2p_path() to allow initiator =3D=3D target.
