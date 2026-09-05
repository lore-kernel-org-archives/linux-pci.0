Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E982744F;
	Sat,  5 Sep 2026 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788617019; cv=none; b=Y8h4UGJMQExicMDRJElNBja+2CHNwES4PZgTQtW+3onxsRrBoTY5wrh+sa69UcAttttVXH+Uj3ss8JCkhFtUwTChUF+nrJ44G6sfdr2grdtZthok3KVlOD375TntXZ+AO2bPCo5hrdLohU8ptsz9jXJEBZ6bTQWBIpdO6wv1Zcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788617019; c=relaxed/simple;
	bh=m4GxGwq5lPDzOp+HaGdv90D6Q/yw+N1aaMReElQGNmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jHGw86heEwi5lSr7qbvgxXoEfC7sxXVMc5Wsd4yzrm6RUUueK2Qmgjtt8Imr9aD43yTnZmhwKaFJbSBfVJiwG+c4nYsqdB2B/eseH59sSOKTqFdxGkeE2ARdNO/ofYURuQUtS7e/lS3xW8Ss1CPVZWAa3yInb6FCfoscdJkBlNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvYlOdce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvYlOdce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2890D1F00A3D;
	Sat,  5 Sep 2026 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788617018;
	bh=m4GxGwq5lPDzOp+HaGdv90D6Q/yw+N1aaMReElQGNmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nvYlOdce9zwScUqwjxS3b2NC2Kn/s6kxcgnwrkOxjlQhfC+PVLUtZcc8llkimNFnG
	 WxAboNzIl9KFs4gCHPIn64IPQ0pwk3/u/pi0eHYD2EIrWm5oH5dQUP5zGtG+uO0M0y
	 6B+HoCsjQfQ95/4QDmsGEpJlMOLqBW8LfF2Kd3KRObavkpZuyHDcTra9rpYkwXQwfp
	 +AMvk1UDe4T/Xlr++58RPMDwnOEksQ8CfcAHUKfgtRWSL1NuisqSMQbHDw+d6qBYpf
	 LJTrPMxZQWyYioRWxCcc90u/j1+/HRwFjTTQ0yPURxbHFpM8qdXZ15R8XrN200xQxK
	 29RmQ/+AkPDdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/3] interconnect: mediatek: fix Makefile typo for
 mt8196
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, media-ci@linuxtv.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260905140113.21638-1-breno3011alves@gmail.com>
References: <20260905140113.21638-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 14:03:37 +0000
Message-Id: <20260905140338.2890D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Correct a copy-paste typo in the MediaTek interconnect Makefile that
> mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.
>=20
> Assisted-by: OpenCode AI
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905140113.2163=
8-1-breno3011alves@gmail.com?part=3D1

