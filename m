Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0F3C3439;
	Wed, 15 Jul 2026 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159259; cv=none; b=dPBzY7FPY0d0zwdvzVecXEmRQnmovtzNhNGtvH07cPMKigrwxOxxeEccApTDlXpNus6IUOovREG8Td6CTNOHTzO3L0oXBqRXSOp48GdKvtO+m40KYENnoyZVnispwJqz2tVBBKAzRwVJ4JCT8HGqJAap+nmeS44oahM/ScQhYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159259; c=relaxed/simple;
	bh=ykq24m3qu7/gh46GyCdkk0cF4WWRLU9U63Gh81Ezk9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pu7owIyGwrbNOJBSjcoB9jyDM3YwWStm01E0K8VeDOSxtBoxtUBg23vwnSZMrGINpyqb388yNx4kqwAaHTkx1X1cCHo3TPJreIvPXJI42uehQLMc7437Qjq2FIu2ED4sqHbsJ3+/2zvs4sAhlvkIh1EgKBiiJc5xxGuVobLUE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+t9BbyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+t9BbyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D4A1F000E9;
	Wed, 15 Jul 2026 23:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159257;
	bh=Bl5lk7GtKJUn87j4SLMbzfc5HjmGwGRh3/zLnBPvIAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=T+t9BbyH/xH5eCUFOoC7kkJIlgvKdo+Ku+RFk+UbSXqwismvztyU1uJjx/qICqmS8
	 QvO7B8sM5QeI2opwEKmvQC4yPbOmdP4N6cKRYX7vRjwwL3NcMIvpepZIETJDV1zpgP
	 XmDE8ft22lJBNGenY9+yBXmAEA0HGqFaMiTzCoHJy1sjHckpdK11yfAx9JHKDCETQN
	 m4LhxZHVyK/oCyCApXzQZFHgzprgyE8EMCfcsPBNWMSBD+94e8rxS6o2cMc48iE2pe
	 DUFzXLoPeCMpVK88aihoRHaxPaeAOdJ2tYluLtlJkN3BWNgG/yMkvjz/L0PyEEYYHf
	 DlaDnDB+4R8yQ==
Date: Wed, 15 Jul 2026 18:47:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, leonardo.costa@toradex.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, Sherry Sun <sherry.sun@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
Message-ID: <20260715234736.GA288957@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629143439.361560-1-leoreis.costa@gmail.com>

[+cc Sherry, author of 610fa91d9863, Richard, Mani, linux-pci]

On Mon, Jun 29, 2026 at 11:34:32AM -0300, Leonardo Costa wrote:
> Hello,
> 
> We are seeing a regression on Apalis iMX6 where the kernel doesn't boot in the
> newest v7.2-rc1 (it was working before, in v7.1). The device tree being used is the imx6q-apalis-eval.dtb. The kernel
> configuration used is the one shown below:
> 
>     https://gist.github.com/lcosta37/53efdb2fb6e6e0fc05437c7e53b47737
> 
> The kernel logs stop almost immediately as the board starts to boot, and I 
> don't notice any difference in the logs that points to the cause.
> 
> Is this known? We are seeing this behavior on all Apalis iMX6 modules, though
> we don't see it on Colibri iMX6, so it is not SoC-specific.

This regression is listed on
https://linux-regtracking.leemhuis.info/regzbot/mainline/ as being
caused by
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=master&id=610fa91d9863
("PCI: imx6: Assert PERST# before enabling regulators") but I can't
find any bisect or other report that specifically points to
610fa91d9863.

Can somebody confirm that reverting 610fa91d9863 fixes this
regression, or at least that 610fa91d9863^ works and 610fa91d9863
fails?

Bjorn
