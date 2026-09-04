Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A1423160;
	Fri,  4 Sep 2026 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530627; cv=none; b=a3QZoBYkbtFKUD9aSR+M/xbypz02U9jgOOAARW+6p4/5XNmtwFf6sIodHyIC1grcGmkAA3vsTfBbLQcQ2izxq/ZQN1oOtJDWARZOgnWgM+kY2XVk8uwTOnLxTE9B/7K+EbZHLHW46IQ2ehnki2x5v8O3DgxYUgp2Xz5ltjZxc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530627; c=relaxed/simple;
	bh=PG2tcqJHAqLE6Ta+d8+XotSryXMN0ygmhHSkNYlEbDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DLExNhUBzbDiduEd1srDSWRKwa53rpZ0JAJWwdovt+pGURCFBExvYgbDnCANxRf3kxg+Lym8+X4xDkXGBBkYiogyk0Z8O5ADbHIUq6qkFo+XWDNHuZEjL6xhFuxdHhW5vAyjykBWEIa59Vh6foH1hXnppXsyk6F1LjYO3u2tpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx9iQ/mr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx9iQ/mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFDF1F00AC4;
	Fri,  4 Sep 2026 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530625;
	bh=PG2tcqJHAqLE6Ta+d8+XotSryXMN0ygmhHSkNYlEbDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zx9iQ/mryPq3MRl+QxsM3O9JaM2yy8YtTDtzYR569ix/pqJHE60TzPNPJsbVIyYpR
	 Tjycl3oB48LkY+Zn8tXTU8jR7vzYBBH6E9pTMzLs9YqNgC8bxe2AsndHygjByB3dfO
	 HzpKFmN/C9BuIey8U/AgJfRNIxoH0C/swvB3ua8BhJ0Q4PCqVzLxVLzPQckfjpnfvf
	 7gjx47eQ4YFY4gLI35vqs45pWTtaaBaXmgn9xRnBZxEktxeqa35JBmHQXemz39Lk8V
	 zyRZwJvUDuGErZQuI9cDbWhV8/sf3lgjbRbGQcLaG8LDp/Gb8RWrYtBpR5lvlG5bOR
	 dgXwvCm+zTubA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] PCI: of: drop the reg_num argument to
 of_pci_set_address()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260904134607.1856121-3-elder@riscstar.com>
References: <20260904134607.1856121-1-elder@riscstar.com>
 <20260904134607.1856121-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 14:03:45 +0000
Message-Id: <20260904140345.6CFDF1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The reg_num argument passed to of_pci_set_address() is always zero,
> so get rid of it.
>=20
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904134607.1856=
121-1-elder@riscstar.com?part=3D2

