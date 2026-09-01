Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E452361969
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223083; cv=none; b=dNbO4rQjsligmiYWeTSckUuaDLZxfvdCzCuTNsPIflycQNntlZDYyUo4ylOlv6bDHRXE6aOQvYAX14Tf60iZpcbsXNEl+q8N7mHnsB6b6s8jYh17mblbeUzkpUvYkrWgPZ07T+65R2aU2UkYz+v68B96j8UISPnV2cKZ+Ott7EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223083; c=relaxed/simple;
	bh=yEwy/p3tp9SCWSY+g7h+XrpdzeDG4iEmCjgit2SlkVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LdWq/pQiWuBjLix3PKu1AdMielauRNOtXQ9N2Z3KvI+dgt0cMzHWcLIv4wZ/GX9P95kkkbDiecO+7ZNbTg6KATBP6sQIlBZyiny2M6LgyD7+TZIQBUfJ5lkPzfxWJlkmG9fyjycbk2FZ1zkrCy2rbbeMYDFe7dNijmNxV85f9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4vL51GC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4vL51GC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA361F000E9;
	Tue,  1 Sep 2026 00:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223081;
	bh=yEwy/p3tp9SCWSY+g7h+XrpdzeDG4iEmCjgit2SlkVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4vL51GCVtK+7w78bv95eAyL8BDEKDgeVC0aMmcMt/CCh/qho8oUic8hQPWmF9DLC
	 iOq4v0nyG2897wZV3we+USVJuLCrtwa1N2aHFUet7yqoCmEAZIP84/+1op+PKmBc7p
	 H11ZkkPEenZ98t+O8wxmASY2PXVSSFkYu3LPTbscDckQ7Le/4gHT00uCIXj//rKGXk
	 gUJGJtBp6P07kDH6Ld7M3uNFgxC7z4iYqO2UwbTZtnkFwTu1HQUKCSviZ75mMcCrFb
	 F4Oq1ZAYJeo8QBbMg23hd7JxyQ2S33jaM+Z7ORrKSqUt1345RmqPzRLk9jfnwMEWam
	 a5UqwGONhT8kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/13] iommu/arm-smmu-v3: Add Q_POS() macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <4aede16c4e2b68b280793a927fe32b6bd8ef457a.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <4aede16c4e2b68b280793a927fe32b6bd8ef457a.1788222485.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:38:01 +0000
Message-Id: <20260901003801.BAA361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A queue position, the wrap bit combined with the index, is Q_WRP | Q_IDX.
> It is a (max_n_shift + 1)-bit value that wraps at twice the queue capacit=
y.
> queue_inc_cons(), queue_sync_cons_ovf(), and queue_inc_prod_n() currently
> compute such positions by open-coding the two macros at each call site.
>=20
> Add a Q_POS() macro and switch the open-coded sites to it.
>=20
> A subsequent change will apply Q_POS() to a position difference, to count
> the entries that a queue pointer moved past.
>=20
> No functional change intended.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D2

