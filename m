Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51F212548;
	Mon, 29 Jun 2026 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740406; cv=none; b=INjddQVyGOD3o/96mYgtCUYJQlK4ODBrNsk6O8HdQpxfXtOCBhZs4IPL4CTYGRU19HV7hQxsip+Qdxbl0go7fYopG3uWJaKZ5wsUSk5RNdn4MUF9Yckfxwx1rZ2yBc1I7Ev1rox4qegqnRKlvvrxh/3RBkkESEDzCYme7Te2o40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740406; c=relaxed/simple;
	bh=fFjOPI8ZqObFtENNlaUIXchv2hz4+4uJo1E55LwoHJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eVnhN3aP1Z4joL524iwrYIuldB2/qA4SC005w6imkMUZRkc16F6x8iCo4pCPv6ZJCuDbUu5Luxw1idJpsl/QZySW6EmzupYlh9vQff6JtgbFuowTFpe1wr9YfEemYoqv/+Qo92bK6ii0rxW0Ng2IQQP/I3Yz/X5e1nfR5SY/SE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZY5ucqz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZY5ucqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368DD1F000E9;
	Mon, 29 Jun 2026 13:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782740405;
	bh=fFjOPI8ZqObFtENNlaUIXchv2hz4+4uJo1E55LwoHJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PZY5ucqz1Szy7k/AoZwZtHbiBKuwHvCu97trQAdro4VhxHI3HzO88KKmCO+TzGXny
	 SdK3/71peonEpsiAIviDXbRb3lsBUbCXTGHJopinT0ZgARogioalTW0sRUuNmut58o
	 kbkbbE1QR6RIF4LBa5HMMGx5ImrptCAczhaPb0qQdcnHfHninYDMKehLvAn7O7TeCp
	 PlExs6n7iyDJXgSULn+DCz8w+hqGM733L3m4jAul4GIFi/p8/NvgiJXzgWGfs1szGk
	 UCzpKH8RLEmtG1Rok4azgnfrSZ/wHCK9e4V0IOP3Agu/rNNAUijyTXhgKJlUuW9Cav
	 SpNNAD6jCCt4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 2/3] rust: leds: add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260629-rust_leds-v21-2-4f0f19579db5@posteo.de>
References: <20260629-rust_leds-v21-0-4f0f19579db5@posteo.de>
 <20260629-rust_leds-v21-2-4f0f19579db5@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 13:40:03 +0000
Message-Id: <20260629134004.368DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the `led::Mode` trait to allow for other types of led class devices
> in `led::LedOps`.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-rust_leds-=
v21-0-4f0f19579db5@posteo.de?part=3D2

