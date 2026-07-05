Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E2A3655C0
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289719; cv=none; b=saHhtV7fDaljavqeHUORHQEzR+BXmR36X2u9+A2f8ocNAlpJV5NY4j0G7vgv5Oa+M1jZv5bKBslfhnYmVtAcFo7wWRVxWGxz/BGmz3rG/sC7MSnxGQagMyfZp1xoEek4wDLlhnXyJ58F439JZ88rqUz/+iRM9503cLvrc7Ifo3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289719; c=relaxed/simple;
	bh=thGYh/dZREQIY1dDp/Iv2/O0/6FgJpJiZzC871HAH8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WGQVEfg6xihVrrwAZjhv6fRVvIBSO71KK1fNfYEL1FoAyADyLlDL3PcMI3empRAXEchoxOio3kz4VBpRj8vWWFQCO4tS68a796C0wQCaKKLb7xjRSzaeVAydb8GZg8M4DR/tOuwNPscroGEIjsO1cDUD5ThGzg1iRBnDcSSpPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpLnbsMj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpLnbsMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB451F000E9;
	Sun,  5 Jul 2026 22:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289717;
	bh=thGYh/dZREQIY1dDp/Iv2/O0/6FgJpJiZzC871HAH8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RpLnbsMj9V6sSKtQMumnmryoX/Y6RtJkwd0Cm9kNuzFt3TCLAoWq/vjdhnOtKbaqr
	 +7hu6qPcl09GzoEvXQh9jVsH+4Sy/BrnhFVSVyhnVMebCCX35r6vQo+hLgDvjXyysH
	 5mjOvwrcI7CKbe6y+yKsqJBPpU1AqI6sGeAVSB92QBxTvbxq+TwyByRPYEyxB3mY4e
	 XF3V/FWpjaEKsmF2o6Uil1EMDmNg+Tm7CxbteFmSon0c2cK+vu8P5yLj0Y7qZSgQt1
	 cpAMxxbaOiwCpBPjDP72ySzqFDNVKGQQpr/0HW8KJxO/nKsvGHNgG4wDp8cZpu/TLS
	 k1we3AEBj5X1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/15] modules: Document the global async_probe
 parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-8-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-8-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:15:17 +0000
Message-Id: <20260705221517.8AB451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In preparation for adding another /sys/module/module/parameters entry,
> document the existing async_probe parameter.
>=20
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D7

