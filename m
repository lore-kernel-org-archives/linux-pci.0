Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821233FE33
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627747; cv=none; b=VDMlpejtqyORTW6GxI1z3YdIRFUmXwcd4QzP+arxXPi5Ia0YR/Y3aoMvBX6hsBWVPz6e5ncrhcmARBs6/kDPmi2sKazDV2Exvyq3OYuU4CDGiJNxScE86ZfVepKvFCDkpTh23bhE/Jd8OJhUSw5d8Fbk8Vlhf1UTS4lC6LNNZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627747; c=relaxed/simple;
	bh=fe27YnHrn417xMLn/wfXD1zsk02Hdmb8eOJLW9TJtTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DPcAVAsCEdeE/gSs5uOvmWnrYMssX2K4GMdXPTxKVGPxVOU3bUuCN3hfzBFDLzIeZQAWQWj030le2JW3alrTUDJ+K8lOsCUlvZrLSX1odJ4w/fqvNAlKDKoOsC0fUtUNKTgyfEswj1Kf/vtgiiyOLIVrGdiIimeQNfADElnjaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbomGuLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbomGuLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833431F00AC4;
	Sat,  1 Aug 2026 23:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785627745;
	bh=fe27YnHrn417xMLn/wfXD1zsk02Hdmb8eOJLW9TJtTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EbomGuLVk0/K0C1qxiVeydf3wVb+gSpn6aCBlq3eP8xGpVCcvj1GmJr4Eu63RrctA
	 u/SPl3Tm2rWrIzwdPDmnIUn533u00c5OKQ50eOZAwcr1enyk+j1KZAgvfgW8YEEf2E
	 nbCmiSR9LDyA6dLrFtPTSYgRjJ9bUDYXu+DR9cdYB4LijYmqQesSMtd3tmrYtEPG1X
	 R7uZEixm4n8ZS1ii4oMqv7Xgr1A4lzWI9iZ5LFkaI1jzSCd8/RtnzBbUZshxIroi2I
	 Si+bmi0TVWd8K2BxFGrUegZSvXjTHWb40Z2woBTAF3klxB6/y9VdsAAJMf+B0MKkGD
	 f+LvCegplvPcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: rcar: Release temporary device tree node
 reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260801233841.469826-1-dbgh9129@gmail.com>
References: <20260801233841.469826-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 23:42:25 +0000
Message-Id: <20260801234225.833431F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> of_find_matching_node() returns a referenced node even when it is used
> only as a boolean test. Keep the result in a scoped cleanup variable
> so the reference is released after the match check.
>=20
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort ho=
ok")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801233841.4698=
26-1-dbgh9129@gmail.com?part=3D1

