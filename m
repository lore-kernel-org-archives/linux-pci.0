Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450599;
	b=tQkI2H0iiWtcnYuXkjJmmKbnpLgDWNjNpkbb1f4VXf7wyvke1enOecjA8f/m4PDkC82G
	 1mYu3oQ4lX/enuKSHCScE18QpaoINVmCI/RYWSIjcw9GHVw7iB81nZVX2HLFhqg6WQDrk
	 0VDMej3l3h8dADB0GGxkzqWfq7tY+UEQvGxPF3riNny3vVo486sp0TWNtI6S1Z+q0sfnd
	 +1nLdCpdNp3r7SQQ32JQ50V1KYaDSSIO1oF/5tmFZOjaPwfmydtaUNoQW1h/zXKOhw310
	 dCOQwAAgRvRRUH/Q+LgBqqOtaSVqC8V3TUc3bX850QeYq/CIfp0OFY9j66ifdnLjDUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l3RuhYbwEU3vQiCy829KxWLgwQxd/5G2qn8sKMSRDVI=;
	b=dSRCneajY0FKNDf2I3CyM1yVRMw83/f7FYi2dSgSbH5Bf8z1ZYpkjyaOnLs7RAuuzeS3
	 racDXmzg7pbp0mPShyEZAxcXoWWLuaP5fZxdC3QUJ485ffN/wceLu/C6SS+E4SyNLKxmx
	 Ojv5ugTfqd8otSvaOxUiwMMiA6PjD+8ItN0PAhn9GgxNpr5MC0rMH0Hn1XXbFk07K651Y
	 y9lJGqHiSXnGpwx8hubuaECXzmCSXJky24iYBZtlE9q+7torpmNJep1uLDfU+PzzJl1Ct
	 SDf40NqgT10+vSweA/HNtRszEi9XuqdYRHy1i8ycCD5/d94mqX+Ku8OKuQHM/j8O6ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RekfWeeS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD62606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RekfWeeS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4E11F00A05;
	Thu, 12 Nov 2026 02:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450598;
	bh=l3RuhYbwEU3vQiCy829KxWLgwQxd/5G2qn8sKMSRDVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RekfWeeS8wHuXlutoPmDImRDvmcv6gFqPXktuhszGukgvjAp3C3IXax0R/jgJ2Cy+
	 WfYpO4qRsxkbikFK1gzZ/hU/j+60WptdzrxhExY0kS6MW0nCaddDZHTRDQzwpyBAdk
	 rTyDsU5OKImeS1XeTZN0ZJOCoCcSQXEcRSr9JIut4TAQSSisOW3kOOCV9vIKmDS/yu
	 CyEiBLEmg09PO0TK0Qn3z1iUujqdwd9wUHUMfuv3pZ9UH3Wp3vj1tjSsQA1iyNVcw9
	 EpkXAODzPE2xEZoP77yKrlIF10zigS2XAjEH5s+jfczOYL6DwkrZzn5fxCJ2akruRM
	 yYx+nLCi5gp/w==
Message-ID: <sashiko-outbox-210196@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] PCI: tegra264: Use pcie_get_link_speed()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261112022405.1230200-4-18255117159@163.com>
References: <20261112022405.1230200-1-18255117159@163.com>
 <20261112022405.1230200-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:29:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Tegra264 was added after pcie_get_link_speed() was introduced and still
> indexes pcie_link_speed[] directly.  Convert it to the helper so it does
> not depend on the array being exported and cannot go out of bounds on
> invalid speed values.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112022405.1230=
200-1-18255117159@163.com?part=3D3

