Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490285;
	b=PlEhz28+5asoBK3qEeHyC2EaWSNLY8bs1kGVr8SUZB+IxIldEZnrz2R6g3my/r/LMw2K
	 Ebr1MIgzRk0fp1szd2g+qOdxa2OAV+NCMdw9IEpAXQGdZF4nTwVLzTdBaLo1k8v7Rx5q8
	 PQlAz895AwVMV+NFBa6S6I3VeFHz7tPhxnW4v/tigCmq+V0fDtb7VgKzl53Q/L1sRIU9S
	 rU6wzbA40b73RNopYqUNNa/kP+NhhhMZMPC3fD0C7/Z4UnJLWnPPjJzokRPFglR6mp717
	 3KiRzLd3aM0I2jATWe6g4YVkQgphX498azBydJo8PzSEandkyOJ+9DxEcV+AIjBTmbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490285;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aIV9CtuzmxOKKZbfGLAo1zNr/2Z7Z452OazH1zMJlic=;
	b=fGbUS7Sn24IhMrha2kxk0ZKZtQ69vT7cPYqnk7orbgFtswlM2PhPS+TDqTpZJOA0kgau
	 m1kh7sjk2n253p1McqFjhlKVwGuuX9MEb4Cu85NqlRz89k0sbYKFpqFUL2Jhb3+HMqfCA
	 e6SvtLwYxEDfNtmmC7cfniQTS2+xZP/+wQbqURoPOZE5ZoytF2cFdBnF0Qf9AbkKvVk4s
	 qbvDEJL34RqiVFutmY3ui5eu6iY9CAylxS6ume+1xQsj1DoHX1xfhQo+9seQPXKWtao8U
	 hE7nzvaFurZe516OhaGp8KVQQFVeA+gtzKDJzgmsxVzb4bB3kcTBdIH7owM7tRmlhCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6txJ07H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ADA606A319
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6txJ07H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56AE1F000C4;
	Tue, 20 Oct 2026 09:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792490285;
	bh=aIV9CtuzmxOKKZbfGLAo1zNr/2Z7Z452OazH1zMJlic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i6txJ07HhfeIOIasA7149JIBOcplgJ350uVXWyxLzksT5FXPwX+tlccdfl3UylDpi
	 mmqwwqTyz424E0hd6z3xPuFe8LuJTKMqaspPG2arsLgAJTUpbxk3DLSrir329Y+4V4
	 QoYt7CLkCPVr0FRnfPMQ6dSMv5pWEMdSIoQKleP6GPbPKEsQur/niHXcK224uLzhXy
	 D1vA+p1l6EbofVl/JwwKT+qMm2oJAIFjF1rL/Q4XD2CKgwKfONM+mhuKtLQt3cQXiH
	 EGFcdf+8e/EIma+fEUopevq5/DzbWtzmRW/UDraPZXV6G2zn16ih8xF3D7qRKKEyER
	 IiV9pJuJkoURg==
Message-ID: <sashiko-outbox-178780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/17] arm64: dts: renesas: r8a779f0: Describe the
 PCIe AER interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-16-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-16-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 09:58:04 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The PCIe controllers report Root Port AER notifications through
> intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
> respectively, separately from the integrated MSI receiver interrupts.
> Describe these interrupts with the "aer" name so the controller driver
> can use them for Root Port error reporting.
>=20
> Append the new interrupts to preserve the existing interrupt indices.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D15

