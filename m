Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B321C2324
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 05:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782450791; cv=none; b=INK5pMB0/7EMNteuyIZpy4nLAdX66DL0K14tyJ9xSkdSV2nSzKwWI/cOxIdQTYCP2ljR90VoKMAKHUwfFy9ui93Wgr6NCVSRgBVQspL7mx2GAk4u5G0qqYz66siDNfEbuARllCtaMh3FUFqlwE6aOmFXVOccC7DASwaW20/5esQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782450791; c=relaxed/simple;
	bh=XhuX+Rl1sriVOM+/0PnGeYDBxQUO/PZ2gIveQk13rK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmYH3OW+duOkMy2y1BQm1P76v+LNarL0oJzwF0q7EXFdpXQ+cR+A0/WpL28aaqGwaePooMXEyDH32uFI+RrpoeEe2X9gVvB0z7nP8hUPc8xJogsui4L0yWhrRpEkxXpV6mUzP4dp5/D+AuF0CxYvAdRXSWQGZU6K1ufbvHo92tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 30492383;
	Fri, 26 Jun 2026 07:12:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 116F360155B8; Fri, 26 Jun 2026 07:12:59 +0200 (CEST)
Date: Fri, 26 Jun 2026 07:12:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Paul Guder <enyalios@gmail.com>
Cc: linux-pci@vger.kernel.org, krishna.chundru@oss.qualcomm.com,
	mani@kernel.org
Subject: Re: Wireless Regression
Message-ID: <aj4KW38uFaZGlefK@wunner.de>
References: <CAH-zrtu1Bci7M-tQc9Vme9z+Bw=1gthM7z6=XX33Jjd_Q6itcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH-zrtu1Bci7M-tQc9Vme9z+Bw=1gthM7z6=XX33Jjd_Q6itcg@mail.gmail.com>

On Thu, Jun 25, 2026 at 07:49:48PM -0500, Paul Guder wrote:
> Hello,
> 
> I seem to have found a regression with the wireless on the thinkpad
> x13s laptop which uses the qcom chipset. This commit seems to cause
> the issue:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=f176c47683bf

That's a stable backport.  Upstream commit is 33a76fc3c3e6
("PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion
support").

Thanks,

Lukas
