Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB53FA5EB
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724504; cv=none; b=igiZb5nD8MOFTy2yo0dWZHwrtiTaWcT2ol4N7GUAf9fyOuJM17mtLh2Vs4zMmSj2GrzYzEqmMHfgtSnz+biQc9wownsXw6dWjvKJSMUGMK5XefJ/17I0/MOSuajlIp9BwnTCWc60mSPnYHUVra08S6b9xU2aAolmXX+bTmGAQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724504; c=relaxed/simple;
	bh=eqzwkhJPCVsywGS3DhDr9S+gQ96pt+Y8q1QnWG6f+WU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gXqiD37z6fj7majyhFxfR7OmjkW5ZndgFcvGAN2AAHuBbAiEeCD/9kvOclGtioxpDqj75fZ/ACC9vW46obzfhoQnW6PWC4/OEVYYugEWnHZszKyX3mN5uqOmvMYI1kUJ3lPPT4EOyktWL89f5HUcWj4REKXs17DmvY0OFG18zBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLJnBIfD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLJnBIfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DE51F00893;
	Fri, 18 Sep 2026 09:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789724502;
	bh=eqzwkhJPCVsywGS3DhDr9S+gQ96pt+Y8q1QnWG6f+WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WLJnBIfDt86KljIb4rqS2+/Nl3wVM0Cwx7Gj43Q5oqcZ0jnUSja5mGpOlZwe5hslm
	 pNViRxM+UsoCiWcxRALOrXgQkwkYbNrCEDj+1nOYmijojWxuyFHdOVEYXqra8lKZaY
	 Q3C2mSG8LUrAI1xvTaLrITXDzxuectD9VDYIHSgHFgWiszZWAucuyXGfGHyvgZ8JYe
	 47gjT/x4aEhfH8wRf5zGftOtfsjMld6rrLA/XTkh0mRYAupFM8uSe5lOpbZq4E/ZND
	 K4zKm4ICg/3xo2vVI6FoTFMRNWlhJz1pU+sT/ArWrsAH/8wmYyShZ1COx9/ylM6s9C
	 d5YbTKWDFZ+vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Add Lenovo ThinkPad T14s
 gen6 WCN7850 subsystem PCI ids
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans de Goede" <johannes.goede@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918093838.6645-1-johannes.goede@oss.qualcomm.com>
References: <20260918093838.6645-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 09:41:42 +0000
Message-Id: <20260918094142.71DE51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN78=
51
> UART BT variants by subdevice ID") has caused the serdev for the WCN7850 =
on
> the Lenovo ThinkPad T14s gen6 WCN7850 no longer getting created.
>=20
> Add a new match using the PCI subdev ids from the T14s gen6 to fix this.
>=20
> Fixes: a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN78=
51 UART BT variants by subdevice ID")
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918093838.6645=
-1-johannes.goede@oss.qualcomm.com?part=3D1

