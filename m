Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8339309EE2;
	Thu, 10 Sep 2026 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043004; cv=none; b=p1kAGhShtONTW2vu/PmQhqrNrb6XKoQ2kqk9y3bboDWXEQ09iyDeDMzGT/u6yUj3uivSGOkNuEGf5jgwLBGqTh084x1UDI+2YwSpy49LrV2nIyc6KJh1PulDnYx5JlbIZJoJTD/5mYLlg7Pjpkw/etS+LlndDR/K2+b7jhxdrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043004; c=relaxed/simple;
	bh=k/l81c2C50ObIQf0NSY1DWtMElAm93i3qaq60SCIFxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDVGjg8GuAB71+wJOvJWV7OyaNXR/CfACtavhDwsxnDP2waDjEkFEc17DhUvUoUR16yvJ0lPYipl8TGl/ZZmBjpGX31egeWFFQUKMsl6cqMqm5b767gJOOKQCMAcPZKiuBf99Uqxhtflp5DuwwZQnFd9IMt64yHJ5B69iJ/KtfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7xAF3F2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7xAF3F2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B610F1F000FF;
	Thu, 10 Sep 2026 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789043002;
	bh=zyD1ZlC5fpFZWH20MyC2W7WYyvtpcSI0QfSjyrqgEAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g7xAF3F261vcbcmPBtbOJxmdSgYmaAkjCaNs0q/Of8h7FIX6h+GRTGh5UjGMOuhn+
	 gZLBmINKqJ7XmZ/vCqE/ZVS54h8wEsmYkth2FHAkRFyDhRol1Nw9FczUundAA3dboO
	 VSt5rXSaXKRllULiNllebwfOj2bcbUNngUixViGwRSV4FUOKHJ73DkB/bukBLY49xT
	 YI6QPis22w9f//y0FY+TfT1BZe8njgeMZd/T9ow3+BnhPWzwaW9klNhszGKwASnp2W
	 dvqJurqIOR/dAlFjFUgJ1wNlINzuFUCBAudTk1gEg66XXlp5V1H4qNX4eJG/TS0zRS
	 li3Xkujf9Efqw==
Date: Thu, 10 Sep 2026 14:23:14 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Toan Le <toan@os.amperecomputing.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Liviu Dudau <Liviu.Dudau@arm.com>, Tanmay Inamdar <tinamdar@apm.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene: Fix device node reference leak in
 xgene_pcie_probe()
Message-ID: <vagn7awznv3vop7gwpavo27s4netd235ei2po6lzkmnoqqhuwv@yiwwhzhaccza>
References: <20260814134118.1387742-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814134118.1387742-1-ruoyuw560@gmail.com>

On Fri, Aug 14, 2026 at 09:41:18PM +0800, Ruoyu Wang wrote:
> xgene_pcie_probe() takes an extra reference to the platform device's OF
> node and stores it in port->node. The driver never drops the reference,
> so every probe attempt that reaches this point leaks it, including when
> CSR mapping or a later initialization step fails.
> 
> The platform device already holds the node reference, and port->node is
> only dereferenced synchronously by xgene_pcie_setup() before probe
> returns. Store the borrowed pointer instead of taking another reference.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Fixes: 5f6b6ccdbe1c ("PCI: xgene: Add APM X-Gene PCIe driver")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

This was fixed by commit, 4869db344e76 ("PCI: xgene: Drop unnecessary OF node
reference").

- Mani

-- 
மணிவண்ணன் சதாசிவம்
