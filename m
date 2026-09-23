Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69E2236EB;
	Wed, 23 Sep 2026 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128513; cv=none; b=olvYW/xq5z3Q7/PWrj6JNLZ0Uo+xbZeMmHtBWpZv6APZ3o+nP4lnQT8O3LIfaFtYPfczw28PJCYq09viYFTgW8eEVYEzb8gJioDftKhCEkIh31Xhvp5/oS1BcOSE0b8CvU6JbGUMAX9GnNS3mJGJ8ozUMhU1TDZm2OvECOV5mL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128513; c=relaxed/simple;
	bh=67a18LFwgxr/sllcme2DCbDODu5QDGw8RCxZLxKq1XY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L7SlKlA64W3Lxe3slXMJPz7hc8S7K0U1yPCrtq3wPTnfGy0EZl0eAmH/4yClmMNOq1JY8bgjByQjdkrwpklq/3+p2jR6IG07sEs4Uo8Hia67J9D8fqe9691t545RikSCyqA4tdvOSFQIHL5qGYctoTSRp4tZpVL6IhNoW6fjnoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiUzkIhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiUzkIhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E2A1F00893;
	Wed, 23 Sep 2026 01:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128512;
	bh=67a18LFwgxr/sllcme2DCbDODu5QDGw8RCxZLxKq1XY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QiUzkIhIGINqBxaNSa6Oja7gRX2gCo9qxlp2yseEDsF5kxRer9rTmb6nuAxt24vKc
	 7M5R8XBV7XgrgXP8uY88pl+Z0UuDiIH5Ieda8ByoJuLInfhqIAaLHZMKo56cAjlZ41
	 dF5lMewnwjgPM12jvmr+V4JrAZbycOHGrTkQetyzzSXmIb88LQT5d+sDvhrz8o/A7C
	 NYNa+IW8P2iWJwf8TQFCUnMwBjj8G0re3LnNI2z2rtnUnv9opN32mP0KgKgdhdJKpR
	 jYspHJstVepEL8VymP358gfSSL/Mr8QJcANxY54IwuunqUu6S3k8zCJlGLYitw0jBu
	 4fMv+v3Gfo8kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit
 K3 PCIe host controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260923015016.64069-6-inochiama@gmail.com>
References: <20260923015016.64069-1-inochiama@gmail.com>
 <20260923015016.64069-6-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 01:55:11 +0000
Message-Id: <20260923015512.01E2A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add binding support for the PCIe controller on the SpacemiT K3 SoC.
> This controller is almost a standard Synopsys DesignWare PCIe IP,
> with some extra link and reset state control.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923015016.6406=
9-1-inochiama@gmail.com?part=3D5

