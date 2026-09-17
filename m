Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A774A498C;
	Thu, 17 Sep 2026 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641181; cv=none; b=Kp8W2+i3M23NkDWyayYK/fo9XoEoHzBfMuqqh/jk1SpEfZ5LsrBGxvbor6Jkfv5Qy/Z9rbOkx8Rygfj8ZZHvSWagqq8ui+qxvVEIar+Nz7+rAsKEqDbr8kbPEFQjtC3s/i4yV+duEETJU0H08BFpaOdRKtLvbKnzYrme9dm0ue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641181; c=relaxed/simple;
	bh=2YuX+CFdvqwykBIKufbp4KH9p6S/lg3C7dxHB07GH6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=agED0/T4y6UuZ1X78u0vC8XOrNwlu6NAZmx9tfQMAlq9iv2yg7CXmif2vQlVlmAlYZCqz9+5ep0r5ZcnjT2M1QbfJpWHQUDaVMAafrZluq+TQ8LUPwb23naaBjCEIBqhfaXeCKQts4/Il0/PFN3uFlVwaz8jk+8k4M2htP0DxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY2iDGM/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY2iDGM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC78E1F00893;
	Thu, 17 Sep 2026 10:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641175;
	bh=2YuX+CFdvqwykBIKufbp4KH9p6S/lg3C7dxHB07GH6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SY2iDGM/pfvVi37DdgQI2MNBP547U81edHKmpGv9ILcPtAB+JZMm+jKNqoElRwPyX
	 9nD1hvGojpDdvugml+blKTNApZmhXYuqW1X0Sd6TEGd3Wff4DsypRVVVEg+2/IsQCn
	 9cl3fkpoCzCSxwIoRAsZEHjNSf5cJpHwmISeo99ZuvjNLqEBPGUYWhgXpvkFfgfRJt
	 qcAJUr23B7XFBV4nY/ey+ZuqgtU4AsRfuDK2b3S9xzKF6f8XCTaAsN/p32YhvQs+dc
	 ESCU3OEPupKzM73+EVr3hN3kjQFMaobdgsWjnkhnspU65joRjkKG0j7QopCWIvtzd4
	 6PvXaftzF+C/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: dw-edma: correct IP name in
 xilinx_cpm6_dma_data comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260917103050.1020982-3-devverma@amd.com>
References: <20260917103050.1020982-1-devverma@amd.com>
 <20260917103050.1020982-3-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:32:54 +0000
Message-Id: <20260917103254.EC78E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Replace 'MDB' with 'CPM6' in the xilinx_cpm6_dma_data comment to
> fix the IP name typo.
> No functional change.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917103050.1020=
982-1-devverma@amd.com?part=3D2

