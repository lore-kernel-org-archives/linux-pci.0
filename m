Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F594D9900
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618534; cv=none; b=q3HgaIf/pzVIHlokiEbSDUR1/IgrgFmYyRGqubWKTMQA6wqxybHXSS1qf5HqTY1m53gdYIsTjD9zFwhRyJv1AhhPmJebBeoRKPeHm+2hFeeQsLbVO8oto3LxNQePA73d9+uJkzc+V7E3Va2igg2FmBoggXuZYAWeWgyuKR/DuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618534; c=relaxed/simple;
	bh=hnz1tHiDREFoxyCpUgFSYuUAtDtS9cD3V8mUGta5b8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0UH9sZopXBazGxGNkHR3hg5pFA66gy3IUdsvmu80Rc5KKy28sbutyCnxoMjg3Z1RKNUFALAkEFlcvkchhl2I1S9n3KRLM9+7unB18Nm9SEXwprUVq2KKCTpMFMl0TqLvP3PsUO521Wm/w+/mVEGGbNubXW/znJl1eyXE6FqxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrGIeO/V; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrGIeO/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783618532; x=1815154532;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hnz1tHiDREFoxyCpUgFSYuUAtDtS9cD3V8mUGta5b8I=;
  b=KrGIeO/VD+U8RY+XAmzWsvV2KO1v8CQPFw0bTQLEJuNUgGtuwXjxc56Z
   tEjSjSsWMF/czL+yn4h0HQZuL28Hluk5F4gBXlhMhl9p2I+fH2VUvxo5T
   TYkXlTJfrPrLcH6EYLQLs1H0S1zNPIH7zT0VPo5+imoVbEn/gZI8XHSRQ
   c8WTDQdQuDc0KH6LvTZstSQismt+DG//7Gw5YGKeWYlD79wff32nlvx+O
   Xmq7UQjfCUrLozBzRrJl3mf9UWqtOUAbTjn42mgbb3sZfRXCj4Du6dpb+
   NJze1I+Lea5yGkbFzPXMO1OICBOW7X+LbCxud3qgziHovXc1spU1RROHL
   Q==;
X-CSE-ConnectionGUID: 89bNOIP+TDeRyI5IkV9CiQ==
X-CSE-MsgGUID: 7r1WWLhFQxSPyaYMci5XCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95462567"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95462567"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 10:35:31 -0700
X-CSE-ConnectionGUID: ALtUaSwcRKC+T3Buya2aEw==
X-CSE-MsgGUID: cxO91jgHQAqQbvTg+irnSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255295818"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 10:35:32 -0700
Date: Thu, 9 Jul 2026 10:35:30 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>, helgaas@kernel.org,
 djbw@kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de, Bjorn Helgaas
 <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: vmd: Add VMD Device ID Support for Intel Nova
 Lake (NVL) and Dunlow (DNL) Add VMD Device ID Support for NVL and DNL
 processors.
Message-ID: <20260709103530.00006e64@linux.intel.com>
In-Reply-To: <g2eyk2maututraomzh6atqckhpjdgqgqoc47pgvjeurw76d7cx@v3tw26qpdvqp>
References: <20260708092957.3269545-1-szymon.durawa@linux.intel.com>
	<g2eyk2maututraomzh6atqckhpjdgqgqoc47pgvjeurw76d7cx@v3tw26qpdvqp>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Jul 2026 15:21:53 +0200
Manivannan Sadhasivam <mani@kernel.org> wrote:

> On Wed, Jul 08, 2026 at 09:29:57AM +0000, Szymon Durawa wrote:
>=20
> Subject duplicates twice and there is no description.
>=20
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Dan Williams <djbw@kernel.org>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: linux-pci@vger.kernel.org =20
>=20
> You didn't CC all VMD maintainers:
>=20
> Nirmal Patel <nirmal.patel@linux.intel.com> (maintainer:PCI DRIVER
> FOR INTEL VOLUME MANAGEMENT DEVICE (...) Jonathan Derrick
> <jonathan.derrick@linux.dev> (reviewer:PCI DRIVER FOR INTEL VOLUME
> MANAGEMENT DEVICE (...) Lorenzo Pieralisi <lpieralisi@kernel.org>
> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS) "Krzysztof
> Wilczy=C5=84ski" <kwilczynski@kernel.org> (maintainer:PCI NATIVE HOST
> BRIDGE AND ENDPOINT DRIVERS) Manivannan Sadhasivam <mani@kernel.org>
> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS) Rob Herring
> <robh@kernel.org> (reviewer:PCI NATIVE HOST BRIDGE AND ENDPOINT
> DRIVERS) Bjorn Helgaas <bhelgaas@google.com> (maintainer:PCI
> SUBSYSTEM) linux-pci@vger.kernel.org (open list:PCI DRIVER FOR INTEL
> VOLUME MANAGEMENT DEVICE (...) linux-kernel@vger.kernel.org (open
> list)
>=20
> - Mani
>=20

Reviewed-by : Nirmal Patel <nirmal.patel@linux.intel.com>
