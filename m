Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723701;
	b=04J2Zf0mYX3QI+laXDGrgDQDNQT0myTE9SJs67HZVO4mZ2akEfpL4WQpF77PV+NQaESi
	 rIptIJSXcF2ScSZ0i6bFMMgMbJgZAfSBGRynfjypt+McL6CcIlgANdogXVIkYrt6akrZh
	 tlEXYyWjP/jVEmWNjkfarQgjoqtm42Q4lmpY9VqVQm0cB9qpr4Bg04hm0coKGiYZwJzhs
	 HBHPVBZ16w02RS4D6G+MmwbG49v+fUPVxoLPBP4oc7eG0SudFSiAnSuK+aOX6xdhlhSyA
	 xBptYxTMANMEfaSvEdmQ++t/hT4upveZMJOw/6lC3pnmDXHzGrVhVwk+ngXkJackeZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723701;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2sFqsllPF1Y+q63O3NJrApRdvLUGk6Hfb1rLY7Udmhc=;
	b=0BvfPZQ2NWeKzRpmQ8987sZcSY/5byD9uRU8vqp9q+8yR2kSCSf5zjEAC1KeZOAS+w0G
	 Uz2p4XbxspBOLhYy4DeacdNfh02Yzj7DsUPErWb0HEOapZAh19sv/96wfbRHmPJyMoTjg
	 lRF/oLJYD4rX31Fa+g+k1Zhp1bIumI5zOFLfURKyjio3B0xkr8/45HzGqQJ5U4qJS/x1Q
	 dhqzRcr62YvOK05AkOG1qUC6MQBKyeo2r+f/Ki3m7xwekrFNNwjFz1OWLwK26825dzm6V
	 2qGBrJPQ6BRkKu8uCg2wwX0LyWWwMnYfDOdLVdFIMOm51zFA+hm6qrnGgj7KRKtSWUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRLJN+Kx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E2606A326
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRLJN+Kx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEC21F000C1;
	Tue,  3 Nov 2026 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723701;
	bh=2sFqsllPF1Y+q63O3NJrApRdvLUGk6Hfb1rLY7Udmhc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PRLJN+KxpZcLn8V1WfWdLt9o1ambZ8Y4Blzax218wBQp2SA8bomJBr+eRQfKjpUsw
	 DfHBSJg9FlTBEpwVfmmpj2xcCbo4S7WR923Y8i0SCwiSY/1xmdGrRIGk31u7BE25gb
	 q9pXBQDBMsOrigTtsSiNL8h5uWXEfcRl9X1H4W0iZHKvLHmtqy15INoNFJSfjotd+f
	 5WSZL1UIbTxp73G7DNx6Bf93Havi99c8a06zPCGh9WISYYc2jwGVkbY9csUlNE+HWx
	 RvyKhDkpvXi0wdEMxRC9y6K7zLIZF/hLrYzuWv8hrD+VtLUMQXRZrI6OmgTFwZawuF
	 JAVgER5D9iOdA==
Message-ID: <sashiko-outbox-195731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI/DOE: Poll briefly for a response before
 sleeping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Clapinski" <mclapinski@google.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261103163101.1696520-3-mclapinski@google.com>
References: <20261103163101.1696520-1-mclapinski@google.com>
 <20261103163101.1696520-3-mclapinski@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:35:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> doe_statemachine_work() and pci_doe_abort() wait for the mailbox by
> sleeping PCI_DOE_POLL_INTERVAL (PCI_DOE_TIMEOUT / 128) between status
> reads, which is 7 ms at HZ=3D1000 and 4 ms at HZ=3D250. Mailbox operations
> are served from the device's local mailbox logic and complete much
> faster: on NVIDIA B200 GPUs, an abort completes in ~70 us and a
> discovery exchange in ~110 us, including the status reads polling for
> them. Every DOE-capable endpoint pays the sleep once for the abort
> issued during mailbox creation and once per supported feature during
> enumeration.
>=20
> Make pci_doe_wait(), which both paths use, back off exponentially:
> start with a 1 us delay and double it on every poll until it reaches
> PCI_DOE_POLL_INTERVAL, then fall back to the existing jiffies-based
> wait.
>=20
> Enumeration at boot runs before high resolution timers are enabled, so
> any sleep lasts until the next tick, which at HZ=3D250 is no shorter than
> PCI_DOE_POLL_INTERVAL. Until they are enabled, busy-wait instead of
> sleeping for delays of up to 128 us. Operations that complete within
> ~255 us of accumulated delay, like the ones above, then finish without
> sleeping, while slower ones waste at most that much CPU time before
> sleeping anyway. Once high resolution timers are enabled, short sleeps
> are accurate and no busy-wait beyond what fsleep() does is needed.
>=20
> Time spent in pci_device_add() for a B200 GPU drops from 45.9 ms to
> 6.4 ms.
>=20
> Signed-off-by: Michal Clapinski <mclapinski@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103163101.1696=
520-1-mclapinski@google.com?part=3D2

