Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823543BB10C
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573492; cv=none; b=PwFrnNFWbcZiiaQYIz/tXFMQ0M3p9IfMxCiFNpTKmQ/xR4CYLyIJQOoNJaA3oaux08RECvWZd0A4GWQLO1klqn5FDVOEeSAxOW/fj6TXsoO9jZ2Ir9rbTlH9cMooJypQ9IZGG6v5djXNNzaoJJjr1U/7UV8fz+1xqEJMEv/5PPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573492; c=relaxed/simple;
	bh=ZzDTk4KetVQ05ngQLxJBeLoycgo3t7O3ckygopKcw1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sYc2mpUI+6wkRwUA7gfxtO68bwOio9VNqNqYmqzN/JMjoXMxN04aSkQZ7dloyfcTkfBYiiXpAkKRIVxl9+/mYGUmmV2dnsuO9d3cSmJabItynGbJqP0zya9yh9HBo1AQtab0r1wo534ZcvcJLWNIXEZAbn3vPHiHugoFu1QHMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhQkwQJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhQkwQJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0F41F00893;
	Wed, 16 Sep 2026 15:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573486;
	bh=BPzk9NwliEa9sfFgpXlFtEI0oR9PWk91X6hIlRRihWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nhQkwQJWCl7BDbtksWRDD3ugdXIkVIzh4q/yMnyCW8fVqtzANxjMneO9keERPveh7
	 2hYLp3fx8mxaD4P+u3yY3rU0iWbdPkJEeG7oyHU4WXFJvkujxUolOcik7r61OEZli/
	 IeiTUWrW1s4yiizAxQ3z4WGcMK+WK1zaggHpDw6gFSkrnPM/GGNMYxzcylcsmyBTGn
	 jXKN0MTlk9ahKtYHyOvS0Vbn4T93EcXK3R3H9xn/4f6jcF0yIoSWtJE6Ux6xHWhdO6
	 j9xJbOkD4gLF7wLdR7zmlZPty3c5McwLZGOeYIqYfJZAJJgZUx/VYBxffaDXi6pRJO
	 r3S25f00rQj/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/3] PCI: dwc: Remove redundant MPS configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260916153907.60344-4-18255117159@163.com>
References: <20260916153907.60344-1-18255117159@163.com>
 <20260916153907.60344-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:44:46 +0000
Message-Id: <20260916154446.8F0F41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Meson PCIe controller driver manually configures maximum payload
> size (MPS) through meson_set_max_payload, duplicating functionality now
> centralized in the PCI core.  Deprecating redundant code simplifies the
> driver and aligns it with the consolidated MPS management strategy,
> improving long-term maintainability.
>=20
> With meson_set_max_payload() gone, meson_size_to_payload() is only used
> for MRRS.  Rename it to meson_size_to_mrrs(), update the warning message,
> and drop the now-unused PCIE_CAP_MAX_PAYLOAD_SIZE and MAX_PAYLOAD_SIZE
> macros.
>=20
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916153907.6034=
4-1-18255117159@163.com?part=3D3

