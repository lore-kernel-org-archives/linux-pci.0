Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414612F260C
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089017; cv=none; b=XAUyoVVl3S/5hMQZEs3njTzV/8EN5vy8sOGxmYZLJcVMGA6dyDz5OoHYnlXsMbrblf2tZFuCZhXbu10nSRLPJbNuolB27v7YqT1ye9ZHM0pIfyJCYoRVRu4U4xzFCa17Ij32BMQ+puNmdEIO0jhaxMtmsX8J0zOyCosih2VnvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089017; c=relaxed/simple;
	bh=/8llM4jB6PI9dW8w0Syl6zB/v3MkF2XW7fc23VnS9Hc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/6TwjJOTL57KO4QQEtOdxZ6xTceqlsN6n64Uq2+e5PKopC8GOWomoYEzQaeEGEu6RPJz0nkJtmp4knnAoJInawNj3s388Z9xByL+yyuQtFIOBDp3XJMo6voa9jwCGmQXNxM6dSVw2DheUlTmJSpGzo5bmeSa4unxnb5yFYVR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPlsbJdp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPlsbJdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D181F00893;
	Tue, 22 Sep 2026 14:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089015;
	bh=/8llM4jB6PI9dW8w0Syl6zB/v3MkF2XW7fc23VnS9Hc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fPlsbJdpU4J+j6H971WBaZEwSHbTRS3AAP5PZQLySq3f4cyGkEbkWXJQqJkTr4Ei9
	 qidgorHtjqp5G4PuSPB/Z7xIg3VFg7j53rzTjAMWcMfQPdH2OoC6xR/3vqL8vI1Kvh
	 sgJDlTgAMDQnqH6FWV9VwkqqK1TA9e5mznbEMbhkxt2Vwut91n1CNCWqY/nZ7STMMe
	 hfT0gJVkMsgzfZIPFTWbR/wW4wbZBBsT0rjBeLZ0flEP4j7DvNpFQVh5h1+6pQdOAS
	 cmXgMs/lGRctgoiT7s7ICqirr9bH0/x0OvbcXIGLe0/0Fj/Pw99uIL6n8GeRu8C/kS
	 S66wNoyzfdXJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/8] PCI: rzg3s-host: Move host configuration code
 together
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260922144629.586997-5-claudiu.beznea@kernel.org>
References: <20260922144629.586997-1-claudiu.beznea@kernel.org>
 <20260922144629.586997-5-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 14:56:55 +0000
Message-Id: <20260922145655.A5D181F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Move host configuration code together to have it grouped. This prepares f=
or
> the addition of hotplug support.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922144629.5869=
97-1-claudiu.beznea@kernel.org?part=3D4

