Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19FE3DDB15;
	Thu,  1 Oct 2026 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848929; cv=none; b=EKaFCvslZUs2nCKYOzEv+tYD1BeegKQ1PkqxQvv1BxpPTjs3LamGvGVPVdLcPQEN+cJ7TAEIwpix3+/LgzCVLN/d9dRU/Z7OLpO9QKB/dGdhFdLDt09/XnXBQEl21KPNGjNSsFMx43olUKO0pnP0Wm3V2CHt5/s/Pu7gltC8DDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848929; c=relaxed/simple;
	bh=tRiUjA2KcO0WGuPJFwSnOFD9OyiuxGye81bqhJpEpfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dxj0X1HKLsm0KfkuvDYbztZoAKMvHdqLqnaeELj44XKPB5ATNxxpnIirrfWibol8KWQ90zVUABxTxN1jso8zgHoLb1aox9k8H97QnDcfEiPQzvMUIQaGEBd9/8WCZXtvXyJJMC1Uw8ZfjeIOp9TXjgrTrLP47S/Y241gERX4okk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzKziRUr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzKziRUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9EF1F00898;
	Thu,  1 Oct 2026 10:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790848927;
	bh=tRiUjA2KcO0WGuPJFwSnOFD9OyiuxGye81bqhJpEpfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kzKziRUrF35iw2DnYQ54ZXSF9zoV6AwrdH+fNgK8xQDgMr27Y4Z/Rbijx9w1/XawT
	 xP06yTNbwVYpkTkK5i6BZl2OCOYbTYTEi1aprk3qf4MpQhA5Y/KF3EAuNHx4wiQFKH
	 shpVnS4/LkAKEdPBttVOMGMvSzXfCRvOEHzjO3YgYhoy9S+0HlDCvqMEHYpK/El9JR
	 SOpri/NxowRPXXR2HxFlEDk29enyiD4Vrgav5YXlxTzv/Lfjk9pRbJHdSamOx054bZ
	 gSQmBb/1AVfS6npB9tjPvRp0Hxp4KhY+EIZ4ZIIgNelbdweWu1ucSp5R8PwPm+tPif
	 nP/Rs7S85T5DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 07/16] cxl: Share HDM decoder register unpacking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-8-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:02:06 +0000
Message-Id: <20261001100207.5D9EF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Factor HDM register parsing into cxl_hdm_unpack_decoder(). Validate the
> range and interleave parameters in locals before publishing the complete
> settings, including enable/lock flags and the target-or-skip register
> value.
>=20
> Use the unpacked settings in init_hdm_decoder(), retaining the target-list
> union and passing endpoint skip state to the existing DPA reservation
> helper.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D7

