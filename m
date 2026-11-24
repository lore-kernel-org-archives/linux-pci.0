Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556901;
	b=eceZTqItERaHV5NHg2Ap4IqjM73jH1uBvk4mDMWQ2wkENmSIRkAGp35pNMJRrCFJCurQ
	 t5clrcSi5Wac/XU5VBxwBOCQaElj23IFQev7GQH2Ud0A55+937lXBgeINfzDzPap/aRy4
	 sdu9JGcChJprpP4Iv2azVcxrcisYcbKjwjFNS6ZmgKmdWYB24AslITaGLQF8HY+HTymvL
	 EpBZF+773Oyj7Tkdd+1u5XYGnlhMwbyRoOkSWFFTdtuR/EYv/CEwIr2o0ULUGxa3YH49b
	 IIyujb42PPSCRwxNSI3GAEMTtSjaen1SONWvgulreWgj35fHvVwXwuxhfE5c6JuIWAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556901;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E8MyasW/f/gZcdhaNalSlFOgjq6u6KkqnVTxjmzO3D0=;
	b=m78hvhfyL739gOY7fwnN3me4Ld4GusfH6NL2AqUKYE5ITUseUXPB4L3oLy2jWsnMGRTk
	 OEYoV0EmOD484UwtGTxSNELVNHN8/IH1nvvhINHcD89YiadV2/AYUQL/khdwFyZA+06zb
	 Ovr75Ubvq5Ppi8dHz/rhOf3DJk9pSkwYNu76vydb05qjS/QN7U6OdpcPrcWhYabbdj/H0
	 PHBmvr5aM/RV0JhLm2KLZ4e3WzjKkLU9bxeeL7fZfPLRfiSOF/ejliyfOgde48ZhXHA3d
	 fMAB5oEPcFIN2Dv3ok1BY8jOb9ryc5N66YogPSMyanpckEqd0nUCdRG4GJI9G3oXU3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=diDoIUE2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5623606A31E
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=diDoIUE2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4711F000CA;
	Tue, 24 Nov 2026 21:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795556901;
	bh=E8MyasW/f/gZcdhaNalSlFOgjq6u6KkqnVTxjmzO3D0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=diDoIUE2Ab3+jlbuALaYQeZUvJaSC0SeLRXix+0KaCtWLT02R+OIZLvnB8wYVPBFj
	 Dm2ss6vuxtUyaMKKHo5p3WO/N4OMZCUHzw0iNIgEtJQKVZF18d3+kvQG+fmIXpWhFW
	 lzrUlk41wILS64bZvldm3pbSbOhKQTeoWxSSWC6OpTsL+mj2UWV4xo19/jOaaJ9FMQ
	 lFbRiDZdSNwNBsHofGlRoKUSdujQ1LwEqgtH28g7qqc49M9aDIVjONcZ+aQSqS6eRN
	 xoNa3MqNbYVObtwvlZE02iQpzUxstu43tE3lHMb1IwLBmu+5fpS2eEspiEb5mZfJ6v
	 /MehiszznIfUw==
Message-ID: <sashiko-outbox-232063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vfio/pci: Only lock the upstream bridge if the reset
 may need it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samiullah Khawaja" <skhawaja@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261124212842.1934651-1-skhawaja@google.com>
References: <20261124212842.1934651-1-skhawaja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 21:48:20 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
> vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
> upstream bridge before resetting the device, and skips the reset if the
> trylock fails.
>=20
> All VFs of a PF have the same upstream bridge. Take a device with two
> VFs, both used by one process. When the process is killed, both VFs can
> be released at the same time. The first one takes the bridge lock and
> does its FLR, the second one fails the trylock and is never reset.
>=20
> The bridge lock is only needed for a bus reset, which is done through
> the bridge. Add pci_reset_function_needs_bridge_lock(), which returns
> false if there is no upstream bridge, if bus resets are disabled for the
> device, or if the device is a VF. Use it in vfio_pci_core_disable() and
> pci_reset_function() to only lock the bridge when it is needed.
>=20
> Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_di=
sable()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124212842.1934=
651-1-skhawaja@google.com?part=3D1
