Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9B429CF6
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016038; cv=none; b=VuILVd1loUUbpBtUabQRj9DLPT8z2fA0G2faVp689SpNVkUNb49vE2bixbvtt3YxPPYAHdUfXF4WgYULWaybseimKsct4yfOSCLdnKbIksoe/EPa1U7a2C9sMF4y8art9Rsl73OSL0lZHUfGWHefT6PSfvrPiEuzSK+IWS5oEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016038; c=relaxed/simple;
	bh=GsAkJfEFMhAUJ0nID5V6SqiNPiDAXLLn0tSHVX9uJ0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s5DCIZ1Tp/i258StXJWUQ1N/DmoY5SIPzZyd8ix6ay9Wo+O5RufdHJ9PIL91ejSw19DhDmJmOG45E2zomPZc5lUHsbKAnIEzDDlR1rJt+L6MI1YO7XU0bvmUq8od6s7kciIIXQNQP820BihUtCWMqnz1IURWtcA/hWiUtA+JSBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvKIO3G9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvKIO3G9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B94E1F000E9;
	Thu,  6 Aug 2026 11:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016037;
	bh=GsAkJfEFMhAUJ0nID5V6SqiNPiDAXLLn0tSHVX9uJ0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvKIO3G9qNZx7MUxN90fyp2lFKOmvl7iYjQc/jk2ODvtDwKpsS6MlvUqp2PQlY/GX
	 8kU/S6tBS453mdEyK0O+qeowsbsTr2cnoi6DEfE/CPsnH82R8TN3Y74/7AcWqD+shx
	 Y6eLvgdJkLI8PljsOgIw5eNPMfxRMrHKixDh83/x9qJA3sYClZw/eDJufrE39fEewy
	 4iHacXTTt8LxxvmBSyo0/lX+VS9rlHaEZWnjqz5U0RQNqxaa41eafvwIPLYHHraY3T
	 rJun9/Ur00v8Nag9eB9exjvMk7YCyFnNN5p+e2h/jowk6db58wSSBuJKtn+XuT+wXk
	 F5Kh3979U5waw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/13] PCI/P2PDMA: Derive peer-to-peer routing from
 ACS control bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-7-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-7-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:33:56 +0000
Message-Id: <20260806113357.4B94E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> The redirect test reports an upstream redirect for any ACS redirect or
> egress control bit. PCIe r7.0, sec 6.12.3, table 6-11 ties the outcome to
> the control bits and the target vector, and an enabled egress control bit
> alone does not redirect. Compute the result from the control bits so the
> vector can be honored next, using the host-bridge route while the peer
> target is unknown.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D7

