Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254B2F8EB8
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713949; cv=none; b=WfbQ9V23T5MR+umGcm7NgaSGa5YdZ1cf2404koi59WdpA1azh19LDkC2KH811R5ilCK6FrO/kZthjUTna0Q4eR3vbmLkRXfcufZLruSSwmuYElQfNp5JsqNkg+4b10HfTuaOFBJQ3QgIIikr3UzyD8InN13K7lZdlP00IP/KVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713949; c=relaxed/simple;
	bh=p1nsehjeONjKHr5tLIil4Ha/GDrv0z813t2obfhEBZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MUTSr6VSG/zRs3yVFfs8qRPVaMbY/aRo6C5CSf0UkDc7YZ6RRjDjxhz3Cx5a2I4jMAOObPYVQFPLhMCjnyj23B9an1g2l1fSspb4Ax+eS8yr2JwG3+D/PwVJOpDYVKTbwBzFLk2D/GoALFVERfa5Lfj/LDXFsB60jYSK3uJ89vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308801F000E9;
	Mon, 29 Jun 2026 06:19:08 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/32] x86/pci: Stop using 32-bit MSR interfaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260629060526.3638272-12-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-12-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:19:07 +0000
Message-Id: <20260629061908.308801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The 32-bit MSR interface rdmsr_safe()is planned to be removed. Use the
> related 64-bit variant instead.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629060526.3638=
272-1-jgross@suse.com?part=3D11

