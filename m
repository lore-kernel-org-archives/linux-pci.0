Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E033CB2D2
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744057; cv=none; b=WzFCBnXj8gouIi9QJCZiCo6RROgKEDFl3sL4V2/FeyhXp0PNr1xB1aWs2vzmgbeWt7N7PoBpf42bZ+wMP4HZVKs+pkRSBkNuEMYAW32LpH5n3g0/EiiFVB+3hbG+615rYwqN404HNOUVg8uigtveFDTwjDBILmjiykuRhdUiUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744057; c=relaxed/simple;
	bh=3ekeGXIFl7M+CPoXt8VwCBoD2GZbOk3AA//04TC7Z5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOnXhrv6+fq23dsAQcFdQum52pvVuiILtrBCAZee9nSoOSF8sGV0oMaG36btwlbbWIXjJOqD/dDk6GQk+wft8AeIEZ35zsCDJFYYOXZClXo68f+rGwYxme2jkDLStrGuq+/wiX5mddSu1aY5IVEFmMk7EOsgrsljECQYjjMom5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLPtbwEm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLPtbwEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAA61F00899;
	Fri, 18 Sep 2026 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744056;
	bh=3ekeGXIFl7M+CPoXt8VwCBoD2GZbOk3AA//04TC7Z5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lLPtbwEmUidxlhWNHfBcjWyTQZzlGqT8mErPn50d6aIpUctj9f2TreLEtRo4W6iCx
	 kFeDOsr035i+3TSfaPELcloXD+elLEew3jI/qUxMPr6pg3rhgH32EMeAN81DuM0PKQ
	 r3fdo+rGaKvD/FQqTI6+MoFlmw7ClQI7lmhIEbEi3hzZUGwrYcBRlg2LlthK/N0BEI
	 FZMohKyScWN5Kkp6jOHdyBs4URHjic7j3LRFbqkDcS3pwTJ7YDLQsyVAj7QuScCbbX
	 usDXH7zzn/GLKYPAl5FM8bnv73NA4MOFwiRLd5BNqO7TyTWzUQgHXHn6Hl/lVRYmYz
	 +8okYjFXweEQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/10] PCI/AER: Clamp negative ratelimit burst to
 zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918145619.3016889-3-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
 <20260918145619.3016889-3-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:07:35 +0000
Message-Id: <20260918150736.4DAA61F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The correctable and nonfatal "_ratelimit_burst" attributes store
> whatever kstrtoint() parses, so a negative value lands directly in
> ratelimit_state.burst.
>=20
> ___ratelimit() reads a negative burst as an uninitialized
> ratelimit_state and splats a WARN_ONCE. A CAP_SYS_ADMIN write of "-1"
> then warns on the next AER error and suppresses every later message,
> with nothing in the attribute to show that logging is off.
>=20
> Clamp negative values to zero, as the companion interval attribute
> already does. Zero still suppresses everything, so a negative value
> keeps its old meaning without the warning.
>=20
> Document that in the ABI description of both burst attributes. Document
> it for the interval attributes too, where clamping negatives is existing
> behaviour that was never written down.
>=20
> Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smt=
p.kernel.org/
> Assisted-by: LLM
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918145619.3016=
889-1-yazen.ghannam@amd.com?part=3D2

