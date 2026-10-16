Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6B375F82
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136897; cv=none; b=l9ZZEzo1Ck5AE1OYjiHPsHTHvk5doZkkV+DM9nDxasMf0iwL3k6nXJnhjkg+dEDk2sfbJ8xBv1zbod7tii1tEKMIfooavKQegMhvNZgTbn2yHGmVE1/W8PJx58vk5Q/kCAXhTaQ5jbauGY+omcQJ7gS55Kjof5XHTBk/KiYkQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136897; c=relaxed/simple;
	bh=4fnz67drrNXIE/av+v7fe/nflJrZkuMxWeJ8PEzL8v8=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=gYKphsIzolxL+UfTlE5iY579yJt6x7USdckTU79va4kr5wvv8sjz5s2dFfeub7R5udh8Yb2DfEs+cI5nQkQ98Y4nd/RvfOI8JZKaRQmkkvNfY/dY0z+bs7tbR4ovQqNBklQ4VC+Hx01gq1D/pwGRlGp8eOcu2IRdr4ywYVnCExE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3VAqLM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3VAqLM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5891F000C4;
	Fri, 16 Oct 2026 07:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792136893;
	bh=4fnz67drrNXIE/av+v7fe/nflJrZkuMxWeJ8PEzL8v8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=D3VAqLM8vleJsqH8qpOx4KU4N8WUSs3thNFnvCFUvkLUr3/n6oKL0m1bREMvsZzNW
	 3zmgHvUkSwKXz4VIAEybBKzcSFG8cGrxFl0/Bjg6yQ2cfjUgMrdr1yKC5wGHRSWB0z
	 58khfUko2a11522IK5/OXKNn36dPURAJ+M61hgJwyMw7dSJ5v+w9HVSKhubdQaKbR+
	 6kLCCv8GHSYrJI8dgWwEMAZQNTFoXudNlY/96qBJIH+eBlgnOh0QMUDufJBVVL+abE
	 C9Pa7KuS2dTO5QMXrZzxDHEkbx8/6ltbY53p/+gY2cFTB8nfL7Q6HbsYfzgjwLlOeQ
	 s/2qjJPf5y6eg==
Message-ID: <sashiko-outbox-173963@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] PCI: dwc: Drop unused shift macros
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261016074026.564302-4-mmaddireddy@nvidia.com>
References: <20261016074026.564302-1-mmaddireddy@nvidia.com>
 <20261016074026.564302-4-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:48:13 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Tegra no longer uses the DesignWare field shift macros after
> converting the call sites to FIELD_PREP() and FIELD_MODIFY().
>=20
> Remove the unused shift macros and the old narrow event-selector mask.
> Add the complete event-selector field with the standard mask name, and
> keep a temporary alias so existing users keep building until they are
> converted.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016074026.5643=
02-1-mmaddireddy@nvidia.com?part=3D3

