Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF632F87B
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666207; cv=none; b=H4gUfYl51vCYCwMx2bBFoFye5H4FgWFSKGbkYqniCfCXbQY3i2NEz8gDcP7OTU5/8zwFJeSkU9OGnW61FrtchQoRA7JQzpu411qwZvBlTwj6CJ2w9ioZXPD7pn11jpbLeaC/TmUBBG9+kZJAtQMJeL+Cubprxy8Hy6Q3S9W7OWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666207; c=relaxed/simple;
	bh=4ikkdYgCG7JaZdhO6ugrAk73F4pa2fY7ETGitPFAdRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SsE5tSSCCqV4wmY4wjpImBIdYLqkGb1t3KbdlS0MLLnU7zuJIy7kH+vYEhansl0QBIhVJ0npf6XIa2hRQ0vNZExMpGUoZs9X1Yvnd9jRwn0selUJmqoKMKN1Vkv9jLTdL8wlTbjOVKsbgcgrPSTl3/iMP9xeT132NGELjjwKpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3klGfKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3klGfKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A14C1F000E9;
	Fri, 14 Aug 2026 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786666206;
	bh=0BEC160ldTBMcu8jGWPlVHah0reX40C4mxAS12AIewc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y3klGfKpg9XvkHtOVkc/D0JPLxZrT+DYEI1a3QWVQRY2EhJquM168AXiObIFG9bZw
	 siutbi3EaWsznB++0EdJM8u2ezePh+pW3+8pWqt6L7qrKzEyWW8gZ9cnveCVPfLkBz
	 p3palh1ts/ys1WYNLTOS3w2+JkYwlA/ZtP1Grv9dOga73aeYwjgCugNlvs0TAS+0dg
	 RM2CEZgfz4tuW1RhGRKlyQGIlHSSviSxf8PkbJ9ovWBvuH0LCeY5vuKVK0c2FSZlMj
	 +XMwkT3he6MoWRctL7EwOqEB1sUp8LEvQzW2I3lC0yKk2B7j/nhS5IjrbiKo082uFJ
	 TAcZkbICyKPIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/24] alpha/PCI: Remove WARN from __pci_mmap_fits()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260411080148.471335-17-kwilczynski@kernel.org>
References: <20260411080148.471335-17-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:10:05 +0000
Message-Id: <20260814001006.4A14C1F000E9@smtp.kernel.org>
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
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411080148.4713=
35-1-kwilczynski@kernel.org?part=3D16

