Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8891A3AB0;
	Fri, 31 Jul 2026 01:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461270; cv=none; b=kvp6J8CjoYJYAEKDSTu1xrDfyLRR0caur1CxtdhGB0MLGX9losg26SJWlnadhby8TcmYIzrFjbnGUNUKH7HoRwrxZTyMtI7bWBlSxEquC5B/ISZw+U9bD0hF76Xosojfzo6Wx34CorPiJyq1ZcVEG7N/gbf7F/HnYyAMy7iAZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461270; c=relaxed/simple;
	bh=SIXK5VnuL/1DMCih9kWbUdSGXd2kLlN8LzJ9PKDGHVw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qcw5Xpm7+q7iVk39wIGpUPkPJOZWJMH9ei+7hSw9vI84Dqg/MPzKcoBvJOCHWqj5yRXvxZpRHI3ej2sgHJGntT/NXZLtt+CrLR4SHWHO6XLSKz/6JG4PFF0wQkPTBwTBWdY6e/6iTbpbgrr1wH9mvlz1rhU9+yPMiPhEIyNHxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQssasCm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQssasCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16591F000E9;
	Fri, 31 Jul 2026 01:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461269;
	bh=SIXK5VnuL/1DMCih9kWbUdSGXd2kLlN8LzJ9PKDGHVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HQssasCmsbbmQjMguKk/MTGE8JinxiFB2+x4ZvHoXW9+FfzG1ytjqae4nljE1U2zU
	 lGeVBZWA4k6pyp4tpcGKONuE+uXjfqnPiN8xieCxDVVvEAU4qoMYfuPoeUvKUSmXcB
	 9JJ/pmghZ9k8M/YL4EGfyY4Zu4DJ4Pe7tDxvgc2cXR7Nyehs7vu9CmWdqbggK5mdG5
	 qenw8bkO4sirmJPciwoqQHeTj/d4/lh2jbnJD/llNIFw8+YpdtN0grqugK7LckKm+4
	 JO1qyQ1733Qi/21UQfWVr9SqTk/ZvdqYfZ5z0jAOZXNGx7ReraxaaOyQClD2+Ozztb
	 yJXNRsxX7Zcfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] PCI: ultrarisc: get and enable DP1000 PCIe
 clocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Wang" <wangjia@ultrarisc.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260731-ultrarisc-pci-clk-v4-2-d738b491e49a@ultrarisc.com>
References: <20260731-ultrarisc-pci-clk-v4-0-d738b491e49a@ultrarisc.com>
 <20260731-ultrarisc-pci-clk-v4-2-d738b491e49a@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 01:27:48 +0000
Message-Id: <20260731012748.B16591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jia Wang <wangjia@ultrarisc.com>
>=20
> Add the required core, dbi, and aux clocks for the DP1000 PCIe
> controller and enable them before initializing the DesignWare host.
>=20
> Also manage the clocks across system suspend and resume.
>=20
> Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Comp=
lex driver")
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-ultrarisc-=
pci-clk-v4-0-d738b491e49a@ultrarisc.com?part=3D2

