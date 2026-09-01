Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F539383C85;
	Tue,  1 Sep 2026 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225061; cv=none; b=uqxS7Y9l+WhZ0I85IipYGYftwK3zimqFSWT4qcI1aYqjfuJuEgwnH8oZxa1Psg3B4aZEzw900gpXdPpyXXowxrI+5MeAOsaHOgrd3Gp1zF4abFMPATXPvuelQSDM1YXR5iC9d7V9FCeHxYVp6/O3BRMPVG+QP2u+fcg0gvmzqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225061; c=relaxed/simple;
	bh=LunQ2htD8GCRNye+qG/9oWC8PEDpF/PpXmFfsgOUy/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mTuP2bXkp9ekx3ARXqjug0RVju+jQWHlzsJjiul6iBA/Eq2eaE3b2oJezcfzW9egJJ1k5LbT1NLbIFGjl2uontYw2SSrOlibx/XxWV6aSRqFuKP6k0qgAPD1p8Cw9cAz/UazE+qse3dpWbHzbddekIEqIrd+3oeCqPLAfzBjVOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr+8sdjs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr+8sdjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7F41F000E9;
	Tue,  1 Sep 2026 01:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225057;
	bh=LunQ2htD8GCRNye+qG/9oWC8PEDpF/PpXmFfsgOUy/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dr+8sdjsbmV9st2/Ah62l5QtPyvsw6ex+SXHo/6zy9UfY1jATOrOMNi7Y4Qy3+QQ4
	 epi7Xu+EnmLmrZMSjqUvtGXAZMgaL5i0v8zyzz5zeyUyZnWPUOXto5uQ3gIABp9g6o
	 +0hX4qWd4j907O/bX3xdKhQc3lc+OnGmHHys2DtargOqq6Z5goW7ttUeLY54+UGn/q
	 d3hkF4iNW+n6EwtgaQZs3Tfsp/c56sNucaZfGZQADKo36dHCUiM/n5dar01rrDaTHI
	 MLw7jP7RB/Bl2Wkx9rSlhnOPWxY+QIyqJrAB1L3h41ZDWZAu4OIoo534gxR94DWen+
	 hf0Uk521PEoqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/21] rust: add bindings for hash.h
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901010347.2614656-8-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-8-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:10:56 +0000
Message-Id: <20260901011057.6C7F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
> and crypto_free_shash() available to Rust.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D7

