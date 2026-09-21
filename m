Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0718859B
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 04:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789966114; cv=none; b=DjeiG2E9ZyfV1fVvsUToXKvmXxLGAG8S8nypoWcjeSCVW7os7g+6VvAENiKoiFlyNcLPIICm6agkZColMovFRUDIwnPvEQ7lwCCZoqrdryzqR++4qi5J79U3iXeuiGikfqDphIe3DoVuJYYia+cfglnkbs7V1+RmF0X/Ea9tT48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789966114; c=relaxed/simple;
	bh=BK9IHtOKDBuKwpXKnNIi+pF3pCRj/LVXF7NiFk3tPoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Awi0nW/dJRRdB/KYf7XfKLafo1dM8nWsgvEdntMOziNwrqVTLwkXZH2QVYPEpZNlGBR22fd/8QKA7rUEno9aLlbGM0vn08TtD9VA5RUToK6DjEWObbBaTYey1YLZLo81Rj7rdfc3LVVpIxC2ow4wHxcuoR7HfKpi1NsS9qrS+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgf4e0BB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgf4e0BB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68BD1F000FF;
	Mon, 21 Sep 2026 04:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789966112;
	bh=BK9IHtOKDBuKwpXKnNIi+pF3pCRj/LVXF7NiFk3tPoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bgf4e0BBA2dTYhOB5sKRErwI9+hNJ1GbWm9ZbUaXYqMsMge6srJbCCZF1W+C+DD5Y
	 SjNHVqf5WygZImyS5eh+EF1FedqF2W1OuCrGGbCY3OOz2uNqWZ3I4rPOpRv8P5rXFq
	 jsBQfHuPBQE3l3jBNdfHxx4JiHqJwFHnV4iK5OXGn8Ks/6ZVGouzdNlEMRHv2Qmwm1
	 zY+iUnxXAiX2ZF2UDOhqLn7arcZXdrSPwmN+UOwS+KOZuLGRK1phb023NvBPS9SaP5
	 HBFlwuTOD1wBFf9+0XdF44PvfHH+fz45asosfOs790ORyIxWG6uTU5vLkqtVpnfzkt
	 0F5ZM2WJekfFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ABI: sysfs-bus-pci: use literal blocks for commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921044637.91089-1-rdunlap@infradead.org>
References: <20260921044637.91089-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 04:48:32 +0000
Message-Id: <20260921044832.A68BD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Use literal blocks for console I/O to separate it from the
> surrounding text. Otherwise the lines run together, without any
> clear break before or after the commands.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921044637.9108=
9-1-rdunlap@infradead.org?part=3D1

