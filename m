Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5C375F65;
	Mon,  5 Oct 2026 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238913; cv=none; b=ofwA3EiYJSBU9KYuwhSHvdZEKajEm5VOZjd0DrPaiWBd/MoZPj29szUrGdnN2yYB90NQ4IZAvOQy7Ezg2Y6yRWpkGsnK/qcOjOpUzJk+Lna6R1LGcly9NyPTpFkmlmqR1fI3FwsWS70HymGD2OIA8cztQkBPVDHEu+VHbH2WQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238913; c=relaxed/simple;
	bh=EEAP5xIM9eAgC8Dtzfa0IWh74VGqveuvZ9DJ2QjMub4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=l2I8raxC8QUNdrBjD9FiA5QPqdZR3ipuyjniZAnZA7cyCXNwFE6sU90USpvyLrtRXnQabF7hpAZL1cE74UvdvwWQMBs0EftcBVIsEQjQhAkSUZ5bk/LZZKgRXhV8Pkc/OVPpouqtjfxtmEuKKNaAuG4RuZzYwv7kAVb7T/aWslM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bojanowski.me; spf=pass smtp.mailfrom=bojanowski.me; dkim=pass (2048-bit key) header.d=bojanowski.me header.i=@bojanowski.me header.b=WzxsUFCx; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bojanowski.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bojanowski.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bojanowski.me header.i=@bojanowski.me header.b="WzxsUFCx"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hzDPv5hzHzKp1y;
	Tue, 06 Oct 2026 00:21:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bojanowski.me;
	s=MBO0001; t=1791238899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZyWaEt+MH9XzVtchopePvqBx/e5d+uLxhFpBKF5Rro=;
	b=WzxsUFCx7fljUja24xgSgRQo498gsXAqUVsyETK4UY+MvVzd8PjUE9SE/c7D0fFEQQRKIj
	iKRflCph6A5uYUMw08hYcSzWfql2xfda7Tzka13AffnA++WHRB+YiXo6faiulPu3pwGhDk
	tQfdFnpb/OIqwfnQnKruqX87EYiw1lazncSxE5I65HTocN0miYyEEfl0X0EacnWe7Tgdqy
	Po9P3y+LmevdoR0WBth5TUDMaLNd1haIKKQlPjHATbu67N2XdJKOLgyaP4W1hEhjLK9RCV
	7ucsSNp8HA7MehCyUJxzd+xEU6mmbivlts/R7taBC2pcBsbJwAM/Lsz45zAbLg==
Date: Tue, 6 Oct 2026 00:21:37 +0200 (CEST)
From: Tomasz Bojanowski <tomasz@bojanowski.me>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andreas Wild <andiwild@gmail.com>, linux-kernel@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>
Message-ID: <1140966133.1231391.1791238897910@app.mailbox.org>
In-Reply-To: <22e0563e-afcd-44f5-9d87-f0b2a637038e@leemhuis.info>
References: <20260923191357.7410-1-tomasz@bojanowski.me>
 <22e0563e-afcd-44f5-9d87-f0b2a637038e@leemhuis.info>
Subject: Re: PCI: failed link retraining quirk costs 1 s per empty AMD
 Promontory 21 port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal


> 04.10.2026 17:29 CEST Thorsten Leemhuis <regressions@leemhuis.info> napis=
a=C5=82(a):
> Hmm, nobody replied afaics (or did I miss something), so it seems nobody
> has an idea what's wrong here. So I guess you need to perform a git
> bisection.

Thanks for following up.  You did not miss anything, there were no
replies so far.

I am not sure a bisection is possible though: I do not know of any
kernel where this does not happen.  I see the same 2 s delay on 7.1.x
(openSUSE) and on 7.2.x (Fedora), and I believe it was already there
on 6.19 and 7.0 as well, so I did not mean to report it as a
regression, sorry if the report read that way.  As far as I can tell
the quirk simply behaves as written: LBMS is set on a port with no
link, so the "broken device" branch is taken and the retrain times out.

I would be grateful for a hint from the PCI folks on whether this is
expected on empty ports.

Thanks,
Tomasz
