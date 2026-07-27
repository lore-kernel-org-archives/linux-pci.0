Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685B42A7BA
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187752; cv=none; b=ZRyGAne6Yca8Yzby8fXO76HrnFTyB+izOaYAnny8tMEt7Lergyxp/NKlSXEY7uOEzD0SQnw3SafRVOYEbHz7cHmtmVynFBUxwlcYicqfwRalJFj7FMEIR+4aMZ78uc+9TdHBKbvvV/DS+kRKdcn2lLZUdqLZpDauOn0VdNfnmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187752; c=relaxed/simple;
	bh=SeO6SktvpG0zThJUElg7tr1ARkZWyqBixms4kfdrVFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rtvqCqdTaEWteBomHYfU+DY55wDPsWOJjxFRR6uLurJOP1caOK9AUXTGtja8oDxiSJCHWgykulSDsI7MImlhcff7qxwTkYMP2Rc8RqIRWM/4sElGN8OHJWgBMgjj8fVawGAGwBDqH2oGlY10ZzzQBIK/KXU5VtzMUalKR7j8+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZvB4z0R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZvB4z0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A7A1F000E9;
	Mon, 27 Jul 2026 21:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785187751;
	bh=SeO6SktvpG0zThJUElg7tr1ARkZWyqBixms4kfdrVFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XZvB4z0RTuWBXEVskEdY/8nydpv6hGDImeYmAuutBevgG30nWB9mCIMZ82aGU+34F
	 OET/k5iM4G6pFMSu0SMAnqS0Z6BovnJsE/jzUV1puHI6J/poEW6aOViRXd4wYMHl/i
	 BxIOJ3/scr/zw6ygQuwh2lZNb0r3hvuSpLYEG8lMqxTtpN2+qQ+ohb54unB0O4m88E
	 3FsDK93t3WNr0f2mT5Kz5EPQzhcmN5WsBRJQ/L5nERfWP57HedWgEG5asAUPQVhIb4
	 yZ5x+HRb2eBaqImfIr4GxNKQ0cFCFzdtFoVmv4t2Gg3ksK4AAyasPM4OUTEjyJWsFG
	 siV3rfxUPGeDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] treewide: Add a flag to detect the Apple T2 chip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727211807.1223-2-atharvatiwarilinuxdev@gmail.com>
References: <20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com>
 <20260727211807.1223-2-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 21:29:10 +0000
Message-Id: <20260727212910.E0A7A1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727211807.1223=
-1-atharvatiwarilinuxdev@gmail.com?part=3D1

