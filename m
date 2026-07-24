Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A723515F0
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911988; cv=none; b=Oevv0F6G9txqcXJxny1e8sXk62KkXGxSJytSqsFCY6B02EaMluSRkPmYHWNupFmKlKw0nX6Tf9xQChgj47qCdIdGbULQXkw6LQzBlncoCIqpYhUVYADBtzXGBOVTW/LOsDlhD6OBDiSXIXZbj0jq8v1voh+9Dn/Iufn/vlnhRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911988; c=relaxed/simple;
	bh=kq1rbquw3Xw8yN+pCQh5CpRArgpbMdLw0KwTgKW3YAk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XYfmmnymXQSxngrstSijkxw0r/dVHPahk5DI/PBRE/MpN6wojZE5amyRfsFm9X5zEXa8YvGe3JccAOoeh7RvrCN3FXVVxLbl2NPCv1atkrDJopHVeNi9yK779ABaKWC+1f0Sfyyie2ByZuUNK9+HIjEr4q18+0Iq5b7TCFP1N3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBQpEh5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBQpEh5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BDA1F000E9;
	Fri, 24 Jul 2026 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784911987;
	bh=kq1rbquw3Xw8yN+pCQh5CpRArgpbMdLw0KwTgKW3YAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HBQpEh5M7AnTzvTXkda3b+zYMc5FX33cFe7Vi9SnEnBGCEp4wS94PtdPe4YY4JBl8
	 185lcYZGmQZewlbcoPOyWF3YgdvsXjELpGrufVOkqWmWn3Udz+fJa3g/avBIoui4uz
	 tUIczUsRBLrgzwDpjJSpbyqK3F5KxNt5KzPEpPmlT+Fu97kDxiq7lGQTg0BZVHAb5B
	 1+gHvKBkNLekvr5L+ABmWhp6ozkIrWTNFaqZgWzuOKD5IXfs7Z9tOX838d35OLTYhQ
	 dvEazQvcuTRnNtOwhsQoZCcPt/79IqwrMK8rt3c0jz1mBgvQ43al976dDkpCm03ZEU
	 EeppYw7eZt/Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] treewide: Add a flag to detect the Apple T2 chip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260724164641.2239-2-atharvatiwarilinuxdev@gmail.com>
References: <20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com>
 <20260724164641.2239-2-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 16:53:06 +0000
Message-Id: <20260724165306.E7BDA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a flag to detect Apple T2 chips on Intel Macs.
> Cache the result to avoid repeated checks. That will
> be used in upcoming patches.
>=20
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724164641.2239=
-1-atharvatiwarilinuxdev@gmail.com?part=3D1

