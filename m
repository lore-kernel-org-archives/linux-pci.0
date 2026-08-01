Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942F36C588
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 04:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785557078; cv=none; b=WlqP5u+Q5DwtHVuEpbOLNJX2CV1c3WTXhgRNBi9CZg7RTtwb5ttTHUZ5s5co6DhW7alCAPdavqz1AT5xEJwtlrKfpRHQMTRHlLo13yFSgpIrOD1rkZLHzKqdjrOdUIzYUAGF1d4jTc9QAAOdiLKhr37n96pFLmLyxH97RG0KWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785557078; c=relaxed/simple;
	bh=xFKMUbrv+ZKqadHDJb7nHUYjkDvajSL7N1/SIEH+zBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1fG3gAZrGT+1mT13/HQtjSaAwsbE602PoriFQCeMIc5aL0PI7xnJyFvhQsyiEaPEOBf0uishHtLh8O0u9q4bmJRqGCsjtjdu+xqrS/PlcHdYIoJRn0arTMJVqZKvTaWiDGQtvkwdZjUo4H4+L5utcXokax1a91G5AS+orZjqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjAuZZN4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjAuZZN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99751F00AC4;
	Sat,  1 Aug 2026 04:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785557077;
	bh=xWoG9RyzRgPHBcRmuZ0O139Uzxg1SGO8MkP4lkx1Ta4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hjAuZZN4JXV85SgliTArod6DT6dfHJxh8txqTeX6WEysz10kKkkrP11zObZtZuUdF
	 tZ7Vp5JBN17TkSzbsHgaL62KfQLUcUflCfwE7wItQZyvJzOLdRqvC18ZtTelim8SmU
	 v5zaZNP8JXhqOx935p4vj99IsS1scxgRZTi9r+KaRI0Xi26owNeifN/UeONLTFzBJg
	 eSaWCUJYR+40qGbxgzDAOoF7bgqtGAuniqZGUTZHxWZcBfmBA4YV4/XDVKPhC+AwCn
	 UoJNpJfaQFT65AhSq+BFlno7vPHdS5NLG0ovXYTsHpAcgK8ukkT0sA7FVL4dDCGUfe
	 +LUDfoGqIzg4A==
Date: Sat, 1 Aug 2026 13:04:35 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Use %pe format specifier to print error pointers
Message-ID: <20260801040411.GA3183355@rocinante>
References: <20260720210839.1507406-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720210839.1507406-1-kwilczynski@kernel.org>

Hello,

> Currently, several files in the PCI tree print error pointers using
> the %ld format specifier together with an explicit PTR_ERR()
> conversion, which prints the numeric errno value.
> 
> Thus, at every affected call site, use the %pe format specifier, which
> exists specifically to print error pointers, and pass the error pointer
> directly.  With CONFIG_SYMBOLIC_ERRNAME enabled, this prints a symbolic
> error name such as -ENOMEM, falling back to the numeric errno value
> otherwise.  As such, the explicit PTR_ERR() conversion is no longer
> needed.
> 
> No functional changes intended.

Applied to the misc branch.

Thank you!

	Krzysztof
