Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8CD477E22
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932487; cv=none; b=MEXS43xxl4tx8KSV/mxMZNoRNC4Yq8ZLiKUUlU0eFEH6zgoYW84SzDfDATYv37HesZZfOSFv9Rcn6No7UsMROzi+3nX0mXL2pvO6QHAdqa7/0rGMtwug4pO3zR5EJ2iAm2iOaCwTmlrODG8PUQBf05Lc7ve53+oSSHv88fWT/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932487; c=relaxed/simple;
	bh=M3tCDN5wg/rW2tWDaS0DsWEJnyJdRcTCdPIQrvBzZ9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pZLModMS1C7iMhPtmB47957mTixEna5az3PyPGo1AC7aGyvFrbiUrz9xj7+rFIuhJWn0tBMKnaejzH+pAmkEf3z7iCRBa3E0eFoOj18m/qLdMd8b8cUwwxY26Zn0Tv+yQMzqIqS+0WUldndDyImWNzFxCapI1Bt4r2U5Fm8csnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gnrr6H7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gnrr6H7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820BD1F000FF;
	Fri,  2 Oct 2026 09:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932485;
	bh=M3tCDN5wg/rW2tWDaS0DsWEJnyJdRcTCdPIQrvBzZ9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gnrr6H7QKZcRMAy8ArLNXhetN8MmeHo7TguuH6vpp3EIdanIOSH5nNgFJjr2XG/OT
	 n+rS6bIy/NqMOkMg+zf0+AlCyaagSzn2Oe2TYJaPt5CwBpz9Mb8Uueh8OOc6H0k9oI
	 bzvKY8WEqvphZZJo8icfvHlu24fVtLHE9MMlMhMQCYx034IPmwA2O6O2HoxpN0ybST
	 BPsKOsocm77gVvdoZ1Igl+S2bh4dqBE62FVol1IGYOsa+BSpfueZypnUzz5Cq8B5Tj
	 YKY2wDx7QzKIZM8DeglXkydro9/BguE05V8I64Rn50Xpl+TzRtzROiuVSO6XlHdlTg
	 jS7CYSFRAyn+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: Correct PCIE_DW_PLAT_EP reference in Kconfig
 help
Reply-To: sashiko-reviews@lists.linux.dev
To: "LECOINTRE Philippe" <philippe.lecointre@thalesgroup.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <305ef70ecadb4db9aa42c66607240aba@thalesgroup.com>
References: <305ef70ecadb4db9aa42c66607240aba@thalesgroup.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:45 +0000
Message-Id: <20261002091445.820BD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Kconfig help text for PCIE_DW_PLAT_HOST and PCIE_DW_PLAT_EP
> incorrectly refers to PCI_DW_PLAT_EP.
>=20
> Replace the typo with the correct symbol name, PCIE_DW_PLAT_EP, so the
> help text matches the actual Kconfig option.
>=20
> Signed-off-by: Philippe Lecointre <philippe.lecointre@thalesgroup.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/305ef70ecadb4db9aa4=
2c66607240aba@thalesgroup.com?part=3D1

