Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182837;
	b=fFzuyUF4KR7RCzlewNHEwSTcOzNVfeAGls1ff8g+sgjo29Z3BzFnvrlPOh/Z2rfp0IjR
	 RAfAV+TEHI0qLOTTpidkjjhXlaOaDl9ra9EqkM7dZ1FOvAo9mPMujEnohQhdZ1KBooTIA
	 YIDlclE1ZHFcVyiamCVwoPUfaTlwtF9xBebR0K0SQXNzpQ5Vq+9eOMJpVmjI59JkQmHJL
	 KitDPGLfa6qYSPyMStUGsZnI8uZN15laqQhO1bzEo+qLhKPrwN2QNyq4qrJQr0NQI8ScS
	 IMHlWTeUPk2PNTD/BGD716DfviyaO+ZUB1glQEY2kDzO7ZO/gE5Vxoy8lR1+pudK9Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182837;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yXvqQXehe98UgPBPlfH5asDvdMFTp1jPXviJro8z3vg=;
	b=wVtOyO1UzuDTrNsWz/7KdMACuA6p/G7r8qkChh4UzHptaURmfpKAegBt5m7tHQ2kOHCO
	 +JgLsqSuLebR71Ltc5XpJtnSZFhw8HiupBOIKbdY8AtxqQKSDjdRm7W+bF+MePWU1dBLy
	 TrtK8xHrmq57XETx1CBUWs0bNK+rPOQU+42wpr1qZ1sJn3zdJI+Hv0SM2Pp29joWPz70G
	 qtnpF0qIr0RjDn5hbDo5d7WYOGWdtg/0rpqfD7be4BVw7Nutn2pFLZ7dwR46RZGR7sdj0
	 k7Ikqd17I1fBMxZ60jkEOh/rPk8yLhENOZtOcggOiEVXwiwd3cY4P/OtUesMrVizpQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SG/DnGNZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C264606A320
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SG/DnGNZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C5A1F000C6;
	Fri, 20 Nov 2026 13:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182836;
	bh=yXvqQXehe98UgPBPlfH5asDvdMFTp1jPXviJro8z3vg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SG/DnGNZkNarG6aEyqPSjwS4FvENppM6i/gU0L2sxqt6ovM8OOhnpQF2w8Yar8Wug
	 ma2f9mrbMpjkvr/6UpGxq4BPV1O8fhOI2vJAbXts5z+W95jl8A3f7D5Qh1g9n5V2Kw
	 3tA+zHK6Zx90HXPTT5zBIIQtrjiSvZZCOiwDx6PW8eYoETQvw0poC3jA+jZGfJK+6+
	 9uckiBOoCWAfuWQScDJ3cvvCdeOTLDI1TIXLO6vk/GPpbkHYFaJBY0mUk27vSFccW6
	 cYHEGfpJRobc4n3rGEY/LDj8ry2TQ5UtKgtpVj46cas3Z2D7G3KpEeHIAXrHhxZsCk
	 taxF+cW3FQfGA==
Message-ID: <sashiko-outbox-225293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/16] PCI: Add
 pci_assign_unassigned_slot_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-5-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:53:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Bridge window sizing and resource assignment need locks that are held
> across both phases. acpiphp open-codes
> pci_assign_unassigned_bus_resources() with a slot filter by calling the
> internal sizing and assignment functions directly, so it would have to
> duplicate that locking.
>=20
> Add pci_assign_unassigned_slot_resources() which sizes only the bridges
> in the given slot, and implement pci_assign_unassigned_bus_resources()
> with it.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D4

