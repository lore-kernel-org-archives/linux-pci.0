Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1921427B35F;
	Fri,  9 Oct 2026 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522342; cv=none; b=gcD+3p7zvv3fNmer2b8a7RsJKEtpYj03Da9TAEt3svGpteXSlg9zcnCaDCjtuT+zrX/LWQ9mK7KuZZzdBn/s8Qaj1X21+lm+Wf4P3PRA3qmm2I2a/j5teGeQe2XJdZteSXc3TfELqKBk2OqJGA9d0m1NvGsEDEDGqOHTSU48Ac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522342; c=relaxed/simple;
	bh=iLlQF4x41y9gcIkdwom947TnNWhRUwMJaDprQf3tGPE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rh3hzHBj6EWbSV11+vTMKyTEFUkiN6yTEAxO2HJow7atJJszlw5Xljhb8vZagug6ygvb6BZthsTwjxneNzfbUgeWAaW7IwMLgzEIJxr9ahfGQcEVdMmF6CxIoQaN2A4c4iPaVfdfkFvpktMo4+tLFzJFJteNBmgCTgjy5uZURRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujl63wzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujl63wzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911931F000FF;
	Fri,  9 Oct 2026 05:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522340;
	bh=iLlQF4x41y9gcIkdwom947TnNWhRUwMJaDprQf3tGPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ujl63wzdRI27Tg7UQFgEzcl9ZAnuv40NT9POlvIS6A/5fQSTEPYeIHiG7VCGmDmHu
	 2RJN8bQ3tq9S6gVPmOWH4srRCvrsrCKw1l6EnT6mYvBH6qeNdFOmILDiDfOLd9erCs
	 u6FEnXVLegEw1ddpmOF8/pwUSjW0RkNcx+OJsOguPcvzVFq+RbkBrFqgHgaVRHB0GH
	 IMaqjkKXh4LRJquSRIMFcgLZZ1E/h1E+8KtX1oIfORYA8KHd5IB54D1hGMSf641JYp
	 GfPH7cDvsDgioyoba4IejyVlDn8VjwgIlwW1jrAe8PhUH6ynFP9VfHvRF7IVHAjay1
	 qqO3DQzXXbR9w==
Message-ID: <sashiko-outbox-164867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/7] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20261009045949.1109871-3-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
 <20261009045949.1109871-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 05:05:40 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Expose the endpoint-integrated eDMA register window and linked-list memory
> through the EPC auxiliary resource API. Endpoint functions can then choose
> which channels to export and map the required windows.
>=20
> Associate each linked-list region with the direction-flattened static
> channel ID used by the local dw-edma device. Report these resources only
> after that device is registered and only for channels with linked-list
> memory.
>=20
> When the register window is already part of a reserved BAR, report its BAR
> and offset. Otherwise report its CPU physical address.
>=20
> While at it, harden the existing doorbell resource query. Report it
> only after the local dw-edma device is registered, and reject VF
> queries because DWC cannot assign DMA/HDMA registers to VFs.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009045949.1109=
871-1-den@valinux.co.jp?part=3D2

