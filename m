Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271508;
	b=MeMf4n+ZNs2ODVSVJMOuwt4tbwv3s/0ryXfKw2Q52N4iQ/cyTfbuKxifn/5Yvwaj/859
	 Ug9aUUM9wCmewhMLj9vJdN7hXLMiLjwU421dq9mUdVoq0BhKl6nzGCkkJZg6/8Np6LKV8
	 aVUbhf6gMJ/vrCRyYfoVlbIfkQEYsJqNfGxDHQzf9xOcM9nZbS4n1nALzNtwgAxxXJQIP
	 xy9qozMDSeUDrkXo2otzPMI6bfbSsgFixzvBRLn+UgqkScM7Xxbo3czksSi8xCXDP2nBp
	 kxOZk1/FJiD4iT1gSLGxJpgRDlPZHnBwf9uyRD4a8doguGmercc9kf3zeLbiBCd5EkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271508;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xi6jf0HfifdAIEFo46tRnvT3ZNMYJnI36IC9Sr2wmo4=;
	b=4GO5F8FImxZB9tfyom8OMxkcXMzdNBlyGiDcmkopjxLbmR77mYTbn6ZMRlahBx6GjQqd
	 NZLlWJ9OgILX3XmDLJOclVnXcW1I6RhnswNDJF7mSiyQPOvMn+dK1UGzSZBA8LMaaTGdC
	 DvTTRLZxtSFqINjEph2qzrFVJZ6v7/+4BBATM66f1Z9iRZCnEfYAnsyVbC/g/PLjhi6Ek
	 zn/wRU1hvKO6WjY5N1VS/PHmLHA1wc7jeEd9pjq1D65mo+Kyf22LVTdV7YsfV6cIqAuvW
	 9Pg36VAMP05h+T3VxQX+ai/Fv/o9SWgcrtgaGrOjVZo49AGxIpKsa5XFsceCI0MC+Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUk70MAp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07ED606A321
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 00:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUk70MAp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE9A1F0089F;
	Tue, 10 Nov 2026 00:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794271507;
	bh=Xi6jf0HfifdAIEFo46tRnvT3ZNMYJnI36IC9Sr2wmo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fUk70MApRrLmsOLOlvZM90zcOaGfIbGvwPz6yDqZrj1wE9FKCWbFdycf6Ac8IpVbb
	 xoh0S/nQrDbaJQF1PQQiHrZUcfIDFItI6TW/LE72jzwQK7Q6/ENnuP7NN3xt7Bq2Zd
	 /sfAh7mA7vr8FcPmlTrggWn5PGvp6FLuB4ybkrcWCtZroc6KIkL4VCvtsmeusT5Rxr
	 6Nb3F2IiI1ByhwlYzdOpaF747JdXU0Rlwf31YkVVxXMCGuuWrnnh0k6IJNBXadQaQC
	 qjIzwl1S2mSA6rJRKNG9y1fcUck8UMUaIs6ASSUkNLW9BeKCUNYXE4gTwm6XmUH5L2
	 C0ejxAHTZvjFg==
Message-ID: <sashiko-outbox-205890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Don't add failed disabled ROM BARs to fail_head
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Markham" <kameron.markham@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261109-r730-disabled-rom-fail-head-v1-1-88ef813d125e@gmail.com>
References: <20261109-r730-disabled-rom-fail-head-v1-1-88ef813d125e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:45:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Kameron Markham <kameron.markham@gmail.com>
>=20
> On Dell PowerEdge R730 servers with "SR-IOV Global Enable" disabled in
> the BIOS setup, kernels since v6.15 hard-reset while igb probes the
> on-board Intel I350 NIC. The iDRAC logs PWR2262 ("The Intel Management
> Engine has reported an internal system error"), CPU0000 (IERR) and a
> CPU machine check, and the BIOS sometimes halts in POST afterwards
> (PST0208). v6.14 boots fine on the same machine.
>=20
> With SR-IOV Global Enable disabled, the firmware does not assign the VF
> BARs of the on-board 82599 NIC, so pci_realloc_detect() enables
> resource reallocation automatically. On the first assignment pass the
> disabled Expansion ROM BARs of three devices cannot be assigned:
>=20
>   pci 0000:02:00.0: ROM [mem size 0x00100000 pref]: can't assign; no space
> [ ... ]
>=20
> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list i=
n sync")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222253
> Cc: stable@vger.kernel.org
> Signed-off-by: Kameron Markham <kameron.markham@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-r730-disab=
led-rom-fail-head-v1-1-88ef813d125e@gmail.com?part=3D1

