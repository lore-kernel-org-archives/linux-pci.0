Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677023F7888
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196118; cv=none; b=oeFUlhNRUpp11QJiQX5jf2hlPhCBCayeZxnyYaeKbvCgwhs3JM3vFXgIpEOg23jj4dINw5HNu5XNAuwJR3XMhlfOaLaKJlm9O/D3P2FziLPKUfNGbbdvy0BYtRM844Wx+b1OhkK319lym6jlaFtptWm2r4UdhKGiTl7UUZ2IFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196118; c=relaxed/simple;
	bh=oxiIaGxewR9PJGZGbYKI2oo4kVtmgmjJaOcP/TldBbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T5V1Sav7JtV//trhE/69UYOitGzQ0XCO2nOO8McZVDXuftwdZrl5r7VSfHYqDpwutOmxJt0PnZCCuIVy67V4kr4ZyqTW5/FzNtgiyqZT7LVqm3ON9CaOxlP84NvsvJnjX48QRIt+YmN1/fuWnmmYi/OUIAv2njocr8oEQWUlSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjImzUW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjImzUW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513C11F000E9;
	Mon, 27 Jul 2026 23:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196117;
	bh=oxiIaGxewR9PJGZGbYKI2oo4kVtmgmjJaOcP/TldBbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EjImzUW4Zh8xyoam6g2jxZ1TfJCFkmg5seeUAd1haQVNX7tPhgY0iptcKXGMeYfC3
	 chLTGkkFLnjb7L2ZRMgh4JFOX1THoXIMX0LFwUaZK/OBs/oTCaEEdMBd/HkBpA+qqQ
	 u6xbjnqYw8DSH8skm8iQLRkYafoW1XiijcrAEPza7MpqZsvz9UCpbNS/fbx77LgeID
	 F3sXXmGUJE8MfVDHl4QMLBcFDKz/mFIc1RoTcqxPswug+dgUMY50ZK5Yz6+uG5V05n
	 mzFLP7POOZlmqiSKuO3Te/ToXJbLqVrQOTLlkO6x5n8TOJGccKhixb8WZs02PNg9B+
	 BAJ1u3YlcGkfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] PCI: iproc: platform: use device functions instead of
 OF.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727234408.296186-1-rosenp@gmail.com>
References: <20260727234408.296186-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 23:48:35 +0000
Message-Id: <20260727234836.513C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Since this is supposed to be the higher layer file, use higher layer
> than OF to handle this. Remove OF headers as a result.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727234408.2961=
86-1-rosenp@gmail.com?part=3D1

