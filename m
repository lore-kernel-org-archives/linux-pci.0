Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7EE50AC16;
	Thu,  3 Sep 2026 20:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469082; cv=none; b=OINgWcfsJC3rJEGvoLQ0fPEx8ILZ/AwDIhEhC2+u14vwIi7/SeZ6kHIwCpO9iC553zW7ya6C3ZTdhmQf3lGpVSQR9mLqnsvolPa92hrFlYiWJC4mcBm5VfaaSvDZd2zk9D4628srAPDQYqxGbb51+KKWi9fPYY/701a73/wQiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469082; c=relaxed/simple;
	bh=x+OxLZkAAgIvx4QoE3yj/4uYcg3R/aAELQ+fu7v5Q0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kIo+SfPgE4YEnXpQKYaEBfHPfC2+v8IhuZObAl9YuKBNs1cLCx/74XrViOEZUhjrX7DyM/e4kkf8AZuNYzWJ3Rsw7i9cU5ApRcqRpj/z0p2k47iw1UOJ5xbcxxehxD9Omj1kM9an0O3FPyAke3uQkqyxRw8Q+h6+XnrAXMCxrho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9eyB17M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9eyB17M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE3E1F00A3D;
	Thu,  3 Sep 2026 20:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788469069;
	bh=x+OxLZkAAgIvx4QoE3yj/4uYcg3R/aAELQ+fu7v5Q0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9eyB17MCMFCFUg3eZspx4TBVArMEU4Wgt4SG8h3SFVPWC0K8cwr1P1IjcbogrC6e
	 4gNyp1BsC2c61KsL4cq9PVsQn8IwK/AmVARyo2TrCCgKJvtghS2tgx3mxuXU2WOsXW
	 7tP7k7M/rFN2vAYinec6KT1sMBJ2H6nKVgIwaeK6dN3qyfn0k71pA1iYpJJ4tzv6Ow
	 mmNP92URthgs/oZvLAXNdxVOIxi34krohJdrvaiGwAT5ScsnvWFMs7QmPyhpHYmhkX
	 voaTF/0hga29pmaWulrg5DMBYxpyethpzTCq2fMu5NtNSdkwY5bgFXT2vy5a9I1Lc0
	 7fJRvkVGrmpag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: PCI: rcar-gen4-pci-host: Document
 Application/Local register reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org
In-Reply-To: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 20:57:48 +0000
Message-Id: <20260903205748.EDE3E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The R-Car Gen4 PCIe controller does contain core reset, which puts
> the controller back into well defined state, but it does also tear
> down the PCIe link. This is called Application/Local register reset
> in the documentation. Document this reset.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903205153.2835=
53-1-marek.vasut+renesas@mailbox.org?part=3D1

