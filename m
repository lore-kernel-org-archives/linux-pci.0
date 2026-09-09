Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417042EEE8A;
	Wed,  9 Sep 2026 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918809; cv=none; b=Azlg0P5rU5MqjxlUIqRWLAIh3q7Wmv0jsUg8RsWWzaTHgG3TQVcLH7SWFL0tnkIIxsinku54+34HIUOkrqQjizJsdoiUMnZeaXdExewnqlERU6053XlLwsentJ+rIMTDPDGCp3dpyTxcb5E53eXTjys/mtHy1YDaeGHDxmHZbF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918809; c=relaxed/simple;
	bh=+g/Ya2Jz43E9beGXNw1yDQunpgAh4WgFGtcnhs5gn20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYXEINb7VZKgGBDwtC7Z1TKiKkX2t5rywudYzmgmz5ooktTKjIqnx+r2mYMfmSP+uTofETHL5ZYdmTmoSKwCyLaPHNsXXbPCncC7DQ3Ep1X/3HNrSoiNfrzyVtatZwf/5uqy8/3jmPWbJu+LjqPTDrg9Gdyu4EZeLsLUUD7wogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmXG/sP4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmXG/sP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF781F00A3A;
	Wed,  9 Sep 2026 01:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918807;
	bh=+g/Ya2Jz43E9beGXNw1yDQunpgAh4WgFGtcnhs5gn20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MmXG/sP4P+iK6mrk2A4PMc+G/b4VhAkoA+SOD/Q//hx2HgLBb7fzi+yXFu9vhbZDw
	 BI2NoycdSp6Egwbb4rXn6wB2WgHe53DC+uOO9E2kcaQMDiHdJmwt5CwpIuqXaAGohK
	 iwO48K46bGktLILa2Wzd2UBKkl7kzdwkrifshwOGWfkb94EzsEOGKTMRPuBJO3r51P
	 cSvUNn1prZoIncol8eJ+idEviTPw8L/ZU/4I/DUW71sKM8F5TP4yeM4hayokKSPrd2
	 pXk6OMgtX1oPKVO3kKEQ/t5IcZoqbiMixX/0UJAkUvBojjOLYUJvSghRED4CsOta/G
	 MZyukDx5PmCJQ==
Date: Tue, 8 Sep 2026 19:53:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Rickey Bartlett <subtexel@gmail.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Flush initiator posted writes before demuxing
 interrupts on Meteor Lake
Message-ID: <aqC8FSpnNxxitHtA@kbusch-mbp>
References: <20260825043220.9047-1-subtexel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825043220.9047-1-subtexel@gmail.com>

This might be going beyond the minimum requirement for the errata, but
lacking additional insight into it, and considering this will clearly
flush preceding writes to completion, looks good to me!

Acked-by: Keith Busch <kbusch@kernel.org>

I am just not sure if reading config space is necessary vs memory space
(maybe it doesn't matter), or if this errata requires reading from every
potential interrupting device to flush preceeding transactions vs just a
single posted transaction to anything in the domain. Worst case, many
devices sharing the interrupt may reduce performance, but it sounds like
the affected platforms typically only have a pair of nvme's at most
anyway.
