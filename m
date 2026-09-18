Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8343AE6E6;
	Fri, 18 Sep 2026 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762153; cv=none; b=j1/+GYpB1ORwtW8R1llJBpPVX1tkRGXyzG+PElTNpfbcmLqlou0nt8KIrAwEXWjRnA1Z262DhwBsqUACBeY413h1PTbPm3ufe3W524/hDT28LK2evEDY6/wAiTXMUysM/sqzxy4x+EnYGsG1qqbKSj0PBbjIHqr1JE14eyrG9Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762153; c=relaxed/simple;
	bh=0mvUweI6LVBPNQEepHdBFnrekjGsiPZ/QHwECl64qEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N63cUAmenfhbQNQzewP/CCbaruIfFyrB2Ukq3WcU1xF56bgivtr53DFFiCGQYDb8kVDCgrn470WTwlFbzj7OJ2RVKCUa+mULdU7RTgA6EyigNy/FVNlaE4h9c3T2ZqlFjO5b3ERQaU/6XG31KKSxal+ytjlEi46ETh2T+wB4AoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/Mldq4h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/Mldq4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6EF1F000FF;
	Fri, 18 Sep 2026 20:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762152;
	bh=0mvUweI6LVBPNQEepHdBFnrekjGsiPZ/QHwECl64qEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/Mldq4h5/cLD2pUa/DgWkA03MpbXuZlIHxIkDytYVQJvjTbENm4nRXEc2+CCx+jo
	 1s4arjt9Cp3O9MoLeNhbtEUa6eq7dwLCpSC9Yv+T5muc9iJ2B1RgizBY0qnVFKZvdj
	 +Lll49pXmPatXIM6AFUnuX8vioCs5z57nmEJqmgQqHCuVUapf5rJmFno7H5Zbw1qHU
	 Uy0dWh7vbhPCydklKF/HpuCSYphNIVTt+rFhs/V/nwugrKKSwOYizAtJxCs1m1jAmn
	 9ZJ21/mUBza39FWbEI0wegy/PYVXdjOPs6uoudIfnZLf6NU1MV1iLGErpeikW+lDLP
	 F80I/03u8yrgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/13] PCI: liveupdate: Document driver binding
 responsibilities
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-mm@kvack.org, "David Matlack" <dmatlack@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, "Randy Dunlap" <rdunlap@infradead.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Saeed Mahameed" <saeedm@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Pranjal Shrivastava" <praan@google.com>, "Alexander
 Graf" <graf@amazon.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Mike
 Rapoport" <rppt@kernel.org>, "William Tu" <witu@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Jason Gunthorpe" <jgg@nvidia.com>, "Alex
 Williamson" <alex@shazbot.org>, "Parav Pandit" <parav@nvidia.com>, "David
 Rientjes" <rientjes@google.com>, "Vipin Sharma" <vipinsh@google.com>, "Yi
 Liu" <yi.l.liu@intel.com>, "Chris Li" <chrisl@kernel.org>, "Leon Romanovsky" <leonro@nvidia.com>, "Josh
 Hilke" <jrhilke@google.com>, "Pratyush Yadav" <pratyush@kernel.org>, linux-pci@vger.kernel.org, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Lukas Wunner" <lukas@wunner.de>
In-Reply-To: <20260918200640.887030-5-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-5-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:09:10 +0000
Message-Id: <20260918200910.DC6EF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.
>=20
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D4

