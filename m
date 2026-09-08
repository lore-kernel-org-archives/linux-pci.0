Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E449EC69;
	Tue,  8 Sep 2026 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876760; cv=none; b=AsgUUxC6DZ00V/6dl7GtemoZgh8x/+7h6OZjGYWWFAfsAhznawjtY7utCI5YvxYCvG6ltgFD3CEBz03wZsje1vnbEapy0XvHRJwl6PDqzNeyq6k1hNZJadMdk+yUNKqFamgENd3RUfiIkwoUN/w4ov3GSqFhl2+yjqou36bE7zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876760; c=relaxed/simple;
	bh=WriDk3HFiYQfvtTkK6ixVRs4uva/F/qQG/gneTpxheg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HSNHSRTebsVbxJknNOawoALF+FmXg03mH2tbkoTBUOlTTWAPXFgCYGWA9OuOe2Fxk9XdXEzb6r9Jk8hdvzGjctnakg1un1qU7PqW4uWUYZFqN3DDfgCzohm8Nsd+aq4W99EM2tR4OsvSa6tTiCAI7FRbX6xnEj9jErbHNUIcBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkShfHKk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkShfHKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A266E1F00A3D;
	Tue,  8 Sep 2026 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876748;
	bh=WriDk3HFiYQfvtTkK6ixVRs4uva/F/qQG/gneTpxheg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mkShfHKkk9nnO6KonAubmDIDXALkTyIPL2ZeeXsIK2wiqFOGj2pLuHs74V2XGvkU9
	 QhEGSLvYHfnjuWStPrfTZiYVVVpNwhXGhhXTBYgky/jd34D9psEPtKoJC2FnWIH3a+
	 Nj9EOBzdXbr7H+hlQ0U3dOp9X21QZoZMmxM+PR57zmjcO7eGcOkdXY2KxDhVbNu/wQ
	 X2CDrJ7MrhSZHGL+NBk3xeZi+LrZjQfdy3GgStCwwxACkIqBAK9V2IpSjg14H+eeTV
	 L6zTfPskzzRVgODRknLUFqhV5SxXUQDxcyMMjT3JOm4WCUD8dnaMDZAIHusg6Z2zY5
	 dID7rRv50RamA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/8] perf hisi-ptt: Complete the field names for 4DW
 and 8DW packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260908140509.2485649-3-liusizhe5@huawei.com>
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
 <20260908140509.2485649-3-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:12:28 +0000
Message-Id: <20260908141228.A266E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the missing HISI_PTT_4DW_HEAD0 entry to the 4DW field name table
> and add the HISI_PTT_8DW_CHK_AND_RSV0/HISI_PTT_8DW_RSV1 entries to
> the 8DW field name table so that all DW indices have corresponding
> names.
>=20
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908140509.2485=
649-1-liusizhe5@huawei.com?part=3D2

