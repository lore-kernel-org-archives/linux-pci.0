Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD2334C08;
	Tue,  7 Jul 2026 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405385; cv=none; b=eymJsxJIEn+83GccpsqAGotH0essZoYZizKDzmDLpNNGXMOghfaCDp6MvZrL0JNZO3ewOf+Q0GLh/RZOsnDpnegDxrbHEXF5IbHvqH1PgGURPSrJetl5NBqq4+6bixF919JJ/hOzFQF+y6YGSPzKgSWlAQMYBlaxHaWWn9urkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405385; c=relaxed/simple;
	bh=aLxw6wDedMFrYodXEcpv1o1akeHQcCLhmJqhupkrXFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cw/tS9tKUPo7IUXj4kKifHHATegN328lR0oTtOuupdY02GZ1xU7jC5dn5VeFZv5BngvzBCdqamy9RCLGvCgqHTIZS41DCPxRM3xJo+8rRKe5lPzUYGSXGQC0xAlcsdaIq9DL/IZsK+Imsstv2nRNhwDxiB9obcOby9ZLq7A8M5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ogT3ycFr; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ogT3ycFr"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 7867F22BA6;
	Tue,  7 Jul 2026 08:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1783405375;
	bh=/0L4272XicdnCVTlaYkSLBNwZCjsMYx6J5/Ki3naDCg=; h=From:To:Subject;
	b=ogT3ycFrxbBdTSIJwRSTgdvlDCdIZrEEhX6YesAYV8i91hyxXwM6/yc2PDtqIsGnO
	 8nUxqHSOmEV2YzrbJEaFsSOrIniOme2iBj348DrizR1xw9TtE376HWNWDOBEK/sQmM
	 33EAmdZ/k6hII5nHOTN8h3kttMUyTYGc1b++GpX0pgz1IlTpKnq6Btozv7EHA9gOCM
	 iud1o4xvhZpdhfrZ9BICaqU8vr4FusXF6BcDpJzathRYYuc6ypihL+ES7BA69MdFQf
	 e9+PLiOInpZImkV2f6AYuYQpGJFFeTCzpD5kwlWhDz3iNceJRH+tWEM6hFpmnzUKvd
	 hvtcNWnPUd9wA==
Date: Tue, 7 Jul 2026 08:22:50 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, smoch@web.de, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v1] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Message-ID: <20260707062250.GA20259@francesco-nb>
References: <20260706030629.3264320-1-hongxing.zhu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706030629.3264320-1-hongxing.zhu@oss.nxp.com>

On Mon, Jul 06, 2026 at 11:06:29AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> introduced a boot hang on i.MX6Q/DL variants by changing the initialization
> sequence.

Is this related to

https://lore.kernel.org/all/20260629143439.361560-1-leoreis.costa@gmail.com/

?

Thanks,
Francesco

