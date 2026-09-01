Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F91380FFD;
	Tue,  1 Sep 2026 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252782; cv=none; b=Aq1pjKgKSq5cfgQP5/dCZaY6wI2ZiyPWhARa+GiYRuBNnlzvndfUZcc6qG+cUWpsxTU2f40y+iJbeqJdj8g8Zc4SMkNYrMMd/jOli8XUpFXQwAZ+zFJC9AuH3OgZfXAXyCfkoqHsMSuvqC1+HvAGinx14os36YHZHtaCbUyuwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252782; c=relaxed/simple;
	bh=wo1uoSKcAfYycb95U7W59yKIhWzIPZ1x10kTnHmt6xs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JZjzGsnF6MPfgSDRFslJcecAY9Gx9u8nfG7+oHAipwvQh37qZwVSsT06ZfhhG3ru/OQEhwNVSgcPuNC7l13ryKMBXlSOa0JV0FI+uLAU7Sg7ph6njk5z8SQTpvFle3ghcEG9Ee9fwxJISsq52/Gk8zmJivjkL5uqTqoXDRWlmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkPW4V2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkPW4V2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16ED1F000E9;
	Tue,  1 Sep 2026 08:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252780;
	bh=wo1uoSKcAfYycb95U7W59yKIhWzIPZ1x10kTnHmt6xs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hkPW4V2Bhpnval62c+/s61M7a7pVQq4gmqgOh7cwLCWNn4Tt49tkaQqhYXEhnrzWt
	 qm+tsL9ldNlCE3J2ocO6AXg68TAIMPrfjLxlEr4G5V+4yfNfYvGy3JzudsbzV2u4gd
	 +wlrWTb6cNgzfAmuL2rc/GxareQuH65z8rtlyy+kyHmeYkXXdCM2n3gwIT58Zb0zBr
	 QM5YdQqgz/3koxHLD15u3pPQ5KMf8jTsJKpiFbONFNR8aDC3OWHBaiFMhcOjvUN4W1
	 H9tkpxJn3+Rj4DLxLIXfG5L/fFzknPzHDrhcQzv8i7q1EwfTPA2S+zSunzwYyAsC5f
	 uk1t6Ti/gjOow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: arm: qcom: document Radxa Dragon Q8B
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260901-q8b-dts-v1-4-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-4-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:52:59 +0000
Message-Id: <20260901085259.E16ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> SC8280XP platform.
>=20
> Document its radxa,dragon-q8b compatible.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-q8b-dts-v1=
-0-7de0b6a73d08@radxa.com?part=3D4

