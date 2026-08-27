Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82942F28FF
	for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810366; cv=none; b=fkFpOs8sOa5X8a1WQSICMhj3THxXS9LhdG94jKnWcWPOZ5t5S0f/ai9K8RtCQ4t5TTm87zXVKlYwJnN14gJ/M+v0YYU3hnKgIMFsmKBXIZ5kAoP5V+8amD99vudpUpEr2cvNUcCxrTfeubrqgJeTgmXMmUDC59u0KCFhlXgrTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810366; c=relaxed/simple;
	bh=x+YGVkEMf5ZUr7FWiSkfUrlqc0sohoLmZW5ig8xBZOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O+i36yIibShdHuYw7Nfa8hY+ey/h4oi3vFnFTUfN+0pz4fM7M68/rWIgPdeEKrqbDBRqpA5/jjN4WGczIpNvxMuGy2X3KKm1J8KC13d+ATlK3+7lY8fwE9NJPwnnnHr3c79BEi3S70FuScsA6EmAcBRJy1b8rpWeovVFsq2Ekc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i79JVkNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i79JVkNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409D51F000E9;
	Thu, 27 Aug 2026 05:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787810365;
	bh=x+YGVkEMf5ZUr7FWiSkfUrlqc0sohoLmZW5ig8xBZOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i79JVkNQYo8VsZA3rH6xLnIDfEYQnyskoBtMJN3y0v/kbVRWS1pWhO12Gekx1v7Js
	 +kmuyLN2gYR8SLQJMlskXid+E/qGa8BYK7vDlzxuwFZnZLOrgkyszdbW00z6SDF1eq
	 nZrWeIoz0Bcvz3Isz6DVba45+DjOYH7Lcb1+3Jxq3J2djWKhu9muaxHHstMNPckErS
	 NbNOm2MrUmaUfijaag43vxXlmIF5k+p8Kq8jqnZ2olDndT9Rocb1n7HMRLFzCpFDQd
	 p5oIeFM1mdLaAvBBALhJLS6ElG+fVViRLhK8S7EzWY9pPd9GsHaOY51IJXaxJgyXCi
	 RMj8uouhHCd3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Allow drivers to skip MEM outbound iATU
 setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xincheng Zhang" <zhangxincheng@ultrarisc.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260827055448.1818858-2-zhangxincheng@ultrarisc.com>
References: <20260827055448.1818858-1-zhangxincheng@ultrarisc.com>
 <20260827055448.1818858-2-zhangxincheng@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 05:59:24 +0000
Message-Id: <20260827055925.409D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Some DWC-based controllers do not require outbound iATU windows for MEM
> transactions. For those platforms, programming outbound iATU windows for
> host bridge MEM ranges is unnecessary and may constrain the available MEM
> aperture.
>=20
> Add dw_pcie_rp::bypass_ob_mem_iatu so drivers can skip generic MEM iATU
> setup while using the common DWC host init path.
>=20
> Existing drivers keep the current behavior because the flag defaults to
> false. The I/O iATU setup does not use the MEM resource iterator, and the
> iterator may be uninitialized when MEM setup is skipped. Avoid using it in
> the I/O iATU error path.
>=20
> Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827055448.1818=
858-1-zhangxincheng@ultrarisc.com?part=3D1

