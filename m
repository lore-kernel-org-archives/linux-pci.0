Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B63451AA
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859412; cv=none; b=cmK9xWs2JiVvFmpqyPlHGmGPHEFzPd1w101atWFv0CG0ze+RbZGBdUiyIhCnKjLeI+rO8LXO2UM368Jg6nNZ8t/t5CnhY08CArvIBS7LlS/bGq+YqudXDE6EHUPRGMSTw0DLqtMml49muJgH0jGec7EKb9SiOz9gwoR+3s9WGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859412; c=relaxed/simple;
	bh=RqyDgM+scAfgLfjA41yiEZlZ+07T+Ng8GWtatTXhS7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EvcmW0MtWvHPcq2EDN61rSafWQpc8H7z354cSLw5oLXzt0VFqy7XBup1Q4afQepbKC6dM5ouwucfdCY3XBBraDkft5eiFvD6a6ng058ttZrYZaPTypcK/A9KdiGLBJW7ftcX7+fpAQ6oWsCTOn2BCPtlxZLB5V4mAMdT/RhT8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVHT866z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVHT866z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3941F00A3A;
	Fri, 19 Jun 2026 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859411;
	bh=vByQtXshn+gaXj5F/0VwR03KIBs++KSVI05VuyHrMt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XVHT866zHdL6x4VDPGjDnl6e4TKS6nEIeB8GseEjO2u/2WI7v5PEMFU247GDlGjB8
	 IamFKr9P/ZI+g4s99Yh9JKmHGPY4YZIvGz73VvX9czOO4vl0bWbiZvucXE7t84pxVz
	 mhcIKhJ9a9ecDAIIky8TP9/CKK9CDvQqObNiMC70FtoMrzCC+tJi5MtUqZEowwrr0G
	 LFtUSgGKIfv4Z0TQOLU/XcIsFk8LlS+X8rH+GACJPSibA5Rmw1xwE/mJ63uldkpC7C
	 deDXtP7xpX12E1JhW4rNOqRSmCu4tLAt9taGkGIEIu7W1v1X4sXDffngQTK5OAK8mE
	 BdAg2/3niF40w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/25] alpha/PCI: Remove WARN from __pci_mmap_fits()
 and __legacy_mmap_fits()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-16-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-16-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 08:56:50 +0000
Message-Id: <20260619085650.EB3941F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Remove the WARN() that fires when userspace attempts to mmap beyond
> the BAR bounds.  The check still returns 0 to reject the mapping,
> but the warning is excessive for normal operation.
>=20
> A similar warning was removed from the PCI core in the commit
> 3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").
>=20
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D15

