Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898B35C6A1;
	Fri, 25 Sep 2026 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368485; cv=none; b=hLpFu7x6N+N6QAg3fqqDFbchmv/ukk5s5BNS4cvD5fW4Y0Jn5c/mfSW0VogCBKJ5wivK8UHREEovHMQq7Us+YjTlVTjnIuyQHklL33PD5pHM7BDG+P+SYPY7DZMk/iMn3sFBF3XpH5eD+fJkE8TYiUkigpbbqQM+gI3iKCsoZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368485; c=relaxed/simple;
	bh=WYiuMMjLovLhU3Hj/VOFiGqTDfTCwAOu9ZWB0icmr6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o8L+NKt6KF6Vdg2HyoubTweSI5Q7rl1HKrLZX9k38JJqqJ0B6SqSG7nnPxLvv2mTrFyu5nI4TbbkbZ+R4eSM5fDyV0MDglUx/x8pu8LSrbZy3IX/9k3CQz6Hq2Hd4XPKNjnnq6IicSknuxRB9QF/eulh+3tcPGqMQGCs0Pk1Z/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khzXK7Vs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khzXK7Vs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD531F000FF;
	Fri, 25 Sep 2026 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790368484;
	bh=w0onJXNSIgY98uXNzZQPLWbggu/WEBLWRclFYyx8ZFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=khzXK7VsSpDcRVV+B275YWouLvZGr8iFkJ0Qm9+7Vd6eOqnoegBTwUCXCTMCR7W66
	 qKMG0GbVk7DnqSQ51g2ubRSjFrBoibQoCmtqoY+V3m6nASTdTGchiByBEE1vM2OKz4
	 h+BtiLu4xnYWbtt3nCvNanKzuJzVT/jK1MplEF7laWiTHYGyb8nN4FEQ3h1BKvP3pD
	 9lP9VY+uW2icNip+g/fcqhjSJ7dbTnE/tDj+1uHD444wVJV2v7vs2nhpA1g3RSV9e7
	 htUlqedbGDJLJoANFu9Z1lgNfztYV21zvUxA0ZlOvbvJI1z/Cu1z2Z+Fv6f09WFb3G
	 Gn5PPbDbADcNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: rcar-gen4-pci-host: Fix
 reset-names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260925203039.110653-1-marek.vasut+renesas@mailbox.org>
References: <20260925203039.110653-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:34:42 +0000
Message-Id: <20260925203443.2FD531F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Drop maxItems: from reset-names, since the entry already contains items: .
> Fixes the following warning detected by DT checker:
> "
> Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml: properties=
:reset-names: {'minItems': 1, 'maxItems': 2, 'items': [{'const': 'pwr'}, {'=
const': 'core'}]} should not be valid under {'required': ['maxItems']}
>         hint: "maxItems" is not needed with an "items" list
>         from schema $id: http://devicetree.org/meta-schemas/items.yaml
> "
>=20
> Fixes: 50b1333e0c7b ("dt-bindings: PCI: rcar-gen4-pci-host: Document Appl=
ication/Local register reset")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925203039.1106=
53-1-marek.vasut+renesas@mailbox.org?part=3D1

