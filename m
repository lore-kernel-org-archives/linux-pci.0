Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D3352C35;
	Wed, 25 Mar 2026 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419823; cv=none; b=DtoYo2oRc1CX0rIBHeqsooQF5o80TCAAXH7OAPGzjFYI9x1ZI5TiXlV1OZueiWGThCPyKuJr2ZZPqtWv1F5xp5sX5EINDG4QSOVN6Ry/xjncrygBdFBzw8SV/dGbjkGYaz3KDOKIEXaxaw3tcqScPRletzsKx1XE7GmX57H0Wsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419823; c=relaxed/simple;
	bh=9Ys9kLszkYFD7JrLh+1mZnnRESLdkc+zF9YL65ZJBIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0LsyefjHnr2qXGGMS4iTH8PnIxPvGQxZTx+sOj4iFJSRBdOJ6nV/LgzephZYn68TizyQcI44J+q5+MKocQ0z44sqcS9aTDJsSYCx7FIg3z0vCgacglBRQJg/9r9KqiKkYDCRvYpqGrRWSTH2dQEtn/eRxgotAvLqGOhsYBMZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tB7pVIEO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tB7pVIEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06DEC4CEF7;
	Wed, 25 Mar 2026 06:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774419822;
	bh=9Ys9kLszkYFD7JrLh+1mZnnRESLdkc+zF9YL65ZJBIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tB7pVIEOFeVSGcy2azcUUZ6dRdiJOUbhCVjoHFeaMNrG5Pihra+GBs6hV0PCIY9Oe
	 TkfRjRhs5aQtMB6lzdWf+4b9637Y8hRP25+yvCSqltp8Gyv/8o/MT2isbPvO5g6Amm
	 E+RYCsiQ2NoKyROst7+mkFKNEJmyXpsuB8WQ5FNhLTmKH5NPJFsT978489EeohrOuL
	 aE1PI7STX+KxmNuAKVYdEU19GHDYB07o5/Rz1EODBPJ2a4qfdrlHidwOGs7YteVEzC
	 3nhblbmheeOPVvT9urmidpzYfUgZIqxEcHr8mjNpsxpD+hT2dPZY1GW5FTkke5yy3l
	 7YV8lD5VZEs4A==
Date: Wed, 25 Mar 2026 07:23:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v3 00/10] PCI: endpoint: pci-epf-vntb / NTB: epf: Enable
 per-doorbell bit handling
Message-ID: <acN_aZNICP15ybZZ@ryzen>
References: <20260323031544.2598111-1-den@valinux.co.jp>
 <7jkibbdz3m3vuq2kq2xxnkt2rjdt5v7itgowc7qormtwgnf6tv@krl5brfjul5y>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7jkibbdz3m3vuq2kq2xxnkt2rjdt5v7itgowc7qormtwgnf6tv@krl5brfjul5y>

Hello Koichiro,

On Tue, Mar 24, 2026 at 12:43:53AM +0900, Koichiro Den wrote:
> 
> - configfs knobs mutability and bounds checking, including (but not limited to)
>   db_count.
>   In my opinion, allowing updates after .bind() looks questionable, and
>   returning -EBUSY once bound seems more appropriate. I'm leaning toward
>   handling this as a separate hardening series.

This is in line with what we did for pci-epf-test, see commit:
ffcc4850a161 ("PCI: endpoint: pci-epf-test: Allow overriding default BAR sizes")

but we return EOPNOTSUPP instead of EBUSY.


Kind regards,
Niklas
