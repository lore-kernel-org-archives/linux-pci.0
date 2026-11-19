Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083601;
	b=CpgEkDzn3r7TSMvtkS+CZeDNiWwaADldk0H8LCdpbVw7AlxtbWsOGkdRha817WSkkBCR
	 Qf2Y2yKrrKgwvOw+hb+jYQn4NgWlc3tlYWxYo/a6948jRRRhqnrypCCEvHzi1DyKT42sl
	 ehqkwcLQ5WMq3ezKXl0djnYBqXnkQ2dV9xm6e1xMWqSdnRSmhZ9AUg0A5HCGmuV34UAjS
	 02XCnkkL4xnqmjD7yKu9MVG3pIqG2/M+N+d+LCjovCJaO/JihmIMJR1EWifjCH4okkrjx
	 YuJQQ/2BdYUmQTU/THnfAS+NOUm0r5QtwL8PUDiBipB7dhxdlkSYbK1vm/Z7IEPhPtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083601;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dHfCXIE26UOCXv7iN1qLfURBWMoXPMXk/WXJT6pRQ5s=;
	b=3e1o+Vovropr0n6ZEHg1cWjF8OSKGmB648WVhLrgNjAL5TcJY2/P5i7wRfsu4yKWZ6nO
	 Ye+0euC3BwQO4gQQfYApGlbUjiXziyxRL6kahOHzCaLqL42wssqGnA3lnmov+Meppi301
	 P8Zqg7l8eRp0ky4We3LHw7uTJVXys7VozJet2GgLqdauGUZmRAvGvAkgKYqGqKcppagPg
	 VIh0ecI75rKqeRUcOePaOVIwK/XH9aYLIvdto6jlINGgDLrmAaWmZIYnhScvI1cMhDaBH
	 7qIG+Tx5o928lrj9elzI5vfscv7BjNLKVAgy94qz2VZJT0e0F0H1/wC8QuNaLFEeydA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUktFuus;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B9606A326
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUktFuus
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47901F000C5;
	Thu, 19 Nov 2026 10:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795083600;
	bh=dHfCXIE26UOCXv7iN1qLfURBWMoXPMXk/WXJT6pRQ5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hUktFuus0Awq3deTVLkoh6CBcXfz26MuTaWfwr4qDrnXfy5AFjpba3gVSC8QCwJRl
	 j5y+gNmk6MD9kWRmfbllT2hh9hDq9+xkbkT5NdAuJKckqhypsOo7+776s0ImGFX7lK
	 fgsLplIUgRbMOWYsID1x8epIKBqfzXQGzzGOYWRwtPPWBiGRnOKK++KU2c53yv5F6k
	 ULsQIYQxpHy3Mxlv+0PPE6s4/ca2OclIl5E3NejzkKwtfmmliHzXP89ouEJuI8isaR
	 cGsyFH7UhI7OdldJBkzw41UT0bv9CY0hUuCBta1l734P5Q8bqQibwkiX7wQRDAwkVp
	 h736mU3u3DMYA==
Message-ID: <sashiko-outbox-222943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 1/4] PCI/CXL: Don't offer 'cxl_bus' reset where a bus
 reset can't work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261119100628.1948990-2-vidyas@nvidia.com>
References: <20261119100628.1948990-1-vidyas@nvidia.com>
 <20261119100628.1948990-2-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:20:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> cxl_reset_bus_function() reports the "cxl_bus" reset method as supported
> whenever the device's upstream bridge has a CXL Port DVSEC.  The reset
> itself goes through pci_reset_bus_function(), which can only reset the
> device through a hotplug slot or a Secondary Bus Reset of the parent
> bridge.  It returns -ENOTTY when neither is possible, e.g., when other
> functions share the device's bus, when the device is a bridge, or when it
> has PCI_DEV_FLAGS_NO_BUS_RESET.
>=20
> "cxl_bus" is then listed in "reset_method" but always fails.  For example,
> on function 1 of a 4-function ConnectX-8 below a CXL-capable Root Port
> without a hotplug slot, "bus" is correctly not offered, but "cxl_bus" is:
>=20
>   # cat /sys/bus/pci/devices/0001:01:00.1/reset_method
>   flr cxl_bus
>   # echo cxl_bus > /sys/bus/pci/devices/0001:01:00.1/reset_method
>   # echo 1 > /sys/bus/pci/devices/0001:01:00.1/reset
>   bash: echo: write error: Inappropriate ioctl for device
>=20
> Each attempt still temporarily sets "Unmask SBR" in the Root Port and runs
> the IOMMU reset prepare/done hooks, although no reset happens.
>=20
> Move the slot and parent bus reset from pci_reset_bus_function() into a
> new __pci_reset_bus_function() and use it for the "cxl_bus" probe.  The
> probe now makes the same slot and parent-bus checks as the "bus" probe.
> "cxl_bus" is then offered under the same conditions as "bus", except for
> the CXL SBR mask that "cxl_bus" exists to clear.
>=20
> Fixes: 53c49b6e6dd2 ("PCI/CXL: Add 'cxl_bus' reset method for devices bel=
ow CXL Ports")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119100628.1948=
990-2-vidyas@nvidia.com?part=3D1

