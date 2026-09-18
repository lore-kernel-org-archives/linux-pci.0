Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48BE3E3DAB;
	Fri, 18 Sep 2026 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762757; cv=none; b=gaJr5W6H3gIc4mdoHZDDVT5GGwyGdOtKFL0v03WT+WsW2iEqTJJunbC0W3dLbm+Yr+ubIfDB0ZH2AIT0fb1Q4eDpL2cXy0Frza4qFPXu9N8H6DYxnakuweSNgoo/FdIDj/utTB8ZE1255celvqcnaVw8/SN04cvaIJcMbCgDfCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762757; c=relaxed/simple;
	bh=sPMFs+N7+9joEThLRn1A4j3xw35F8/P+UFOYT3cS5vs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jTEmueRrZa57tYMZJ42TqQNo7V68RoHQbrWaM9/WrF7d/O3cOZERXaBm7nAwV2JVcAV2tDoYc2W0GTE2rm3GNXl9Rvd1vq47ZfPZNUddw4nKiCxVCoKF+zQ5ovARxNbEXxauCN/Yo5bme3Q8sDCiQWhp5echtBj/jLbj76UQ4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPlYpnky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPlYpnky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC1D1F000FF;
	Fri, 18 Sep 2026 20:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762756;
	bh=sPMFs+N7+9joEThLRn1A4j3xw35F8/P+UFOYT3cS5vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YPlYpnky7mi7B4nDnFiPWFOktxyeOfZ6KKSL7GtCns3H/qFcDP2ymrRRryPu9vgtG
	 q3IxdutHh9FQV/SOx9Wfr7nM7nCvaF6c9fG3dRTc5Pwi6HbXkMEUHCpWm2l+XRvbMO
	 jyeanBPSSs+r9gtihibrV5eci0c2MBoImHb46PnH+WRVi7fbVIbl1nqRcZ4IT6EXdJ
	 lZg0alLcSFWRV3YTOLv2NZHPojAX5Wlyzk00C/tqasLB3LL6/+D84ZWFbIYsTxj4KJ
	 4z1cNCOfQScLPAOORjL2DmtXqRtwA2LJtSLXY7mhhQ0A87b9VYfmZ+8i8MSYTSbUfP
	 5LSVRzzVbIVGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable
 on preserved bridges
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-kernel@vger.kernel.org, "David Matlack" <dmatlack@google.com>, linux-doc@vger.kernel.org, linux-mm@kvack.org
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Vipin
 Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, linux-pci@vger.kernel.org, "Mike Rapoport" <rppt@kernel.org>, "Parav
 Pandit" <parav@nvidia.com>, "Pranjal Shrivastava" <praan@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Alex Williamson" <alex@shazbot.org>, "Jacob
 Pan" <jacob.pan@linux.microsoft.com>, "Alexander Graf" <graf@amazon.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, kexec@lists.infradead.org, "Josh
 Hilke" <jrhilke@google.com>, "Lukas Wunner" <lukas@wunner.de>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "David Rientjes" <rientjes@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Samiullah Khawaja" <skhawaja@google.com>, "Yi
 Liu" <yi.l.liu@intel.com>, "Chris Li" <chrisl@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>
In-Reply-To: <20260918200640.887030-11-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-11-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:19:14 +0000
Message-Id: <20260918201914.EFC1D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Adopt the ARI Forwarding Enable bit on preserved bridges and update
> pci_dev->ari_enabled accordingly during a Live Update. This ensures that
> the preserved devices on the bridge's secondary bus can be identified
> with the same expanded 8-bit function number after a Live Update.
>=20
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D10

