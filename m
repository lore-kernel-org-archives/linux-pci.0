Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE4375F87;
	Tue, 30 Jun 2026 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804261; cv=none; b=d8CYhs7WFvXbCn8Wj4Em8Gp9glC4YSdy4ghLFA2tYv48KADT2qnWAi2aQTr16BBCJ8CweGfnbijvGOUHtY0vCzl7NISdCFy6GSToe7wzXg4na/j+I9a9pMB7StEWMpgR3It3CXg3jbp9KMt+CwFO2pjfPiQ0F7bl38Dk6InSzwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804261; c=relaxed/simple;
	bh=54RWHvDn+GBlHyU1bOLol8gbOaTe4ndYmq7vcTPXfSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLOpjfebcn51WlP0heDuQtXmwnfI0MHDKvVzbZ1ThXPnztbDsWTbbJ7d5Hm1uiUr+z1o95cCKSiyeg8vEx/N1XdFgT9kDGXmYcFSarIAyX/JkLa+ZeQkNpjXBnUpbqijLdJoYVkK9BfnfNptMOcBcCo/xXsoboSp+iDs+OEsATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmQAdiHp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmQAdiHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084F81F000E9;
	Tue, 30 Jun 2026 07:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782804260;
	bh=FL0SLwfXlT7L+oOMsLkMNmEaeLRGVGRS0w0AOzU0THw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cmQAdiHpPL3ydZ6Op4olnnbcfAimXfAgdq5sVrz7ImVtTKi2QvvoYh5a15SQDVKpS
	 mlU4S6PT+c8N6SNeYen5dKjLFpR/eIAHQAPb8TSd6iWk4R4zj2cIdjdwpLGdeTF2Xc
	 yUBc29xjS0d6iUuB0Q9WOOxDCqVwBQnkv03DvnqbE059urMTaTZ/BTAI+1pNtj7fsF
	 TCdXnZx+qLutQuTKq7e6W7eu4KwnUk2cc8fgrPaQm6j4q12IfU9o8wD9vvkfKdqozW
	 HtPX3k8QUI+NxjQ81fnty4ESvLbg1yGbwYYFSiWiB21MciL7nMeGOxTz29pP0ozQmN
	 hfo/iYrS5r71g==
Date: Tue, 30 Jun 2026 09:24:09 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, Frank.Li@nxp.com, 
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, will@kernel.org, 
	"Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>, imx@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sherry.sun@nxp.com
Subject: Re: [PATCH V2 0/2] PCI: imx6: Improve PERST# fallback logic
Message-ID: <wj7dtqwadw4mletyq2s2an3g74acpmvvnkbogsdztgb27s2lul@i6ogmrnbd6to>
References: <20260525065443.2338629-1-sherry.sun@oss.nxp.com>
 <178280401285.286395.10401291228239552702.b4-ty@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178280401285.286395.10401291228239552702.b4-ty@b4>

On Tue, Jun 30, 2026 at 09:20:12AM +0200, Manivannan Sadhasivam wrote:
> 
> On Mon, 25 May 2026 14:54:41 +0800, Sherry Sun (OSS) wrote:
> > From: Sherry Sun <sherry.sun@nxp.com>
> > 
> > The pci_host_common_parse_port() shouldn't decide whether to fall back
> > to the legacy RC-level binding by checking for "reset-gpios/reset-gpio"
> > properties on the RC node and returning -ENODEV. That's a policy
> > decision belongs to the caller, not this common helper.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] PCI: host-generic: Simplify return value handling in pci_host_common_parse_port(s)
>       commit: 4b523544008aa70cda4b34c0589bbe47172c2637
> [2/2] PCI: imx6: Add imx_pcie_perst_found() to inspect the parsed result
>       (no commit info)
> 

I've squashed patch 2 with 1 to avoid bisectability issue pointed out by Sashiko
and rewrote the subject/description as well.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
