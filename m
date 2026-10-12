Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8773448F000;
	Mon, 12 Oct 2026 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815808; cv=none; b=hq0vZOd34l51W6IF5qadR9TW7FPksaQ/ragi/yhmGYc8wW3JRtOiFaTWe/reSCGbPo1m2u7wha2erpY4STK85b1WwC2x8pOQUUEP8xMiqJ2ReqM9nQyH5QM1xMAiB/TxUdDJGXiXD6V6X9eR2vg7qKi+zJsC3VpO85xt/rJmo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815808; c=relaxed/simple;
	bh=wmCe46iuialLFiW0sDIukMyWJTCi14saYMA7H+ONvUU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tF6+E/OWFfvAROhZ+eR4f7W9D4/kA/3BDrwZ6l0bXk9wM/FutTMbqKOB0psTFr959jOasEDUZSmJeIU3Eu8NgCN6I8HXfVp9M6XtAL+FdSKKRnmjMWP002SA6aNSCXIjB3i9MnRhP/6EJX/8h6Vl65XgRjsMoDvsV4is31CbSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbcCHgym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbcCHgym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73371F0089B;
	Mon, 12 Oct 2026 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815807;
	bh=wmCe46iuialLFiW0sDIukMyWJTCi14saYMA7H+ONvUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cbcCHgym4RfrogAwms9sTYUiwvDRtKxdMf+dLxXDWWvmbwj8RrGiprO+Hq/hTaQnR
	 evN78v2Y9pCtTqLVD2DZBpD6FagbE6shM1hdoqyGrhmtGbCb/BjGKtbrlly2eXMEFL
	 wwQgQmTZe4R1YZ25SM8eCRXMOY9g2tU9IYbS0TNXK1Byc037UdRZbVwsvXjFJTVoWu
	 ANUc9C09NN+XDuK19LNeX7q4O8ojyKvja/j1RST/fTzUQy/csVH9Gweyn76jNCZyed
	 gd5ylWtqxyxmXIJ42EirsaI3p/Je3TMSpHNjXrtBRjx8hqxg/TlLnqi7I9vP9mYROF
	 j+ZR7+E/fY/lg==
Message-ID: <sashiko-outbox-168272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 06/10] PCI: of: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261012142826.159178-7-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
 <20261012142826.159178-7-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:36:46 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode.dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012142826.1591=
78-1-herve.codina@bootlin.com?part=3D6

