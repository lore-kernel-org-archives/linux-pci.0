Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47D53FD4F
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183953; cv=none; b=YyMGZXAQhI/a0VHWlocwn8gdLThgdIt3zCrJpxj1DYEjYqRnkoMk2QbnEyaKY3BQZwXi34jLfcnKGqGuSl9aqx+o3mMEkGAgEA4NM1z0pxnyqFPQZbkKpIm6BXDws/TytY80hFlO1CJnSaJI96h9RaPypei3zmRxXIIR+jVzik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183953; c=relaxed/simple;
	bh=9kytVhS+x5/xmw/Fa1pf5hxNR1BR5G9KyVoXprXWLQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GgzemFRsHCf86EQ5c0AUYWILhN9/MZ3zzaj2tVAnEE71xmaZ+aQBUf7uiaN0Y3bO4HiDcfBrSx4HPCFrBki/o1IkILww+2D3Yeh0El2K/gFtYSbOuRwrHhmG3Jx4J+9SxVcUCo9Fno8kQskV3S7PLzf4U5pfOqxi/1slKNxnEHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny0N6S0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny0N6S0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7BF1F00ADB;
	Mon, 31 Aug 2026 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788183951;
	bh=KqWFxVyOCSBqzhdCBXhk/vjD8d1Zer2YmnfoSEBKFJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ny0N6S0/GRguefZmEgmU1YBG8d/9nTo6ErzM4G5KKyBtXrkN7xnxrHS0bDJRpOQiM
	 CMZNUp/blx2ug3zbrtkUSgSe4nqKCblIkhjXAyVpBqTvuTvQUZLlsPUIQsG5fZOhHK
	 aqmAEoJHT2W5ftU3O1s3AjZC0iPK6nZZVfssdBS7HQ2x/zaG65nfqNk3cVYGQWFUY2
	 pZRLh7TmCRuf0lGvKQ5sqYhIi/9V/NXMS+bPz4m75dU0/SZormrnImoM9QogZd+Yea
	 vqFh5gpknIG0gBAyfeNQaoPLCHEZPSpvN/KogYTkzCnu5JV2rPQJrNkCwIdlwpjnKE
	 PGmV0mrAIw4QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] PCI: Avoid FLR for MediaTek MT7925
 WiFi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-17-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-17-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:45:50 +0000
Message-Id: <20260831134551.1B7BF1F00ADB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
>=20
> [ Upstream commit 9f22b92259bb5ac43e2b9007103787d4418fec56 ]
>=20
> The MediaTek MT7925 WiFi device advertises FLR capability, but it does not
> work correctly. This manifests in VFIO passthrough scenarios. Normal VM
> operation works fine, including clean shutdown/reboot. However, when the =
VM
> terminates uncleanly (crash, force-off), VFIO attempts to reset the device
> before it can be assigned to another VM. Because FLR is broken, the reset
> fails, preventing reuse.
>=20
> This is similar to its predecessor MT7922 (see 81f64e925c29 ("PCI: Avoid
> FLR for Mediatek MT7922 WiFi")), but with different symptoms.  The MT7922
> issue manifests as config read failures (returning ~0) after FLR. The
> MT7925 shows different behavior: config reads work correctly after FLR, b=
ut
> [ ... ]
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Link: https://patch.msgid.link/20260522070646.203115-1-jtornosm@redhat.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-17-sashal@kernel.org?part=3D1

