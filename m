Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599996;
	b=g3NhwXbbyhDL4aHnirIK6kpXXkvDBdsO2Nn93qY/Q+wNUbvLPbLda1tnWR8U7Bg5nZXm
	 Yo3Zoqshsaog4X39ckXL+1rxsiffbYjigrJsy+BcrTLuCiFlwvPXUZW3/qc2nYe5X0N2O
	 WXFoeWCD76n/LR8rdptK+G6Pv9osl7nzuXZtswbqjS3PYnApG/1W0uGRL9qNH6/6eM6Xy
	 0vnlhr5m6EW+1Y6gXXoaDEcivRluT3ALL44KJikxZQkfDuwZzf8H+nBM3K6jVY5V0/8fh
	 F2C1NKSDB3gXGiuNcWTuvy9Lj48zTvyBMpzx0bGVn6a/csjka9pcm6drvRkF9yQ4v2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599996;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gZelb6+SQimuw+6mI7LgXQLiGTzOOIH5/ZP+CGBrIG8=;
	b=Ypr5pqrh/MOMuR+MijKr6NxvaxXlmFpllhYCP7RV3eHnz0Gqu/XUFGfF3kfsX2l6bYk0
	 MA5AaCgE0lSBRy9r/0ameGrp/ksHJGQPgWwceTC5a/I4p9JzGGplIbkhQiPFdCZp04O6D
	 qjPs/0CmbwC0QR2T0k77cIF08Mmr1K4w/7pijQ99niXv+JREPTsIkzU56Koldj84xIOsZ
	 3+e/1nuf+kRNpn5YIYoaXltRJCdRE0tnWGZ7javHuTswtWGCH3VhL9LcdRmE67aDULXcb
	 wPQg5k3zkjccFCNGhhDSfldpQz5TTRZgqhAXZg8SltUQYFs6MjKUoztNEyJIxq7b1lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATQK8TUw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF675606A31E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATQK8TUw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3851F000C0;
	Wed, 25 Nov 2026 09:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599996;
	bh=gZelb6+SQimuw+6mI7LgXQLiGTzOOIH5/ZP+CGBrIG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ATQK8TUwqmHHKNL6l/bhaQKEeyp/G7SQXpEUWU6lvWdRKVImE1w5CF/+z4XniJ9JZ
	 IVeA9bNtFOpFPTusN769XIcicpl5Q8xjCsOI8wtezUIUJoRJv9oVgj3DPYFhTjl/lN
	 lBMOTN6657rKhKjz35nagFNfcfCBchkQb5LkfApwT/VrBWq2Xfe1IRGe25tYOMZjLr
	 /TG97Mwg6N4LWkYZKUWhrD07XiU/5WKS4fHnuTfIKiLvlKs7moRHP2KkuhP6VFtCMT
	 HrA6OcJwqHwzHWLSjwiLd1FlIJR6d2+MD/uO7i3utNTOnkTt9BtL0G1wAzMX59Xf3L
	 h4UdmjoSLkTJg==
Message-ID: <sashiko-outbox-233037@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 00/15] Add support for the NXP S32G SerDes
 subsystem
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIFBldHJvdXMgKE9TUyk=?= <jan.petrous@oss.nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261125-s32g_serdes-v4-0-3bfe0589be8d@oss.nxp.com>
References: <20261125-s32g_serdes-v4-0-3bfe0589be8d@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:46:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 15-patch series:

- Patches 1-10 and 12-15: no issues found.
- Patch 11: skipped (not reviewed).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-s32g_serde=
s-v4-0-3bfe0589be8d@oss.nxp.com
