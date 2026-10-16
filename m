Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A812E5B2D
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148256; cv=none; b=DB9ccHLtHZTa5vZnGH1l/IPPE6WbfibhajxzSQgAM2vwV4v0P03hvGO5+2mHEzI0ih+qSv8E2eKoViSo49GdM+S+yyI3H1cAZkdaMoAdP+qdU+JOUkvKhxsSjrXSo7w223e7Bq7wrAXttuN/RSljB3y1YsIbJlVNOD/i7M3LkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148256; c=relaxed/simple;
	bh=LIVNWUvL4Za4U/M+59nIj02xnPSvj+RoHsmlKS1Eiu0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Acnr+nXqdVE2ca7Jvsb64nXeKxTEOee/BGPHto9a+uDxNpgdKhhgluXxly8F/sFHYxGpbnNbbaZTpHcB/adS4G39W9JvLCg3NSK2neKEfOppLCSIngkkYf5csJjR1glQlcwfRC3lY+1eD/kDtbe/ntFKFBAXvJtkoHKDd1ag40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWuxHq8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWuxHq8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43481F000C4;
	Fri, 16 Oct 2026 10:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792148254;
	bh=pLzkZ0Zm886cAyy/AW8v4bzhFyBK9O9ETHQtVUdkJWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SWuxHq8Q3ftQhNnPK3XyLUTvaErQmxJyYaDhP+wWHOsiuEOfhHaurRqvWhJa4IceR
	 jAGkgfVoZcgUIMLZJ/AiwY4mmGaEW93LZtm5tz6NMghQLh3u5nozH6YYFVtA4puA9Z
	 BgebfJ43UMB97HZ8+K9FHVo6ZtBSrUROA/C0/rHFJiOD7cPCRv87XZ1NNBQ6g4WF+j
	 syYygnS3TWvp6LOBmPa95lfAK7MA/URuuyHByRJWprgjmsQ6XVUlaz0BhqC4eUmG1E
	 TveWmLGvoNUK21/hfPBp+wWm3XIjEtuz2tCiIRuqiQLj+5AfTmHTHZttO4utBp1ruD
	 KpAoo3bAKqzXQ==
Message-ID: <sashiko-outbox-174218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Add PLX 8600/8700 quirk for missing
 Command Completed events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Murashka" <yurypm@arista.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261016105426.1366992-1-yurypm@arista.com>
References: <20260918212343.D98451F00898@smtp.kernel.org>
 <20261016105426.1366992-1-yurypm@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:57:34 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> All PLX PEX 8600- and 8700-series data books say the Command Completed bit
> is set only after the Hot Plug Controller completes a command that changes
> the Attention Indicator Control, Power Indicator Control, Power Controller
> Control, or Electromechanical Interlock Control fields.  It is not set
> after writes that only change the Presence Detect Changed Enable or Comma=
nd
> Completed Interrupt Enable bits.
>=20
> Consequently, pciehp waits for Command Completed after changing these
> notification Enable bits and logs a timeout, for example:
>=20
>   pcieport 0000:90:02.0: pciehp: Timeout on hotplug command 0x07c0
>   (issued 2032 msec ago)
>=20
> Like the controllers already handled by quirk_cmd_compl(), these PLX
> switches report completion only when the same four Control fields change
> and fail to report completion for notification Enable-only writes.
>=20
> Add only the PLX PEX 8600- and 8700-series switches on which this fix was
> tested to quirk_cmd_compl().  This makes pciehp mark Enable-only writes
> complete immediately while continuing to wait for commands that change
> Control fields.
>=20
> Signed-off-by: Yury Murashka <yurypm@arista.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016105426.1366=
992-1-yurypm@arista.com?part=3D1

