Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286772;
	b=Ngs73AKNIs6vVoyzRNNF4zz+CWn77hrthNtRlidIVv4/ISB/LXSa4HM1e8Gb3yA/U6FQ
	 upCuq2zE2J3iEKIBAxg19up0cOAgmATSKV551alMqT2TpsCvZKFZWsPjlIBNT1BdgNwqX
	 c3/dv2TbFPzpMgvWzcQPUHtfb42Yi5MFKUGO2JSpivaoB53B8U2wVGauV7PF8k4Wxk2Tg
	 ZvJYg5Y+EqsHHwy4O8Xosjzpb2gaV0QrR0hmHdFgvnR6Au8rPyj9S7yljqLlqmQ1Tg98M
	 xKIuJSXJ5cE5Aw6MlcZ0E5z3/iKAzI+JdqkNGoCnjn7DuJ2+WLl41b9HiBqa2B9TkFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286772;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fkhz+Yr/vumM1sucWDt+IqkIh9JZ2MdeM8dRNCRS9hg=;
	b=UQQcK6CpjU+OCEjmC8C/WyDrP7pE6iHX4XOfNSkUsE53k/mua1+9OhOqRE6luguxBHgB
	 gNRmml6D+pQu/wewMvur4gJorWfN31EtDvU/mkkQ9W1+j6MBj6JMZ+opnq+INxjomp6Pw
	 dF9ch4AQgVQKud2R1ORE+1ibFPBUAUl/hGenHYsVDqePeA9++TN7naiRBQC3THOPK2fyO
	 2ld3BrQUODo98sMmMsy1huxnypWBoXdyPv4r6acJv8zyqz43ufvIpcXR/oGxdl2exygZp
	 WP4yddnWCPmH+wLf4Ja/5c653Z41Dbt4zzEg52WdSSjyNkEn7rir4wkPClM2COE2uRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqEa0b97;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C7606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqEa0b97
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62E11F01828;
	Thu, 29 Oct 2026 15:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286772;
	bh=fkhz+Yr/vumM1sucWDt+IqkIh9JZ2MdeM8dRNCRS9hg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PqEa0b97w/UGmI7nHEy+VjiqVSJR4ocotDZlAa+KmFk60wI4T7I8Rl2jcNFiaRF8Y
	 P97Bfm0NO9BXntDy+I8pTmFNe6l74pbFonkBCIFs+M2mEa9H7eOScYruO8NBxNceCM
	 5SIWs2euYFTOCKKCJad3GIvsWCzKMWaN7Ukr1S0C4MBgR1NfIbXsqR8+ZV1BF2MWzL
	 aKIc8Z0VQrFs/2ADQ139016leDdkTdx+Lqh6RUdBsl8j8O2teXI6+uXs4y1EU0bGl1
	 u2Gf3sS2yyQYIushoUMQwDjRJx8LH1L0/oJ7IcC65sMMI1FKsYe/rsPdyy2C0zm5Av
	 Ivth7Jc/Fswiw==
Message-ID: <sashiko-outbox-189587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 16/18] PCI/CXL: Expose CXL Reset as a PCI reset
 method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-17-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-17-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:12:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Register cxl_reset with the PCI reset-method interface and place it before
> FLR, which does not reset CXL.cache or CXL.mem protocol state.
>=20
> Return -ENOTTY when device capabilities, function scope, cached HDM state,
> or required cache synchronization do not permit a safe reset.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D16

