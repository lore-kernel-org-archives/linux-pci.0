Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539737C92A;
	Wed,  8 Apr 2026 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677212; cv=none; b=TllSIK/fL1+KadNqS5RxMJaUaMN2RWCh8fbT9u4jwAxTBUc1zIK/9+SVZQ5O38uuAhykJABMzGM4+B9x3KXbuiy5KMLtOLDRpjwAdZZ5gidM27jO6M3knrrel/MlGEQuWmQNMWGnhSUiy1wYQQcfReaQ+rS+jlrhZa4fJ+TsMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677212; c=relaxed/simple;
	bh=sinj7MfgSc4VJPyuu4cTK699IZREfP9g+K6XjvgtNZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jP/vUydLvabRne6k4uBvuk3jke/VawaO5QUu40gZ7Ha0W1yOMF4oHNgSoGSNnL56Py5eevcC5gnrARUV2MF2wQXaKh36JKKBv393HutjmDGAxckGos7bwpQteGqTiDMVizCdVuyRgzG/WmZC0CqDfnYubJj94UcE2VCEKPlaFRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3W8LQAm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3W8LQAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29383C19421;
	Wed,  8 Apr 2026 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775677211;
	bh=sinj7MfgSc4VJPyuu4cTK699IZREfP9g+K6XjvgtNZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=T3W8LQAmN79sv9lrgpeDuYERSNJeRL4PKLIyau0dN/eOe2sXejUAsw4/58NQm2tha
	 sj9wunLVCWpifE9zP5xwuSJtKc6LGkU9uZK0fqJz2j/xL7HUgCefFpe1sKjDH1s1GB
	 0sTD6YTtVde0Miv57N7yp3iurSnC/hqVil13zZalJ2pJTT4hinaGeDG8nLYv7suyGb
	 jbljR2JPlD3rHTB559HaLXe3CmJtZTWvD4WyBNOSF+XyiwJetSxtZ8Is/8d0mCOkkA
	 gZ/eGrk3NIGg/PZxwDYutUj7ogqzcPmPKRxW+t0QxxJL2vUYV5PyhaIyV6M1bS7XLd
	 CfhOw2uO0xflQ==
Date: Wed, 8 Apr 2026 14:40:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 0/3] Skip subrange map tests on DWC iATU allocation
 failure
Message-ID: <20260408194009.GA308328@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177557111043.286575.12032515827207230571.b4-ty@b4>

On Tue, Apr 07, 2026 at 07:41:50PM +0530, Manivannan Sadhasivam wrote:
> On Tue, 07 Apr 2026 14:04:07 +0200, Christian Bruel wrote:
> > For platforms with a limited iATU inbound window entries, pci_epc_set_bar()
> > might fail to allocate the ATU entries for subrange maps requiring more
> > than 1 slot.
> > For the dwc controller, this failure is reported with -ENOSPC in
> > dw_pcie_ep_set_bar(). In this case, the epf test cannot be run and needs
> > to be skipped.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/3] PCI: endpoint: pci-epf-test: Handle -ENOSPC in subrange_setup
>       commit: dfac277624c82b361dbb3e0fc57f577a270bebbb
> [2/3] misc: pci_endpoint_test: Handle -ENOSPC in subrange mapping test case
>       commit: a51c75fc48c2a0d2ead2d7e8c521de0423ec8dec
> [3/3] selftests: pci_endpoint: Skip BAR subrange test on -ENOSPC
>       commit: 2b729b7721bd4d0640b26790ea6c360c85a4af8c

I squashed these together because they need to be understood together.

I'm missing the details, but it seems unfortunate that the COMMAND_*,
STATUS_*, and CAP_* definitions have to be duplicated and presumably
kept in sync in drivers/misc/pci_endpoint_test.c and
drivers/pci/endpoint/functions/pci-epf-test.c.
