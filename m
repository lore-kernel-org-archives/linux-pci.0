Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070C4A1E01;
	Wed,  2 Sep 2026 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357039; cv=none; b=qBXNiOipRu72kqQFz81bcXtmDDLteTao/eBWSPry3MIbaiHBgLpYubzzQYH+gvRPRGNeL4OKwaysKVezRHtqKmB/cDjKpAz9dW+PmTim/gtMTD9BfaK2G5shIgu9zNHigBULpk0b0Xh6YJMowD6Q6OBqbSSTbmzTCnbULQZapac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357039; c=relaxed/simple;
	bh=6DPa7B241pq7fw4nlYGTZ+cvQPbsGt9yP0uzJzWIWSk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AqpY6zWMVZXI+0NILxeweknSRJImMWccJfZIIoomjCUq9k4TpdnwBy1EA/nBKEp+bifv1sBf70j0HU1tLd52d9MYgKZAfvycXY1iwlnRcItB+J2FcmKQiuabA++yeZqZE8LI2nd5c0dy+SkC3vP+ZnuOyv1qu6doWKjRO0LPtp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp7esMTz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp7esMTz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46B91F000E9;
	Wed,  2 Sep 2026 13:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357035;
	bh=6DPa7B241pq7fw4nlYGTZ+cvQPbsGt9yP0uzJzWIWSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vp7esMTzmWpSkSWN+D0tXMiCbMxC278sY5sRuHNRADs22wA/QyPzFZkdo+Xgs+w99
	 Y8HpFZ2DyKNllJuEZUU4FzvZlJfPluCLUEqyTzixc8zcXTHlq9RSmcrC7sImmaMNvL
	 0sDW5htd36L2U34HS1oj1Flv5vhFOK11yYWG2AxZSbRofvijhHtz0lj5NQ2SRZrARa
	 4pQHNAs25Zt5PDUv3r7HuP9F2gOrUbC/f+2bzpjOnWhRMLVUNvKxC+PRAJY7PkGiMP
	 Tfi9Xeu8C5panSbMn/lSKPC1+kdpzbiI9Q/PNZPXkEyIeNd8Bt19JujAw2lqrQy7io
	 mpJT3+vRp2VEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 9/9] Documentation: cxl: Document CXL protocol error
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260902133933.2992457-10-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:50:35 +0000
Message-Id: <20260902135035.B46B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> describing the end-to-end CXL protocol error path: AER ingress, the
> AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
> cases, severity policy, trace events, and a source code map.
>=20
> This documents the architecture introduced by the preceding patches in
> this series.
>=20
> Assisted-by: Claude:claude-opus-4.8
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902133933.2992=
457-1-terry.bowman@amd.com?part=3D9

