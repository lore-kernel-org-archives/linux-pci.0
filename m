Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1CC145FE0
	for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2026 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493782; cv=none; b=HVjM8HLrB9K9d3HqVHoTEjsaWNpYMsQXRnd1PLUwqGmo216w4/O20ilKrf8h/x/DyYQe0f4iN9MSDf9x5QdNiEVUDfULdqyVGasdXD2MqXIrQIn7IS1HCCGcDvnIJu4qlS9kitbKDx0YIf+Botp/JzacLlEABUqItMfu/DeCVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493782; c=relaxed/simple;
	bh=qbsXYXhdrP80WPE3iVyewVA79m1u7aprBi5ya8R9tKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXk8PVIpywYJSjy7nfCWmz9FjNakE7U5P06oas1uEM57jgNOkrWcHXf5PmQ6svvyv08l793ZTjcZiFSQzFmkkPtvJacmmaM0YNPPWuYrRQutXv9X9V0+00Ttx2a++f6ylIAGlDkTlrTmxwQtSzAttV2VmYGtWimjmAsieFdOKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7Hp2o0G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7Hp2o0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7306CC19421;
	Thu, 19 Feb 2026 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771493782;
	bh=qbsXYXhdrP80WPE3iVyewVA79m1u7aprBi5ya8R9tKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7Hp2o0G8VDMlq/HgeG5/pULidyL+9bwOPJh443KrhhQSS2yUPeJtBi75kCUYkn+J
	 8Z8taf0U1emyXaEvzE2cYMrSbJhXGduc1V59q2kv4J1fwfa9x5tWdshMbp5ocidwhy
	 QeObCt/mfEzewyTeaVQJpaj9MpXp2XMOkjupPiDfQr/7FtU1ErGv3GrGTdnDZZ6Wao
	 GHEfd0idEv0nkrGJM66RilyuxCcUZFYs4gs6Kv/FvBqgeo2Otakp01e4j4h/K04S77
	 JwxqFdLiFN5kAHrWamSrC6eJ1I4UB11r+Jvkc4mjqHU8lnQTKYKA8W8vad0/EDwIDQ
	 MoBnmEhCiDAXQ==
Date: Thu, 19 Feb 2026 10:35:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 7/9] PCI: endpoint: pci-epf-test: Advertise reserved BARs
Message-ID: <aZbZTyrsrSgcX2Ly@ryzen>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-18-cassel@kernel.org>
 <aZTzn-R6f9acu-2J@lizhi-Precision-Tower-5810>
 <aZWXzzul8xRaDQgm@ryzen>
 <aZXiEWmNEdCfXse2@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZXiEWmNEdCfXse2@lizhi-Precision-Tower-5810>

On Wed, Feb 18, 2026 at 11:00:17AM -0500, Frank Li wrote:
> > Thus, we need to tell pci_endpoint_test that these reserved BARs (which are
> > not disabled) has to be skipped, because if we perfrom READ/WRITE tests
> > against these BARs, bad things will happen. E.g. if you write to a BAR that
> > exposes iATU registers, you will clear/overwrite the current inbound addresss
> > translation configured by the endpoint.
> 
> I see. it actually means skip bar test. is CAP_SKIP_BAR<n>_TEST better?

Yes, for pci-epf-test, a reserved BAR should be skipped, but not only for
the BAR<n>_TEST cases, it should also ignore the BAR in the consecutive
BAR test.

Everywhere in drivers/pci/endpoint, a reserved BAR is a BAR with fixed
MMIO registers (to e.g. eDMA registers, MSI-X table, iATU registers).

E.g. the code for the consecutive BAR test in
drivers/misc/pci_endpoint_test.c is:

@@ -403,7 +426,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
 
 	/* Write all BARs in order (without reading). */
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
-		if (test->bar[bar])
+		if (test->bar[bar] && !bar_is_reserved(test, bar))
 			pci_endpoint_test_bars_write_bar(test, bar);
 
 	/*


It seems quite clear that pci-epf-test should skip a reserved BAR.

I see your point, but I'm leaning towards that that it is better if we use
the same terminology everywhere.
I'm worried that introducing another terminology (SKIP BAR), might lead to
more confusion than clarity (we already have RESERVED BARs and DISABLED BARs
as enum values in pci_epc_bar_type).


So, while SKIP BAR might be slightly more descriptive for pci-epf-test,
I worry that that using a third term, will cause more harm than good.


Kind regards,
Niklas
