Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7BF3BFADE;
	Thu,  8 Oct 2026 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439604; cv=none; b=VCtORcOCC20K+2JnHzcvm2cYaA4veV9d3iLEoMERqoRNhtiyNP5wa7SSK6JYC3sWjDAT9Xisu7Ewju0zYDyJzgAsVhL2T4ZDOd87Txj9mbLKQBk4cI5m83FgmCtPF946HT4FEHdCf4oDDvftvKvrAuXCD2OcmULwo8fB3YBX2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439604; c=relaxed/simple;
	bh=5jknAUUz/+aDjYhT4Qu8cyB/tB+8Tcb8g76bc61h3Co=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JVbQJUj4QsqDA6Hh62OjybG9zeM1bUjpAfLY0ItY1ABfswJ2amWUmJlYagjfAerRrvOjudXVW/avr5wM1lm0VU/Y/AEyQ620aTuoSY6+P2t3fW1hWH2Jr0RfWLgClv17UioifW6vtxfsU5JDbjDFK/9IT2Gl2JD/gdcUsvQEU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF/xSohw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF/xSohw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8F91F000FF;
	Thu,  8 Oct 2026 06:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439603;
	bh=5jknAUUz/+aDjYhT4Qu8cyB/tB+8Tcb8g76bc61h3Co=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YF/xSohwnTv/3rYn9MOQLPyPBn3sgM9TILV6AIoco6oW0YSGGHeOTvHdV9QgeUqMc
	 9MzRwBlzPCFPQdW96voYgRFtJ7trA+xUQd6p3UXLtBi/1HaC77RluU2PXaGWUHzY02
	 UmTfLkniHN69MCAFWWVKgSwScsxQ6AEFHoqu30y7u9O/MG8ShqfFLaqV5Unttt6tFD
	 CIZzxn3VKsG5LaTpikWQea6RoWsKhrQ9MMKCHaXL36DQPZBGiwVXwonaiZ5bFjx9uk
	 WSRsbRxI2bXxnBDlx275uNyk4u7A4ATiDLfIWx8nZES6+08aPKh4og2nXwEFGIt6Nu
	 sPOxS/wava6gQ==
Message-ID: <sashiko-outbox-163651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/16] KVM: Remove unused file_is_kvm
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-7-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-7-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:06:42 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Steffen Eiden <seiden@linux.ibm.com>
>=20
> Remove the now unused file_is_kvm function.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D6

