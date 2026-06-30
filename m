Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F6404BFD;
	Tue, 30 Jun 2026 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823217; cv=none; b=KQJyhptfQdjt+ToHm3zSeyJsFZHqsBSTo5RpMgzGkDN+wGAZ7Zy8JhN2DQL1gRIkhfSXXxSVnC9CsFeoN1qQaLWHXRG1DmR0D1RM0epAt6jXSjm45dMBPB/wY/x9aY051nyFbaypMUdi0D0ZemMIgfnY4cWo3ll7bhjWVfzBSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823217; c=relaxed/simple;
	bh=pkOfWleTAoRTBq+Oo5iJfbPZ0XHswf3coUym+OIUsVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PuWaX/0ahQVbOpZK/JjhU5Cctt4+9Qyeef2ovhyhzY/6lZfLU2YAM84XhLWXBqOUL13m6yFR948jFVmELmRmZakugOVPKN9M02vKvxpdNXl/vA+07RcHwPzLeqFLwM2wAde6vbOXMzGUAdJxZ12vObdJUBHG19WHqAFhwUnNvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRUvHqpP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRUvHqpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798A71F000E9;
	Tue, 30 Jun 2026 12:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823215;
	bh=pkOfWleTAoRTBq+Oo5iJfbPZ0XHswf3coUym+OIUsVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRUvHqpPkYvquyRFGM5LH0H2ZROJL43y+UX5njVPQzxeaL+ioroDnSCYFjHMkcnM/
	 MuO24o0G9wcOWs9ymFIRBvMFTPWNfHUjtubUDjAMfCfnvpBRHOJ6KZxB2DGgzRJTke
	 sVbaIP6rzKhPAI52BFJwmqYkIaf+XoTRXzd+hkGXpMTbvfezMTKCIvi7zQnDuj9qH5
	 rTvsFkx7U9td6Cr93yG94YnBmDttlCsvl/znc5MSP9EdZhbJCeRCoqPF6NpaxVcubs
	 +jHetG6MYpf9PwJwdKKTAeKEKeDnc/IeOTGQEqESujuNH0QBhqlxzsijX88OneeqLE
	 TTMDl11xe20WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/11] rust: net/phy: remove expansion from doc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, robh@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260629-id_info-v2-5-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-5-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:13 +0000
Message-Id: <20260630124014.798A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The expansion serves little purpose and it can easily diverge.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D5

