Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A9226864;
	Tue, 10 Dec 2024 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858686; cv=none; b=MkAKOnq7Z8dTT3Z3I4o9Rs2NFhugxpNooNYuvMJmjKXht3oift+LyYO6SEs4J0nSkNt3rFTwxdERF1y1511MoohBo2wHZVoEwJayGhcJtog+hTMPTp2swZzRnUb6z4zGamIfruyu9uP5OAC+oCFJ6qvLj8eRW51e/IiyP5Ds5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858686; c=relaxed/simple;
	bh=wF/gTlY74rp2rVeF9vGO4vwlHjzWG1ZRXLox74bBq1I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PaJmf/mxtDU4Fi23za1vizIn7HztMAShSnrRwhBg2hF6VuMs2AnCB+Ttit0zi0/B7UdyBFPBBo6E5YasqZSIDjSQzFdHX80ajQ+tXGQrjG0a9cKPjhNErLsDsXpIljm3Dw0c5XMB57xpigOrqVHApJxMW4k9ig1RwxS0ok7c8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7SPAqVW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7SPAqVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02990C4CED6;
	Tue, 10 Dec 2024 19:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858686;
	bh=wF/gTlY74rp2rVeF9vGO4vwlHjzWG1ZRXLox74bBq1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P7SPAqVW7vDZUzTEKGTpTADl6lAJaDJh9pzupw6180C+t49MLH9tuph/P8eTySuDW
	 IAr4Fe27iWDJOf++F3cDUca41anOU40bJ9/TVaHAZcMy6TT4xhHwO5/6LL0zo56GdU
	 WTj+wHC99ovUqTqkpJxY0KbSzygXpUEk2cKXtpyUIeBLWxl3Ef+sTq8N6r00wTWpH6
	 pu5MtZc3ww2ugaK9l0jw3PVodG9oKUJxvmDTOCfCWNZ1joG2ygXNKPB0qHPtkA9IOg
	 iArcfBd+2RNmrF9/F6qOVPtaKScKa5L6FdmQGcWje9kZyiHIoDAoWnK6ivIV5H25wP
	 60fPWQVxWENKg==
Date: Tue, 10 Dec 2024 13:24:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Message-ID: <20241210192444.GA3079017@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>

I try to make the first word of the subject a verb that says something
about what the patch does, maybe "Enumerate" in this case?

On Thu, Dec 05, 2024 at 02:23:39PM -0800, Dan Williams wrote:
> Link encryption is a new PCIe capability defined by "PCIe 6.2 section
> 6.33 Integrity & Data Encryption (IDE)". While it is a standalone port

Since sec 6.33 doesn't cover the "IDE Extended Capability" (sec
7.9.26), I would word this as "a new PCIe feature" here.

> and endpoint capability, it is also a building block for device security
> defined by "PCIe 6.2 section 11 TEE Device Interface Security Protocol
> (TDISP)". That protocol coordinates device security setup between the
> platform TSM (TEE Security Manager) and device DSM (Device Security
> Manager). While the platform TSM can allocate resources like stream-ids
> and manage keys, it still requires system software to manage the IDE
> capability register block.

s/stream-ids/Stream IDs/ to match spec usage

> Add register definitions and basic enumeration for a "selective-stream"
> IDE capability, a follow on change will select the new CONFIG_PCI_IDE
> symbol. Note that while the IDE specifications defines both a
> point-to-point "Link" stream and a root-port-to-endpoint "Selective"
> stream, only "Selective" is considered for now for platform TSM
> coordination.

s/root-port/Root Port/ to match spec usage, also below

> +void pci_ide_init(struct pci_dev *pdev)
> +{
> ...

> +			 * lets not entertain devices that do not have a
> +			 * constant number of address association blocks

s/lets/Let's/
